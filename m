From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 2/2] Allow core.askpass to override SSH_ASKPASS.
Date: Fri, 27 Aug 2010 14:00:16 +0200
Message-ID: <AANLkTik5eMLCKK7muBW9k8-0ZAxraATCs5hHVcX-Zutn@mail.gmail.com>
References: <201008271251.23136.k.franke@science-computing.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Frank Li <lznuaa@gmail.com>
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Fri Aug 27 14:00:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ooxbw-00033s-2O
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 14:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440Ab0H0MAi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Aug 2010 08:00:38 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48064 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707Ab0H0MAh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Aug 2010 08:00:37 -0400
Received: by vws3 with SMTP id 3so2762948vws.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 05:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=AA37bfZI9SgOahsrZTpjcP+S3vLLPEu5REkQeWgyWTw=;
        b=XN5ww4dF4OELuRhNF6gnqNBFkPOJvEYiVY1tRWUsW46dhSTj5xT8Dg3h1YSqDD61EP
         6LL9PJ+Zb5s6Wk25InuUTHsL7FEAOI7sUelKNd/cJvEgXsSXB5KvsBttY04pjIDnFsOl
         qrU+yxqdUdVqplh7VeCMNDmAOVL2wJRWsV9E4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=l8TouoKVNnwqDsWowBh+kB2AiEqkYBvMimrLEnRMPPwVVp2p+zmc6A9tCHUWWQgtcd
         04CnrdllWvZisBA4is7GqDSN7FXLt+SVFvO7rVEZuC5BsE0s8e3rPnPcjrvVVN3Gbymk
         xjT22Wrpv/SumkvEwJAbJwVQvGFDS3e+oPmWc=
Received: by 10.220.59.5 with SMTP id j5mr432785vch.230.1282910436233; Fri, 27
 Aug 2010 05:00:36 -0700 (PDT)
Received: by 10.220.180.76 with HTTP; Fri, 27 Aug 2010 05:00:16 -0700 (PDT)
In-Reply-To: <201008271251.23136.k.franke@science-computing.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154594>

On Fri, Aug 27, 2010 at 12:51 PM, Knut Franke
<k.franke@science-computing.de> wrote:
> From: Knut Franke <k.franke@science-computing.de>
>

You don't need this line unless you're forwarding a patch for someone
else (or using a different e-mail account).

> Modify handling of the 'core.askpass' option so that it has the same =
effect as
> GIT_ASKPASS also if SSH_ASKPASS is set.
>

Why are you sending a two-patch series where the second patch tries to
correct the first one? Wouldn't it make more sense to squash the two?

> Signed-off-by: Knut Franke <k.franke@science-computing.de>
> ---
> I'd say this precedence order is more intuitive; and more useful.
>
> =A0connect.c | =A0 =A04 ++++
> =A0git.c =A0 =A0 | =A0 =A03 ---
> =A02 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index e296bfc..f97b84c 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -627,9 +627,13 @@ char *git_getpass(const char *prompt)
> =A0 =A0 =A0 =A0static struct strbuf buffer =3D STRBUF_INIT;
>
> =A0 =A0 =A0 =A0askpass =3D getenv("GIT_ASKPASS");
> +

Why?

Apart from these nits, I think the patch does the right thing. IMO it
doesn't make sense for SSH_ASKPASS to trump core.askpass.

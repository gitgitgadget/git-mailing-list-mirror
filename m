From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] builtin/checkout: Fix message when switching to an
 existing branch
Date: Sat, 21 Aug 2010 11:15:25 +0800
Message-ID: <AANLkTim4K7LnZOhGQUNwpLR24Hm+V1fWrxY2UE2oPGx7@mail.gmail.com>
References: <1282326107-2139-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 05:15:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmeYZ-00034R-Hc
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 05:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202Ab0HUDP2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 23:15:28 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51267 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143Ab0HUDP0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 23:15:26 -0400
Received: by ewy23 with SMTP id 23so2602853ewy.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 20:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uavwMLyhpnP46c1NGyf6bmwDpVGOQ5v9dhkUqU/2mmM=;
        b=b8aOM1Ked6+o4kXhrmOl/uaZtzrWCjpI2eMD/SYQ8r/R2LH/NdVkxG77XFE44UDDiv
         ng778zle2FQlSATeE+2w5lCABdt6anSsMrAGpAYS9qhK/jGGE8nXujybvjXOWZNrOhcw
         EXab8IjjVjvcJD+g7DyBV1KemO4FhCKZv3sNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vv9WCMzq/2bgYPwV0XUvJvlqCHz45UIMMVQnXNzvu3ynOwM9EnjS0YtvU7UFSwOoSK
         FLHwJFaXFbCtMAnMncVRNwSbMSRORsGIkUPodqcZL63MipJiZ/SiMg7xVM/GkKkrTQsi
         sbu3LFnnSx8NA3Av9x15x4h9jkoHPqfrRXGk0=
Received: by 10.213.15.65 with SMTP id j1mr2096042eba.79.1282360525594; Fri,
 20 Aug 2010 20:15:25 -0700 (PDT)
Received: by 10.213.22.134 with HTTP; Fri, 20 Aug 2010 20:15:25 -0700 (PDT)
In-Reply-To: <1282326107-2139-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154092>

On Sat, Aug 21, 2010 at 1:41 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> =A0builtin/checkout.c | =A0 =A05 ++++-
> =A01 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 156900d..ff5ac1e 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -545,10 +545,13 @@ static void update_refs_for_switch(struct check=
out_opts *opts,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (old->path && !strc=
mp(new->path, old->path))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprint=
f(stderr, "Already on '%s'\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0new->name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (opts->new_bran=
ch)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprint=
f(stderr, "Switched to%s branch '%s'\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0opts->branch_exists ? " and reset" : " a new",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0new->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf=
(stderr, "Switched to branch '%s'\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 new->name);

On a closer reading, I realise that "reset" isn't mentioned if the
branch exists.

The terser ternary version doesn't suffer from this defect.

--=20
Cheers,
Ray Chuan

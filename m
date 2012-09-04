From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC] i18n.pathencoding
Date: Tue, 4 Sep 2012 19:23:35 +0700
Message-ID: <CACsJy8A1GnhTeMzwXwA1C96pp0ERskxZC=SO+QE2__pfwmChow@mail.gmail.com>
References: <201209010811.33994.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 14:24:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8sAx-0004I6-NP
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 14:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856Ab2IDMYI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Sep 2012 08:24:08 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54327 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778Ab2IDMYG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2012 08:24:06 -0400
Received: by ieje11 with SMTP id e11so4679694iej.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2012 05:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=t2YF8cgAZ0ZXpoE49Auo+TEeAP4gZ2rDRHMoGHCGg9g=;
        b=ML6gs4VRe7DXY7Jx/+fKPycO37Bo+fkAHy29oMbsQd1Z+MVb+e1Mkhi2IpuU6QJ7nu
         GzvDqWKM6FzQyCHBvOo425CPK2HSM0hXd8UZ4RhRgKuht/unPP4xmaNMWtimML7J+XNH
         4qKd409BgJiGHs58Rz3nlkPwC6fJmzZbu04taPq+TeyO9ty2+puBUhxEUYaEsvxLBSH/
         kKs2z+/xbat2HsicBRdzqw+kxJwYU/dLUIWOkQdzElAHH9f1B0usYl6oQbaCe/kX/xNk
         UosdLUYD+PV7CsZghHnQAMx2iS8JU6ByQ67gwEa96Lq/Jvxv00Ixy3VHb+/Ls4Rkmzva
         Qmiw==
Received: by 10.50.220.194 with SMTP id py2mr13794179igc.15.1346761445539;
 Tue, 04 Sep 2012 05:24:05 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Tue, 4 Sep 2012 05:23:35 -0700 (PDT)
In-Reply-To: <201209010811.33994.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204740>

On Sat, Sep 1, 2012 at 1:11 PM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> diff --git a/parse-options.c b/parse-options.c
> index c1c66bd..5840c18 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -476,7 +476,7 @@ int parse_options(int argc, const char **argv, co=
nst char *prefix,
>                 usage_with_options(usagestr, options);
>         }
>
> -       precompose_argv(argc, argv);
> +       reencode_argv(argc, argv);
>         return parse_options_end(&ctx);
>  }

If you have to re-encode command line arguments, what about paths
coming --stdin or a file? I guess that paths that are argument to an
option are not re-encoded too, which may put git in an inconsistent
state where it cannot compare paths to paths because some may be
re-encoded above, some not.
--=20
Duy

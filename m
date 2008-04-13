From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] builtin-apply.c: use git_config_string() to get apply_default_whitespace
Date: Sun, 13 Apr 2008 05:56:44 +0200
Message-ID: <200804130556.45141.chriscool@tuxfamily.org>
References: <20080408084233.GA7785@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sun Apr 13 05:52:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JktGL-0000SY-LH
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 05:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837AbYDMDv1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Apr 2008 23:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754862AbYDMDv1
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 23:51:27 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:52347 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754253AbYDMDv0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Apr 2008 23:51:26 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 675351AB2B0;
	Sun, 13 Apr 2008 05:51:25 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 49D7F1AB2AD;
	Sun, 13 Apr 2008 05:51:25 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <20080408084233.GA7785@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79388>

Le mardi 8 avril 2008, Stephan Beyer a =E9crit :
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
> Hi,
>
> a simple `Janitor patch'.

Thanks.

>
> Regards,
>  Stephan.
>
>  builtin-apply.c |    8 ++------
>  1 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/builtin-apply.c b/builtin-apply.c
> index b5f78ac..ce0a0c3 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -2978,12 +2978,8 @@ static int apply_patch(int fd, const char
> *filename, int inaccurate_eof)
>
>  static int git_apply_config(const char *var, const char *value)
>  {
> -	if (!strcmp(var, "apply.whitespace")) {
> -		if (!value)
> -			return config_error_nonbool(var);
> -		apply_default_whitespace =3D xstrdup(value);
> -		return 0;
> -	}
> +	if (!strcmp(var, "apply.whitespace"))
> +		return git_config_string(&apply_default_whitespace, var, value);
>  	return git_default_config(var, value);
>  }
>
> --=20
> 1.5.5.rc3.8.g78d1a

Tested-by: Christian Couder <chriscool@tuxfamily.org>

Junio, please apply.

Thanks,
Christian.

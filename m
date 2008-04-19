From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] http.c: use 'git_config_string' on configuration options.
Date: Sat, 19 Apr 2008 07:16:55 +0200
Message-ID: <200804190716.55490.chriscool@tuxfamily.org>
References: <48089F6A.3040102@tordek.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tordek <kedrot@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 16:34:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jn5NY-0005KF-1t
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 07:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbYDSFLo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Apr 2008 01:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbYDSFLo
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 01:11:44 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:60923 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112AbYDSFLn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2008 01:11:43 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 63C031AB2B3;
	Sat, 19 Apr 2008 07:11:41 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 45F961AB2C8;
	Sat, 19 Apr 2008 07:11:41 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <48089F6A.3040102@tordek.com.ar>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79890>

Le vendredi 18 avril 2008, Tordek a =E9crit :
> Signed-off-by: Guillermo O. Freschi <tordek@tordek.com.ar>
> ---
>  http.c |   35 ++++++++++-------------------------
>  1 files changed, 10 insertions(+), 25 deletions(-)
>
> diff --git a/http.c b/http.c
> index 256a5f1..cadc1bf 100644
> --- a/http.c
> +++ b/http.c
> @@ -100,39 +100,27 @@ static int http_options(const char *var, const
> char *value)
>         }
>
>         if (!strcmp("http.sslcert", var)) {
> -               if (ssl_cert =3D=3D NULL) {
> -                       if (!value)
> -                               return config_error_nonbool(var);
> -                       ssl_cert =3D xstrdup(value);
> -               }
> +               if (ssl_cert =3D=3D NULL)
> +                       return git_config_string(&ssl_cert, var, valu=
e);
>                 return 0;
>         }

Did you check that there is no compile warnings resulting from this ?
Did you read the last sentences of http://git.or.cz/gitwiki/Janitor ?

By the way it seems that your patch has spaces instead of tabs everywhe=
re.

Thanks,
Christian.

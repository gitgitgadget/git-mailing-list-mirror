From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC v7 1/2] Add infrastructure for translating Git with
 gettext
Date: Fri, 4 Jun 2010 21:57:02 -0500
Message-ID: <20100605025702.GA2019@progeny.tock>
References: <1275704035-6552-1-git-send-email-avarab@gmail.com>
 <1275704035-6552-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 04:57:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKjZV-0005zN-EX
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 04:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817Ab0FEC5M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 22:57:12 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43779 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676Ab0FEC5L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 22:57:11 -0400
Received: by iwn37 with SMTP id 37so1692134iwn.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 19:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tAMzPwwK1BHii4lKF9pSyn6hHbFiQJODsaIuD+Xn4B8=;
        b=BrjwAb2gAhQIyj4qVZdU5+p8YPn8IEzJMvDHj6jnUuXhNiXWyjhAF+JS8gLVuGPAnF
         Muaw3urnwJ90lGaK30f5diPX+dkQ0R5K/y/Lq3uFwQUIs+g1Ns/tBHYg+qExDS2M6QIB
         4H4mUE9aVUawYfWTrXIFSvI3vwFmZz/VpBcUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ey3f3TIc9uM24sx64jSwzrFwZXpMZsSHQVWGWrabCdD6gKAl3CvQ+UFSnMo+za4N5l
         HBf8XPRNCqg/uDt+EEt9OisdvRGm0kxRpnNzrQXqiaAB7jSkbtfwFcd3M6lslwQQXJ5S
         O8KLABhzytXkhuA4JE9Q/IXqzk2rWDE44H9fo=
Received: by 10.231.148.145 with SMTP id p17mr2436538ibv.28.1275706630376;
        Fri, 04 Jun 2010 19:57:10 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d9sm8238711ibl.4.2010.06.04.19.57.09
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 19:57:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1275704035-6552-2-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148451>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> diff --git a/git.c b/git.c
> index 99f0363..d749eab 100644
> --- a/git.c
> +++ b/git.c
> @@ -3,6 +3,7 @@
>  #include "cache.h"
>  #include "quote.h"
>  #include "run-command.h"
> +#include "gettext.h"
> =20
>  const char git_usage_string[] =3D
>  	"git [--version] [--exec-path[=3DGIT_EXEC_PATH]] [--html-path]\n"
> @@ -490,6 +491,8 @@ int main(int argc, const char **argv)
>  	if (!cmd)
>  		cmd =3D "git-help";
> =20
> +	git_setup_gettext();
> +

This handles builtins.  =E2=80=98grep PROGRAM_OBJS Makefile=E2=80=99 re=
veals nine
other source files with their own main() functions.

Jonathan

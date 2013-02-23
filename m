From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/2] update-index: list supported idx versions and their
 features
Date: Sat, 23 Feb 2013 12:53:56 -0800
Message-ID: <20130223205356.GC3222@elie.Belkin>
References: <1361534964-4232-2-git-send-email-pclouds@gmail.com>
 <1361584468-11820-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 21:54:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9M73-0007Ye-EK
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 21:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758380Ab3BWUyD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2013 15:54:03 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:46020 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757986Ab3BWUyB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2013 15:54:01 -0500
Received: by mail-pa0-f45.google.com with SMTP id kl14so1072544pab.18
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 12:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zOSAUQGWEte2SOmYwAVzynYtsb5/aYeM3UWleZfGNBE=;
        b=PlNwR800bq3aK5S5lnybUySFY2PvOP6VH8dytEFvDthMkGal65Ng6sjtKGZS4oq+bI
         NB8nhViASfmIUPhlqNmdTo8Y0cYzf0QdcOirZEJIPCSdOvN14i+gOANUPVyAWWfPB2Ep
         YGYRhfAoPYY4rLLepTQPG7eKvU0y+HukPaDcjsLGV1dVVxpGWrotpKeD+vemiqSH7969
         G0/8C7P3+AVoo/OlOHcbYXZ21llOFUG3IQ9xW67Ac13CyFrmxtj+uyks3omFgH2YgNxt
         j9q+e1mXiAXUAqTjRGrA2uzJj3nrIgiDYswwvlcGiMLWSw3jNM3+6gFtl4+U+/ExVhpo
         fojQ==
X-Received: by 10.68.234.100 with SMTP id ud4mr9984879pbc.8.1361652840854;
        Sat, 23 Feb 2013 12:54:00 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id km10sm7006950pbc.9.2013.02.23.12.53.58
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 12:53:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1361584468-11820-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216913>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -145,7 +145,15 @@ you will need to handle the situation manually.
> =20
>  --index-version <n>::
>  	Write the resulting index out in the named on-disk format version.
> -	The current default version is 2.
> +	Supported versions are 2, 3 and 4. The current default version is 2
> +	or 3, depending on whether extra features are used, such as
> +	`git add -N`.
> ++
> +	Version 4 performs a simple pathname compression that could
> +	reduce index size by 30%-50% on large repositories, which
> +	results in faster load time. Version 4 is relatively young
> +	(first released in 1.8.0 in October 2012). Other Git
> +	implementations may not support it yet.

Markup nit: the second paragraph needs to be unindented, or asciidoc
will treat it as literal text, including line breaks.

Usage nit: s/could/can/

Clarity nit: something like "such as JGit and libgit2" after "Other
Git implementations" would make it clearer, at least to my eyes.

Aside from that, this looks like a good change.

Thanks,
Jonathan

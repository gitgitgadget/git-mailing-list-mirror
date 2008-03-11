From: Mitch Tishmack <mitcht.git@gmail.com>
Subject: Re: [PATCH v7] autoconf: Test FREAD_READS_DIRECTORIES
Date: Tue, 11 Mar 2008 15:46:13 -0500
Message-ID: <8FA8FE5C-373E-4E01-A6DB-0E438054B8F4@gmail.com>
References: <200803110948.35353.michal.rokos@nextsoft.cz>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Tue Mar 11 21:47:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZBNM-0006OF-M4
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 21:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763AbYCKUqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 16:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753606AbYCKUq3
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 16:46:29 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:60754 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbYCKUq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 16:46:28 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2701430wxd.4
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 13:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=JYivcs4lyOwk8xLKLsFpEPyl9RgCaVnBMXsQrTq9n+4=;
        b=iTR67D1rQKieI57rxz+nFB5xBcjh2HlUJq4EgEe41xRL9tswmx49FnYZeuZNNHv4s2rWZ3uujtvYAadhu5mLDqj66DeKfQ2FURpxZKsK27Gf/6eQOd/Cs+Lv69qaR5fNEnA/tZUp3W73MKBxt4MY8evYbrdZv/4XQfARsBYiB0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=SRlxdAZjCw3MMmP7N0JGqiYUUvglyv5HPQJYsRGY8PYWwo/G5s4IEDVoFKvPk+KR98xEy67Id+p1M8m1jSiRYosbt9XJ644SBb9CugzHLJV3WziT6cvcYN94NRvN4tSsWREV4o9+GRkeY2cQewin1GaHrwMYtnPOqEgGIJz6v8c=
Received: by 10.70.53.3 with SMTP id b3mr7814620wxa.82.1205268387395;
        Tue, 11 Mar 2008 13:46:27 -0700 (PDT)
Received: from ?192.168.3.124? ( [71.216.112.176])
        by mx.google.com with ESMTPS id h37sm440155wxd.6.2008.03.11.13.46.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Mar 2008 13:46:24 -0700 (PDT)
In-Reply-To: <200803110948.35353.michal.rokos@nextsoft.cz>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76898>

Can add these systems.

OS X 10.5 x86 - FREAD_READS_DIRECTORIES=UnfortunatelyYes
Tested-by: Mitch Tishmack <mitch.tishmack@gmail.com>

Solaris 10 Update 4 (08/07) x86 - FREAD_READS_DIRECTORIES=
Tested-by: Mitch Tishmack <mitch.tishmack@gmail.com>

mitch

On Mar 11, 2008, at 03:48 AM, Michal Rokos wrote:

> Add test for FREAD_READS_DIRECTORIES to detect when fread() reads  
> fopen'ed
> directory.
>
> Tested on:
> AIX 5.3 - FREAD_READS_DIRECTORIES=UnfortunatelyYes
> HP-UX B.11.11 - FREAD_READS_DIRECTORIES=UnfortunatelyYes
> HP-UX B.11.23 - FREAD_READS_DIRECTORIES=UnfortunatelyYes
> Linux 2.6.25-rc4 - FREAD_READS_DIRECTORIES=
> Tru64 V5.1 - FREAD_READS_DIRECTORIES=UnfortunatelyYes
> Windows - FREAD_READS_DIRECTORIES=
>
> Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>
> Tested-by: Mike Ralphson <mike@abacus.co.uk>
> Tested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> diff --git a/config.mak.in b/config.mak.in
> index 8e1cd5f..7868dfd 100644
> --- a/config.mak.in
> +++ b/config.mak.in
> @@ -46,4 +46,5 @@ NO_MKDTEMP=@NO_MKDTEMP@
> NO_ICONV=@NO_ICONV@
> OLD_ICONV=@OLD_ICONV@
> NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@
> +FREAD_READS_DIRECTORIES=@FREAD_READS_DIRECTORIES@
> SNPRINTF_RETURNS_BOGUS=@SNPRINTF_RETURNS_BOGUS@
> diff --git a/configure.ac b/configure.ac
> index 287149d..82584e9 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -327,6 +327,26 @@ else
> fi
> AC_SUBST(NO_C99_FORMAT)
> #
> +# Define FREAD_READS_DIRECTORIES if your are on a system which  
> succeeds
> +# when attempting to read from an fopen'ed directory.
> +AC_CACHE_CHECK([whether system succeeds to read fopen'ed directory],
> + [ac_cv_fread_reads_directories],
> +[
> +AC_RUN_IFELSE(
> +	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
> +		[[char c;
> +		FILE *f = fopen(".", "r");
> +		return f && fread(&c, 1, 1, f)]])],
> +	[ac_cv_fread_reads_directories=no],
> +	[ac_cv_fread_reads_directories=yes])
> +])
> +if test $ac_cv_fread_reads_directories = yes; then
> +	FREAD_READS_DIRECTORIES=UnfortunatelyYes
> +else
> +	FREAD_READS_DIRECTORIES=
> +fi
> +AC_SUBST(FREAD_READS_DIRECTORIES)
> +#
> # Define SNPRINTF_RETURNS_BOGUS if your are on a system which  
> snprintf()
> # or vsnprintf() return -1 instead of number of characters which would
> # have been written to the final string if enough space had been  
> available.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

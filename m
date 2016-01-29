From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 03/10] test-regex: expose full regcomp() to the
 command line
Date: Fri, 29 Jan 2016 00:31:43 -0500
Message-ID: <20160129053143.GA17334@flurp.local>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
 <1453982183-24124-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 06:32:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aP1f5-0008T7-6i
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 06:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbcA2Fby convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2016 00:31:54 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:36514 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbcA2Fbx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 00:31:53 -0500
Received: by mail-io0-f194.google.com with SMTP id h8so5727795ioe.3
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 21:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UQT/8vC8QHLRPtqcc62TXyBAkze4phL0AUpuPtsxcEQ=;
        b=AGa6bcJjOVR1UuXgtQeY3xgB2nCxnqFz6KNaz1JEQABwjcZHUCkqsrL015NLiLMQnn
         noj/IU01c0DjI0mTHBuB8N5iYdUHNCSyeR5ZAvSOSLaQIvZUCwDpNfwkHQ+70brGeZED
         pS1Qb5JDRDjtYmcbWJwVkNA5HJfnw49b8udcpXdVS2X3UutIlp/CCwRhoBS07BenEyKs
         +Ux1Zfi+2bI9pz8TLLKbEtrsbMF7a3NFn9OL2rcZuazpQz23znW9SznONl24dZbscBIF
         cvF5ka4qg9KnkZ3Ap4kiUC7vdu2YuQsYLz5IyADwlkcyhgwX0IkrX7PHxq+xpSTALKv6
         Ijcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=UQT/8vC8QHLRPtqcc62TXyBAkze4phL0AUpuPtsxcEQ=;
        b=KykSnGc+/7Onl3kJSqqagTtFYQEW37NFywF93DoZ7rTtXifRhHA3qT5jvWuXdTxiTP
         Jh6GUea2T5FxOTrJj8acaIMrhDZuRV5hcz0uEmhpuiwDCLvjaKzhjftqeOqFCELm0xcr
         LCKY9BulZUiH7AeHve2S180Tn5t1vlRsATMvZoD9hLm9RGwwSCxqOj7GV34rYbfyxXZT
         SzIlAw10/DPw3VqsP1r/q7KuKaVL8e6vJspdEInX39GmmoyNVlsLTrBTustYPJH43T9s
         wgLv2dMzwtHaZZr73eKgsqamvoEV2LB98IH9I7o2FSWV4Po5eXs2X012h1JwkLaQNVZs
         9NUw==
X-Gm-Message-State: AG10YOTEId5fPuiCu9rv48HcT/6HQlwPY6hjZeANS3C/dp8qlrKfvrV/jtCfESFFeIH45g==
X-Received: by 10.107.134.160 with SMTP id q32mr8312511ioi.25.1454045513073;
        Thu, 28 Jan 2016 21:31:53 -0800 (PST)
Received: from flurp.local (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id 5sm2211743igr.19.2016.01.28.21.31.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jan 2016 21:31:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1453982183-24124-4-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285060>

On Thu, Jan 28, 2016 at 06:56:16PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/test-regex.c b/test-regex.c
> @@ -1,19 +1,63 @@
>  int main(int argc, char **argv)
>  {
> -	char *pat =3D "[^=3D{} \t]+";
> -	char *str =3D "=3D{}\nfred";
> +	const char *pat;
> +	const char *str;
> +	int flags =3D 0;
>  	regex_t r;
>  	regmatch_t m[1];
> =20
> -	if (regcomp(&r, pat, REG_EXTENDED | REG_NEWLINE))
> +	if (argc =3D=3D 1) {
> +		/* special case, bug check */
> +		pat =3D "[^=3D{} \t]+";
> +		str =3D "=3D{}\nfred";
> +		flags =3D REG_EXTENDED | REG_NEWLINE;
> +	} else {
> +		argv++;
> +		pat =3D *argv++;
> +		str =3D *argv++;

I realize that this is just a test program, but it might be a good
idea to insert:

    if (argc < 3)
        die("usage: ...");

prior to the *argv++ dereferences to give a controlled failure rather
than an outright crash when an incorrect number of arguments is
given.

More below...

> +		while (*argv) {
> +			struct reg_flag *rf;
> +			for (rf =3D reg_flags; rf->name; rf++)
> +				if (!strcmp(*argv, rf->name)) {
> +					flags |=3D rf->flag;
> +					break;
> +				}
> +			if (!rf->name)
> +				die("do not recognize %s", *argv);
> +			argv++;
> +		}
> +		git_setup_gettext();
> +	}
> +
> +	if (regcomp(&r, pat, flags))
>  		die("failed regcomp() for pattern '%s'", pat);
> -	if (regexec(&r, str, 1, m, 0))
> -		die("no match of pattern '%s' to string '%s'", pat, str);
> +	if (regexec(&r, str, 1, m, 0)) {
> +		if (argc =3D=3D 1)
> +			die("no match of pattern '%s' to string '%s'", pat, str);
> +		return 1;
> +	}
> =20
>  	/* http://sourceware.org/bugzilla/show_bug.cgi?id=3D3957  */
> -	if (m[0].rm_so =3D=3D 3) /* matches '\n' when it should not */
> +	if (argc =3D=3D 1 && m[0].rm_so =3D=3D 3) /* matches '\n' when it s=
hould not */
>  		die("regex bug confirmed: re-build git with NO_REGEX=3D1");

Again, I realize that this is just a test program, but sprinkling
this 'argc =3D=3D 1' special case throughout the code makes it
unnecessarily difficult to follow. Some alternatives:

1. Rename the existing test-regex to test-regex-bug (or
   test-regex-bugs), and then name the new general purpose program
   test-regex.

2. Drop the special case altogether and have the program emit the
   matched text on stdout (in addition to the exit code indicating
   success/failure). Most callers will care only about the exit
   status, but the one special case in t0070 which wants to check for
   the glibc bug can do so itself:

    test_expect_success 'check for a bug in the regex routines' '
        # if this test fails, re-build git with NO_REGEX=3D1
        printf "fred" >expect &&
        test-regex "[^=3D{} \t]+" "=3D{}\nfred" EXTENDED NEWLINE >actua=
l &&
        test_cmp expect actual
    '

   Of course, that doesn't actually work because "\n" in the 'str'
   argument isn't really a newline, so test-regex would have to do a
   bit of preprocessing of 'str' first (which might be as simple as
   calling unquote_c_style() or something).

3. [less desirable] Move the 'argc =3D=3D 1' special case to its own
   function, which will result in a bit of duplicated code, but the
   result should at least be easier to follow.

>  	exit(0);
> --=20
> 2.7.0.288.g1d8ad15

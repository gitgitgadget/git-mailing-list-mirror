From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] t0001: check syntax of sample hooks
Date: Sat, 10 Jul 2010 19:53:27 -0500
Message-ID: <20100711005327.GA5744@burratino>
References: <20100711004518.GA5658@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 11 02:54:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXkoL-0006VS-Oy
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 02:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653Ab0GKAyO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Jul 2010 20:54:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54775 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab0GKAyN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jul 2010 20:54:13 -0400
Received: by iwn7 with SMTP id 7so3485136iwn.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 17:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=N3wkr4iO7z0fYIa9lpewexCYQ202+2lutuVjJMtweb8=;
        b=hx/nN/KdL8sGXVcmUWbNr3bKWLrzyIQAqTdE6fGei14ellpFW/IAVoXJvmkIhKy1SG
         HUirLn9DPv5knU+Fm3NLdiuUSoDg1+SDEZ8LbvvI44jHILDJ5A+HPy6UPNNfTqL6hYp+
         1T/p2j8UBp5sISLcv+Ypr3F7L7tc7J1jolfoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=qTH2C/rcEUPGnelcJ7AwS10jBQ2k7CspLw31OdkYWYvBNzwcl2tIV3OI96UnF2gBIk
         hoeyBdzPsicYemnXmVtjfQWVqb1aRItlp3NiRXYqHv+rS99ZcAD+0OvpXuWT/97nIROV
         SFZ9pu/qgNM3rl/+HcUYpsp0CGTI65KDR7l9M=
Received: by 10.231.17.13 with SMTP id q13mr11543853iba.14.1278809652290;
        Sat, 10 Jul 2010 17:54:12 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id n20sm11782220ibe.5.2010.07.10.17.54.11
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 17:54:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100711004518.GA5658@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150738>

Jonathan Nieder wrote:

> +++ b/t/t0001-init.sh
> @@ -141,6 +141,24 @@ test_expect_success 'reinit' '
>  	test_cmp again/empty again/err2
>  '
> =20
> +test_expect_success 'sample hooks use acceptable syntax' '
> +	rm -fr hook-syntax &&
> +	git init hook-syntax &&
> +	(
> +		cd hook-syntax &&
> +		test -d .git/hooks &&
> +		fail=3Df &&
> +		for i in .git/hooks/*.sample
> +		do
> +			read shebang <"$i" &&

This should use =E2=80=98read -r=E2=80=99, for the sake of #!c:\Users\X=
yzzy\bin\bash.exe

*sigh*
Jonathan

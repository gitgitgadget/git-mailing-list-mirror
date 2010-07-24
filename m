From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/6] t/README: A new section about test coverage
Date: Sat, 24 Jul 2010 16:25:43 -0500
Message-ID: <20100724212542.GA5610@burratino>
References: <1280004663-4887-1-git-send-email-avarab@gmail.com>
 <1280004663-4887-7-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 23:26:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcmFB-0003Ty-9m
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 23:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756607Ab0GXV0r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 17:26:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43088 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756273Ab0GXV0r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 17:26:47 -0400
Received: by iwn7 with SMTP id 7so1470704iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 14:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1rnVdSBCvnFhOwkHxV07HAWjnHq5Wuoox3PVVC8xX6c=;
        b=HVKH+LLdCYY4MmLABYXBcMXlcqVRBKmU2SSFeVf1rhEU1R2XBcF29p7PmuF5FWEuOY
         mlLXvg4qVuYBhN+FwsXU+U26BcHvAr8MiFBLiBqZWFvN7oTTSd7JLjqDbkJl+WlEetkI
         Nu5fU9ujd6uU1wo1nvrN/gnbOjb+9knSLR1cA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LlDjMvREpjdGkdX2RTVsMRoUy5dvXAq7Uj7vL3fBdFKgMu89BtuhHWoel4aHr6D7Oe
         6DIePpZdr+ZvIyny99HMiXSCJS3AlRuwqeWcIDz7WIqA4Il+rRqwf/gd4FXkDVKy4ElE
         SqGrzFmervqQTW0QFEZcuwyXTduz3QZs3BDyg=
Received: by 10.231.59.83 with SMTP id k19mr5913329ibh.178.1280006806285;
        Sat, 24 Jul 2010 14:26:46 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r3sm1737688ibk.13.2010.07.24.14.26.45
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 14:26:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280004663-4887-7-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151676>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Document how test writers can generate coverage reports

Very neat!

> --- a/t/README
> +++ b/t/README
> @@ -267,6 +267,9 @@ Do:
>  	git merge hla &&
>  	git push gh &&
>  	test ...
> +   =20
> + - Check the test coverage for your tests. See the "Test coverage"
> +   below.
> =20
>  Don't:

I have a moment=E2=80=99s hesitation reading this, because I suspect te=
st
coverage checking would be most useful if test authors were _not_ to
pay too much attention to it.

Imagine that the git test suite is almost perfect, so it checks all
the important behavior of git, including edge cases (yes, unlikely,
but bear with me for a moment).  Then the test coverage data would be
very useful indeed: it would point out code that is not actually
needed for anything.

However, if new authors make 99% coverage a goal while writing
tests, the result will be lots of useless tests that check
behavior no one cares about and less useful coverage information.

> @@ -508,3 +511,40 @@ the purpose of t0000-basic.sh, which is to isola=
te that level of
>  validation in one place.  Your test also ends up needing
>  updating when such a change to the internal happens, so do _not_
>  do it and leave the low level of validation to t0000-basic.sh.
> +
> +Test coverage
> +-------------
> +
> +You can use the coverage tests to find out if your tests are really
> +testing your code code. To do that, run the coverage target at the
> +top-level (not in the t/ directory):

In other words, I would rather the rationale here read:

	You can use the coverage tests to find code paths that are not being
	properly exercised yet. To do that...

I think it is great if people write new tests that do not exercise
their own code but instead explore related behavior.

That said, with or without any of the changes implied above,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test failures in t4034
Date: Tue, 21 Aug 2012 15:09:36 -0700
Message-ID: <7v1uizdhi7.fsf@alter.siamese.dyndns.org>
References: <80B6C6EE-130C-48C3-BBBB-5FCD1E7EFDEF@gernhardtsoftware.com>
 <5030FD49.6060704@ramsay1.demon.co.uk>
 <7vboi6nzym.fsf@alter.siamese.dyndns.org>
 <5033D573.9030103@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Aug 22 00:09:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3wdt-0005Iv-GX
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 00:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127Ab2HUWJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 18:09:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56643 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758608Ab2HUWJi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 18:09:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AB4E8E26;
	Tue, 21 Aug 2012 18:09:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MyeRQrM/fomfFldLYwZYHfssuyE=; b=ohz9vN
	VIe1mcj7lRggZYMEsbS4dDnapGkQoDCdgONuw+IIUS4us6B56ZNk497P3TIpO3Fk
	OLooZw/tTmpWdpCR8picUrBXWpt6m3+qr9BTFwFIBjMPwByAk4LU6QcNJpMglbUJ
	zsUXqwNqq0GE9lQVkjSdGwRY1sGRTJbQvZrH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y9yiS/YK2df51WLwUEUxFbDb5ygKdKhH
	YsfktmBH4n2WAcRnCi/xnGzw3dcBw9bmMJZSrJiYGtO9Wp/MnwycIfPSJ01rFqQu
	ODV2tNjkUPsDRkLu4nnYQ4yYIUUsil+Zp/gconlMqkuD8/+crx3cBM/zMdd2M6e+
	5q+CyjjsT5c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47A9B8E25;
	Tue, 21 Aug 2012 18:09:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 812698E24; Tue, 21 Aug 2012
 18:09:37 -0400 (EDT)
In-Reply-To: <5033D573.9030103@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue, 21 Aug 2012 19:37:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E59C22D2-EBDC-11E1-AF13-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203999>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> I think that, after some testing, this (or something like it) is the
> best that we can do. What do you think?
>
> ATB,
> Ramsay Jones
>
> -- >8 --
> Subject: [PATCH] test-regex: Add a test to check for a bug in the regex routines
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
> diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
> index 9bee8bf..da2c504 100755
> --- a/t/t0070-fundamental.sh
> +++ b/t/t0070-fundamental.sh
> @@ -25,4 +25,9 @@ test_expect_success POSIXPERM 'mktemp to unwritable directory prints filename' '
>  	grep "cannotwrite/test" err
>  '
>  
> +test_expect_success 'check for a bug in the regex routines' '
> +	# if this test fails, re-build git with NO_REGEX=1
> +	test-regex
> +'

OK.

>  test_done
> diff --git a/test-regex.c b/test-regex.c
> new file mode 100644
> index 0000000..9259985
> --- /dev/null
> +++ b/test-regex.c
> @@ -0,0 +1,35 @@
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <stdarg.h>
> +#include <sys/types.h>
> +#include <regex.h>
> +
> +static void die(const char *fmt, ...)
> +{
> +	va_list p;
> +
> +	va_start(p, fmt);
> +	vfprintf(stderr, fmt, p);
> +	va_end(p);
> +	fputc('\n', stderr);
> +	exit(128);
> +}

Looks like a bit of overkill for only two call sites, whose output
we would never see because it is behind the test, but OK.

> +int main(int argc, char **argv)
> +{
> +	char *pat = "[^={} \t]+";
> +	char *str = "={}\nfred";
> +	regex_t r;
> +	regmatch_t m[1];
> +
> +	if (regcomp(&r, pat, REG_EXTENDED | REG_NEWLINE))
> +		die("failed regcomp() for pattern '%s'", pat);
> +	if (regexec(&r, str, 1, m, 0))
> +		die("no match of pattern '%s' to string '%s'", pat, str);
> +
> +	/* http://sourceware.org/bugzilla/show_bug.cgi?id=3957  */
> +	if (m[0].rm_so == 3) /* matches '\n' when it should not */
> +		exit(1);

This could be the third call site of die() that tells the user to
build with NO_REGEX=1.  Then "cd t && sh t0070-fundamental.sh -i -v" would
give that message directly to the user.

> +	exit(0);
> +}

Thanks.

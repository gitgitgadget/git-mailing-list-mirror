From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] modernize t7300
Date: Mon, 07 Dec 2015 13:40:34 -0800
Message-ID: <xmqq610alyy5.fsf@gitster.mtv.corp.google.com>
References: <CAPig+cRa31uriO4qkZUydooNx0V+dNrUgFvTUxoLL9gCjq9AHQ@mail.gmail.com>
	<1449413906-23256-1-git-send-email-rouzier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: James <rouzier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 22:40:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a63WU-0004Kg-K0
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 22:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038AbbLGVki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 16:40:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756013AbbLGVkh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 16:40:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 82E3131B25;
	Mon,  7 Dec 2015 16:40:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uU/gBtvSVxj6+rzB5lRBrUPhLz8=; b=ZtlG67
	VUiddy8iVhZOQAsjWxXu7Fs//v1+kdXV5Wr06vEYSyAH4yXm8vCacnIS2PiXK+RU
	G9vD7ZQzFvL3KsYrRkeMZqr5CVfFYul/NIW5pNMnLgWqLsxa8MM5aHG+jyg5NSvB
	ruODQgn4nA2jfyMtsbxVefNwOoQ5VWHgS6bpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qUBLuAkw854s2GfP7gCNgQp/Nrc8Hz/i
	k+LLYGQ9FQWEAWPoaLunP2BvNSayHHhC4fO+BNZHBeei4n1bncThfapKshjvmoBA
	wtfrC9MJciFyHz1R5i0nDA+JyUSfuvmaFAPgkGe5dly0G+BA61bT8WKWY9Mul8pK
	rnwSGlTHZUw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7A81531B24;
	Mon,  7 Dec 2015 16:40:36 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F06B231B23;
	Mon,  7 Dec 2015 16:40:35 -0500 (EST)
In-Reply-To: <1449413906-23256-1-git-send-email-rouzier@gmail.com> (James's
	message of "Sun, 6 Dec 2015 09:58:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 26835F4C-9D2B-11E5-A665-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282129>

James <rouzier@gmail.com> writes:

> From: James Rouzier <rouzier@gmail.com>
>
> ---

Missing sign-off.

>  t/t7300-clean.sh | 382 +++++++++++++++++++++++++++----------------------------
>  1 file changed, 190 insertions(+), 192 deletions(-)
>
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 86ceb38..d555bb6 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -28,15 +28,15 @@ test_expect_success 'git clean with skip-worktree .gitignore' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f src/part3.c &&
> -	test -f docs/manual.txt &&
> -	test -f obj.o &&
> -	test -f build/lib.so &&
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&

OK.

> +	test_path_is_missing a.out &&
> +	test_path_is_missing src/part3.c &&

This is better than the original, which may have said "OK" upon
seeing a directory called "a.out".

> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so &&

OK.

>  	git update-index --no-skip-worktree .gitignore &&
>  	git checkout .gitignore
>  '
> @@ -46,15 +46,15 @@ test_expect_success 'git clean' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f src/part3.c &&
> -	test -f docs/manual.txt &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so

The verbosity of this conversion makes me wonder if we want to have
"test_paths_are_files" and "test_paths_are_missing".  For that
matter, this test does not really care about the distinction between
files and directories (e.g. some tests said "test ! -d docs" and
would have passed if there were a 'docs' regular file, but what we
really care about is the path 'docs' is _gone_), so what we want may
be test_paths_exist and test_paths_are_missing.  With that, the
above hunk would become

	test_paths_exist Makefile README src/part1.c src/part2.c \
		obj.o build/lib.so &&
        test_paths_are_missing a.out src/part3.c

I dunno.

>  test_expect_success 'git clean -e' '
>  	rm -fr repo &&
>  	mkdir repo &&
> -	(
> -		cd repo &&
> -		git init &&
> -		touch known 1 2 3 &&
> -		git add known &&
> -		git clean -f -e 1 -e 2 &&
> -		test -e 1 &&
> -		test -e 2 &&
> -		! (test -e 3) &&
> -		test -e known
> -	)
> +	cd repo &&
> +	git init &&
> +	touch known 1 2 3 &&
> +	git add known &&
> +	git clean -f -e 1 -e 2 &&
> +	test_path_is_file 1 &&
> +	test_path_is_file 2 &&
> +	test_path_is_missing 3 &&
> +	test_path_is_file known
>  '

I think this is wrong.  The next test piece will be run inside
"repo" directory with this patch applied.  Don't lose the subshell
here.

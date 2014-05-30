From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] t5538: move http push tests out to t5542
Date: Fri, 30 May 2014 10:26:02 -0700
Message-ID: <xmqqr43b9o0l.fsf@gitster.dls.corp.google.com>
References: <87y4xk8asq.fsf@spindle.srvr.nix>
	<20140530010649.GD28683@sigill.intra.peff.net>
	<20140530013419.GE28683@sigill.intra.peff.net>
	<87lhtj8sqx.fsf_-_@spindle.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nix <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Fri May 30 19:26:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqQZP-00008V-I6
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 19:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934396AbaE3R0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 13:26:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61742 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933239AbaE3R0I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 13:26:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 28C6C1932F;
	Fri, 30 May 2014 13:26:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=buA0BkuFGd1IHRhPhDXLkLgnJ/o=; b=DChK/9
	dzWRoKQBIF5FjB6foTGjIqWWFktEdJnlC44cyzy5Vhc2DEXi8fpPQ31PXModTbE9
	fMFhSsqcuhiUvbYUBN5QX4VAv9GUFWjuK1xQjx5rdm6idMOer+uJfjwseiv2m2sB
	zqfDqHhEOliokTeTH7BamvzWHGbjKlQohGBKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UmsyXuqMzlOr9Rj2btRrADTtaE2zsxIB
	diUFB/a+M1j4V6tfZR68PjlPR8VqBWej57sn40MLq9k0/cpQiccBsH8NeZfeWvUH
	T/ISxNvqa/hadFxqH7I5jsoy8d4lZsnKJ2nB7KM1SlUaL/3yO/TI3/Mg+T59eA3x
	XJPC8x7OfO8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E88A1932E;
	Fri, 30 May 2014 13:26:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7E7C91932C;
	Fri, 30 May 2014 13:26:04 -0400 (EDT)
In-Reply-To: <87lhtj8sqx.fsf_-_@spindle.srvr.nix> (nix@esperi.org.uk's message
	of "Fri, 30 May 2014 11:29:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7A5586D0-E81F-11E3-A732-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250447>

Nix <nix@esperi.org.uk> writes:

> As 0232852b, but for the push tests instead: this avoids a start_httpd
> in the middle of the file, which fails under GIT_TEST_HTTPD=false.
>
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> ---
> On 30 May 2014, Jeff King said:
>> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
>> index be951a4..a980574 100755
>> --- a/t/t5537-fetch-shallow.sh
>> +++ b/t/t5537-fetch-shallow.sh
>
> btw, t5538-push-shallow.sh has the same bug but was not fixed up that I
> can see. (Though I can't see the original fix in the history of master
> either: was it squashed away somehow?)

What do you mean by "the original fix"?

0232852b (t5537: move http tests out to t5539, 2014-02-13) you cited
in your proposed log message?  That is v1.9.1~12^2 and certainly is
reachable from the master branch as master~185^2.

> But something like this is needed.

Thanks for marking the patch not to be applied / still broken.  I
agree that moving http bits into a separate test would be a good way
to go.

> (signed off with my work email address for paranoia's sake.)

As long as your employer is fine with your patch contributed to us,
and assuming that the patch was done on your employer's time, it
would be the right thing to do ;-).  Just FYI, if your From: address
on your e-mail does not match that address, you can start your
message body with "From: Nick Alcock <nick.alcock@oracle.com>", a
blank line and then the true body of your message.

>  t/t5538-push-shallow.sh      |  59 -------------------------
>  t/t5542-push-http-shallow.sh | 101 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 101 insertions(+), 59 deletions(-)
>  create mode 100755 t/t5542-push-http-shallow.sh
>
> diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
> index 8e54ac5..ceee95b 100755
> --- a/t/t5538-push-shallow.sh
> +++ b/t/t5538-push-shallow.sh
> @@ -120,63 +120,4 @@ EOF
>  	git cat-file blob `echo 1|git hash-object --stdin` >/dev/null
>  	)
>  '
> -
> -if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
> -	say 'skipping remaining tests, git built without http support'
> -	test_done
> -fi
> -
> -. "$TEST_DIRECTORY"/lib-httpd.sh
> -start_httpd
> -
> -test_expect_success 'push to shallow repo via http' '
> -	git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> -	(
> -	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> -	git config http.receivepack true
> -	) &&
> -	(
> -	cd full &&
> -	commit 9 &&
> -	git push $HTTPD_URL/smart/repo.git +master:refs/remotes/top/master
> -	) &&
> -	(
> -	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> -	git fsck &&
> -	git log --format=%s top/master >actual &&
> -	cat <<EOF >expect &&
> -9
> -4
> -3
> -EOF
> -	test_cmp expect actual
> -	)
> -'
> -
> -test_expect_success 'push from shallow repo via http' '
> -	mv "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" shallow-upstream.git &&
> -	git clone --bare --no-local full "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> -	(
> -	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> -	git config http.receivepack true
> -	) &&
> -	commit 10 &&
> -	git push $HTTPD_URL/smart/repo.git +master:refs/remotes/top/master &&
> -	(
> -	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> -	git fsck &&
> -	git log --format=%s top/master >actual &&
> -	cat <<EOF >expect &&
> -10
> -1
> -4
> -3
> -2
> -1
> -EOF
> -	test_cmp expect actual
> -	)
> -'
> -
> -stop_httpd
>  test_done
> diff --git a/t/t5542-push-http-shallow.sh b/t/t5542-push-http-shallow.sh
> new file mode 100755
> index 0000000..61a7281
> --- /dev/null
> +++ b/t/t5542-push-http-shallow.sh
> @@ -0,0 +1,101 @@
> +#!/bin/sh
> +
> +test_description='push from/to a shallow clone over http'
> +
> +. ./test-lib.sh
> +
> +if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
> +	say 'skipping test, git built without http support'
> +	test_done
> +fi
> +
> +. "$TEST_DIRECTORY"/lib-httpd.sh
> +start_httpd
> +
> +commit() {
> +	echo "$1" >tracked &&
> +	git add tracked &&
> +	git commit -m "$1"
> +}
> +
> +test_expect_success 'setup' '
> +	git config --global transfer.fsckObjects true &&
> +	commit 1 &&
> +	commit 2 &&
> +	commit 3 &&
> +	commit 4 &&
> +	git clone . full &&
> +	(
> +	git init full-abc &&
> +	cd full-abc &&
> +	commit a &&
> +	commit b &&
> +	commit c
> +	) &&
> +	git clone --no-local --depth=2 .git shallow &&
> +	git --git-dir=shallow/.git log --format=%s >actual &&
> +	cat <<EOF >expect &&
> +4
> +3
> +EOF
> +	test_cmp expect actual &&
> +	git clone --no-local --depth=2 full-abc/.git shallow2 &&
> +	git --git-dir=shallow2/.git log --format=%s >actual &&
> +	cat <<EOF >expect &&
> +c
> +b
> +EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'push to shallow repo via http' '
> +	git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +	(
> +	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +	git config http.receivepack true
> +	) &&
> +	(
> +	cd full &&
> +	commit 9 &&
> +	git push $HTTPD_URL/smart/repo.git +master:refs/remotes/top/master
> +	) &&
> +	(
> +	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +	git fsck &&
> +	git log --format=%s top/master >actual &&
> +	cat <<EOF >expect &&
> +9
> +4
> +3
> +EOF
> +	test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'push from shallow repo via http' '
> +	mv "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" shallow-upstream.git &&
> +	git clone --bare --no-local full "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +	(
> +	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +	git config http.receivepack true
> +	) &&
> +	commit 1s0 &&
> +	git push $HTTPD_URL/smart/repo.git +master:refs/remotes/top/master &&
> +	(
> +	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +	git fsck &&
> +	git log --format=%s top/master >actual &&
> +	cat <<EOF >expect &&
> +10
> +1
> +4
> +3
> +2
> +1
> +EOF
> +	test_cmp expect actual
> +	)
> +'
> +
> +stop_httpd
> +test_done

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5537: move http tests out to t5539
Date: Thu, 13 Feb 2014 12:14:43 -0800
Message-ID: <xmqqy51ekbws.fsf@gitster.dls.corp.google.com>
References: <CACsJy8Do0CRhhC+YvXSmihczOMDT9UpA4a4mEQ1z5MbR3TSXRw@mail.gmail.com>
	<1392297674-4291-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 13 21:15:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE2hA-00049y-6P
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 21:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbaBMUOs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Feb 2014 15:14:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32845 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889AbaBMUOr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Feb 2014 15:14:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EE896B00D;
	Thu, 13 Feb 2014 15:14:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mRdxd0u/8swo
	O22tq9BIAc+SDr0=; b=QsisRT+uYe2qUBl73ReBSMrz9LemdL8VMhgfIlUsTmyh
	QvCixjMfA4uGJz1qTb8uG3URpUd62O8ruhDc/w/w+dqP2TlRirDmRCac8vu78qWa
	Po2j0Y2LAXaRW5e6KoP/GGXbVhBDtfhMdyHHR7nN1EIY8HJSZ9NjcEwlK8Xy8ks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oEegVl
	xrqYD8rC6teoqhSf5IMC+iD/Eiw+uZ02tpXodeqxC1mFVMbMUgkwiAikmxJSE5JL
	eBFCZOKcZCekTP5a1QKp31b3mo1wUSQBKgpR/l2IXHA8JSvbpwG2sAxwJmrcGdS1
	JMNf4A7eVsARaBG+ggOlZCAmEO1aW2bmYPlig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C5106B00B;
	Thu, 13 Feb 2014 15:14:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC9C56B008;
	Thu, 13 Feb 2014 15:14:45 -0500 (EST)
In-Reply-To: <1392297674-4291-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 13
 Feb 2014 20:21:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7B636A9C-94EB-11E3-9557-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242078>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> start_httpd is supposed to be at the beginning of the test file, not
> the middle of it. The "test_seq" line in "no shallow lines.." test is
> updated to compensate missing refs that are there in t5537, but not i=
n
> the new t5539.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  On Thu, Feb 13, 2014 at 8:22 AM, Duy Nguyen <pclouds@gmail.com> wrot=
e:
>  > On Thu, Feb 13, 2014 at 5:12 AM, Jeff King <peff@peff.net> wrote:
>  >> lib-httpd was never designed to be included from anywhere except =
the
>  >> beginning of the file. But that wouldn't be right for t5537, beca=
use it
>  >> wants to run some of the tests, even if apache setup fails. The r=
ight
>  >> way to do it is probably to have lib-httpd do all of its work in =
a lazy
>  >> prereq. I don't know how clunky that will end up, though; it migh=
t be
>  >> simpler to just move the shallow http test into one of the http-f=
etch
>  >> scripts.
>  >
>  > I'll move it out later.
> =20
>  Here it is, on top of nd/http-fetch-shallow-fix because the new test
>  in t5537 is picky and a simple merge resolution wouldn't do it.

Will queue; thanks.

>
>  t/t5537-fetch-shallow.sh               | 57 -----------------------
>  t/t5539-fetch-http-shallow.sh (new +x) | 82 ++++++++++++++++++++++++=
++++++++++
>  2 files changed, 82 insertions(+), 57 deletions(-)
>
> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> index 098f220..3ae9092 100755
> --- a/t/t5537-fetch-shallow.sh
> +++ b/t/t5537-fetch-shallow.sh
> @@ -173,61 +173,4 @@ EOF
>  	)
>  '
> =20
> -if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
> -	say 'skipping remaining tests, git built without http support'
> -	test_done
> -fi
> -
> -. "$TEST_DIRECTORY"/lib-httpd.sh
> -start_httpd
> -
> -test_expect_success 'clone http repository' '
> -	git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PATH/repo=
=2Egit" &&
> -	git clone $HTTPD_URL/smart/repo.git clone &&
> -	(
> -	cd clone &&
> -	git fsck &&
> -	git log --format=3D%s origin/master >actual &&
> -	cat <<EOF >expect &&
> -7
> -6
> -5
> -4
> -3
> -EOF
> -	test_cmp expect actual
> -	)
> -'
> -
> -# This test is tricky. We need large enough "have"s that fetch-pack
> -# will put pkt-flush in between. Then we need a "have" the server
> -# does not have, it'll send "ACK %s ready"
> -test_expect_success 'no shallow lines after receiving ACK ready' '
> -	(
> -		cd shallow &&
> -		for i in $(test_seq 10)
> -		do
> -			git checkout --orphan unrelated$i &&
> -			test_commit unrelated$i &&
> -			git push -q "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
> -				refs/heads/unrelated$i:refs/heads/unrelated$i &&
> -			git push -q ../clone/.git \
> -				refs/heads/unrelated$i:refs/heads/unrelated$i ||
> -			exit 1
> -		done &&
> -		git checkout master &&
> -		test_commit new &&
> -		git push  "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" master
> -	) &&
> -	(
> -		cd clone &&
> -		git checkout --orphan newnew &&
> -		test_commit new-too &&
> -		GIT_TRACE_PACKET=3D"$TRASH_DIRECTORY/trace" git fetch --depth=3D2 =
&&
> -		grep "fetch-pack< ACK .* ready" ../trace &&
> -		! grep "fetch-pack> done" ../trace
> -	)
> -'
> -
> -stop_httpd
>  test_done
> diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shall=
ow.sh
> new file mode 100755
> index 0000000..94553e1
> --- /dev/null
> +++ b/t/t5539-fetch-http-shallow.sh
> @@ -0,0 +1,82 @@
> +#!/bin/sh
> +
> +test_description=3D'fetch/clone from a shallow clone over http'
> +
> +. ./test-lib.sh
> +
> +if test -n "$NO_CURL"; then
> +	skip_all=3D'skipping test, git built without http support'
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
> +test_expect_success 'setup shallow clone' '
> +	commit 1 &&
> +	commit 2 &&
> +	commit 3 &&
> +	commit 4 &&
> +	commit 5 &&
> +	commit 6 &&
> +	commit 7 &&
> +	git clone --no-local --depth=3D5 .git shallow &&
> +	git config --global transfer.fsckObjects true
> +'
> +
> +test_expect_success 'clone http repository' '
> +	git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PATH/repo=
=2Egit" &&
> +	git clone $HTTPD_URL/smart/repo.git clone &&
> +	(
> +	cd clone &&
> +	git fsck &&
> +	git log --format=3D%s origin/master >actual &&
> +	cat <<EOF >expect &&
> +7
> +6
> +5
> +4
> +3
> +EOF
> +	test_cmp expect actual
> +	)
> +'
> +
> +# This test is tricky. We need large enough "have"s that fetch-pack
> +# will put pkt-flush in between. Then we need a "have" the server
> +# does not have, it'll send "ACK %s ready"
> +test_expect_success 'no shallow lines after receiving ACK ready' '
> +	(
> +		cd shallow &&
> +		for i in $(test_seq 15)
> +		do
> +			git checkout --orphan unrelated$i &&
> +			test_commit unrelated$i &&
> +			git push -q "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
> +				refs/heads/unrelated$i:refs/heads/unrelated$i &&
> +			git push -q ../clone/.git \
> +				refs/heads/unrelated$i:refs/heads/unrelated$i ||
> +			exit 1
> +		done &&
> +		git checkout master &&
> +		test_commit new &&
> +		git push  "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" master
> +	) &&
> +	(
> +		cd clone &&
> +		git checkout --orphan newnew &&
> +		test_commit new-too &&
> +		GIT_TRACE_PACKET=3D"$TRASH_DIRECTORY/trace" git fetch --depth=3D2 =
&&
> +		grep "fetch-pack< ACK .* ready" ../trace &&
> +		! grep "fetch-pack> done" ../trace
> +	)
> +'
> +
> +stop_httpd
> +test_done

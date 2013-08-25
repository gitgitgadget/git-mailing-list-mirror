From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] t/t7106-reset-unborn-branch.sh: Add PERL prerequisite
Date: Sat, 24 Aug 2013 23:50:48 -0700
Message-ID: <xmqq8uzql0vr.fsf@gitster.dls.corp.google.com>
References: <1377316906-70338-1-git-send-email-draenog@pld-linux.org>
	<1377316906-70338-4-git-send-email-draenog@pld-linux.org>
	<20130824203414.GD2960@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 08:51:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDUA7-0005vN-W0
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 08:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756111Ab3HYGu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 02:50:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45404 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756040Ab3HYGuy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 02:50:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EDCF2F26D;
	Sun, 25 Aug 2013 06:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BiagbnrJofZ60sQLhEIlgQ1tReQ=; b=dxzRcq
	p/aqBaMV/BEep6QUVW7kV7J6xqIMHoGYyLcU0wVewOGpMGgTAwqrhh+TzHWRJxIF
	mniK44iDhktNPqLO/uzp0cI/tAWOPRR2seswuV3rlpb2DkicTUTweX7yBHCLqEC2
	MpjlSRN5/pbYE+DwRmqwZ4aDkFwOcrGGDC0MI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jUxk6Fo9HaAPYBWE9B4ZZOOzNxSGO7oe
	BS9oYUCixA3JlzwbtSTmfTMbX/AsS+qT+nxTLRa/pwnagbBtMIym9WkELbl4k5sV
	DTbmi709tTdDHizs2y3qB778Fsh54JAkPVLudtHhIuzFBgIrgT8IoT1z5f7xlldQ
	yTdn7ELBu/U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 075622F26B;
	Sun, 25 Aug 2013 06:50:54 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C0A02F26A;
	Sun, 25 Aug 2013 06:50:53 +0000 (UTC)
In-Reply-To: <20130824203414.GD2960@elie.Belkin> (Jonathan Nieder's message of
	"Sat, 24 Aug 2013 13:34:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AF5DD56A-0D52-11E3-B967-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232932>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Kacper Kornet wrote:
>
>> Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
>
> Thanks.
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Here's a style cleanup on top.
>
> -- >8 --
> Subject: reset test: modernize style
>
> Avoid command substitution and pipes to ensure that the exit status
> from each git command is tested (and in particular that any segfaults
> are caught).

Makes sense.

The change to the one that feeds 'y' to "reset -p" may be a bit too
pedantic, as we are not in the business of testing "echo y", though.

> Maintain the test setup (no commits, one file named "a", another named
> "b") even after the last test, to make it easier to rearrange tests or
> add new tests after the last in the future.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  t/t7106-reset-unborn-branch.sh | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/t/t7106-reset-unborn-branch.sh b/t/t7106-reset-unborn-branch.sh
> index 499cd88c..af00ab4d 100755
> --- a/t/t7106-reset-unborn-branch.sh
> +++ b/t/t7106-reset-unborn-branch.sh
> @@ -11,7 +11,10 @@ test_expect_success 'setup' '
>  test_expect_success 'reset' '
>  	git add a b &&
>  	git reset &&
> -	test "$(git ls-files)" = ""
> +
> +	>expect &&
> +	git ls-files >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success 'reset HEAD' '
> @@ -24,28 +27,42 @@ test_expect_success 'reset $file' '
>  	rm .git/index &&
>  	git add a b &&
>  	git reset a &&
> -	test "$(git ls-files)" = "b"
> +
> +	echo b >expect &&
> +	git ls-files >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success PERL 'reset -p' '
>  	rm .git/index &&
>  	git add a &&
> -	echo y | git reset -p &&
> -	test "$(git ls-files)" = ""
> +	echo y >yes &&
> +	git reset -p <yes &&
> +
> +	>expect &&
> +	git ls-files >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success 'reset --soft is a no-op' '
>  	rm .git/index &&
>  	git add a &&
> -	git reset --soft
> -	test "$(git ls-files)" = "a"
> +	git reset --soft &&
> +
> +	echo a >expect &&
> +	git ls-files >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success 'reset --hard' '
>  	rm .git/index &&
>  	git add a &&
> +	test_when_finished "echo a >a" &&
>  	git reset --hard &&
> -	test "$(git ls-files)" = "" &&
> +
> +	>expect &&
> +	git ls-files >actual &&
> +	test_cmp expect actual &&
>  	test_path_is_missing a
>  '

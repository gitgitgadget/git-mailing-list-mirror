From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test: add git apply whitespace expansion tests
Date: Thu, 22 Jan 2015 11:23:32 -0800
Message-ID: <xmqq7fwetya3.fsf@gitster.dls.corp.google.com>
References: <CAO2U3QjGUfnTRO_poS+=-MfE4aYGuWpVJTe20H-u=FgkVy-RYg@mail.gmail.com>
	<CAO2U3Qjn9o_eYayEMCC3S6DBr9kVH7mPL00QGrXAnV2iYRP-=A@mail.gmail.com>
	<CAO2U3Qj-Hg2tb72NgO6wb-aqAxFG7aga2ZDeZNDCPJzGtmHTAA@mail.gmail.com>
	<CAO2U3Qhd_DPP09BUyMr6NKUtOe4EQQ7G83BRg7MbtQXFPjKv8w@mail.gmail.com>
	<CAO2U3Qje-YwcV1d5BK_zZqrTki4AU=emdkUZzEEieRjmoQdmGg@mail.gmail.com>
	<CAO2U3Qi4TWZiNoOQVSW=Ycvp3bpBySZrCGmRLCbRJJes_n2Wkw@mail.gmail.com>
	<99579252-EF8A-4DAF-A49D-2AC5627ED9E3@gmail.com>
	<4157F6B0-DDF4-4F71-A09B-EE216537CA89@gmail.com>
	<xmqqbnly1oqo.fsf@gitster.dls.corp.google.com>
	<xmqqzj9iz3gu.fsf_-_@gitster.dls.corp.google.com>
	<102e322e68e78e39a7c227f3f3e102c@74d39fa044aa309eaea14b9f57fe79c>
	<CAPc5daXVk_ROUy7rmzS0aosWvE2wqw8tHZgomHHkay9CZjhbiw@mail.gmail.com>
	<xmqq1tmnwypp.fsf@gitster.dls.corp.google.com>
	<21FC5344-64BF-46B1-ADA9-DDE3B1FEC8C4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git mailing list <git@vger.kernel.org>,
	Michael Blume <blume.mike@gmail.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 20:23:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YENLw-000153-Cj
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 20:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbbAVTXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 14:23:37 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53258 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752655AbbAVTXf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 14:23:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 97A2631D22;
	Thu, 22 Jan 2015 14:23:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=suXokT9uVUJlFdtisMpvxeW0Pl8=; b=TlFt5G
	h8/OUd5UQZEqGcA1hhT4Q5tsFuFLvhLItZqC7O1Rfz4uIQ0VuqeLDUEUgH8ldzKd
	/0vFwWJWJKfV7U9/edjaKnG1U9B3ef1MKUoWZdPrS6ZlT5rLhoypxgXOxenInMJX
	Yg87N0glkn7VVE1tjWdQoL5dqCA53Tz8EakLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HZ0hbwM7JB/QCLX07DEOSMULIYyiB5/k
	g+oV71kQ7wHkBx4Ye+R11JXW77E1Aw51zz7IV0dhb2wlGcHJ8JDyk7Lm1GKloSxb
	hz8nUaF2BowQMvz2wX5gYJEUp/J+ejQl9rc3lRPaq+U6nYGeM8GNrM1TYpIQKPZ1
	7zV+uHDTQus=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CB5E31D20;
	Thu, 22 Jan 2015 14:23:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0E96B31D1F;
	Thu, 22 Jan 2015 14:23:33 -0500 (EST)
In-Reply-To: <21FC5344-64BF-46B1-ADA9-DDE3B1FEC8C4@gmail.com> (Kyle J. McKay's
	message of "Wed, 21 Jan 2015 22:55:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 28169DE8-A26C-11E4-9B04-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262857>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> On Jan 21, 2015, at 14:33, Junio C Hamano wrote:
>
>> "Kyle J. McKay" <mackyle@gmail.com> writes:
>>
>>> So since I've not been able to get test 2 or 3 to core dump (even
>>> before 250b3c6c) I tend to believe you are correct in that the code
>>> thinks (incorrectly) that the result should fit within the buffer.
>>
>> Thanks; let me steal your tests when I reroll.
>
> Awesome. :)
>
> But please squash in this tiny change if using the tests verbatim:

Thanks.  I actually have a question wrt the need for $MAKE_PATCHES.

It would have been more natural to do something like:

test_expect_success 'setup' '
	printf "\t%s\n" 1 2 3 4 5 6 >before &&
	printf "\t%s\n" 1 2 3 >after &&
	printf "%64s\n" a b c >>after &&
	printf "\t%s\n" 4 5 6 >>after &&
	git diff --no-index before after |
	sed -e "s/before/test-1/" -e "s/after/test-1/" >patch1.patch &&
	printf "%64s\n" 1 2 3 4 5 6 >test-1 &&
	printf "%64s\n" 1 2 3 a b c 4 5 6 >expect-1 &&

	printf "\t%s\n" a b c d e f >before &&
	printf "\t%s\n" a b c >after &&
        ...
	cat test-4 >expect-4 &&
	printf "%64s\n" a b c >>expect-4 &&
	while test $x -lt 100
	do
		printf "%63s%02d\n" "" $x >>test-4
		printf "%63s%02d\n" "" $x >>expect-4
		x=$(( $x + 1 ))
	done &&

	git config core.whitespace tab-in-indent,tabwidth=63 &&
        git config apply.whitespace fix
'

test_expect_success 'apply with ws expansion (1)' '
	git apply patch1.patch &&
        test_cmp test-1 expect-1
'

and if you want test files you can just skip tests #2 and later,
without introducing an ad-hoc mechanism like you did.

Was there something more than that that you wanted from
$MAKE_PATCHES?

In any case, here is an update to that sanity check patch to catch
the two cases the BUG did not trigger.

Sometimes the caller under-counted the size of the result but
thought that it would still fit within the original (hence allowing
us to update in-place by passing postlen==0) but the actual result
was larger than the space we have allocated in the postimage,
clobbering the piece of memory after the postimage->buf.


diff --git a/builtin/apply.c b/builtin/apply.c
index 31f8733..3b7ba63 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2171,6 +2171,12 @@ static void update_pre_post_images(struct image *preimage,
 		ctx++;
 	}
 
+	if (postlen
+	    ? postlen < new - postimage->buf
+	    : postimage->len < new - postimage->buf)
+		die("BUG: caller miscounted postlen: asked %d, orig = %d, used = %d",
+		    (int)postlen, (int) postimage->len, (int)(new - postimage->buf));
+
 	/* Fix the length of the whole thing */
 	postimage->len = new - postimage->buf;
 	postimage->nr -= reduced;

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96954203E2
	for <e@80x24.org>; Fri, 11 Nov 2016 21:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965140AbcKKVJH (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 16:09:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50304 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934727AbcKKVJG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 16:09:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 912C24EA53;
        Fri, 11 Nov 2016 16:09:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NJTqCtBDgekKw3g0oRVhyFD3J5Y=; b=KayADn
        cX9dafn1hKw1DpviTIEVXcmIas2kfH03y0RePFynktFqOwXH1j8E0jVTF+NvnHLb
        QwtNX9UnjbGl6DbbzS2mBIP3mmfBcLd6/CoRT5dmmyF3QNHf7viAIhgvgXYrb8sD
        BLjPvn/7kFYb2Cxj2uToLGMh74hmgdjoNBnWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v80arDQfxZEEXasbKaJh4iB6bFpDqir6
        S1yFwGBaWoa2mLTuABd9f+zHy+Z2fMdSCM/bk+HzZ4zVr62AMOcC/dtIOCFTWV+N
        aNeiM6wUZbx5klH9WGPtdNNo3fYtNxjzZ5NMdtfyw0fVXr9NmmlevFK2S0CKIfK3
        yR736ndQOTk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 890AE4EA52;
        Fri, 11 Nov 2016 16:09:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 052074EA51;
        Fri, 11 Nov 2016 16:09:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH v2] t6026: ensure that long-running script really is
References: <16dc9f159b214997f7501006a8d1d8be2ef858e8.1478699463.git.johannes.schindelin@gmx.de>
        <xmqqfumy51tk.fsf@gitster.mtv.corp.google.com>
        <fbf517ad-7341-eb6d-ab38-4fe91410e57c@kdbg.org>
        <20161111084148.tgtsijn74z2pdylq@sigill.intra.peff.net>
        <6a421222-a138-5647-4965-8ede24d904b2@kdbg.org>
        <xmqq60nt3fqc.fsf@gitster.mtv.corp.google.com>
        <ba2b3f08-87b1-c954-2020-e5a4bece7f83@kdbg.org>
Date:   Fri, 11 Nov 2016 13:09:03 -0800
In-Reply-To: <ba2b3f08-87b1-c954-2020-e5a4bece7f83@kdbg.org> (Johannes Sixt's
        message of "Fri, 11 Nov 2016 21:54:57 +0100")
Message-ID: <xmqqmvh5207k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13DCF6D0-A853-11E6-9AEC-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 11.11.2016 um 21:48 schrieb Junio C Hamano:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> Good point. Here is an updated version.
>>
>> Unfortunately, I already took the version before this one and
>> started my integration cycle today.  I'll wiggle this in; it
>> essentially is about adding a big comment to explain what is going
>> on and then moving the when-finished down below it, right?
>
> Correct.

Thanks.  It has become like so:

-- >8 --
From: Johannes Sixt <j6t@kdbg.org>
Date: Fri, 11 Nov 2016 21:24:44 +0100
Subject: [PATCH] t6026: clarify the point of "kill $(cat sleep.pid)"

We lengthened the time the leftover process sleeps in the previous
commit to make sure it will be there while 'git merge' runs and
finishes.  It therefore needs to be killed before leaving the test.
And it needs to be killed even when 'git merge' fails, so it has to
be triggered via test_when_finished mechanism.

Explain all that in a large comment, and move the use site of
test_when_finished to immediately before 'git merge' invocation,
where the process is spawned.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6026-merge-attr.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 348d78b205..8f9b48a493 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -187,12 +187,20 @@ test_expect_success 'custom merge does not lock index' '
 		sleep 3600 &
 		echo $! >sleep.pid
 	EOF
-	test_when_finished "kill \$(cat sleep.pid)" &&
 
 	test_write_lines >.gitattributes \
 		"* merge=ours" "text merge=sleep-an-hour" &&
 	test_config merge.ours.driver true &&
 	test_config merge.sleep-an-hour.driver ./sleep-an-hour.sh &&
+
+	# We are testing that the custom merge driver does not block
+	# index.lock on Windows due to an inherited file handle.
+	# To ensure that the backgrounded process ran sufficiently
+	# long (and has been started in the first place), we do not
+	# ignore the result of the kill command.
+	# By packaging the command in test_when_finished, we get both
+	# the correctness check and the clean-up.
+	test_when_finished "kill \$(cat sleep.pid)" &&
 	git merge master
 '
 
-- 
2.11.0-rc0-149-gea84a1ce98


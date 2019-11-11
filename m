Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C36E1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 06:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfKKGOO (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 01:14:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64027 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfKKGOO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 01:14:14 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D08FC3859C;
        Mon, 11 Nov 2019 01:14:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vp8zQHnDpDMKNLrHbDH7bCwIlFg=; b=PxvQXK
        2MLoCGvSNEt8gZa2Q+ZpEAH7L8Ro8Ep6BMwJvppGgik56PP8QfwcSrS5BEBytyl2
        80Dm2LrSdrtAEIfEbTYhzitZ+KrycFz/kOz/3TkpL9COxm/rgWNAG/b9+PdArSgb
        koQP2tmTW87Sefqa3ghrGhzCNEY98MauZ8qp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w83EllVP32ui43YOZKM2/au/X+PDxXjx
        lekOnlnuUbRFwn6ZbdJHMv0IV7NmtvFHhxXmv4yUem43exF6EYwzmhzSHiJR0knK
        lQTfndJFcMn38ZNbOekj3nx8sSkm/vLQzsXCJ57TCdKhNCrNEa/W2weNHmG3iL1P
        X/p7MGvIO/g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BBE763859B;
        Mon, 11 Nov 2019 01:14:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 20A2D3859A;
        Mon, 11 Nov 2019 01:14:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 0/9] Improve odd encoding integration
References: <20191031092618.29073-1-congdanhqx@gmail.com>
        <cover.1573205699.git.congdanhqx@gmail.com>
        <xmqqd0dzhxgi.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 11 Nov 2019 15:14:10 +0900
In-Reply-To: <xmqqd0dzhxgi.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 11 Nov 2019 13:02:37 +0900")
Message-ID: <xmqq8sonhrd9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A23A62C-044A-11EA-BFF9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Doan Tran Cong Danh <congdanhqx@gmail.com> writes:
>
>>  t/t3433-rebase-i18n.sh           |  84 +++++++++++++++++++++++++++++++
>>  t/t3433/ISO8859-1.txt            | Bin 0 -> 15 bytes
>>  t/t3433/eucJP.txt                | Bin 0 -> 68 bytes
>>  t/t3900-i18n-commit.sh           |  37 ++++++++++++++
>>  7 files changed, 195 insertions(+), 11 deletions(-)
>>  create mode 100755 t/t3433-rebase-i18n.sh
>
> Doesn't "make test" barf with test-lint failure with this series
> merged to 'pu'?
>
> In other words, isn't 3433 already taken by another series?  

In the meantime, here is what I added to the tip of the series.
Notice that t3434 itself does not have to repeat its own name over
and over this way.

Thanks.

 t/{t3433-rebase-i18n.sh => t3434-rebase-i18n.sh} | 10 ++++++----
 t/{t3433 => t3434}/ISO8859-1.txt                 |  0
 t/{t3433 => t3434}/eucJP.txt                     |  0
 3 files changed, 6 insertions(+), 4 deletions(-)
 rename t/{t3433-rebase-i18n.sh => t3434-rebase-i18n.sh} (89%)
 rename t/{t3433 => t3434}/ISO8859-1.txt (100%)
 rename t/{t3433 => t3434}/eucJP.txt (100%)

diff --git a/t/t3433-rebase-i18n.sh b/t/t3434-rebase-i18n.sh
similarity index 89%
rename from t/t3433-rebase-i18n.sh
rename to t/t3434-rebase-i18n.sh
index 93e5402849..f693a7f4a0 100755
--- a/t/t3433-rebase-i18n.sh
+++ b/t/t3434-rebase-i18n.sh
@@ -16,8 +16,10 @@ Initial setup:
 
 . ./test-lib.sh
 
+test_vector="$TEST_DIRECTORY/t3434"
+
 compare_msg () {
-	iconv -f "$2" -t "$3" "$TEST_DIRECTORY/t3433/$1" >expect &&
+	iconv -f "$2" -t "$3" "$test_vector/$1" >expect &&
 	git cat-file commit HEAD >raw &&
 	sed "1,/^$/d" raw >actual &&
 	test_cmp expect actual
@@ -39,7 +41,7 @@ test_expect_success setup '
 test_expect_success 'rebase --rebase-merges update encoding eucJP to UTF-8' '
 	git switch -c merge-eucJP-UTF-8 first &&
 	git config i18n.commitencoding eucJP &&
-	git merge -F "$TEST_DIRECTORY/t3433/eucJP.txt" second &&
+	git merge -F "$test_vector/eucJP.txt" second &&
 	git config i18n.commitencoding UTF-8 &&
 	git rebase --rebase-merges master &&
 	compare_msg eucJP.txt eucJP UTF-8
@@ -48,7 +50,7 @@ test_expect_success 'rebase --rebase-merges update encoding eucJP to UTF-8' '
 test_expect_success 'rebase --rebase-merges update encoding eucJP to ISO-2022-JP' '
 	git switch -c merge-eucJP-ISO-2022-JP first &&
 	git config i18n.commitencoding eucJP &&
-	git merge -F "$TEST_DIRECTORY/t3433/eucJP.txt" second &&
+	git merge -F "$test_vector/eucJP.txt" second &&
 	git config i18n.commitencoding ISO-2022-JP &&
 	git rebase --rebase-merges master &&
 	compare_msg eucJP.txt eucJP ISO-2022-JP
@@ -64,7 +66,7 @@ test_rebase_continue_update_encode () {
 		echo for-conflict >two.t &&
 		git add two.t &&
 		git config i18n.commitencoding $old &&
-		git commit -F "$TEST_DIRECTORY/t3433/$msgfile" &&
+		git commit -F "$test_vector/$msgfile" &&
 		git config i18n.commitencoding $new &&
 		test_must_fail git rebase -m master &&
 		test -f .git/rebase-merge/message &&
diff --git a/t/t3433/ISO8859-1.txt b/t/t3434/ISO8859-1.txt
similarity index 100%
rename from t/t3433/ISO8859-1.txt
rename to t/t3434/ISO8859-1.txt
diff --git a/t/t3433/eucJP.txt b/t/t3434/eucJP.txt
similarity index 100%
rename from t/t3433/eucJP.txt
rename to t/t3434/eucJP.txt
-- 
2.24.0-309-ga5a95dfdb6


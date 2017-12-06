Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32B6720C11
	for <e@80x24.org>; Wed,  6 Dec 2017 16:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752379AbdLFQr5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 11:47:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64818 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751362AbdLFQry (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 11:47:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C93A9C5FCC;
        Wed,  6 Dec 2017 11:47:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=okFw1H3tz9zfCW5pMLgmok8MPeY=; b=FqzKT1
        BUj0Hqk8ZKmJ60/FzpLIe5huyJXKJLbiWoLCzR+5kGSf6PQdaJEkCzJGVBnFk5cS
        DR2zaSaUQmraMwRRSBysrXMwFy39HgkF8r9bWO1FRoUuUiMbmvgU2wRSzZZ1nKVX
        o0AY/ieGyp6ks3KaBi2TAS6+EuIVa0B/SQ6Uw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NB4FEgzks1rXE41arKmsPKvdswVi7BrN
        Z+RfOAWVbqPBveJSy3pDNxGLT2Z0v5Hu3ZlsnQ/CrLzZyTRhzKB4HNJA5jy4zrpk
        kAnF5j7puvRZE64VjsIBgCIVjX0oiVLNsucMKlIxvr9rFLRB37Vw0voFkf5NnyMv
        8/bH+LKsTx0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C06E0C5FCB;
        Wed,  6 Dec 2017 11:47:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2ED4AC5FCA;
        Wed,  6 Dec 2017 11:47:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ann T Ropea <bedhanger@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v7 4/7] checkout: describe_detached_head: remove ellipsis after committish
References: <20171203212743.10228-1-bedhanger@gmx.de>
        <20171113223654.27732-1-bedhanger@gmx.de>
        <83D263E58ABD46188756D41FE311E469@PhilipOakley>
        <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
        <20171113223654.27732-3-bedhanger@gmx.de>
        <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
        <20171119184113.16630-5-bedhanger@gmx.de>
        <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com>
        <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley>
        <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com>
        <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley>
        <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com>
        <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com>
        <20171124235330.15157-1-bedhanger@gmx.de>
        <xmqq4lpjkl4g.fsf@gitster.mtv.corp.google.com>
        <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
        <20171203212743.10228-4-bedhanger@gmx.de>
        <xmqqshcqmoe7.fsf@gitster.mtv.corp.google.com>
        <20171204231313.17929-1-bedhanger@gmx.de>
        <xmqq8tehjh6f.fsf@gitster.mtv.corp.google.com>
        <20171206002042.18863-1-bedhanger@gmx.de>
Date:   Wed, 06 Dec 2017 08:47:52 -0800
In-Reply-To: <20171206002042.18863-1-bedhanger@gmx.de> (Ann T. Ropea's message
        of "Wed, 6 Dec 2017 01:20:42 +0100")
Message-ID: <xmqqpo7rhkg7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33DE2942-DAA5-11E7-98EA-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ann T Ropea <bedhanger@gmx.de> writes:

> v7: fix style issues (redirection, here-dox, long lines, setting/exporting/unsetting of env var): cf. <xmqq8tehjh6f.fsf@gitster.mtv.corp.google.com>

Thanks.  I'd say this is polished enough already.  Let's stop
rerolling, wait for a few days for others to give final comments and
merge it to 'next'.

I've however queued the following on top of the entire series.  I do
not mind squashing it into this step, though.

-- >8 --
Subject: [PATCH] t2020: test variations that matter

Because our test suite is not about validating the working of the
shell, it is pointless to test variations of how a literal string
'yes' is quoted when assigned to an environment variable.

Instead, test various ways to spell 'yes' (we use strcasecmp() so
uppercased and capitalized variant should work just like 'yes'
spelled in all lowercase) and make sure we take them as 'yes'.  That
is more relevant in testing Git.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t2020-checkout-detach.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 9464069d15..bb4f2e0c63 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -294,15 +294,15 @@ test_expect_success 'describe_detached_head does print SHA-1 ellipsis when asked
 	# Various ways of asking for ellipses...
 	# The user can just use any kind of quoting (including none).
 
-	GIT_PRINT_SHA1_ELLIPSIS="yes" git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	GIT_PRINT_SHA1_ELLIPSIS=yes git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
 	test_i18ncmp 1st_detach actual &&
 
-	GIT_PRINT_SHA1_ELLIPSIS='yes' git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	GIT_PRINT_SHA1_ELLIPSIS=Yes git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
 	test_i18ncmp 2nd_detach actual &&
 
-	GIT_PRINT_SHA1_ELLIPSIS=yes git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	GIT_PRINT_SHA1_ELLIPSIS=YES git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
 	test_i18ncmp 3rd_detach actual &&
 
-- 
2.15.1-465-g070199a3f5


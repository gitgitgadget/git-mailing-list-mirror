Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EBFC1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 21:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732806AbfHAVzG (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 17:55:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50562 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbfHAVzF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 17:55:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BF276A0CF;
        Thu,  1 Aug 2019 17:55:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lKuUF48OqZGrxL7p4KQ2e/UdioI=; b=ZN8poP
        HdsMlWPPui2Uvon9YYYLCoDo8V0AuqEETFdmOkKpy2KnsF3cD9azg5Nut0dEStoo
        Kdgh7o1xCZLNGbsiEyK+xZhMKgxH2RdVxFr7v4Y/hvjbyCP2NhaQcOUOMXr3OVol
        dJaN6GgENF6lAVfaaJPi2/U2yngweCpSrqBOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dXQZpJ29FZzmljAdiS3O0yagDoe9Np+C
        phmxTX3BZp5DPNhMAcdaCEg0XzeNkqH2l8vMX9WYIl94ABmXHSzkZHW7jr5Prw/w
        /LtX1ISt7wplGzUa6WqaZbZ3SI5mBy4oeD1g2FIAJ5SONuuQnf0djloCWiVZTIBW
        82EthA2bwGo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 950B96A0CE;
        Thu,  1 Aug 2019 17:55:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ABB2A6A0C9;
        Thu,  1 Aug 2019 17:55:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com,
        Ariadne Conill <ariadne@dereferenced.org>
Subject: Re: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git v2.23.0-rc0
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
        <20190731231848.GC1933@sigill.intra.peff.net>
        <20190801002125.GA176307@google.com>
        <xmqqlfwcopn1.fsf@gitster-ct.c.googlers.com>
        <20190801213638.GA30522@sigill.intra.peff.net>
        <xmqqa7csmudm.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 01 Aug 2019 14:54:58 -0700
In-Reply-To: <xmqqa7csmudm.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 01 Aug 2019 14:46:29 -0700")
Message-ID: <xmqq5zngmtzh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 029278A6-B4A7-11E9-ADFF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>> +	if (mailmap < 0)
>>>  		mailmap = 0;
>>> -	}
>>
>> This should be "mailmap = 1" to match the commit message, no? (Which
>> also implies we may want a new test).
>
> Gaa, of course.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Thu, 1 Aug 2019 14:48:34 -0700
Subject: [PATCH] log: really flip the --mailmap default

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c      | 2 +-
 t/t4203-mailmap.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 40b4cbf57d..02fa179077 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -205,7 +205,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	userformat_find_requirements(NULL, &w);
 
 	if (mailmap < 0)
-		mailmap = 0;
+		mailmap = 1;
 
 	if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
 		rev->show_notes = 1;
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 43b1522ea2..ede0c292af 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -461,6 +461,11 @@ test_expect_success 'Grep author with log.mailmap' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log.mailmap is true by default these days' '
+	git log --author Santa | grep Author >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'Only grep replaced author with --use-mailmap' '
 	git log --use-mailmap --author "<cto@coompany.xx>" >actual &&
 	test_must_be_empty actual
-- 
2.23.0-rc0-155-g5fbf3435fe


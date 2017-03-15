Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0211C202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 22:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754290AbdCOW6y (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 18:58:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60774 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754278AbdCOW6v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 18:58:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 849407AE5A;
        Wed, 15 Mar 2017 18:50:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=q5at
        KYOej5WigfuoOZlMiU3Bsfw=; b=A5ejdcmyaOjj62yXFqWNHzsFiC19vWy14az5
        szVVlLCyoh+LeuMwVK0kegc2YojfpBEfk7r5SimhYKwpypTkC6r5PpVm7QFDfrlt
        GVDoI2p0NdfTMQbj1xJKnvh1QZH8pubwo9IKhM4rOSRGG9e1PNBcs1RjPtyW51kj
        jfm0GGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        ZIbonH4MS4qbVaj9bBSQ8IIcNzjzskAkxiaL1RaaQEVcvRm8bqt9fJbwjjE7SGGe
        6LhPkg12kTfOK/q8wRCdHtJnpT+W0Flg6gvgSyMIIKx/MaDTxH+BfVwkylK8qspk
        TlW3CD18jUJaABEupUb6dlHjdoFQ2AzyjLP8oAPI5jQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E92E7AE59;
        Wed, 15 Mar 2017 18:50:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D532B7AE56;
        Wed, 15 Mar 2017 18:50:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/2] Teach name-rev to pay more attention to lightweight tags
Date:   Wed, 15 Mar 2017 15:50:43 -0700
Message-Id: <20170315225045.15788-1-gitster@pobox.com>
X-Mailer: git-send-email 2.12.0-306-g4a9b9b32d4
In-Reply-To: <xmqqd1die00j.fsf@gitster.mtv.corp.google.com>
References: <xmqqd1die00j.fsf@gitster.mtv.corp.google.com>
X-Pobox-Relay-ID: D411C766-09D1-11E7-8DC5-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a reroll of what I did in

    http://public-inbox.org/git/xmqqd1die00j.fsf@gitster.mtv.corp.google.com/

Junio C Hamano (2):
  name-rev: refactor logic to see if a new candidate is a better name
  name-rev: favor describing with tags and use committer date to tiebreak

 builtin/name-rev.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++------
 t/t4202-log.sh     |  2 +-
 2 files changed, 57 insertions(+), 8 deletions(-)

-- 
2.12.0-306-g4a9b9b32d4


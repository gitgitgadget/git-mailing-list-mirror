Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29DA720372
	for <e@80x24.org>; Fri, 13 Oct 2017 05:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752808AbdJMFLf (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 01:11:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56365 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751353AbdJMFLf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 01:11:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67207B3085;
        Fri, 13 Oct 2017 01:11:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id; s=sasl; bh=e/iOoTeC43TYFOjOn4lXQuP7aQA
        =; b=H001HRhXj85nquYGGEr3eLHfFeRUAiAva9tx4S5YBM4M+VFvzYDbX22doEX
        JcGHUv2fvQZ43jwbJsRXhzBBE9KVL3y2HQcxJp02lj7f8xj5quHuFlvqfgcN0qlQ
        vIsJI9uy8Do6Pveu88QMiDHCS5fU09IpDIvcHF+BsgKRbtTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id; q=dns; s=sasl; b=EuBjt+iePc5S6nWrMpgRogBaj6HDl
        NW239LTEFAwYbNQ5kZ18b4pHHaHBrEfeQkvw5mg7uRCA6UNFyqzw7uxXaOZ7J+sF
        KuRLqqrTPyN6mqAFyJyXWtQUQcZAiZvQCcFIVYheIE3ov3vWstutLjW3HQvr/Htf
        pbRGppAOMbBuok=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5946AB3084;
        Fri, 13 Oct 2017 01:11:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 879E4B3083;
        Fri, 13 Oct 2017 01:11:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] a small branch API clean-up
Date:   Fri, 13 Oct 2017 14:11:29 +0900
Message-Id: <20171013051132.3973-1-gitster@pobox.com>
X-Mailer: git-send-email 2.15.0-rc1-158-gbd035ae683
X-Pobox-Relay-ID: FAEAF67E-AFD4-11E7-B5C1-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This started as a little clean-up for a NEEDSWORK comment in
branch.h, but it ended up adding a rather useful safety feature.

Junio C Hamano (3):
  branch: streamline "attr_only" handling in validate_new_branchname()
  branch: split validate_new_branchname() into two
  branch: forbid refs/heads/HEAD

 branch.c                | 44 ++++++++++++++++++++++++++++++--------------
 branch.h                | 27 ++++++++++++---------------
 builtin/branch.c        |  8 ++++----
 builtin/checkout.c      | 10 +++++-----
 sha1_name.c             |  2 +-
 t/t1430-bad-ref-name.sh |  8 ++++++++
 6 files changed, 60 insertions(+), 39 deletions(-)

-- 
2.15.0-rc1-158-gbd035ae683


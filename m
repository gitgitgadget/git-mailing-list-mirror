Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E53461F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 23:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754637AbcI1XfA (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 19:35:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62967 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932838AbcI1Xa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 19:30:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A9F541BF8;
        Wed, 28 Sep 2016 19:30:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=bztA
        xLaabhBQ+vzkbyiZ/C8oXiQ=; b=MACc22goe6so5n8QyhySD9XyahlN0L5/D9xG
        EveEagTkG/zfolDUi/8xWWv9EWlt/YP1jXddG6GXmuCfd9ogwdcAo/dcEXpgFisn
        GmnxWUel8EDzIH/xdo49W720rLd5Ay1/Uqr09Qinm01b8UT1RG/WuCvQ1YI84HBU
        bPsZ62c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        OCIAi8XmsHslIp5Pm/3222YrCWfCc+sdGBN/ZJdxhYbs2igbStTdWQIFVSJ1sZVw
        hn7T0WuxcHnigoj0F9hKIFjsx6tO8xAH1ctZbsDUq8hlUscFb1ThmpHJLWuAHUeH
        Gi7euw5DVxZ9YEhK3/P/ig9Va+IMkyshVQbiC3xK5bw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C56041BF7;
        Wed, 28 Sep 2016 19:30:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8110A41BF3;
        Wed, 28 Sep 2016 19:30:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, torvalds@linux-foundation.org
Subject: [PATCH 0/4] raising core.abbrev default to 12 hexdigits
Date:   Wed, 28 Sep 2016 16:30:43 -0700
Message-Id: <20160928233047.14313-1-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-584-gc9e068c
In-Reply-To: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
X-Pobox-Relay-ID: 96C52D30-85D3-11E6-980A-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per request/suggestion by Linus. 

This took far more effort to keep the existing tests working than
the actual change.

Junio C Hamano (4):
  config: allow customizing /etc/gitconfig location
  t13xx: do not assume system config is empty
  worktree: honor configuration variables
  core.abbrev: raise the default abbreviation to 12 hexdigits

 builtin/worktree.c     |  2 ++
 cache.h                |  1 +
 config.c               |  2 ++
 environment.c          |  2 +-
 t/gitconfig-for-test   |  9 +++++++++
 t/t1300-repo-config.sh | 39 ++++++++++++++++++++++++++++-----------
 t/t1308-config-set.sh  |  1 +
 t/test-lib.sh          |  4 ++--
 8 files changed, 46 insertions(+), 14 deletions(-)
 create mode 100644 t/gitconfig-for-test

-- 
2.10.0-584-gc9e068c


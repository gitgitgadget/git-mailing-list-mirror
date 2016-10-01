Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C0D2207EC
	for <e@80x24.org>; Sat,  1 Oct 2016 00:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752433AbcJAATn (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 20:19:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53796 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751505AbcJAATm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 20:19:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D41543ABB;
        Fri, 30 Sep 2016 20:19:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id; s=sasl; bh=khkxJnFgkQdmImYbJcAmNQkJw9U
        =; b=c/nGQhF+gOqjiCpJzBnq1cMQev7jHE+Cb/Gs4X251letuxrmGXNOlmN155m
        gBdJwpLfn9g9WuMCt5VOzqEUIp1yZhzzVE+H2RHp6bfBGCO/qMb7Pm901ZLYXawO
        TA19oa/qW9V6zZApNSzC8KsftSgvnzodNic5wCTd04gXaFNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id; q=dns; s=sasl; b=Dx2sCM5bcNAuY4A1VQ8jSirUXprcH
        DjGwkF0pHKpSstEa5vDnxeYT+/G32mDauf7iNb9EIpVdA84X+xVmvoWRD31KFB5w
        DlAXswXGiTfuuesZnplQe+2oW3SjsHy1P1nDFy/gg0X3bT0hltG3l4c1FH0Z1E4u
        z2dBQTDyN049ZQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6675643ABA;
        Fri, 30 Sep 2016 20:19:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E129143AB9;
        Fri, 30 Sep 2016 20:19:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] auto-sizing default abbreviation length
Date:   Fri, 30 Sep 2016 17:19:34 -0700
Message-Id: <20161001001937.10884-1-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-622-g05f606bbb0
X-Pobox-Relay-ID: BE3E1C42-876C-11E6-B7CF-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So here is what I queued in 'pu' tonight after back and forth with
Linus and Peff.  The third step from Linus needs to be signed off
and also a meaningful log message for it needs to be written, and
also may need to be updated to include what Linus did in [*1*], but
otherwise I think these are in good enough shape for people to start
playing with them.

They apply on top of Peff's jk/ambiguous-short-object-names topic
that ends at 5b33cb1fd7 ("get_short_sha1: make default
disambiguation configurable", 2016-09-27).


*1*

http://public-inbox.org/git/<CA+55aFxyF=xX84AXr8MG14MRHwdrQw00PBM20UfqBdidaeqdMg@mail.gmail.com>


Junio C Hamano (2):
  abbrev: add FALLBACK_DEFAULT_ABBREV to prepare for auto sizing
  abbrev: prepare for new world order

Linus Torvalds (1):
  abbrev: auto size the default abbreviation

 builtin/fetch.c     |  3 +++
 builtin/rev-parse.c |  5 +++--
 cache.h             |  4 ++++
 diff.c              | 25 +++++++++++++++++++++++--
 environment.c       |  2 +-
 sha1_name.c         | 28 +++++++++++++++++++++++++++-
 transport.h         |  3 +--
 7 files changed, 62 insertions(+), 8 deletions(-)

-- 
2.10.0-622-g05f606bbb0


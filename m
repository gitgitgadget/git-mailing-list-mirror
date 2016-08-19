Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EDD41F859
	for <e@80x24.org>; Fri, 19 Aug 2016 20:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755538AbcHSUub (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 16:50:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55837 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755533AbcHSUua (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 16:50:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 08F8235C5F;
        Fri, 19 Aug 2016 16:50:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UdwYHVCyZoAg9hccpQZQHpXfYLQ=; b=r7G3s2
        RmSB0o9TSE2XhjF/lgnQ4KHBeoe4GJilaltZaBHA+cWa3jVKRb3w3SwXVQkNiNJ5
        Ob+NSw6hx76pqnS4qbG73UCA4Zd9qAtzLqZARAF9AsH/CyRtueGxHS5oJr2rNJ2w
        sA/rGuw87wexU1Wal7zKRNhrr5dHJMYXMP2d8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VCegwqG+4z3Dqe454Z4yzak8J6+i+kBC
        4QouNYlHlLAgvUF/5Y+LzYNjRe2lNfH+UgrKBixwZumtYiaRb/pVh9hH0jjP4qzu
        c6CDLVmxnHjWxQ5LODxmvwDbEgvpd5ZZ8ttEA+Ga+eJdcpzwfoyBEypxRKvJmbF/
        C3bHrL3vxLk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F256D35C5D;
        Fri, 19 Aug 2016 16:50:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6633835C5C;
        Fri, 19 Aug 2016 16:50:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v8 7/8] cache: add empty_tree_oid object
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
        <20160819000031.24854-8-jacob.e.keller@intel.com>
        <xmqqfuq01oww.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xp6VDdMnh-srDzToSwh3mZrQei+B8DjpB2N6OkqAuARkw@mail.gmail.com>
Date:   Fri, 19 Aug 2016 13:50:20 -0700
In-Reply-To: <CA+P7+xp6VDdMnh-srDzToSwh3mZrQei+B8DjpB2N6OkqAuARkw@mail.gmail.com>
        (Jacob Keller's message of "Fri, 19 Aug 2016 13:35:51 -0700")
Message-ID: <xmqq7fbc1o1f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CABEF9A-664E-11E6-BFBE-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> Is there a reason for that? I've found that .field = value is safer
> because it ensures that you don't end up initializing the wrong
> values? Or is it a compatibility thing?

Yes.

Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B944C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0502073D
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z7fGe27/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfLJUKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:10:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59484 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfLJUKS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 15:10:18 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4252B2EC6;
        Tue, 10 Dec 2019 15:10:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4lhENtB5/xFUcRV9UxeJz2ohqtE=; b=Z7fGe2
        7/RCfQ/8sN3qtZpHijFgLaQ6oU3e6w6Hz29ThGntr7g5vq7SStg8W7RdICkYUh1v
        sQE9xFk2IeXqQLm2jUkmAq2+g7GzmUuUHEpQtslK7LsmVIi5qVpfYF0h1IRJG65U
        /2YY9f7KVwJ5zALOqitGurT7XSv8Q2eDE4yJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mbKF6YHRv3K/kvIo8RR4KSFAsBgE7Qs6
        QWN6YdIEReeASYhMJn3EVL05LN7ZXGIXpXZK0HfhZ6wj5UkIFPCfZGpv7IJp7EHL
        3hNF7MdHGERTujJheV5h56eWQZBd18HNyALwqDFTYtUXPRj+17lHPcsBetNztTq5
        i64T0gOGS3E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CB6DFB2EC5;
        Tue, 10 Dec 2019 15:10:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EACADB2EC4;
        Tue, 10 Dec 2019 15:10:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     KOLANICH <kolan_n@mail.ru>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: Could /Documentation/technical/commit-graph.txt be relicensed under a permissive license?
References: <E2770343-BB39-458C-835E-04F0753783C3@mail.ru>
Date:   Tue, 10 Dec 2019 12:10:11 -0800
In-Reply-To: <E2770343-BB39-458C-835E-04F0753783C3@mail.ru> (KOLANICH's
        message of "Tue, 10 Dec 2019 22:31:18 +0300")
Message-ID: <xmqqimmoq6vw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 137EF4E8-1B89-11EA-8834-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

KOLANICH <kolan_n@mail.ru> writes:

> ... the license of git itself is GPL, so I am not
> allowed to use these 2 files to create an own permissive-licensed
> tool reading this file. 

It is a wrong conclusion, isn't it?

GPL copyright protects the expression of the document, but the
copyright protects only the expression, and does not protect the
underlying format itself and the idea behind it.  So I do not see a
need to relicense the documentation text at all.


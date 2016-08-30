Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4C231F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 16:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757686AbcH3QXF (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 12:23:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52581 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753438AbcH3QXE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 12:23:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 702DC3989D;
        Tue, 30 Aug 2016 12:23:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eF0Oq5vPm/0YxBA6jpZZ8GCApLQ=; b=xKHw0u
        JYv/1tJISyEc5Wyek8xgeeeAX0C+7iQ8tGN9hlcIAKjJME3U4Jb5zuCEU6+QP49b
        PpEShIa9uCgxEc4xuNaXQ/s1QWGF2GgpMPYYQjK6HK603m5wDtIJR1OuKRXLWFb2
        Ns6PVHG8s8FSd6p0zRyRucsyPon8qJ7M4nB40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wAl9Tmp9t7O+mrUGIeGlpqVL+V5C6qip
        xxUACW+yq1INhXO3xaLeA/Nhcu9xvZmLWT6HnvaDXX7zs8fICa56MIWSX5swv5JH
        dojqT/rO9J/SCIz+PAFe5f/dj+XIFeM3Lft57fUEji0/LM9kFI8MPPdHsjUYgQqE
        SzSX3dw0Nl0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 679FF3989C;
        Tue, 30 Aug 2016 12:23:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9B5B3989B;
        Tue, 30 Aug 2016 12:23:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] require_clean_work_tree: ensure that the index was read
References: <cover.1472137582.git.johannes.schindelin@gmx.de>
        <4122fc996a0076c2426d5e1325f2ce2810ef4f9b.1472137582.git.johannes.schindelin@gmx.de>
        <xmqqmvjv6uxn.fsf@gitster.mtv.corp.google.com>
        <xmqq60qj6kmf.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1608301300010.129229@virtualbox>
        <alpine.DEB.2.20.1608301645170.129229@virtualbox>
Date:   Tue, 30 Aug 2016 09:23:00 -0700
In-Reply-To: <alpine.DEB.2.20.1608301645170.129229@virtualbox> (Johannes
        Schindelin's message of "Tue, 30 Aug 2016 16:46:25 +0200 (CEST)")
Message-ID: <xmqq1t166xaz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06517810-6ECE-11E6-B022-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Scatch that.  That would not work in a freshly created repository
>> > before doing any "git add".  An empty index is a normal state,...
>
> Alas, that does not work, either. If no .git/index exists, read_index()
> will not set the "initialized" flag.

Exactly

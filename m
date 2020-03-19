Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046B3C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 00:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1BD20719
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 00:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iWgZ4jUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgCSAJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:09:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56639 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSAJF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 20:09:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4E8640263;
        Wed, 18 Mar 2020 20:09:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/8bdMqqrdpUJLRQ0coBcU/k/0gM=; b=iWgZ4j
        Uc5sEB2QAzuthTgcF6bc+f312OnSZe6mNsLXfZgLOiAVmGLLbu8Hw3BQ9kThsekC
        g7B7kskjipXZXjeveEAVj11LWhcpiEGCSSwEcWycSSgKLif4q60Wo3kip84M0nL6
        WFe9j96XF1MQlECfxosHeQNqQdsmQtkyg+OOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BqFqkziY/PHBTu+vcjg7MuJJrd4JE4dN
        Uq0sQKDblI2eU/+54M8n2/MdG5rrfmdE2zy3TYj3Wz0fhPTgzktMRrCgKS5oGy0T
        LbWOYZ3lzew5aw8ssTTb4pvL0KsKYjYxvCZzkOFciS8ocRHwVZ33gTtJfSOXCv0+
        rsc9jiejriE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CA56240262;
        Wed, 18 Mar 2020 20:09:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E8CF34025F;
        Wed, 18 Mar 2020 20:09:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/1] docs: add a FAQ
References: <20200315223923.170371-1-sandals@crustytoothpaste.net>
        <20200315223923.170371-2-sandals@crustytoothpaste.net>
        <20200318230030.GA45325@google.com>
Date:   Wed, 18 Mar 2020 17:09:00 -0700
In-Reply-To: <20200318230030.GA45325@google.com> (Emily Shaffer's message of
        "Wed, 18 Mar 2020 16:00:30 -0700")
Message-ID: <xmqqo8stdx43.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D699C36A-6975-11EA-BB7A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Not really on topic for this particular paragraph, but there are a lot
> of instances of "Some people ..." - in general, would it be less
> combative to say something like "It's tempting to..." or "It might seem
> like a good idea to..."? That way it feels less like "there are people
> who do X and they are wrong" and more like "X might seem like a good
> idea but it isn't". Or to put it another way, let's attack the bad idea,
> not the people who suggest it.

Thanks for a perspective; I personally did not find that "Some
people do X" accuses them of doing it wrong, but you certainly
have a point.

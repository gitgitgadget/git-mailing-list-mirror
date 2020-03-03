Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E21C3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B9220870
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uvlnnu2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgCCW30 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:29:26 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51104 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbgCCW30 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 17:29:26 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A41FCA6EF;
        Tue,  3 Mar 2020 17:29:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7SI4pWQ2jI0ndke7aFFGCVhf0gU=; b=uvlnnu
        2eJlpkBn9lugrd8oatorMbXBT79wlEv2D8qUzRtttyY7bnASadX6cUp4kFAwez/j
        oqmwPd/5Tr4yQYLU9a2d0nUnq/4Cg3kLgcfPHCKFXnCBC+YZcMnYmiMEun8zhSiS
        QZRuK+C9/YL0uz95YagCne1lXrpUKil7sIHgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kM/gN6ZHR6kDyVd3hHGZX1B4T/9gBDMt
        /92x6R/sZO/ddF9BrSozpaRwR4shynaZ/fs9Oq1fWieGxuOzEfby9Ldy4vxxYh0/
        CnyO0ZTGxaCIDPUPvaXZLoub6wY1Go+aKH01xN8dYPbwNlm7fTPX3Dzwwdy15nDE
        /VVm8dL/VXU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81F25CA6EE;
        Tue,  3 Mar 2020 17:29:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A56A2CA6EA;
        Tue,  3 Mar 2020 17:29:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: update the documentation of pack-objects and repack
References: <20200228154357.1710521-1-damien.olivier.robert+git@gmail.com>
        <20200228154357.1710521-2-damien.olivier.robert+git@gmail.com>
        <xmqqk142bn5f.fsf@gitster-ct.c.googlers.com>
        <20200303174136.ess5lfxrsrt6qvdu@feanor>
        <xmqqa74x8e9k.fsf@gitster-ct.c.googlers.com>
        <20200303212302.znhumbjo7lywyhvh@doriath>
Date:   Tue, 03 Mar 2020 14:29:20 -0800
In-Reply-To: <20200303212302.znhumbjo7lywyhvh@doriath> (Damien Robert's
        message of "Tue, 3 Mar 2020 22:23:02 +0100")
Message-ID: <xmqqa74x6pj3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E6ABD18-5D9E-11EA-BEFF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> So do you suggest instead to remove all references to 'git-pack-objects'
> in 'git-repack'?

Not really.  If you are trying to remedy ...

> This is a high level overview, but the user who knows a bit about Git
> internals may wonder what exactly 'all' entails: non local objects, kept
> objects, promisor objects, unreachable objects?

... this kind of thing, I do not think that a solution that is the
best for readers is not this:

> Knowing that the default options passed are:
> `--keep-true-parents`, `--all`, `--reflog`, `--indexed-objects`, `--exclude-promisor-objects`

that requires them to go down and read what --indexed-objects (for
example) means in the documentation for "git pack-objects" command,
and piece together what they mean when they are used together.

> answers this questions: it is essentially all objects except unreachable ones.

Yes, "all objects except unreachable ones", which you came up with,
is a good description, I would think.

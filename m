Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B70181F731
	for <e@80x24.org>; Wed,  7 Aug 2019 21:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfHGVxT (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 17:53:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57142 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfHGVxT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 17:53:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03F2F171DDB;
        Wed,  7 Aug 2019 17:53:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J0r2eNQbPMm6FxrGhW+1DGW25SQ=; b=qdMzgF
        KhI34XOxWfBsgxxemoGWntkhlsUmNmTe9fDfdGRN53rYNJaDKIUve6K2fqaMahAX
        2FH0GLCzHeDWYwq96tfFi0MESytfmGxZrdEAeehvjjd1CoN+2glHCBAO3eppZIV3
        pzoGXqS6V6BtRF5tH+dWbunR1TG07MHWJ+qB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O1Y5ObFl5hXNIM9c0yAN5u1yXyn8Pey7
        GkZm9YkAdUoRlAWIusuuN9LC/uVhvfyxjyJnHtQZP9FQl3Sy+mn/ay3IVJisG+gR
        pBrykQZtu42qqf1b1kHdY+aXYqzCs09qAu04QI08D8r/l8p8h2D2RtubCfEUinvr
        R9ZI+euzik4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF7E0171DDA;
        Wed,  7 Aug 2019 17:53:16 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6271C171DD9;
        Wed,  7 Aug 2019 17:53:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: Call do_quit before destroying the main window
References: <20190804143919.10732-1-me@yadavpratyush.com>
        <b7cbe50d-879f-68b9-30b2-181c3058297f@yadavpratyush.com>
        <xmqqftmejgr1.fsf@gitster-ct.c.googlers.com>
        <549ad583-5ca1-7096-f4ce-10e8a836f7f9@yadavpratyush.com>
        <xmqq5zn8j25p.fsf@gitster-ct.c.googlers.com>
        <9a425bf6-1138-48db-3506-6bee1eff21ee@yadavpratyush.com>
Date:   Wed, 07 Aug 2019 14:53:15 -0700
In-Reply-To: <9a425bf6-1138-48db-3506-6bee1eff21ee@yadavpratyush.com>
        (Pratyush Yadav's message of "Thu, 8 Aug 2019 02:33:42 +0530")
Message-ID: <xmqqa7ckhcc4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2E1FD06-B95D-11E9-8049-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> I think you misunderstood me. I do not mean to create a GitHub pull
> request, because as you say, no one other than me and you will look at
> it. What I meant was that I can pile up a bunch of commits, and send
> them on this list here for you to merge. I can explain those changes
> in the cover letter, so people not very familiar with git-gui or
> Tcl/Tk can still get a general idea of what's happening.

If you meant to volunteer to act as a git-gui maintainer, that would
be wonderful.  Then I do not have to play an interim maintainer.

Or did you mean to do that only for your own patches, forcing _me_
to become a de-facto interim maintainer for git-gui project?  You
effectively ended up doing so for this single patch already ;-)

I will not be able to continue doing so for anything more complex or
controversial, though.

Thanks.

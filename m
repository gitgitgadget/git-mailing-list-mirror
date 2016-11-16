Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D292042F
	for <e@80x24.org>; Wed, 16 Nov 2016 18:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933080AbcKPSN3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 13:13:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56612 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933562AbcKPSLR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 13:11:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8AD744D82E;
        Wed, 16 Nov 2016 13:11:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1+9CGVXMHwUJGbi2izly9ZrBL4s=; b=SkgaBA
        K31Leg7jY6XT7V47Slqp/cSaYu7021o/SViBCWebmAMQ5Vd2d+pa1AL/KJPLhBwM
        1ByLzdRl119HCOFkvcjqzyAniXV369GrbyJco9n47gGxnQHEp723GeCPhnbJWjUA
        Sv0ixH46BXfvrEqovkkdcwSj830v7KO8xZpqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=diHxVO1k655+aihrN3+9GKsVC9yikLyR
        ZwThicb8xIKtAwn2XcJr+cGkmF/+yo9YeanYJiMhe9nWBuvKYQ8I0ySwOEMnCY4Q
        60MLYSjj2qUM/d2iGdt0wf9cMP7X9SojXREEi8tZCRwVuX4q7gjhA6XlBqk5UKt8
        JWl4m3HKrEQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81AA44D82D;
        Wed, 16 Nov 2016 13:11:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E9FF54D82A;
        Wed, 16 Nov 2016 13:11:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/11] git worktree (re)move
References: <20161112022337.13317-1-pclouds@gmail.com>
        <xmqqeg2gyv1v.fsf@gitster.mtv.corp.google.com>
        <xmqqa8d4yts7.fsf@gitster.mtv.corp.google.com>
        <20161116130533.GA5393@ash>
Date:   Wed, 16 Nov 2016 10:11:13 -0800
In-Reply-To: <20161116130533.GA5393@ash> (Duy Nguyen's message of "Wed, 16 Nov
        2016 20:05:34 +0700")
Message-ID: <xmqqy40jqoqm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 101373FC-AC28-11E6-A167-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> The following patch should fix it if that's the same thing you saw. I
> could pile it on worktree-move series, or you can make it a separate
> one-patch series. What's your preference?

Giving a stable output to the users is probably a good preparatory
fix to what is already in the released versions, so it would make
the most sense to make it a separate patch to be applied to maint
then build the remainder on top.

I do not think "always show the primary first" is necessarily a good
idea (I would have expected an output more like "git branch --list").

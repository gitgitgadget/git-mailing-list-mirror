Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71ECEB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 20:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjGRUtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 16:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGRUtb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 16:49:31 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB96BD
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 13:49:30 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F51418A978;
        Tue, 18 Jul 2023 16:49:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7lRgtQtwiCad0NGyRmiXf/EG0e/rkqT2yWTGX/
        uxI2o=; b=SA00vHt/1+AJMxOBwX8WoC3KzT0HesrVFPuJMzs4h3U/qeFGo+yJ4m
        qZlVZKWnGubbsK6o1yF8k8auRrXgeLOeWXNDR/GX2ND5WlO7HzUfvuwNqFuftswC
        KueKpS0jX9VLi9dDwvDbPcHd3Be0GSHEG9yvWDLXxoovboliKBTiM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 161C018A977;
        Tue, 18 Jul 2023 16:49:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 77C1C18A976;
        Tue, 18 Jul 2023 16:49:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git List <git@vger.kernel.org>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] ls-tree: fix --no-full-name
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
        <xmqqo7k9fa5x.fsf@gitster.g>
Date:   Tue, 18 Jul 2023 13:49:26 -0700
In-Reply-To: <xmqqo7k9fa5x.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        18 Jul 2023 09:37:30 -0700")
Message-ID: <xmqq4jm1gd2h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95EDAF42-25AC-11EE-B5D2-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>  * "git commit --[no-](short|long|porcelain)" are accepted and
>    behave as "git status" without doing any "git commit" thing,
>    which should be corrected, I think.

It turns out that this was very much deliberate that these options
imply "--dry-run", implemented in 7c9f7038 (commit: support
alternate status formats, 2009-09-05).

So there is nothing to fix here.

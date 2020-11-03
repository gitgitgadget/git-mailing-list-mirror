Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DCAC00A89
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 00:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB78B22258
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 00:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N2FuGgC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgKCAqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 19:46:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64045 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgKCAqD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 19:46:03 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC62C908DD;
        Mon,  2 Nov 2020 19:46:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/qqDzHM36JkF76a/8x5WHtYpk+M=; b=N2FuGg
        C0bsNVi0Rpt7hHOufzc+DPB2WbOh4GDq4XOVvKJ76B5hi0pl6aBuyJbUjWJR2W0T
        tjc8nrJ7UZDq/9PBHH05NTsUEwEkPY+vOvoeN41cAwnswiVK9BoO78zzXkxEV7KL
        s42Uq4zF9hWRjvhbo7h4EpsX1WZgFG/Lc4Mnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YgEsP59/veJuG7y3tN1z2xu6NL6wQe20
        /ADWDtA/pzoZ7xh3hte62g/D+9RGlf1jCbh/FBYVfPeJApJoncLNA0axUPN+6S9F
        VbWoU8H3Pkza8MbRtfcdiy4k8GXq6mZ0+lx8yBP9SnVUFP6B3bUfN5zv8r4BduhE
        ENO6+xFQpWQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B57C3908DC;
        Mon,  2 Nov 2020 19:46:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4573D908DB;
        Mon,  2 Nov 2020 19:46:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] "Push" protocol change proposal: user-specified base
References: <cover.1604362701.git.jonathantanmy@google.com>
Date:   Mon, 02 Nov 2020 16:46:01 -0800
In-Reply-To: <cover.1604362701.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 2 Nov 2020 16:26:09 -0800")
Message-ID: <xmqqh7q7qncm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F28E72DA-1D6D-11EB-B5C4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> At $DAY_JOB, we've noticed some pushes being larger than necessary.
> Here's a first step towards solving that. In this protocol change, we're
> allowing the user to specify an ancestor believed to be common

Is this designed to be a short-term kludge until we have a similar
"common discovery" negotiation we have on the upload-pack side, or
do we know some fundamental reason why the "push" side cannot do so?

Just being curious as to what the eventual and ideal future beyond
"we must have an immediate problem worked around in some way even
with an ugly hack before the end of this cycle" would be.

Will take a look but not today.

Thanks.

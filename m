Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9713C3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 18:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721E92072D
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 18:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sZe2Byut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgCCStu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:49:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53746 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbgCCStu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 13:49:50 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6243AC62BF;
        Tue,  3 Mar 2020 13:49:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2Xz/JuphP6PKcewc9nIHgIEi6rQ=; b=sZe2By
        ut687wIyNQBMVQAc2bpUTGE9fdMWxeKW56czdJgpSp6Y7iHLXzZBM+teZjfOAkNk
        3IlgRjU3zN9p+kTHiDKQNR9EDjkjh+LXisNitDoCd3+Bx8WSDMG8J4CX3tNCUm4r
        WKjpm1mEkR8Tsk9rPDQsUPvvAWWLMHFCQqxG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hVRKosIJuMFKKw2WPeaEyQA9oBUBE5l6
        szsPBzwXWOtavW+F9+ly32b4bDasTNesVrsezd6HvTiXTU4yJMApsFCvEWvwwxVj
        Sa69ydLbXifThiLRsN6jASKVGUltgPvLkbDc/4RYCtIy0HWISNYgjlRwMtbkTuBr
        f+Fvq0G4pK8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5A59CC62BE;
        Tue,  3 Mar 2020 13:49:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8759EC62BD;
        Tue,  3 Mar 2020 13:49:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: update the documentation of pack-objects and repack
References: <20200228154357.1710521-1-damien.olivier.robert+git@gmail.com>
        <20200228154357.1710521-2-damien.olivier.robert+git@gmail.com>
        <xmqqk142bn5f.fsf@gitster-ct.c.googlers.com>
        <20200303174136.ess5lfxrsrt6qvdu@feanor>
Date:   Tue, 03 Mar 2020 10:49:43 -0800
In-Reply-To: <20200303174136.ess5lfxrsrt6qvdu@feanor> (Damien Robert's message
        of "Tue, 3 Mar 2020 18:41:36 +0100")
Message-ID: <xmqqa74x8e9k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C03D3CE8-5D7F-11EA-9A5A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> The problem here is that
> `--keep-true-parents`, `--no-empty`, `--all`, `--reflog`, `--indexed-objects`,
> `--exclude-promisor-objects`
> are always passed and not driven by any options of `git repack`, so I
> did not know where else to put them.

Ah, I think I may have misread the patch, then.  Why do readers who
wanted to learn 'git repack' even need to see what the command does
under the hood, driving what other low-level commands by passing
what options, in the first place?  Such implementation details can
change without affecting end-users, no?

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1564FC0018C
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 07:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F232220B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 07:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgLGHsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 02:48:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55725 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgLGHsN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 02:48:13 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8415B85179;
        Mon,  7 Dec 2020 02:47:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qvLSMn4T0VBoVFeLNjWMUQ+127o=; b=JvjbLn
        Ia2t7KNnp2p9JAWlfKrwlzWJQLgP96qbuEkC7blGQgr5Fs/ojQsJiG6f5gjxelZq
        XWpE9sObvOQZ+Gnu/GoDvlAU6SVkZGOhMZeEK0Fct5CwWe2nH0/qbj6AX/1j4C2B
        fmSjOevqZuUaLz+j3D5ZyGDzNDWpV4vcCAIrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mJIKe7JV402EAyi7k489LAOJK2oE0LlF
        kT/hNnj58k0Vbgyl/P8dxp6B+nQk7tF9xdKvwVr6LScrxebXNhpbif75UJiuu+RN
        B/d6Ve64+9kKdACa/0+aBxAQ7Uxf7ENMmaAK8ONYxETPy/pt50xY2lD4liyY9GXA
        iXWxlxsaIKY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A1FB85178;
        Mon,  7 Dec 2020 02:47:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 072DB85177;
        Mon,  7 Dec 2020 02:47:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH v2 0/5] speed up 'make clean'
References: <a5f59bcf-9ae6-b3a8-7073-5797971d286f@ramsayjones.plus.com>
Date:   Sun, 06 Dec 2020 23:47:31 -0800
In-Reply-To: <a5f59bcf-9ae6-b3a8-7073-5797971d286f@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 7 Dec 2020 00:30:31 +0000")
Message-ID: <xmqqtusyawh8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7676DCE2-3860-11EB-A1D8-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Ramsay Jones (5):
>   Documentation/Makefile: conditionally include doc.dep
>   Documentation/Makefile: conditionally include ../GIT-VERSION-FILE
>   gitweb/Makefile: conditionally include ../GIT-VERSION-FILE
>   Makefile: don't try to clean old debian build product
>   Makefile: don't use a versioned temp distribution directory

All five patches looked sensible.  Thanks.

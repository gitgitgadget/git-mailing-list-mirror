Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C843C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2085B208FE
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I6bg62qI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgD2T1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:27:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60520 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgD2T1n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 15:27:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 20EC0C975B;
        Wed, 29 Apr 2020 15:27:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=WliKXw2GebhP66wUYvm0Rt5td5A=; b=I6bg62
        qI/kf26xsOrdE/aoDjcy9W4RyJdT79dxbY/BjLbX93dc+kamZ33pftqpN/h3XsZG
        NKaWmmvQD8APoyT5ekn4bP+ZcGSiT309UKSWw9bOqW/OsGjc4P1wWfbGZHxQ2Myv
        jhp+kocMnlZfNW9lNnb9Vt70WvOeUsXDRza6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OXfUBkabCVPeemB3/K2hkzRlF86JBEC0
        mjODbu9vOZTifMJEcU064Mj3jF5XJ1TV/ftBNbW9+KYwtroicmSuOuM9lm0HIPH5
        8J1gcKWp3dSpR6txWtRq1L/e87q6MFcZZ1oW9ijiUwrYcobgyteN2cZxKztFxxl1
        AiLlhMNzQ+4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 18405C975A;
        Wed, 29 Apr 2020 15:27:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5B87DC9757;
        Wed, 29 Apr 2020 15:27:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Ivan Tham <pickfire@riseup.net>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
In-Reply-To: <877dxyo1k8.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        29 Apr 2020 16:37:27 +0300")
References: <20200429130133.520981-1-pickfire@riseup.net>
        <877dxyo1k8.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Wed, 29 Apr 2020 12:27:38 -0700
Message-ID: <xmqqk11yw0r9.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DAF3410-8A4F-11EA-9824-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Ivan Tham <pickfire@riseup.net> writes:
>
>> Add support to delete previous branch from git checkout/switch to have
>> feature parity with git switch -.
> ...
> Is this short-cut /that/ important to create yet another confusion?

I do not think it is that important, but I do not think "cd -" is so
important, either.

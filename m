Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ECFC2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 18:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD21020757
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 18:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VhaUGM3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgDISJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:09:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56824 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDISJp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 14:09:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2777C0AF5;
        Thu,  9 Apr 2020 14:09:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lrG7HzpWo5pAQIR/uQwr+/A4nls=; b=VhaUGM
        3eROcy0zIpg5XdSSf2cFKD6bZRts1Oc7G9/iqxBsfvMENuxinVWtzoh7HtpblTIV
        Vq5sqF5ONHRmKklZZyJXE/fE27/QsMSM2Ydsfw7JvSmiqttl0XUyFbKDUzYqSKHN
        OnM3shrLubzlRgYR1PkxMI9zDnsDCMw1RisKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tu80g1pXBwMbPb8cu0W77pQXw8rDV253
        s6wk79r80Dnj/EsFNaHG0WRLur09XRuGzQBr9p4e45wFMjUV3OZO3ZGazzR0PLie
        t3lqkWnAfdfWi5HGvrFjJLlhiCPbMbNi0ODfS3jiOau2J/kQYh3e7zgap29/VtG/
        ZMPzlkYRZnU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8701C0AF4;
        Thu,  9 Apr 2020 14:09:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F3B64C0AF3;
        Thu,  9 Apr 2020 14:09:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Allo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Allo <dinoallosaurus1111@gmail.com>
Subject: Re: [PATCH v2] t4200-rerere.sh: use test_path_is_* functions in the script
References: <pull.595.git.1585588586605.gitgitgadget@gmail.com>
        <pull.595.v2.git.1586444061576.gitgitgadget@gmail.com>
        <20200409152134.GC1937@danh.dev>
Date:   Thu, 09 Apr 2020 11:09:39 -0700
In-Reply-To: <20200409152134.GC1937@danh.dev> (Danh Doan's message of "Thu, 9
        Apr 2020 22:21:34 +0700")
Message-ID: <xmqq7dyoo7j0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 484BF906-7A8D-11EA-8023-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

> On 2020-04-09 14:54:21+0000, Allo via GitGitGadget <gitgitgadget@gmail.com> wrote:
>> From: Angel Pan <dinoallosaurus1111@gmail.com>
>> ...
> That's not a good message, either. But, it's some what simpler and
> cleaner.

Thank you, Allo, for a patch, and thank you Danh for a good review.



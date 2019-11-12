Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11D531F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 05:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKLF5P (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 00:57:15 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52588 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfKLF5O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 00:57:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CAF189B388;
        Tue, 12 Nov 2019 00:57:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EPYhpEbVxkLXgPQKTmbiFrzF84A=; b=qzVUi/
        hGuatpS7cW6p31wwe5sujLV6hqasTdNQRQz8fIoBGJqHjBLi3Itd/d8Jgft/xU2P
        kIPAzT1//p+PklYFnNZj0GDkDl3vGe19YUrEk/mpXj5K1lsWudLxpanyrjVIHH4X
        A0yNPYwOIjrZXK/mL2U8XNWYWPAwEgXPRR0/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VB2GCh+gaUY+HNUKtZx2gjEU0DyOJyCo
        JeoLu+mW6lZfimt9EQpDvpUbOhPzU+4nLyehVCB6aiaHHbhzEFwZd7I73qeOCSNL
        rAJYhCAwRUgRk41wXannZ1wNzCtM0GEgnp1qx0jvekRoEXum0o3Ig3DwSRkqiJ69
        Mj2rJqyONrs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C49029B387;
        Tue, 12 Nov 2019 00:57:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 042299B384;
        Tue, 12 Nov 2019 00:57:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 15/20] parse-options: move doc to parse-options.h
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
        <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
        <3d1e7e72efca06d18606b6f9dd8c3b6771dfde06.1573034387.git.gitgitgadget@gmail.com>
        <xmqqh83bi10h.fsf@gitster-ct.c.googlers.com>
        <CACg5j27=t_tC4AqNz6tSdsgbDKECq1p+OwS=ydak7d94q2PHZg@mail.gmail.com>
Date:   Tue, 12 Nov 2019 14:57:07 +0900
In-Reply-To: <CACg5j27=t_tC4AqNz6tSdsgbDKECq1p+OwS=ydak7d94q2PHZg@mail.gmail.com>
        (Heba Waly's message of "Tue, 12 Nov 2019 10:38:40 +1300")
Message-ID: <xmqqblthfxho.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43EBCA86-0511-11EA-A95B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heba Waly <heba.waly@gmail.com> writes:

> So my proposal for this matter is to investigate the possibility of
> using a doc generators that'd extract the documentations from the code
> to a single doc file per library.

Something like that may become necessary to bring docs in some of
the *.h files up to par with D/t/api-*.txt.

Note that the quality of the latter is quite uneven.  The one I
noticed perhaps is exceptionally well-structured (even if some of
the details of its contents may have gotten stale) and to match its
structure, the order of presentation in the generated doc may have
to be different from the order of definitions in the header.

But for the ones with poor structure with stale contents, getting
rid of the stale D/t/api-*.txt and describing the API in *.h files
is a vast improvement.

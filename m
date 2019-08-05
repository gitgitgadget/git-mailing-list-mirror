Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 870DD1F731
	for <e@80x24.org>; Mon,  5 Aug 2019 19:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfHETfD (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 15:35:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56268 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHETfD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 15:35:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2F4948CEA7;
        Mon,  5 Aug 2019 15:35:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wK55HqnHeBdQejubg27pMxcuz38=; b=yhP1Ir
        ZARqA3e3wMbq/QZZE3TCvR6xhcXPOh/z+5IWZHz+kiT/kNilHom2fxAi6W3UjknF
        K+bev9D4/lNHbCajucWgAZwcoVZFaMdTQE4Uha42raBTjcobRz09y3ywW3fgOl4k
        9bagtSp+AUwhcGmCeGjjvbQPngTBIyH3zy7uQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lKPofimc+IyBtIyUlYaVKLCfhHbsy6Uv
        l/ZhMIPLDXhHnSvcb2LGMMHGjI3UV56eJ1Zj/wDLvmi7293KEj0YCLaRKiAVBBa/
        K+EzoxK4/n6/UoeyP3YS73tGEpilmkJSEpn1VQiiGW0oK/9LSE3QVUZ0FR/aTCJm
        HkCQUi4X/eY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 273638CEA6;
        Mon,  5 Aug 2019 15:35:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 547328CEA4;
        Mon,  5 Aug 2019 15:34:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, l.s.r@web.de
Subject: Re: [PATCH v2] grep: avoid leak of chartables in PCRE2
References: <20190727202759.22310-1-carenas@gmail.com>
        <20190801170946.81221-1-carenas@gmail.com>
        <xmqqwofvleuv.fsf@gitster-ct.c.googlers.com>
        <CAPUEsph2S1+PpET6R-=YnTyvm8+5t5ytJL6VJR0nbmyMQWcYuw@mail.gmail.com>
Date:   Mon, 05 Aug 2019 12:34:56 -0700
In-Reply-To: <CAPUEsph2S1+PpET6R-=YnTyvm8+5t5ytJL6VJR0nbmyMQWcYuw@mail.gmail.com>
        (Carlo Arenas's message of "Sat, 3 Aug 2019 11:50:51 -0700")
Message-ID: <xmqqr25zmmn3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C075928-B7B8-11E9-8E84-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> Thanks for fixing the conflicts in pu as well; apologize if I could
> had made it easier by doings things differently

With many topics in flight, conflicts between topics happen all the
time.  Thanks for checking to catch a mismerge.


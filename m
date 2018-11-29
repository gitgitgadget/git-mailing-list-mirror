Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0649F211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 06:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbeK2RKD (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 12:10:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63036 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbeK2RKC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 12:10:02 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A74A512C20F;
        Thu, 29 Nov 2018 01:05:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eUJWgLiYa4u7w5zXgjgPrJWLNYk=; b=iYlAn+
        xfWTDUGM6mMz8wBpPgQC+cfQA7jo+UHSkS4N3LaTxDPi6/suCiSVzZO0gf37+1cM
        alHQZKsP01SWU8R8V1ve4NcYdZOW6Lz2Y0VwXimzpOm9UYDseUiUbVJJguzjyOOd
        Uo20/w4hK76uztWKpV62byxYDdkV0MziI9IHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qWEsTBC0+yenmAIpkJCzFhTTtSIvk5Jv
        bjYAVJLfZ3bk3PH3PmbxCePS6bsEvLxM9QrBAqgM0v6XpyD5LLST9vFS03vrRQ8Q
        shUXP7XelBq0Lfjy+Ex0OpNf92RblB12OZWPIJB1SiP388eY1YcjPAbmA9NJH1YA
        ZihcHfAM5WI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A043412C20E;
        Thu, 29 Nov 2018 01:05:48 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F1AC12C20D;
        Thu, 29 Nov 2018 01:05:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 7/7] Suggest other commands instead of "git checkout"
References: <20181120174554.GA29910@duynguyen.home>
        <20181127165211.24763-1-pclouds@gmail.com>
        <20181127165211.24763-8-pclouds@gmail.com>
        <xmqqbm69spp4.fsf@gitster-ct.c.googlers.com>
        <CACsJy8BBeRDY85rJLzeJRFSazEn1rZ8JGN6_vwAr2ia=FaiLNg@mail.gmail.com>
Date:   Thu, 29 Nov 2018 15:05:47 +0900
In-Reply-To: <CACsJy8BBeRDY85rJLzeJRFSazEn1rZ8JGN6_vwAr2ia=FaiLNg@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 28 Nov 2018 16:33:39 +0100")
Message-ID: <xmqq36rkpgec.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0FBD68C-F39C-11E8-9AAC-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I see my deliberate attempt to provoke has failed :D Giving your view
> of the new commands as "training wheels", I take it we still should
> make them visible as much as possible, but we just not try to hide
> "git checkout" as much (e.g. we mention both new and old commands,
> instead of just mentioning the new one, when suggesting something)?

Yes, I do support the overall idea of learning two (or possibly
three) separate commands would help new users to form the right
mental model much sooner than learning one that can be used in
multiple ways.  Another possible approach could be to split the use
of "reset" that does not move "HEAD" into the same half of
"checkout" that does not move "HEAD", i.e. checkout-files.

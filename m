Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE741C4363D
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 00:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2490207C3
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 00:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U/xtG9X+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbgJAARW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 20:17:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51223 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729980AbgJAARW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 20:17:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DCA35928E1;
        Wed, 30 Sep 2020 20:17:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S9cUTipYuIpra+rznU7c6uf62JY=; b=U/xtG9
        X+/oDq6Sk3iNLCsKFtJF7D2YFGQxsaST4T9xk7rRuDCXOMsYGdNuehLYB8wNQkti
        mu+Tbo4OUSo8cOaVdpWZ5ouJ7BiGLTS4Ite9aw5nyjz14diJMUn+7dF/F1nOLLfZ
        fTr2EaZO8ZjciUKh6CCnvA6lDSqfuTn/fccKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h9w3oXMpyVfpyrLaFeOb7RboQya4z7fi
        QGOdvYAGwVfCwKjWLzJMJ8welPuUZQRuAr/oKXL/FxhoT0eZiruqyMeQAwmuqXqO
        q4KsBiPHetRED5F8vEzmi2Yznyg4PhWs8ZOwe5YIYBOFGTfqijUi+RqPpP7IbOSq
        /fdZOom1Q3I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D46A6928E0;
        Wed, 30 Sep 2020 20:17:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5FE56928DF;
        Wed, 30 Sep 2020 20:17:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shengfa Lin <shengfa@google.com>
Cc:     git@vger.kernel.org, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu
Subject: Re: [RFC PATCH 1/1] hideTimezone: add a user.hideTimezone config
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
        <20200930232138.3656304-1-shengfa@google.com>
        <20200930232138.3656304-2-shengfa@google.com>
        <xmqqpn62essa.fsf@gitster.c.googlers.com>
Date:   Wed, 30 Sep 2020 17:17:20 -0700
In-Reply-To: <xmqqpn62essa.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 30 Sep 2020 16:41:57 -0700")
Message-ID: <xmqqblhmer5b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79318F3C-037B-11EB-BE55-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> new file mode 100755
>> index 0000000000..41ed9c27da
>
> Let's not waste a test number for just a single test or two.  Can't
> we roll this into 

... an existing test for "git commit"?

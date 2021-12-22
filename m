Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11688C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 19:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbhLVTmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 14:42:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50994 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhLVTmH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 14:42:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9CE9116118B;
        Wed, 22 Dec 2021 14:42:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rw/QM/ndRnPQi62ZjJ2rggsGYw1BYA6R09l2a5
        H4o88=; b=uqPSmwrx3ARAa//lZxw6bmf5qTSffzZVHzDWWbOj09bgUXGDpCPH3L
        lO6Y6M0H13+u3aB/HrsoOWfPHsKi2x7wbK1ADJRqev5ORi6j/wzQrL64BD8a4Vqc
        61Xo7Z+boPnoAlGIeca2T6BDPMzQ1TT8G10/6GoPNoe0aAPidxDKg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 95A7D161188;
        Wed, 22 Dec 2021 14:42:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EDB59161186;
        Wed, 22 Dec 2021 14:42:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com, jonathantanmy@google.com, steadmon@google.com,
        chooglen@google.com, calvinwan@google.com,
        workflows@vger.kernel.org
Subject: Re: Review process improvements
References: <YbvBvch8JcHED+A9@google.com>
        <20211217183942.npvkb3ajnx6p5cbp@meerkat.local>
        <211222.86ee65pb60.gmgdl@evledraar.gmail.com>
        <20211222154534.b2gb22ghn2mpyeur@meerkat.local>
Date:   Wed, 22 Dec 2021 11:42:02 -0800
In-Reply-To: <20211222154534.b2gb22ghn2mpyeur@meerkat.local> (Konstantin
        Ryabitsev's message of "Wed, 22 Dec 2021 10:45:34 -0500")
Message-ID: <xmqqh7b0juk5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D1AE54E-635F-11EC-938A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> This would require pretending that we're authorized to send mail from the
> domain name of the commit author, so this unfortunately won't work (and hence
> the reason why GGG does it this way). E.g. say you have:
>
> From: foo@redhat.com
> Subject: [PATCH] Fix foo

Would it help to use "Sender:"?  When GGG or any other automation
are trying to send e-mail on behalf of the person shown on "From:",
I thought that it is the mechanism for them to use to identify
themselves.



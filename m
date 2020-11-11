Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7876FC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F3C8206F1
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O/MyZzmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgKKQdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 11:33:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60705 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgKKQdu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 11:33:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B77D4A1838;
        Wed, 11 Nov 2020 11:33:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TTDUxaTaVN4G
        pGjYwAKpDwEYMBs=; b=O/MyZzmEHkSRAN8qXB6geNO//Saqcgz+4oKr4O7wTSnb
        4/6Qc6IoYLJa+HwFr5xWgG6TV7T3ZyqlJQFkTlGwRZ6/Wea7QqBv9QH5F32BzCFN
        kf7DiCa/cS8QMlfVcEU497X2CaTDohHjAM1NyDo8gLobEp1EtmtN55lIyCPt4YI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ugzur6
        9JTC66bC9Gp6CyFA1vYtrr4wJ90tl53FOMkccqFGrz1RjUbxwSClIw6+tl3v5570
        aivFU8ihdsaaI6jqjLMeg7I2RkFPTNlycc0upRrkUw5dr1Bls605RTk036fMlr3l
        i+tY2OMz//EcPJUJ96PIN21Q6axQyIryY/olw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AFA7CA1837;
        Wed, 11 Nov 2020 11:33:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3AB81A1836;
        Wed, 11 Nov 2020 11:33:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] parse-remote: remove this now-unused library
References: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
        <20201111151754.31527-6-avarab@gmail.com>
Date:   Wed, 11 Nov 2020 08:33:47 -0800
In-Reply-To: <20201111151754.31527-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 11 Nov 2020 16:17:54 +0100")
Message-ID: <xmqqwnyr4zv8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AC9CF1AA-243B-11EB-B155-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Completely remove the git-parse-remote shellscript library.
>
> Since e9460a66e0 ("parse-remote: support default reflist in
> get_remote_merge_branch", 2009-06-12) when there were around 300 lines
> of code here used by various core code everything in it has become
> unsued, and that unused code was removed in preceding commits. Almost
> all of its previous functionality has now been rewritten in C.

Very pleasing to see this.

I would imagine that an equally easy to understand and more compact
presentation of this series would have been to

 - copy minimally needed code to git-submodule.sh verbatim, while
   dropping the dot-source from git-submodule.sh (patch 1)

 - just say "nobody now dot-sources this shell library" and do what
   this step does.

Especially 1/5 confused me more than it helped me to understand the
end result ;-)  It does not matter in the endgame that GIT_DIR was
defined there, as long as we know nobody other than git-submodule.sh
dot-sources the shell library and git-submodule.sh uses its own setup.

But that can only be said with perfect hindsight after seeing all
your efforts in these five patches.

Thanks.



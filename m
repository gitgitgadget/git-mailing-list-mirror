Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FA3C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 18:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiGUSNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 14:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiGUSNs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 14:13:48 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862D73E756
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 11:13:46 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98E81138C6A;
        Thu, 21 Jul 2022 14:13:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yMxT2FlcO9MO
        mFe3O75Cd8ikVRB5O1UxA/H1BKJY500=; b=vPGIR+oYjVmW8zKgQw1WWL1QCS2f
        vqNwPdf1ycpSnmqxIlWmx4sYdbagKKoyHDrc+Dyk0uUWqmmVG4JIbpjgpGG+6Fma
        JBUs/Z60yQbXwWAs5NB79/6vQ+PK4X/H0pfghVQat68hCNbxxXTCKTe7SxrGoBLQ
        bGwwZVXpX0cloNw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F206138C69;
        Thu, 21 Jul 2022 14:13:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F3269138C67;
        Thu, 21 Jul 2022 14:13:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v5 0/9] docs: create & use "(user|developer) interfaces"
 categories
References: <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
        <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com>
Date:   Thu, 21 Jul 2022 11:13:43 -0700
In-Reply-To: <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Jul
 2022 18:13:49
        +0200")
Message-ID: <xmqqr12egwq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DBD57A98-0920-11ED-A42F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> See v3[1] for lofty goals. The changes since v4 are mainly to rename
> the "user formats" and "developer formats" to "user interfaces" and
> "developer interfaces".
>
> Now:
>
> 	$ ./git help --user-interfaces

Hopefully this is a much better choice of words.  "formats" would
have had a very high chance of getting misunderstood and confusing
readers.  The interaction with hooks (e.g. you stop the operation X
that asks the hook's decision by writing hooks/pre-X that exits with
non-zero status) would probably be much better understood if it is
described as "interface" than "format".

> And for "--developer-interfaces" (I wondered about calling this --apis)=
:

"api" might be less misunderstanding-prone, but both should probably
be OK.  Again, much better than calling it "format".

Thanks.



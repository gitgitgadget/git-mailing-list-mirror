Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E75C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 00:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357088AbiCYAyd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 20:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357085AbiCYAyc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 20:54:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E391BBE0B
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 17:53:00 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D79FB193131;
        Thu, 24 Mar 2022 20:52:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AqfoDg/9+fYu
        pvmReCVo3qDNsr43zBuGAl5TNVzh6dA=; b=EFO4Liuw3aAiV+3NXRJhHxDgBd1T
        Jp3ec2s58x0EPxOHVYby2qJTNhmiJhj0Etm/jTyzIlclgUGCxXdaeIzvxME/p3Ch
        +9AZ2/rFmHzBzaHA2Byh7988hs75muNz0SK4Rko29/9V+L1pYLSUdgH0i7tdAwcx
        Ga7fc50kA72tO/E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D0104193130;
        Thu, 24 Mar 2022 20:52:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 375DA19311F;
        Thu, 24 Mar 2022 20:52:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 10/27] revisions API users: add "goto cleanup" for
 release_revisions()
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        <patch-v2-10.27-eafe57663fc-20220323T203149Z-avarab@gmail.com>
Date:   Thu, 24 Mar 2022 17:52:56 -0700
In-Reply-To: <patch-v2-10.27-eafe57663fc-20220323T203149Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 23 Mar
 2022 21:32:00
        +0100")
Message-ID: <xmqqh77metuf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E9515C3A-ABD5-11EC-B72C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a release_revisions() to various users of "struct rev_list" which

"rev_list" -> "rev_info", no?

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B0EC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 01:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356463AbiCYBVt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 21:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244604AbiCYBVt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 21:21:49 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93172366AE
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 18:20:16 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 32130189890;
        Thu, 24 Mar 2022 21:20:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+5J4om2Wgjor
        7JgsqGFZAs952ITFxIKSw3tK1HCBKxM=; b=OhICql6+mmpFRmwx4H0AEF5QHTuK
        TNMwyqngvbLUC8m4qH8zehRCGTYGeBqIlXx2qtq3OAE+7HsJyIWoFTFJfKdYUQHy
        yOWAk/nFSuJAn0YFTytlWUrsXlgf7BDNhAB0+V6kfrwmN2agZIVPcJ/ipXdAS7ru
        HfxCLTAtwkpmYCQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B05C18988F;
        Thu, 24 Mar 2022 21:20:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 95DE518988C;
        Thu, 24 Mar 2022 21:20:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 21/27] revisions API: have release_revisions()
 release "prune_data"
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        <patch-v2-21.27-f98d473f08e-20220323T203149Z-avarab@gmail.com>
Date:   Thu, 24 Mar 2022 18:20:12 -0700
In-Reply-To: <patch-v2-21.27-f98d473f08e-20220323T203149Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 23 Mar
 2022 21:32:11
        +0100")
Message-ID: <xmqqk0cide0j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B8ADFCD8-ABD9-11EC-8030-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Extend the the release_revisions() function so that it frees the
> "prune_data" in the "struct ref_info". This means that any code that

The same comment as the "cmdline" -> "filter" in a few patches ago
applies here, this time "rev_info".




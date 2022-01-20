Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE3EC433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 22:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378090AbiATWdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 17:33:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53163 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378078AbiATWdV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 17:33:21 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA428100A81;
        Thu, 20 Jan 2022 17:33:20 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=Xp0zJ2VHQHpGC
        imjYPlAmQoCmdFo0StcZvXeLDF5zhA=; b=OMuRVjXXczFePgOCZp9DTPAzQsszR
        Q4QiCfAN//sPqzo9F265Nbd11N5LrAHvo7vPvyLulkGI57dsudGbHMn2oW94AAcU
        2nWFpDNigbytdleTa6pTTijE4p86M8R26j/01qLnLZjytfkhY8+kDYEFeu0AGeVa
        JeZW8EqKUmSUTo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E218A100A80;
        Thu, 20 Jan 2022 17:33:20 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.242])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5DB19100A7F;
        Thu, 20 Jan 2022 17:33:20 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Thu, 20 Jan 2022 17:33:18 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Petr =?utf-8?B?xaBwbMOtY2hhbA==?= <psplicha@redhat.com>
Subject: Re: [PATCH] checkout: fix BUG() case in 9081a421a6
Message-ID: <YenjLhy3/q5Jnd+J@pobox.com>
References: <YemTGQZ97vAPUPY0@pobox.com>
 <patch-1.1-21ddf7c628d-20220120T212233Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <patch-1.1-21ddf7c628d-20220120T212233Z-avarab@gmail.com>
X-Pobox-Relay-ID: F8534D5E-7A40-11EC-B634-5E84C8D8090B-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> Thanks to both you and Petr for the report and easy to reproduce case,
> and sorry about causing it.
>=20
> In retrospec it's a rather obvious thinko. Here's a minimal fix for
> it, along with a derived test case that I made more exhaustive to
> check the state of the repo before, after, and in-between the two "git
> checkout" commands. As noted it'll also pass with 9081a421a6d
> reverted, showing that our behavior is the same as before that commit.

I can confirm the new test succeeds and the case which Petr
reported works as it did in previous releases.

Many thanks for the quick fix and more extensive tests =C6var!

--=20
Todd

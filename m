Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509B8C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 11:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiHJLmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 07:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJLmB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 07:42:01 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF5D77574
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 04:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1660131713;
        bh=UZSRk0GGYiXFAWUxNdfMYzasNp1/DySAW0pNgooa4Oo=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=oBuRNoKGY0mwN4xkrzS2k+cfYBwV7pqkVVVJGN/B4FbQbnotykZhTVjno3YN/rSpO
         qep0Sv3Pk4/D8ksINBiWkxr9BRW1Cy0GDD4zLM0TgVZhwQhKE63N9p6OJMemhnEZPH
         xuW7OktewtqgoXVR9XmwROF42Q/oK/sdKcZmoVXE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3Xjb-1nLHv80G2d-010DQc; Wed, 10
 Aug 2022 13:41:53 +0200
Date:   Wed, 10 Aug 2022 13:41:51 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Alexander Meshcheryakov <alexander.s.m@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Subject: Re: [BUG] Unicode filenames handling in `git log --stat`
Message-ID: <20220810114151.uhaun5gbknd5btyz@tb-raspi4>
References: <20220809182045.568598-1-calvinwan@google.com>
 <xmqqsfm4prqk.fsf@gitster.g>
 <20220810084017.gnnodcbt5lyibbf6@tb-raspi4>
 <CA+VDVVUKf48Q9A0hWPnBE+qG_7tBDuXKkdo+wWDU7iC3Wg=oEg@mail.gmail.com>
 <20220810095157.wo4jaumtu47qplsb@tb-raspi4>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220810095157.wo4jaumtu47qplsb@tb-raspi4>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:2J+FiR8hdnmAnCwWjIIrIq4W+0nRQC4qK37kgrZSoXBceKYU+qp
 FzfVtFQzdsWIQTi8Cvy5Gx/Zy+PG+o1ybmkFderkt00cUwAznw/MjxHUIa1aqO/BcUsBF+R
 n7kfHpqMyFcNL9m4B80GB+Xs9DRypylBcKCqVeUoDkWeqOWuVYDsgtkMfszxAFIKlWex8So
 ocSdogGnQoNYrkR8DZ4PA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DmT71jytZA8=:alKPV4rvMiHNXt2377Az81
 Cdkxxs0Sph8PsN+aEyP/xsftQyTuadPEStQMEy6NqUSMJOao7OfC1w4/iPu0OjDo6x7I4ObxA
 2W69xr8+QU7vVVwGBQRfeNePLJUDVZ1z6qiixJuyXWCCJRvO2xJbE13pdSbu5wgjtRDbpQUq+
 KRckp4IOpdSpC//eC23MW3lB8uhJ6c0DFlElNfr/qVz3Rkq3nMmDeiRDxNd7C010sL+t6hpeH
 Bn1WKLB44VivTafnigqi+A6uHMEmxoiEjaZCq1k5rRW016xw64zALXiy7zm0ZOrFunDF2E0EE
 ahnDpFCrIJ/7HPDOSnKg1TQ8/XbYGPz013HcdGVei0FeGjC5dEPg/vtKEZnVRY0REy2H2k/0B
 3twG7HnV31ZdkZahCSxrsnk7oPfCKBahoGO8EUpmpE+e7qIyHmBcZq01J4QjSiylJdeahcVr3
 iHazxKZhHy93cu7aMqmvtkeHa3X2iETA6fZshamU99z2frcgy2e2/rNFCHAiHYoVlvsak2xNC
 JIycETBViCMlWABKv+wxNkhHgPn1MhYrP4XiZXwGITyU/j5lw7QBWrwnjh5Rndxp+jpEVzIRI
 MEBBy46/U0epnkPICrin/eXRpdDOydMNteEnhGW188tgl9PgjeU5l3M7odaJMCcOfnqT9CARS
 1sKlZOKuTZof6y8EJWEt+f0r8HTHyh98XftYkr9jsUE/2VkJmnea29GR4trxEYpPk2XkmH3D1
 3RIziUJMrBOzp/rUzZIXmCHqKyG85xjiykJyQS62Fl2AOxVeBZUGC1d9uC1I+0eOTsO9RBCoY
 sRd4cf4ebQUMDbSjC7ANvvEa7FawJ8/p+NcpRhujXPjD5Zbnk42UDgq6EP/y1/7FtE4ClPJWD
 zLba7+NL2A953oUvo9Gpy19cLKuOBrilRUZkmZoGnJ07CYS5s5UEczT17xefXb3itORZD3IoS
 VBwv8dC866AyEt/MamGRFmtBuBoI+80j8NntK45aqN5wPvzRb4Gl/F8W2lmWuCbSda+EFnfAq
 5Faumzc+HzQ6YsU47BILIQzQ/2hd4NBhrSVQYhs4L8+5yRjOa4DqBU0m2Lysw05/Deuf8rqyy
 iALJdd5TDn7Tqn7qd0YlR9q5g5Qo0lLB7fvEFwlVHdDqHkAKNxlCIfswg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 10, 2022 at 11:51:58AM +0200, Torsten B=F6gershausen wrote:
> On Wed, Aug 10, 2022 at 12:56:11PM +0400, Alexander Meshcheryakov wrote:
>
> Thanks for digging.
>
> (And please, try to avoid top-posting here in this list)
>
> > I believe I have found exact place where strlen is used incorrectly
> > This is at diff.c:show_stats
> >
> > https://github.com/git/git/blob/c50926e1f48891e2671e1830dbcd2912a45634=
50/diff.c#L2623
> >
> > It probably should be replaced with one of utf8_width, utf8_strnwidth
> > or utf8_strwidth from utf8.c
>

Please forget what I wrote earlier - I was running the wrong `git` binary =
:-(
Sorry for the noise.

I can probably do more testing soonish.


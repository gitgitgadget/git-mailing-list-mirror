Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 462551F461
	for <e@80x24.org>; Mon, 19 Aug 2019 15:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfHSPgL (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 11:36:11 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45942 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfHSPgL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 11:36:11 -0400
Received: by mail-qt1-f193.google.com with SMTP id k13so2318372qtm.12
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=umXw1A/Qt3LDLbe1jfOgdpq0tt5ann7Sw9QinVidh5k=;
        b=b/8MELwxY4OwxG8QX1DG7xTjICI8fahpwSi7m4AFJVwzv96PcWEjTVSirIwkTckxsU
         cd/oRs0l8nDrZinbesnufsVPzj+00BdRgsehHxvulAVsCdPqUReHjEO3pzI2MsQARIsV
         7yKa6tJUCvImRoWIAmWJU1kch48FQmsFsWU4xZHBip/XIaO/sNOHyOLHCMSGj9izpQOa
         XGP6WDlUal5DMC8129u1n/GFxxJKHkMuBMIBn6lxdezLDX2YPX828lnPApgwsSY2K4AT
         iBIf95iMPZP0PxQcc2PzWoOCVxE0ZxmThrkanPzyDFKVFTxjijgiTXSTlpt206tr0bqm
         lmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=umXw1A/Qt3LDLbe1jfOgdpq0tt5ann7Sw9QinVidh5k=;
        b=NudgUUVOMBAZ/FyWQlm3pOUaO1wBOzAP188KL6n6pJwhTHtrm3yvNG27/0fwf+VXte
         VmyVVQ5j3E+XasywL9Z8eTJ971x1apXBLeTWKSjSh1vyTCvC5yP+mqGZCJ19HjHxJKSE
         Z/2n+VlmCVMAXGZA2Jxt1QNN+874Cozd3+meYWoExKPlBZf+mkNzgwwsV/yQcCsFFYG4
         tUyc+CVW0opt299uz9oUoTO49DNkdEVanJx4Zib6NddMsRC/mKv8QRl7A3moeSkluHPy
         sYUAMICu4fu4tIAitZt+sE0quOvo+rQ5YOczqs4J9kOnL1uGnIHP7fclfFZlGOmidoc/
         HS7w==
X-Gm-Message-State: APjAAAVuzfccGBRVp0bajv2141erpNU9wQBgeqNZc7eqlIN8/qBMuGjS
        hNwcKKqYO7j12n59l920EJbXmzBKxFqyV6jSi5I=
X-Google-Smtp-Source: APXvYqyk4ga1TNz9d1I62eVR3rBaV9GIBCGYRAsQzgkN+doqDtc/E1w5OGbkPvKJiL16unHk8+dBhYGjKiC3+9Ocn8I=
X-Received: by 2002:ac8:2f61:: with SMTP id k30mr22218192qta.340.1566228970121;
 Mon, 19 Aug 2019 08:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190813160353.50018-1-vcnaik94@gmail.com> <b7f4b745-8942-6d90-dbc5-7f79f2cc323e@web.de>
 <xmqqr25o7qmf.fsf@gitster-ct.c.googlers.com> <CAK_rgsGSfL2zQLP59O+PUCLGz0X8c4UQ3Zg=9M+nCww5C+X_gA@mail.gmail.com>
 <xmqqtvai4cc4.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvai4cc4.fsf@gitster-ct.c.googlers.com>
From:   Varun Naik <vcnaik94@gmail.com>
Date:   Mon, 19 Aug 2019 08:35:58 -0700
Message-ID: <CAK_rgsHKaLkO_wputOKcHBTDTnyvOUNTABUKK3fKc3ddiaNzQQ@mail.gmail.com>
Subject: Re: [RFC PATCH] unpack-trees.c: handle empty deleted ita files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 15, 2019 at 9:34 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Varun Naik <vcnaik94@gmail.com> writes:
>
> > On Tue, Aug 13, 2019 at 1:33 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
> >>
> >> So perhaps
> >>
> >> +       !ce_intent_to_add(a) && !ce_intent_to_add(b) &&
> >>
> >> i.e. "a cache entry is eligible to be same with something else only
> >> when its I-T-A bit is unset".
> >>
> >
> > I decided to follow Ren=C3=A9's suggestion in response to this. Patch c=
oming soon.
>
> Either is fine as the implementation of the same semantics; I
> however am not sure if two I-T-A entries should compare "same" or
> "not same", or if we are better off catching the caller that feeds
> two I-T-A entries to same() with a BUG().

I'd argue that two ita cache entries should be a BUG. Since we believe
that a cache entry in the tree can never have the intent-to-add bit set,
it suffices to show that no call to same() ever passes two cache entries
from the index.

The call in unpack-trees.c:merged_entry() compares the "old" entry
(which comes from the index in all cases) to a newly created "merge"
entry (which is a duplicate of an entry from a tree in all cases). All
other calls compare either entries from two trees, or an entry from a
tree and an entry from the index. I also can't think of any case where
someone would want to check if two index entries are the "same" in the
future.

The same argument probably extends to the conflicted bit, but changing
that is probably out of scope of this patch.

Varun

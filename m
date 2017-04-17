Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB59320A04
	for <e@80x24.org>; Mon, 17 Apr 2017 12:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753035AbdDQMJ7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 08:09:59 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36594 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbdDQMJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 08:09:57 -0400
Received: by mail-oi0-f67.google.com with SMTP id b187so27743058oif.3
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 05:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/FTlk+FR4Ljw9JbH5ID3D0atHNkhCPNhP3GKVwjMJOw=;
        b=QtXj1s7ke3cXZfq+pPIzbD1HcIJQlM+OtaarzBLNaa/bRLEnq2zJrrejSxJuYq7WGy
         Hn8gPXM2u5kcOCRahtpOwVjxMWK99EkKBvPFU2LcVOk6bpALw4kyAKI0G2aAUK7VTx+P
         k+JeMjQzD6Jnx46giktYHN3hj4MwgCQyQec1NEe1+AC+t0opUiWPWi9J35iOSFMpeikK
         lIbG1M4AGrsbsSEYV6rsLJz7CPzUvhsMk9lKorgTWrjWS3WOxZmz46UbyeRfs7Fg298q
         QpVGtQgxSiNc/X80AsZXrWkJgl8ujEqFdfnASJnCI7oKHikPLqppKo/+oTDcXkWLte6B
         GR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/FTlk+FR4Ljw9JbH5ID3D0atHNkhCPNhP3GKVwjMJOw=;
        b=EEXsKEQv0PO0Yx488QSVNoH+Ah7/5B7eqiDRQ1qFUcGiMTu9CXIVKeGIduHuEghfhw
         1+GoIIMIC8upa3K5K3Op+WdmdGa3+qy1K/mt50aa4x9EozgyXTP5SjO3yQlm49NpBC1T
         LbQHxvJwWEUv7byfdz/OVYBQBsNMnUxfxPo0aa4Ie2qyVjsrvW7fW1/8S4pykQmm8XGf
         Qyo9epVnJmnB6/xM0mVGgmP82bvAG6OuTksVieAg9BfUVb2WYJaElP4dOvYvb4ttv9hG
         HHltsd7lWSlnjtPPv/WnFHjhEYRRNd+f9yAO/DBtra/dN5Oi2/BofgpDYZqNRJ9SgNz6
         tnWA==
X-Gm-Message-State: AN3rC/4USFtuxEFecPDOfKws2LLYpZ1pNL+lvp83beugXqbNSAiMG2M0
        OMNgWA/JprB2R02bB8eFvZly4F8j0g==
X-Received: by 10.157.5.102 with SMTP id 93mr5349941otw.10.1492430997158; Mon,
 17 Apr 2017 05:09:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Mon, 17 Apr 2017 05:09:26 -0700 (PDT)
In-Reply-To: <CACsJy8CbxGPeWHgR8s-ix_wxPODvisw6eaLnEUV4LDmoeXt5BQ@mail.gmail.com>
References: <20170407192357.948-1-kewillf@microsoft.com> <20170407192357.948-4-kewillf@microsoft.com>
 <20170410102429.GB19325@ash> <SN2PR03MB2333BCFD2E1A6A400706F94CB7000@SN2PR03MB2333.namprd03.prod.outlook.com>
 <CACsJy8Dw8qfS6G71y3FoT9w7H=FABMx=5R=v8JcPCEHtv1vLcw@mail.gmail.com>
 <SN2PR03MB2333B9A0A7A3888F0402594DB7030@SN2PR03MB2333.namprd03.prod.outlook.com>
 <CACsJy8CbxGPeWHgR8s-ix_wxPODvisw6eaLnEUV4LDmoeXt5BQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 17 Apr 2017 19:09:26 +0700
Message-ID: <CACsJy8Bb_maecm2ywHuyMXhORXZBMxMzmtdX_YgCq_DVfwy+Dw@mail.gmail.com>
Subject: Re: [PATCH 3/3] reset.c: update files when using sparse to avoid data loss.
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     Kevin Willford <kcwillford@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 16, 2017 at 11:25 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> Because this is a reset --mixed it will never run through unpack_trees and
>> The entries are never marked with CE_REMOVE.
>
> I know. But in my view, it should. All updates from a tree object to
> the index should happen through unpack_trees().

Just fyi. My view is wrong. We need to handle a diff here, not through
unpack_trees() because "git reset --mixed" support partial reset, see
2ce633b928 (git-reset [--mixed] <tree> [--] <paths>... - 2006-12-14).
We might be able to make unpack_trees() leave certain paths(pec)
untouched, but I don't think it is worth it. In other words, your
original patch is the way to go.

PS. I briefly wondered if "git checkout <tree> -- <pathspec>" had the
same problem. I think not, because while --mixed does not touch
worktree, checkout does, so it should restore on-disk versions if
needed. The read_tree_some() call in checkout_paths() should respect
sparse patterns and add skip-worktree bits back if needed though, but
I don't think it does that.
-- 
Duy

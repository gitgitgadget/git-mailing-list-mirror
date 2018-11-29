Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D89C211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 18:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbeK3GCZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 01:02:25 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:42800 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbeK3GCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 01:02:25 -0500
Received: by mail-ed1-f41.google.com with SMTP id j6so2783011edp.9
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 10:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CN0Is/V5j8jHxbgM1x+zBDCRPJAe4Cf2GAcP+bs7IVA=;
        b=CVrp6DdCfglqkibalhjfaTdhx8wG606oZHVsPOWZZSnLx44BWfrU9+0DZbAe5Hc7+6
         pYdgh0WsyN/ZlcQrxPvmkKvkOIa699Vxqhdy6q7z1iGrY0fZgvTAEOuXGS7biQh3BEja
         bCRg3G+gCVFvoFtX0K6W8PMze61FR++LqsC1BvY5gEkbhI+oyUd85gUOlEDcYuXfQd9R
         elxs41PAs6nt1T5TwwjywPJ+9lemqX5AYu+1pwFOTu+bIOPtbJDHEruAdaKJ91qhXsne
         BCYuiySjnIuycA84pZl3AkL2C4KMOZKMi71AXbk1BFNFOpqNTllE3E3IQS08mIvCr4cl
         kvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CN0Is/V5j8jHxbgM1x+zBDCRPJAe4Cf2GAcP+bs7IVA=;
        b=HJK1HGLgeNVfqDzAEjykekS8oR3Of8sR2H6ykHTQvZeihefMeytAvTCP4POtwXVIQi
         wqqlR8fJ5BI2zcvF1PSbkLn/0xVFT2k/DZORrWwUQoGb8LuO4YZBakIqdzC6GKEwMqMU
         4ZwUsWhlGMaLb9hx/iqCrTFjwpMBsKLicVtO90hCGtppjwEihpJBv/0qOigSyHZsYmF5
         QdQZy3fZMNyCOsnWDKBIjQdawx34ma8h+T8U6lfeejQtP0H/hdJ4PrrXC8gRoF2WRvpa
         zbJGEFW88Us1zD+ujPn3jh3AjVFlMX4BOzDsQDCJ6p8/pM5HEFVdQnoL8YvvgG6fQX5X
         5Heg==
X-Gm-Message-State: AA+aEWayfMWoIs6HB9Sqi0P/pdFpNrqussXRftZdMucb/8/nMbu9u+3s
        4CJ4CLJUn6egihWf5zfi4W7rJMRk2kVhnZhiXi/MFQ==
X-Google-Smtp-Source: AFSGD/V7REqBJ9NY040fl2E0hiGhgfakiXggWoQiS2EZk3gSqla7gMuUKYEMiQo7pLEN+6RgxZMnmS6u1sblLyFG0tM=
X-Received: by 2002:a50:8343:: with SMTP id 61mr2722415edh.154.1543517760951;
 Thu, 29 Nov 2018 10:56:00 -0800 (PST)
MIME-Version: 1.0
References: <87zhtsx73l.fsf@evledraar.gmail.com>
In-Reply-To: <87zhtsx73l.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 29 Nov 2018 10:55:49 -0800
Message-ID: <CAGZ79ka1sjU+rHctRP4SVMP0GQsK2iZghkU46=f96ugqvX5Neg@mail.gmail.com>
Subject: Re: How de-duplicate similar repositories with alternates
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, git-users@googlegroups.com,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 29, 2018 at 7:00 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> A co-worker asked me today how space could be saved when you have
> multiple checkouts of the same repository (at different revs) on the
> same machine. I said since these won't block-level de-duplicate well[1]
> one way to do this is with alternates.

Another way is to use git-worktree, which would solve the gc issues
mentioned below?

I view alternates as a historic artefact as the deduping
of objects client side can be done using worktrees, and on the
serverside - I think - most of the git hosters use namespaces
and put a fork network into the same repository and use pack islands.

Can you elaborate on why worktrees would not solve the problem?
(I initially was hesitant to use them as I liked going into .git and temper=
ing
with files such as the config directly. But now I cannot `cd .git` any more=
;
it turns out the advantages outweigh this corner case that I was attached t=
o)

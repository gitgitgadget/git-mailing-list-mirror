Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC78C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 17:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiGURbn convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 21 Jul 2022 13:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGURbl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 13:31:41 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512101A826
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 10:31:40 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-31e45527da5so24826397b3.5
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 10:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k7jAQTu2n516AQOU6gG5pEuDsGtmpx2BurE5KIutF8o=;
        b=Nz5xMkYYO/dflSjfGSsUuYuUpIWqQvwigvjPoBaA0cng+DHiIZuuN67D6PK2Bv4xy/
         r4zQip4lsjz3HYI8Fnybw1zgkKdbezEGd86JKz1DE5qyHrIasFoP6RurwdZPi6slT3vu
         ySWYcoupz1cHYVBItdSyjlNeSMHT1L70MSHDmmYGDPAjT0mB7vctbJTZa/W9h+ES1LXu
         d+74e2/VV35e4+7uQRpdAS96VQpUmfzXULcqxUt/WvcIWUdhHYb8+nbEcNfzvMMsX/zG
         aRnKdzLTUqVPg/sNOdfMTWaPP06MpNGMPgoFsYK2mIAns3oAhsh2Y6YnIrKLBRoV7y9V
         pYAw==
X-Gm-Message-State: AJIora8jXYFTGDP/gPXlU0EW8ak3l7g7VUQts8SD7kwRZgtLHYLzE4bh
        1bpNEkQk3wvMY8wjLIIZISWrykWnILRHRatNzY8=
X-Google-Smtp-Source: AGRyM1sOHhcsYe9Dur/q08riF7vRPw/yJAM6q/c2a/dS7SJeJtV4Z3gNSP1XB0vqV02G/dVzje6aBYoIzbvkbfJDZj4=
X-Received: by 2002:a0d:e609:0:b0:31e:695f:8eba with SMTP id
 p9-20020a0de609000000b0031e695f8ebamr10094148ywe.70.1658424699460; Thu, 21
 Jul 2022 10:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
 <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com> <patch-v5-4.9-a7310898866-20220721T160721Z-avarab@gmail.com>
In-Reply-To: <patch-v5-4.9-a7310898866-20220721T160721Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 Jul 2022 13:31:28 -0400
Message-ID: <CAPig+cQ99HD0d9wDS1=ESsDgucu_Dqk5YJGSYB9USUZ1odMP4Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] git docs: add a category for file formats,
 protocols and interfaces
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

/On Thu, Jul 21, 2022 at 12:14 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Create a new "File formats, protocols and other developer interfaces"
> section in the main "git help git" manual page and start moving the
> documentation that now lives in "Documentation/technical/*.git" over
> to it. This compliments the newly added and adjacent "Repository,
> command and file interfaces" section.

nit: s/compliments/complements/

> This makes the technical documentation more accessible and
> discoverable. Before this we wouldn't install it by default, and had
> no ability to build man page versions of them. The links to them from
> our existing documentation link to the generated HTML version of these
> docs.
>
> So let's start moving those over, starting with just the
> "bundle-format.txt" documentation added in 7378ec90e1c (doc: describe
> Git bundle format, 2020-02-07). We'll now have a new
> gitformat-bundle(5) man page. Subsequent commits will move more git
> internal format documentation over.
>
> Unfortunately the syntax of the current Documentation/technical/*.txt
> is not the same (when it comes to section headings etc.) as our
> Documentation/*.txt documentation, so change the relevant bits of
> syntax as we're moving this over.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

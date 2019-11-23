Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C868FC432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 06:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AED620719
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 06:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfKWGVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 01:21:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44726 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfKWGVn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 01:21:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so11124153wrn.11
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 22:21:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YV8LOp+3LVr1H0xyzlU6fphIHRFxQ9gsNWAfGB4hXvQ=;
        b=AU5wrOKMf6z6Pz/BFymJb7ONC9jVZZkZYZZN2YNLyB85pR925fNmbGtwFW1n24cTcO
         VJHyBupnev0h5AFLuBG/eLs0pgf5+YT0Bv0omRscZxly8eM+kEtB+uic7sMNhQMYamyR
         NhsGcmtS4R3LmxGLmpqtd/Rj8uIwV0Fr5lSMd22EDR2LAQvMfyiCT2FpHlM1ncRk5rmU
         j2dE478VrodzU3DDwOwNpeW+N9CWotJQzVr8OTb+gcjvjN5UP087jkbCaIYN3e81nSbV
         4W9bc63kv420BCtmaK++1XRoJOfuXrC3HWQju1bFiyEjK8E3eXIJEKTx49RJGnSFrRCF
         D2Wg==
X-Gm-Message-State: APjAAAUtX2nF574DAKWPTfnKx+KHHJhKnf3phIikrHknLlrKhtdT9X+r
        rR4HwAsd/0elOIoKdCLqc17Ja1BnPt2EcckDzIQ=
X-Google-Smtp-Source: APXvYqxyJRvyIU/jtsm05dUair4BMFhNl09cFUelPUFqgQfOh4dxKgYIq3N4ku/IgnSRvevG8pPiXrwUkmqJ/alrt6k=
X-Received: by 2002:adf:b193:: with SMTP id q19mr20031653wra.78.1574490101183;
 Fri, 22 Nov 2019 22:21:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574296987.git.liu.denton@gmail.com> <cover.1574449072.git.liu.denton@gmail.com>
 <85c2f8ca2704e54c2d0e6e65822a04d21e383f6a.1574449072.git.liu.denton@gmail.com>
In-Reply-To: <85c2f8ca2704e54c2d0e6e65822a04d21e383f6a.1574449072.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 23 Nov 2019 01:21:29 -0500
Message-ID: <CAPig+cTE_cYQi=Ys5tKYbs6bRXf9moNqO6zo1M_hn6w9HfL-bQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/22] t5317: use ! grep to check for no matching lines
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 22, 2019 at 2:00 PM Denton Liu <liu.denton@gmail.com> wrote:
> [...]
> While at it, drop unnecessary invocations of 'awk' and 'sort' in each
> affected test since those commands do not influence the outcome. It's
> not clear why that extra work was being done in the first place, and the
> code's history doesn't shed any light on the matter since these tests
> were simply born this way[1], doing all the unnecessary work for no
> reason, probably due to copy/paste programming...

Taking this wording literally from my review comment[1] is (again)
fine, but I ended the fragment intentionally with "..." with the
expectation that you would fill in the remainder, not expecting you to
copy/paste the fragment blindly. Without the remainder -- the part
which is supposed to follow the "..." -- the reader if left hanging.

[1]: https://lore.kernel.org/git/CAPig+cQviTjwLSZ+QkC62B58mq6z3yDA-XhPVJQYRq0inEo9nA@mail.gmail.com/

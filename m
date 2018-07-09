Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 546A81F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933060AbeGIUw3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:52:29 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:40530 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932928AbeGIUw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:52:28 -0400
Received: by mail-oi0-f48.google.com with SMTP id w126-v6so38477627oie.7
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 13:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tQJ7exFFn7dRTK1qv5jjughuW7c7eHPQCQbYFCsi0gc=;
        b=pwBdlg4rwmw3XToqf594wLDJ0558vWxvLAlAoYF993PsYZ3wbJXiOEPTZcJN/2y/ry
         9u/GmZ5wq6oTnXC0mksYsYShMvqZVJ8wtFB0iaYRTqN6Ozl1CffXFzrgnYvhZ+fEJT2u
         F5Ti+w51tNiLtAbPSYEbLRY6ohbubnBxSL9QEayFDwFI+FEHCgO8pFzCTYod6T9VHbid
         pSUlI6HCONzl3DpfzEzIpZZJAfHk0cUBT7phyIdFOxoAsdJUl2EydY19Or7AY31pneQG
         a+z8nvSXI2i+tPAsiz8ppdBhbTuxEplXemkzansqR//40ar3Fc00RdKhq5w0Jf04tLCg
         YL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tQJ7exFFn7dRTK1qv5jjughuW7c7eHPQCQbYFCsi0gc=;
        b=smY3uH+8JMfh/Bf7z9XCyWvYEMB2B4WJP/e6eoPcDna4WItMSX5SjS1sKwyX3t9Tgn
         NcNCWatZeOPw8vOoHuVkFEOxWHPEevsyy0KavlUsip5yKsf2Z61/1zbP1GF3pOOluTCA
         tD0Yow2NDt17zGRGXsQGqWisIpW6t3jRwyldBvEfDWDIMr4+JgB5499GjiAxqYr3t/wl
         wjqFsHF4LncnkZqvIbsySte4DmK0lBqULcZb8hX/A8GDyQH5OXjYd7pzka/kHf4PP4Hl
         vZhYlldcgovorY5wajWpR4U6PkEmS3gOPioNVo+wGzy7PtgQcVMnvC9wnCXyt9gfQ1MN
         tyeA==
X-Gm-Message-State: APt69E0zVTel/ylN4O75IXHrXeWi1vAa2p5+IqoD/cSWcANmQ2z+Zfb1
        5hSFSo3RNfUSDS+uuuZ0X1wNUbJwOJz7WAJakkc=
X-Google-Smtp-Source: AAOMgpf/fZCgEAWM6+QLf4LAi5uXeIeaArrN29QO1LagetPiElRj+yGGlgP9RTUw1sPyEhmpbbajBo8OMwEBsX2H4Hg=
X-Received: by 2002:aca:bc54:: with SMTP id m81-v6mr26024875oif.308.1531169547930;
 Mon, 09 Jul 2018 13:52:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:74c3:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 13:52:07 -0700 (PDT)
In-Reply-To: <20180709180804.GA6134@sigill.intra.peff.net>
References: <CAFW+GMBLeLyJjJPaEXkyQ5fJ=L4q4vQ=26wjZ+n07ZvSaTaCUg@mail.gmail.com>
 <CAFW+GMAnkLYReotwRvbVt9iPqmuq_8WMc1sck4Jkj_fyafVm3w@mail.gmail.com> <20180709180804.GA6134@sigill.intra.peff.net>
From:   William Chargin <wchargin@gmail.com>
Date:   Mon, 9 Jul 2018 13:52:07 -0700
Message-ID: <CAFW+GMB0x9Kimmdt_v1-eOhTUV=gzj7SyHwR2KF5ofHL0d15ug@mail.gmail.com>
Subject: Re: Unexpected behavior with :/<text> references
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yep, I agree with your analysis. I'd be happy to test and commit this,
probably later today.

Thanks for your input, and for the patch!

Best,
WC

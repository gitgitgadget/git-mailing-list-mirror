Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 850BB2036D
	for <e@80x24.org>; Thu,  5 Oct 2017 10:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751427AbdJEKQg (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 06:16:36 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36209 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbdJEKQf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 06:16:35 -0400
Received: by mail-vk0-f67.google.com with SMTP id w23so4140105vkw.3
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 03:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MGcypwo4nW+EzlXmWSrq3Mil7hcbQUygyR+UGysqoz4=;
        b=pJntxc6Bxyi2NPTODzXPETVga/ckNhKCIRKRwWq803m0LwZ8e8vhDTY2FociBMR6wB
         aFCMc/lfI6XYL0i0hOBMYXe6tH63z3kzRQLKZ5uiGLuJcZPHIthXXswubJmnvU8BJ/dd
         kyWX/IuPQSWFANQWzUEQejhoa5pKhZPkqOdNNU7z2S7u2KTyfsXM94SAdKIjzUBPab/2
         aUZGAI9NXSR2uCVD8XiHZ4tlxr0g7kkt/E7zrk0AsuVklwtzCbi4Zv9Fz/ZHGsxHI4Ft
         1uFsBsWEessX739bCKAXL/nCl5d9SbeljmsfYS/H+cMs7RvchNy8XN/Mbz9XTdgjQ5FT
         K5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=MGcypwo4nW+EzlXmWSrq3Mil7hcbQUygyR+UGysqoz4=;
        b=OvZWSoBKeMPILnPvKpUcnXR9pf/UkWaQRNiNCUYZYgHvwNpB3u+URWE1Zr0jV4fX3b
         xh2fcMKvXXQL3jYJ2/GTYXtD4bixVAJHPp4s1kj70poEwfWyt4Zy9knes/bZnZfDwxSI
         QzJs8gLAcIZWu8zg8X09qabt3lll5lFsMKOyuUgi9TMI6TI635Ln3OeG7c4f5OliuvEP
         aN1fzPhhGIokXihq1CtfJQNUPbwYPQyNYnS97Qtkf9WuHdaE2kEv/khM4gsAGvcE00NS
         SoN8sbCp1vbtBlh7G3etGC90yIs9D0Ee0+ZkdN/OjQPtIy0Wn+6bDxZoy9rE4L6CIrgH
         RQAg==
X-Gm-Message-State: AHPjjUg3/SAwTkeNuSAYj4vIJZohSX2q/uRbPMJAyVwg6Wv37O18grub
        Rl0WS2tC6tb7LOt+uA8jxn1LNAMdD3Xye3ghzY8=
X-Google-Smtp-Source: AOwi7QD9ntWx1u7bt63L/p5b5w0v5+PlqgREACS3MG7KNHFZtmm8vc3+INhDVVPlMgB1wfCYdS9rOGS14T8rfrh+SWM=
X-Received: by 10.31.186.71 with SMTP id k68mr12960842vkf.98.1507198594588;
 Thu, 05 Oct 2017 03:16:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.16.157 with HTTP; Thu, 5 Oct 2017 03:16:14 -0700 (PDT)
In-Reply-To: <20171005100001.do5m4zhexcsltvw7@sigill.intra.peff.net>
References: <20170925095452.66833-1-dstolee@microsoft.com> <20170925095452.66833-2-dstolee@microsoft.com>
 <20171005084249.sdkimglkxqh2vi4i@sigill.intra.peff.net> <xmqqvaju6i3p.fsf@gitster.mtv.corp.google.com>
 <20171005100001.do5m4zhexcsltvw7@sigill.intra.peff.net>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Thu, 5 Oct 2017 19:16:14 +0900
X-Google-Sender-Auth: CXrnYBEeHh0tNUPTD5m7QvgWAYk
Message-ID: <CAPc5daVKNgU8XsUnBDYYutFqZt_RmTomKGCV5GEsFN6+6==jmA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] test-list-objects: List a subset of object ids
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 5, 2017 at 7:00 PM, Jeff King <peff@peff.net> wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
> Actually, I'd just as soon see timings for "git log --format=%h" or "git
> log --raw", as opposed to patches 1 and 2.
>
> You won't see a 90% speedup there, but you will see the actual
> improvement that real-world users are going to experience, which is way
> more important, IMHO.

Yup, "log --raw -r" would really exercise the abbreviation machinery
without spending time on the diff machinery, and it would be a good
test.

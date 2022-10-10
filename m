Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9B1C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 12:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiJJMTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 08:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiJJMTE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 08:19:04 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD8918B3B
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 05:19:03 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id h10so6987708qvq.7
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 05:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b0jqAxQakVDOXuh7MczrB3hQOlk+IxCer+e1ipeLtSM=;
        b=cS4bNQbc3+7Dikp/6X8J+XTCWN2HoUYuAVwylJ1jRCF8kc9JMCZL/k5ObNM9jR6xF1
         YYW+VlgXqIkfS92OmwchNhIp0/INQCFs2+QPZWNufcZ/6y94RuK33YxVI3w3kbPHCX/Z
         O8KwSb2ih/IzLqYPnw/tE2QCn8bXOODTKkpZLVpRd0W61F1GNZOlAvRhwsA+enG4gZ1i
         ROeCSMLQzuDDPliz24vWuMBZfQk0lPhJyIoL2PMGTArU5sPX/E/HiLBwhYQd4hZimxS1
         HYlyolnfvkpcHSZk0xC7IqVLjTFR2XvIbjcwXGyjcQ2h0wk7mBZW4yoxODeqVOLFtcs7
         ijCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0jqAxQakVDOXuh7MczrB3hQOlk+IxCer+e1ipeLtSM=;
        b=arrsJey8edoqHXX5PyKRP/vIxb43YUwy/dTGJg/0Xu3USYqzLoFo+coghGiUziQnnL
         uE6M1o3FvZBIeabT1f/vlCU5SNCLpFJSDIUtfcguIhnC1onIHBmUqrf2OJiUgLpiWRYN
         7MYKLkCrln89aekAsZX18On/2TLhFIKQdTdUXXaODqmgo6037rYC5pXMIWRMVqAh3Lpv
         wLGyfwoVERLYSbffQWWnFR0eHmWLCR5TNOo2u7ShJf6ggWgfkaqScvCw13tErCCKq6yz
         lf5Ljp9iXyM40/aJrH7taJftc9ixPfGAjw+bfCJSz0RiTPH23nRxlsGHHYG+I0IS37PK
         pqzQ==
X-Gm-Message-State: ACrzQf0Dm9TwB8TsUTKdgt+lSR+eUCuOybM5QTsopYErooafV/w+zT7n
        JqiIKOE0wakGOgNQJtdXBVurTk1PvfPTVv4SskIWd4KE/qyaLg==
X-Google-Smtp-Source: AMsMyM73JM1dmjHnCoWjyPeNSA/pZ5Y36dP9lWYxNa3IlL4BvztuV1clX05u1zzadHLZS6zm0lsKwVQvUnbmUPpP91c=
X-Received: by 2002:a0c:f445:0:b0:4b1:b0c9:a334 with SMTP id
 h5-20020a0cf445000000b004b1b0c9a334mr14332494qvm.131.1665404342216; Mon, 10
 Oct 2022 05:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PPyiEvfkqZYq6uESMt3QYnfMDZDmPbGiQ5Qkeb77rtLV5Aug@mail.gmail.com>
 <CAP8UFD1o5qxSvbV05DK_J=zbU=D_+HS0Q2ufEFSQVaBoWw_7Ow@mail.gmail.com>
In-Reply-To: <CAP8UFD1o5qxSvbV05DK_J=zbU=D_+HS0Q2ufEFSQVaBoWw_7Ow@mail.gmail.com>
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Mon, 10 Oct 2022 15:18:50 +0300
Message-ID: <CA+PPyiF5KK6p7rv57YL_wsDO+WPifoRp1oe0F-6mo5NxLAwDWw@mail.gmail.com>
Subject: Re: [Outreachy] internship contribution
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I see most of the articles are UNIX based, does it mean that I should
have a UNIX based operating system in order to contribute?
Currently, I have windows installed 11 on my PC

On Mon, Oct 10, 2022 at 11:19 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi Wilberforce,
>
> On Sun, Oct 9, 2022 at 6:46 AM NSENGIYUMVA WILBERFORCE
> <nsengiyumvawilberforce@gmail.com> wrote:
> >
> > Hi, I am Nsengiyumva Wilberforce From Uganda. I am happy that my first
> > application for outreachy internship was accepted.
> >
> > When I read about Git in the project list, I got interested and I will
> > be glad to be hooked into this community and get my hands dirty in
> > contributions. I am eager to learn new things from my mentor and the
> > entire community.
> >
> > I will be glad to hear from the community on some tips on how to get
> > started with contribution.
> >
> > And more so would like to get in touch with the my mentor
>
> As you also sent me a private message, I already replied privately.
> But for the public record and maybe other applicants for an Outreachy
> internship who might be interested in working on Git, we have
> information about how to get started contributing on the following
> pages:
>
> - https://git.github.io/Hacking-Git/
> - https://git.github.io/General-Microproject-Information/
>
> About microproject ideas, we haven't set up a specific page yet for
> this Outreachy round. Maybe we will do it but you shouldn't count on
> it. You can still take a look at the pages for the previous GSoC or
> Outreachy rounds like:
>
> - https://git.github.io/SoC-2022-Microprojects/
> - https://git.github.io/Outreachy-23-Microprojects/
> - https://git.github.io/SoC-2020-Microprojects/
>
> You will see that some ideas are quite generic and we propose them
> over and over as they are still valid.
>
> You are welcome to ask specific questions (publicly is preferred so
> that others can benefit).
>
> Thanks again for your interest in working on Git,
> Christian.

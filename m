Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56DFC433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 08:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiJJIUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 04:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiJJITm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 04:19:42 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2758126EA
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 01:19:40 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id b145so12259238yba.0
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 01:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8bQ6lWGGSnbO5mcGxbhRCmc7as16d3BNeZJv0twMCzk=;
        b=fJOSL4AK/LtQ0/L8rOXBQ1q1JqsXUKaYBFvzaaJI2UNdJRoH/tBPAtZVeg6hkc1no1
         lmUtxKTwYcUI/TZt+YcQ6v+4L4WQFIiazn1jBaOY5NkFvPEPTZZYNtu86mVyUMMxWL0R
         1jX+t1ONHUNHV6KCyaKi2tny1zY9XmgYbkQNmH7voyJKiuHp0CIMV3LQShPrT415HJ0M
         YEgKCHaetkhl6Mf1JGqcVgf0u5BgVPdoClJz/AHgp4x3iCMcvdOMCioCMdK/BHxoYS7I
         vOYRHR7s1POj2XD4GxLpgUSFpQic8phNvoXCLzcmj9jtinnRgXOLVtQaS9rMbQevgw56
         +PjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bQ6lWGGSnbO5mcGxbhRCmc7as16d3BNeZJv0twMCzk=;
        b=bQmP0j8EmKaNRn3UX9VCzkX4/Xam19MwMemw5KkgEjDTCafHuHRd8pIssIhmnyQOzl
         sSQYCaQm5W26b67InBs3eEGryUjfleU3UqPXQMjc42EVoZeD2cgiLo2+f1uzfK0yGHvg
         DM4FC5CMDEHcTa5wwoZ6kKgJxg9j6/7VG4sBfATnyEta6ZkSA1OO10gbMMSpB/2IxAiG
         0SjHyT98jSyFXcfnTCw8s3mvxY19+SQI6eHZDl/PSwSLXqlM70Ni5QpCncWDPHZqvhgM
         TQAKrVyY410zxwSAC1/VfkJpg7A8pq86uO1OI3jdmEdrkllWWvwS6Fi7Rz8escs2ikVl
         0+KQ==
X-Gm-Message-State: ACrzQf255NmQna+B3Uk/dhDwyEMip0YjD9TE0LZpsFNwxqPKxe7OnIgA
        aD4IRBzTnMEMIpGe34SDj1Pk9l5433UdXsHtoQY=
X-Google-Smtp-Source: AMsMyM7NLZNlJW64RnNqFz56Ulyh0I+fXPNr7UqzzOcY5mG0W7DdZaK7rtWX2d5e5vvRziDuqeZSYyqZTPzQGLwo4oE=
X-Received: by 2002:a25:c8c4:0:b0:6c0:c896:1208 with SMTP id
 y187-20020a25c8c4000000b006c0c8961208mr5317512ybf.494.1665389979076; Mon, 10
 Oct 2022 01:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PPyiEvfkqZYq6uESMt3QYnfMDZDmPbGiQ5Qkeb77rtLV5Aug@mail.gmail.com>
In-Reply-To: <CA+PPyiEvfkqZYq6uESMt3QYnfMDZDmPbGiQ5Qkeb77rtLV5Aug@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 10 Oct 2022 10:19:27 +0200
Message-ID: <CAP8UFD1o5qxSvbV05DK_J=zbU=D_+HS0Q2ufEFSQVaBoWw_7Ow@mail.gmail.com>
Subject: Re: [Outreachy] internship contribution
To:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Cc:     git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Wilberforce,

On Sun, Oct 9, 2022 at 6:46 AM NSENGIYUMVA WILBERFORCE
<nsengiyumvawilberforce@gmail.com> wrote:
>
> Hi, I am Nsengiyumva Wilberforce From Uganda. I am happy that my first
> application for outreachy internship was accepted.
>
> When I read about Git in the project list, I got interested and I will
> be glad to be hooked into this community and get my hands dirty in
> contributions. I am eager to learn new things from my mentor and the
> entire community.
>
> I will be glad to hear from the community on some tips on how to get
> started with contribution.
>
> And more so would like to get in touch with the my mentor

As you also sent me a private message, I already replied privately.
But for the public record and maybe other applicants for an Outreachy
internship who might be interested in working on Git, we have
information about how to get started contributing on the following
pages:

- https://git.github.io/Hacking-Git/
- https://git.github.io/General-Microproject-Information/

About microproject ideas, we haven't set up a specific page yet for
this Outreachy round. Maybe we will do it but you shouldn't count on
it. You can still take a look at the pages for the previous GSoC or
Outreachy rounds like:

- https://git.github.io/SoC-2022-Microprojects/
- https://git.github.io/Outreachy-23-Microprojects/
- https://git.github.io/SoC-2020-Microprojects/

You will see that some ideas are quite generic and we propose them
over and over as they are still valid.

You are welcome to ask specific questions (publicly is preferred so
that others can benefit).

Thanks again for your interest in working on Git,
Christian.

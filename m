Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828D7C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 17:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352973AbiCPRu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 13:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236996AbiCPRuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 13:50:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C036A05F
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 10:49:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w12so4991523lfr.9
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 10:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2OY5Ie0NPXrGwfBOG4r7I3yZ8aKWJpxkVPBpfDt91D0=;
        b=oow3A9Mso/ugqnUQM0/Wn3sk75CXNMZw0AFPliEutfZ1cuoLYufm74ieJToxfR8Pl/
         ka8+LbBqQ7Jwyj6Vd+7T7lQC2m0iiYXl4vrZScBGnVPxS/JxzAqRWP8EpNyZ7+Qa72r8
         0U5qU7smYJZsOI3PQCURpqV0Aa+GMKiUJW9E4dyitM9Y6PoRYvTriyFdJDGFGn8cA1v+
         3a+6BhFl5gSrf+6B+tn4L8MP949nlcZ2WrTjcCH/PGL7lyEigcbgwts8UPzi6gE3Rrnr
         WyNzAHoGT+p+SB2qSnLNvMgPrJpnvI+ZeyyksVPErsWTzL7kWwB6epOB8WoOjq9XRHfq
         Nc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2OY5Ie0NPXrGwfBOG4r7I3yZ8aKWJpxkVPBpfDt91D0=;
        b=cY5ubnN2xp6/PlYmf9u2modRz11liij1GsRUSLeO61MQ6hKMwpMajSIB1UYVVJuLfs
         X7pPDYerbpz2hgGw/7FfLB9zUpJrX8lC/rSIKepLHO4VEJhn9ZU+4B6H4eFkw5hNybzR
         cdRb29R5xUr9BBE4ettonmeK/J1lN53jFy+EPWScePVGoBftz4Ig5qO2dzDecQKVf8Ag
         TdWNNV1L16G7mbgDBZuIPMQ/IHlvkSqhdyaI1ZrZyan3BgLkCDtMmFP6MEcJVeF2SZdp
         TwRKWIXLt4jzfdAKPG8mWg4Rt0wxzkk1TvneBXEE6g9wCZqxcySqacMbujWUAOLjtAbD
         tkXw==
X-Gm-Message-State: AOAM532uodFHGcd3VbuJrBcxKXCyTyJtcclu91BtlUyAdiXA0y8V0iCr
        3wSlJUWcaPYwBVU112n7s81QVyuWx9v+Asq0NaZ//A==
X-Google-Smtp-Source: ABdhPJx4VAbR4NDx3BNrdpVYCy0s92xmkLtmFA6qqB4gPCJvcjBYSt5Jzinu+ymRuzyzRFOI7WDQaENEjYX1r6OeJNM=
X-Received: by 2002:a19:9141:0:b0:448:2286:b731 with SMTP id
 y1-20020a199141000000b004482286b731mr466967lfj.240.1647452949068; Wed, 16 Mar
 2022 10:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com>
 <42d8eebd-f987-a24e-e47c-67334583568b@iee.email>
In-Reply-To: <42d8eebd-f987-a24e-e47c-67334583568b@iee.email>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Wed, 16 Mar 2022 10:48:57 -0700
Message-ID: <CAJoAoZn91dyFEdMKUj_XU8CjUbh5EtdqjTR3CaAe=Bhii7dt3Q@mail.gmail.com>
Subject: Re: Let's have a user experience workshop
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Alice Merrick <amerrick@google.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 16, 2022 at 10:38 AM Philip Oakley <philipoakley@iee.email> wrote:

> > Interested?
> > * Join the git UX Google group (https://groups.google.com/g/git-ux) if you
> > are interested in participating in an event.
> I joined the group, but there are no current entries, and, at present I
> can't post anything.

I can shed a little light here. I set up the list; for now, it's
primarily intended for use as a roster for a future live event
(similar to, but smaller scale than, the diversity/equity/inclusion
workshop we had a couple of years ago). Maybe after the event it will
be useful to open that list up for posting, but if I'm being honest,
I'd personally prefer to keep discussions about Git's UX on git@vger,
where everybody can participate. Hopefully that rationale clears up
why you're unable to post or see anything there. :)

 - Emily

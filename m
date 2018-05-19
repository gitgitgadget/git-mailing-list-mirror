Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E29C81F51C
	for <e@80x24.org>; Sat, 19 May 2018 05:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750785AbeESFq3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 01:46:29 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:33924 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeESFq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 01:46:28 -0400
Received: by mail-ot0-f176.google.com with SMTP id i5-v6so11566115otf.1
        for <git@vger.kernel.org>; Fri, 18 May 2018 22:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vd21mogDVNlsKJx1X/cBtgCZlymt7s0YgRwd2/gO2YY=;
        b=aTxw94ghIXmFV+zRqy6BniDU4l565W1+hrruXUGkuOcfKyalG5EUoF5Z1UJtbLBMio
         93kl4H8UZK+awaMe3mCj36tXen/fMacGhj1h3KDFvC3785pBXAgoIyk23VuBqtyo3bVM
         Bdq+r3IN597/5GhudUMnlmlPuCQwPvjmOJwronmGzyl3CuSrVASrR8fQs+HGq5OxCP7D
         HphqlbfhSiFLWKTZXYi/2oLEI7wfciPaZOiQdiIZ9T8WdrRjwuHvrjMHqBW1pZ+Y9iAE
         dhn4MrRdzL/P6dMc/Fyhw8ua3M52ZoOqEZBi4THHHNysO709rctDoReMd1wUa3RCQYRR
         t+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vd21mogDVNlsKJx1X/cBtgCZlymt7s0YgRwd2/gO2YY=;
        b=XaQ6tOacTRqDEa5kYTNVpvEg2pBI76UUHDNiplznNmlbVmTI+a3mmemzxsoeT9tTjR
         ZMVES+z4PZW/gUfSIMvGMTSPE8iqoTw+EcAsl27ZXjR6V/LWqfx2ydomWGZXD3szSU9Y
         93ERKhfiZiK6x/E/oG4KNXk9YJMr1OVPOL4jeMQ1lF39FDR/dNSKUabEQ9l/buw8J6fh
         RNgBxTiDNCbNp+cpmlelmNy4ruG0s4omr1ms7cplwmnFC4DN+A1anilyZymw8yOkC8t7
         1g0NKSTNdNkfF2nqYTb8ORKF+FC4L9seiBaHxPXSEg8sAlNOuLl+5+IoZxjFpOJZ2671
         wqHg==
X-Gm-Message-State: ALKqPwcaMhiogcApRe9Omfc9AYCx5d4VR+iIlmB9XUk2zVHbvVA7YhVv
        T0i/zP3CBNrKNn/prHH8q0Pi4MRTClGRjEoo3p8=
X-Google-Smtp-Source: AB8JxZo99cg9HOlW6PNB5oMzevUMNnVwrQGYtA9Nx0gAGnzR9a4S6Alsql/Io0X43ywJfspisyOBGeOvOwSQzrXN5CI=
X-Received: by 2002:a9d:e8f:: with SMTP id 15-v6mr8783923otj.14.1526708787445;
 Fri, 18 May 2018 22:46:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Fri, 18 May 2018 22:45:56 -0700 (PDT)
In-Reply-To: <20180517033110.GA13235@sigill.intra.peff.net>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <87h8n7bhro.fsf@evledraar.gmail.com> <a933cb3a-6c04-d963-aeda-b5850ca8994c@linuxfoundation.org>
 <1950199.Z2x8tXoTfI@mfick-lnx> <e8776c83-ea57-456d-5bc8-ca2fc990bed0@linuxfoundation.org>
 <20180516192343.GB3417@sigill.intra.peff.net> <3289a942-3f0d-ff63-7eab-95fe06c4c0f6@linuxfoundation.org>
 <20180516193744.GA4036@sigill.intra.peff.net> <5156717b-6fc9-b792-dfa4-1ba48ac50333@linuxfoundation.org>
 <20180517004355.GA9431@sita-lt.atc.tcs.com> <20180517033110.GA13235@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 19 May 2018 07:45:56 +0200
Message-ID: <CACsJy8AGugSYaPw9qxxXhGEz4RgawQ+moVtoGJcWhQ_=HRUOqA@mail.gmail.com>
Subject: Re: worktrees vs. alternates
To:     Jeff King <peff@peff.net>
Cc:     Sitaram Chamarty <sitaramc@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Martin Fick <mfick@codeaurora.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 17, 2018 at 5:31 AM, Jeff King <peff@peff.net> wrote:
> On Thu, May 17, 2018 at 06:13:55AM +0530, Sitaram Chamarty wrote:
>
>> I may have missed a few of the earlier messages, but in the last
>> 20 or so in this thread, I did not see namespaces mentioned by
>> anyone. (I.e., apologies if it was addressed and discarded
>> earlier!)
>>
>> I was under the impression that, as long as "read" access need
>> not be controlled (Konstantin's situation, at least, and maybe
>> Peff's too, for public repos), namespaces are a good way to
>> create and manage that "mother repo".
>>
>> Is that not true anymore?  Mind, I have not actually used them
>> in anger anywhere, so I could be missing some really big point
>> here.
>
> The biggest problem with namespaces as they are currently implemented is
> that they do not apply universally to all commands. If you only access
> the repo via push/fetch, they may be fine. But as soon as you start
> doing other operations (e.g., showing the history of a branch in a web
> interface), you don't get to use the namespaced names anymore.
>
> I think a different implementation of namespaces could do this better.
> E.g., by controlling the view of the refs at the refs.c layer (or
> perhaps as a filtering backend).

Yeah. Namespaces (that work for all commands) + worktree was my plan
for centralizing repos (for one user). But I never got that far to
look into making ref namespaces work for everything.
-- 
Duy

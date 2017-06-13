Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 672A31FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbdFMRNp (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:13:45 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36825 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbdFMRNo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:13:44 -0400
Received: by mail-pg0-f51.google.com with SMTP id a70so63416625pge.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aowoWVLQENeW7ygZnUQbaVLskIskJCpIAHl9Ic6yEQg=;
        b=LKCXIMye8Yzdg0FZ6fxoVhG0QaZwsQlGTMNyPyBl2CBu1Zp9Z/fIp7UXGDSsndld1l
         /EiD/G4MWWxoeYd1t1boOD7rcmL4zxrH8GkXhte4eBnOazgVSHKR3nxm/FGCtJl1VMEk
         mAeqxX3yiYImfrfxv8O6PVleck6VLzikzaEHXRzSosYJ4WAZ8TwLHaUbn6xjfIXoMO+i
         GfbFDkqo6CZQ9fjoMQnJXq0IcJABrusrm0DI+sd2Bfd0TULVmCT6dZ7Hj2U4D/DCydb4
         Yw40ekZAYBYipeuymYQfVwfn3RxpceyJ6sQOPuaJcihzk6kcVfYH5/oe34tmfMSj4A1F
         UWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aowoWVLQENeW7ygZnUQbaVLskIskJCpIAHl9Ic6yEQg=;
        b=N3LTmRmG8xtqo322BW0RmBZBnn6q5aZyVljMpAHQQ8XDWFXfDPBUXszbNY3XOCooJr
         XcmY6S8JGyDgOzCEFXY62zfZ4OnHOxEcSwUYpwH8xiS1Qy1s1afgVtXIqbHHJ6qlrQRa
         AWO84uu5ea1RYR/u7UhYFk9HssMS76VaRi/PnKkb4XYCaV1XnT9/uGnoRV13TFCX4VsP
         h1Iu53CDpif6DkjdDyLnHX4J0iU+dk6mZCVHLKJz70AMOz6Ok1DG+Yi8UcjeH2AR1Dax
         3BoCJSsEFi/C9Gqqey7Glzx3yTFdmzjKc7wGXW8Kq0WSpOX5boRk5oXmaJ/YuMIgQdg3
         vtMw==
X-Gm-Message-State: AKS2vOwhknUCPFVmUEmnc1uER60qAzRm9q/tp+S2DxzKohJ1oKXVyLdc
        KsL9Jg541/uTdxESld7CopE15ssL850D
X-Received: by 10.84.209.228 with SMTP id y91mr760639plh.210.1497374024001;
 Tue, 13 Jun 2017 10:13:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 13 Jun 2017 10:13:43 -0700 (PDT)
In-Reply-To: <xmqqa85b9626.fsf@gitster.mtv.corp.google.com>
References: <20170613023151.9688-1-sbeller@google.com> <xmqqvanz9afq.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYR+qh1X-dQixdpDbcr5z-DJ2mkdncaVn_8y90kNco9tw@mail.gmail.com> <xmqqa85b9626.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Jun 2017 10:13:43 -0700
Message-ID: <CAGZ79kYV8Ngis=ux50Zs1r5XOBUJ=hw2=8BEkNqk7PiGamX0AA@mail.gmail.com>
Subject: Re: [RFC/PATCH] builtin/blame: darken redundant line information
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 10:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> * As you have an individual color setup, maybe you can fix this
>>   for you by setting the appropriate slots to your perception of
>>   dimmed?
>
> I do not think it is possible with only {new,old}{,alternative} 4
> colors.
>
> Consider this diff:
>
>          context
>         -B
>         -B
>         -B
>         -A
>         -A
>         -A
>          context
>         +A
>         +A
>         +A
>         +B
>         +B
>         +B
>          context
>
> Two blocks (A and B) that are adjacent are moved but swapped to form
> a pair of new adjacent blocks.
>
> We would like the boundary between the last "-B" and the first "-A"
> to be highlighted differently; all other "-A" and "-B" lines do not
> disappear but go elsewhere, so they want to be dimmed.
>
> The newly added 6 lines are actually moved from elsewhere, and we
> would like the boundary between the last "+A" and the first "+B" to
> be highlighted differently, and others are dimmed.
>
> So I'd think you would need at least two kinds of highlight colors
> plus a dimmed color.

Here is what currently happens:

>
>          context
>         -B              dim  oldMoved
>         -B              dim  oldMoved
>         -B              highlight oldMovedAlternative
>         -A              highlight oldMovedAlternative
>         -A              dim  oldMoved
>         -A              dim  oldMoved
>          context
>         +A              dim  newMoved
>         +A              dim  newMoved
>         +A              highlight  newMovedAlternative
>         +B              highlight  newMovedAlternative
>         +B              dim  newMoved
>         +B              dim  newMoved
>          context
>

So the there is only one "highlight" color in each block.
There is no separate hightligh-for-ending-block and
highlight-for-new-block respectively.

> If old_moved and old_moved_alternative are meant for highlighting
> "-B" and "-A" above differently, while new_moved and
> new_moved_alternative are for highlighting "+A" and "+B"
> differently, you'd need a way to specify "dim" for old and new moved
> lines, which seems to be impossible with only 4 new colors.

The standard non alternative was dim in my mind for the
adjacentbounds mode.

If you prefer to have the alternate mode, you rather want no dim,
no highlight, but just 2 alternating colors of equal attention-drawing.

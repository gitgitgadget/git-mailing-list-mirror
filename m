Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FB5820970
	for <e@80x24.org>; Sat,  8 Apr 2017 22:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbdDHWVu (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 18:21:50 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33155 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbdDHWVs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 18:21:48 -0400
Received: by mail-lf0-f54.google.com with SMTP id h125so55891792lfe.0
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 15:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D54Se1NSUnRU7110KYWbNXL4Zg1alKzVZM0aK8UK9eE=;
        b=tvLxnHWnZjggL6y9BxbWekH5jocv5n2pHRAnnVWZPsXvlFd7moSTQqZJv5R+qH5Zil
         eY9R3yeA/1/uVN5DrDg6NVfKwg7SDNhFpnmDMX79i4erhqWV2Ebv1yW9foYsKJq3/AB6
         r+VXlgtFh9DgpuuSLqW5+i8jbGZVCF5OgAJCeiPN27SskM44Nh/ciXVJLqTIJTwkLHPd
         9w0bZm6SflFYAuIZLPQaEL5M71OT+Vv5f+Wjk5H0S0gmslrpSJE0jNC4Bc9npjnf34iG
         jVOvF42htFqGeHtStx/Q2LZV5dqPJzibgp2bT9n7o+mf1YmznzXo0OZR0DGaoo93Ymb1
         pzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D54Se1NSUnRU7110KYWbNXL4Zg1alKzVZM0aK8UK9eE=;
        b=Sg82n6RGJ1VGISxxHgLhsujFXAFTIpYcA4NIx+901TnD9gxYTRvuSWoUC66ufJyCpR
         gwn0JuBiTiG1HMjASohmZaO2FBBTm+YaBrn1CJ9zFba5B9mRDCq7NpVAKAy9BPayjilA
         9IinfFjNxh0nRCOqbvLz8p4LJYfv0wz/fPulRtMxonyy9UBs0jxWoGDu05VwR7HMvsID
         KZkxmR+X4PaOuuu8wKBZtImDd0HVlHrxNkvvW8BH5blupSu0KuZEwbOgcDrAchuDTnz8
         xwMix5Mg8ecH8CpwTcJ/6C4YthyX+PgJVoAsFYCKIPy/egEM7X01goJu1NWy90qU0Otw
         QJ3g==
X-Gm-Message-State: AFeK/H2Y+4BSVVjRtn19UPelIvdxXlaTl0rbLhCTSBOVibNH8HgT/9VUX/7/t3C4aoPgCqXsP5ZkPVj3mbT1lw==
X-Received: by 10.25.79.69 with SMTP id a5mr15364013lfk.58.1491690107261; Sat,
 08 Apr 2017 15:21:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Sat, 8 Apr 2017 15:21:26 -0700 (PDT)
In-Reply-To: <20170408221302.e7sv6cy4xayr2w7o@sigill.intra.peff.net>
References: <1491617750.2149.10.camel@mattmccutchen.net> <CACBZZX7MeX-6RHgh2Fa9+YL03mjxs8xmyE86HnVxBxjMYizcig@mail.gmail.com>
 <20170408092910.g5wl2ew4cfu7wzft@sigill.intra.peff.net> <CA+P7+xqfHDVKpVKVYbB-4kjb9ja+u4GVMwkTFrj0f0n_OXZfvQ@mail.gmail.com>
 <20170408221302.e7sv6cy4xayr2w7o@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 8 Apr 2017 15:21:26 -0700
Message-ID: <CA+P7+xrJpoQXjTFG4VubRYJxYQHcZwzgt4BmQp2iShE__A4ycQ@mail.gmail.com>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 8, 2017 at 3:13 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Apr 08, 2017 at 02:54:29PM -0700, Jacob Keller wrote:
>
>> > So the best way to use it is something like:
>> >
>> >   git fetch              ;# update 'master' from remote
>> >   git tag base master    ;# mark our base point
>> >   git rebase -i master   ;# rewrite some commits
>> >   git push --force-with-lease=master:base master:master
>> [...]
>>
>> What if we added a separate command something like:
>>
>> git create-lease
>>
>> which you're expected to run at the start of a rewind-y operation and
>> it creates a tag (or some other ref like a tag but in a different
>> namespace) which is used by force-with-lease?
>
> So then you replace that "git tag" command above with "git
> create-lease". I think it's an incremental improvement because it would
> probably record which branch you're leasing. But I think the more
> important issue is that the user needs to remember to take the lease in
> the first place. A create-lease command doesn't help that.
>

Well, if we don't mind backwards compatibility breaking, we could
require that uesrs run create-lease, and refuse to accept anything
that isn't a lease ref? That would force the user to have created a
lease which should help? But that IS backwards incompatible...

>> It might be possible to generate these lease tags prior to operations
>> which modify history and then maybe having a way to list them so you
>> can select which one you meant when you try to use force-with-lease..
>
> So yeah, I think that is the more interesting direction. I hadn't
> considered resolving the multiple-operation ambiguity at push time. But
> I guess it would be something like "you did a rebase on sha1 X at time
> T, and then one on Y at time T+N", and you pick which one you're
> expecting. Or maybe it could even cull old leases that are still
> ancestors of your push (so old, already-pushed rebases aren't
> mentioned). I suspect that ends up being equivalent to "clear the leases
> when you push". And I think that may be converging on the "integrate"
> refs that Stefan is talking about elsewhere (or some isomorphism of it).
>
> -Peff

Yea, I agree this sort of direction is nicer.

Thanks,
Jake

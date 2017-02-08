Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B52C1FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 02:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbdBHCt2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 21:49:28 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34938 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753098AbdBHCtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 21:49:25 -0500
Received: by mail-ot0-f193.google.com with SMTP id 65so16546505otq.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 18:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JjGie7hvZEUNyTxhTgeDu8vbis+oYjh+vd+ulMg9oY8=;
        b=GNSiB/oz8F8Roihs0mELn0BfgRb6lUE1PcH1yEcfK/vjEJcFR2Q8JJYKzPQZWXQ4Ze
         FokAxdYhNTswsMToJuvzWbgbyG9AiO0U2NMS26LVARRbrSpxJAVaYN9w8v2EtwWlljiM
         /XJZxME0Ym/2N0FTzpz61/sT9x8yovCE3glgdDlOrJKwK9OP/W7fZbEaEYht52TkuHXy
         jEI2V6i34Rabb3O1eVj0VprwPS+t/ebJPeDRplNfAGDSsACDYIrQ2icI3DvyZAAs2ncU
         08mJxYC3gGeeQMvUHT7shVctn+QO0Gobq/2PRR4LQP1Qw55cjZ800YOiwk+8w5WnxY9d
         Y0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=JjGie7hvZEUNyTxhTgeDu8vbis+oYjh+vd+ulMg9oY8=;
        b=inreJN+hmSsCrD6g4iS1RGVx7VpzFcvwPCR33tUJB0DJf69Jfo+IDfEg5VLVOtkiwj
         Hfj5yH7/zEptbquWKFyp9AbRR0buQ0a9CQHgmE2l4Pc4piOxQseXCc0eV9PtJYhPbLSt
         p/9+2lenG779YK8D21/EqWzSYiEOVpB87GvIK0HEKgsDC2bWnuoNb3nIZWi0gszQDUb1
         v0n6wQCBA5L+73/jyT3A0NJOJLBXrYGHOLK9tmsXF6AQHEiR3u2cAih3k6aDOVLYfSUu
         s4J6Ah9G33/d1VU06sv67904hsamLnRLmMoyPUrTCxglJUlq57M7MHyXWcVeID/RfIBD
         pblg==
X-Gm-Message-State: AIkVDXKta22lkfqTZcYpYoX02MPUnpmV9ZPBJg3bMbKTr1pmONKAME08n0k5DBW7JcGKSEd6u7KAvnUeumQ6Tw==
X-Received: by 10.157.41.204 with SMTP id g12mr8978378otd.165.1486522165023;
 Tue, 07 Feb 2017 18:49:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.63.13 with HTTP; Tue, 7 Feb 2017 18:49:24 -0800 (PST)
In-Reply-To: <20170208024042.trmkjm4jnxidcflg@glandium.org>
References: <CA+55aFyznf1k=iyiQx6KLj3okpid0-HexZWsVkxt7LqCdz+O5A@mail.gmail.com>
 <CA+55aFzkTZAb1vy3G5M_Nb1BeOhTiCGksUfLa+ZQtiU2x6Q=Fw@mail.gmail.com>
 <alpine.LFD.2.20.1702071739060.17609@i7.lan> <20170208024042.trmkjm4jnxidcflg@glandium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Feb 2017 18:49:24 -0800
X-Google-Sender-Auth: j05P4EjMOlOslCQbG75BMKOYIoA
Message-ID: <CA+55aFxTwK=+oJT_zujKLWEho9CoL6u6LTLDEP+wzjFDx=JQyQ@mail.gmail.com>
Subject: Re: Fwd: Possibly nicer pathspec syntax?
To:     Mike Hommey <mh@glandium.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 7, 2017 at 6:40 PM, Mike Hommey <mh@glandium.org> wrote:
>
> As such, the default positive match should be ':/' (which is shorter and
> less cumbersome than ':(top)', btw)

So that's what my patch does.

However, it's actually very counter-intuitive in a subdirectory.

Git doesn't do much of that, but let me give you an example from the
kernel. Again, this is not an example of anything I would do (because
I'm always at the top), but:

  [torvalds@i7 linux]$ cd drivers/
  [torvalds@i7 drivers]$ ll

  .. whee, *lots* of diorectories ..
  .. lets see what happened in net/ ..

  [torvalds@i7 drivers]$ git diff -M --dirstat=1,cumulative
v4.10-rc6..v4.10-rc7 -- net/
     7.4% drivers/net/ethernet/adaptec/
    47.9% drivers/net/ethernet/cadence/
     7.1% drivers/net/ethernet/emulex/benet/
     1.1% drivers/net/ethernet/freescale/
     3.6% drivers/net/ethernet/mellanox/mlx4/
    23.5% drivers/net/ethernet/mellanox/mlx5/core/
    27.2% drivers/net/ethernet/mellanox/
    92.5% drivers/net/ethernet/
     5.3% drivers/net/wireless/intel/iwlwifi/mvm/
     5.9% drivers/net/wireless/intel/iwlwifi/
   100.0% drivers/net/

  .. let's see what happened *outside* of net/ ..

[torvalds@i7 drivers]$ git diff -M --dirstat=1,cumulative
v4.10-rc6..v4.10-rc7 -- :^net/
   2.4% arch/arm64/crypto/
   2.1% arch/powerpc/include/asm/
   1.5% arch/powerpc/kernel/
   3.9% arch/powerpc/
   3.5% arch/sparc/kernel/
   4.1% arch/sparc/
   8.3% arch/x86/events/intel/
   1.7% arch/x86/kernel/cpu/mcheck/
   1.6% arch/x86/kernel/cpu/microcode/
   3.3% arch/x86/kernel/cpu/
   3.8% arch/x86/kernel/
   1.0% arch/x86/platform/efi/
  13.3% arch/x86/
  24.0% arch/
   1.1% drivers/base/
   2.9% drivers/dma/
  12.3% drivers/gpu/drm/i915/
   1.0% drivers/gpu/drm/nouveau/
  16.2% drivers/gpu/drm/
   3.9% drivers/hid/
   1.6% drivers/iio/
   2.3% drivers/regulator/
   ...

Notice? When you say "show only the net subdirectory" it does the
obvious thing relative to the current working directory, but if you
say "show everything _but_ the net subdirectory" it suddenly starts
showing other things.

Now, it would be easy enough to say "if you don't give a positive
path, we'll just use the empty path that matches the negative paths".
So if you ask for a negative relative "net" directory, we'll use the
relative empty path. And if you ask for a negative absolute path,
we'll use the empty absolute path.

It's a couple of lines more, and I think it might avoid some confusion.

And I suspect almost nobody has ever done any of this before,. because
the syntax was/is so cumbersome.

                Linus

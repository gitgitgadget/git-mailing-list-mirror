Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A05631F404
	for <e@80x24.org>; Fri, 24 Aug 2018 04:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeHXIZx (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 04:25:53 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:39736 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeHXIZx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 04:25:53 -0400
Received: by mail-pg1-f176.google.com with SMTP id m3-v6so2816352pgp.6
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 21:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I5eGl10PHGsXe0uzTW+ht2gcT2krflKbUjwnn6k+eRE=;
        b=IghnHYIc15P5c0cM07LXEZ3L9pogIj8D0exJKb/p1YlW/A+dnsne3DAiUcYiRNLkKJ
         P0+b/bQpWMvxkbuLqfUiHLYq8tjjhlfiZULmvxTM16YSh9aSZumG0gvAzuNlOUyhcO2d
         Qx7iTKmenM9+g8tnHA9CVkmXzFPD/Og7PKAlRlz4Ih3MSqam0DGa7MCEzhhpVv9y9kT0
         zEykMBaJFk3etZ/IyAVQo3MuIlmUlrP675KoYr88/eAvbmNJ1bm1x0p3SNIYCnQCEmYX
         Cv8PhwnH+A2viLwFGE3B1Z1qxPDsL4rK856Mrc21o8GVksDtg06d2bLSi1klXaJq2Qtj
         aMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I5eGl10PHGsXe0uzTW+ht2gcT2krflKbUjwnn6k+eRE=;
        b=cfFhQy9auST+g0OZjNwnD7iOwPX4TOcSviKr+awjla4BJI11YTpjKi77BJyVIRmIQl
         U3/tG7tud1hpAGAcZyCPMMnD4IeNU3k9NQIILoD35Mvqc7tLvNfpzald24nxhC5ihARu
         Gp02vEbmcUeo4m9bIZiO3PAFyBeH5Tr4I5OQdepRz2VvGZeTF2wgKV9aHJEjmInMN+Vj
         kwi/6aSuh+vgz/8bQN+ukT/dEkIuM737xvlIacIYt2aNzdKWZRKf0mBacbfdMH4t3rvm
         7h7wwzsBIiKuxdDj4x4Dd2ZLPNGzBC57p8/RPiC5Q0Kip7s8d/t/LncKiC3/ldojACeI
         95aQ==
X-Gm-Message-State: APzg51Bd7phxDtVOYGOYI+Ataxc08ZeGaO8gd3/8d/hbxcOgMko3cgwj
        6/O2VVOSXNF/OIwGtpaT2u0=
X-Google-Smtp-Source: ANB0VdbbZlEpRt+aKONsrr2rP/Z5TmIExKA5/givmBKYy1uTE3SYNyQ2bkhgIGFu1JCEVd+0kitIxA==
X-Received: by 2002:a63:65c2:: with SMTP id z185-v6mr73436pgb.276.1535086377306;
        Thu, 23 Aug 2018 21:52:57 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id y86-v6sm9834216pfk.84.2018.08.23.21.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 21:52:56 -0700 (PDT)
Date:   Thu, 23 Aug 2018 21:52:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Questions about the hash function transition
Message-ID: <20180824045254.GA214696@aiede.svl.corp.google.com>
References: <878t4xfaes.fsf@evledraar.gmail.com>
 <20180824014007.GF535143@genre.crustytoothpaste.net>
 <20180824015438.GF99542@aiede.svl.corp.google.com>
 <20180824044720.GG535143@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824044720.GG535143@genre.crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On Thu, Aug 23, 2018 at 06:54:38PM -0700, Jonathan Nieder wrote:

>> For what it's worth, even if it all is in one commit with message
>> "wip", I think I'd benefit from being able to see this code.  I can
>> promise not to critique it, and to only treat it as a rough
>> premonition of the future.
>
> It's in my object-id-partn branch at https://github.com/bk2204/git.
>
> It doesn't do protocol v2 yet, but it does do protocol v1.  It is, of
> course, subject to change (especially naming) depending on what the list
> thinks is most appropriate.

 $ git diff --shortstat origin/master...bmc/object-id-partn
  185 files changed, 2263 insertions(+), 1535 deletions(-)

Beautiful.  Thanks much for this.

Sincerely,
Jonathan

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC92A1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 22:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfJ1WYL (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 18:24:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43897 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ1WYK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 18:24:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id l24so7935433pgh.10
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 15:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aQ6AFWDETUXHvHBTh/DhtMZ3deQBXNCdYsan0u0UfVc=;
        b=V7s8eUEUdnhuhexPdLswAlWNjpRMwKSRrEfrf0JCSrUugyGTXPegYliWOI2HXSLzRm
         CDrhFHahep4TUx+dPjq4TLwQ0x2W6PyWhT/UlAA3/LY8e0rh/wXEKk+uFNIm7TLy3NvZ
         TrYStRrgPD1y14uVcjYveGnyycFHaSyXxlv0rVh2+w1sa6KIWbNmUkGTUyz4yunUrCzA
         HNhnbWto8cxm1yFQ21hHnJmIVTYPswtS55tJ1HQQ82aD8GWnTpq4VEXXEVFieki6V38M
         XTvNjbk+z7cu0N9I4PW23AKv/n/Fy6F/Xp5UNWqB0z9b61GnnoLA+MuL6r7BYUH6vFiH
         5VVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aQ6AFWDETUXHvHBTh/DhtMZ3deQBXNCdYsan0u0UfVc=;
        b=EGiKS48PFXmcP0qL9JQf9OvL1if3p1ehkhSzChcVqi4oOBu5F4NFSdZAS40AtYo4Ac
         zOunDAqcM5UJCVx6idiqmOdZGgZrp40yDOrLyy+CbKX1lr+ie3NFs/1Or7is2ZY8Kg7y
         08r1AOYEC+snVRX5Of5Y8fu2cnj6LYAC2HTebVGAGqOkojE/SvSIR4N+xy1GILjacakV
         mNLt8AkVbSmd75AdoY+jiHNx8Iw5vDhcUa+A9NFT8c3glMV/iUkjsgAQB+GNpECldI4Z
         kyaf53Mry6btQ6tVp1/TTN7oJlxXwPnn9CL4tiHoqHYfJJMbsLQXnBBxpnB5deIyAkIC
         pqQA==
X-Gm-Message-State: APjAAAWrv0oIHTwpntE0T+PdNoRR8/OMpQZCO6qo7cY+zAmV6HsNdW+T
        LXTup/09M0z550KX3t8Lxq8=
X-Google-Smtp-Source: APXvYqyHxnOj85MbTiHnRM4qkcRDr4RKb+4s5nP2HchjHpH6JkRX1WaFegblVPKhG+RgNPRDAWpVfg==
X-Received: by 2002:a65:46c8:: with SMTP id n8mr23497781pgr.354.1572301447738;
        Mon, 28 Oct 2019 15:24:07 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id i123sm13875177pfe.145.2019.10.28.15.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 15:24:07 -0700 (PDT)
Date:   Mon, 28 Oct 2019 15:24:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Mihail Atanassov <m.atanassov92@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation/git-bisect.txt: add --no-ff to merge
 command
Message-ID: <20191028222405.GE12487@google.com>
References: <20191025222032.3399-1-m.atanassov92@gmail.com>
 <20191026022655.GF39574@google.com>
 <CALs020+0E=7wy-N46BRLrBcKmMSTpcMyZ9WybmgTzb60aCo5PQ@mail.gmail.com>
 <CALs020KFKOp4mFnY_2Mg5_H8Jc6PPV56O=1S66mriZA+XWd1Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALs020KFKOp4mFnY_2Mg5_H8Jc6PPV56O=1S66mriZA+XWd1Hg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Mihail Atanassov wrote:

> Thanks for the quick turnaround! And apologies in advance for the delayed
> and potentially mangled response, I can't get into my gmail account from
> a sensible MUA...

Interesting.  https://support.google.com/mail/thread/11736136 tells me
there's an issue with Kmail's oauth support.  You might want to get in
touch with the Kmail authors, or, as a fallback, use an application
specific password or other mail client.

[...]
> On Sat, 26 Oct 2019 at 03:26, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Hmm.  I think the comment might put a bit too much emphasis on the
>> "how" instead of the "why".
[...]
>> So I'd be tempted to leave the comment ending with "and then attempt a
>> build".
>
> Fair point, I actually did spend a bit of time on the fence between your
> suggestion and what I ultimately submitted. I ended up expanding on it
> precisely because the '--no-ff' seems a bit arbitrary to the casual observer
> and requires cross-referencing other documentation (which is how I figured
> out I ought to produce this patch :)).
>
> I can't think of any wording that would be any better, so I'll push a v2 with
> no comment changes, and leave it to the reader's curiosity (or lack thereof).

Thanks, that sounds good to me.

As an orthogonal point, I wonder whether we can start the multi-step
migration of making --no-commit imply --no-ff by default:

 1. Act as --ff when --no-commit is passed without --ff or --no-ff
    (the state today)

 2. Warn when performing a fast-forward merge and --no-commit was
    passed without --ff or --no-ff

 3. Error out instead of performing a fast-forward merge when
    --no-commit is passed without --ff or --no-ff

 4. Warn and refuse to perform a fast-forward merge when --no-commit
    is passed without --ff or --no-ff

 5. Refuse to perform a fast-forward merge with --no-commit is passed
    without --ff or --no-ff, just as though --no-ff were passed.

(A config setting could allow people to get the futuristic behavior
early.  And it might be possible to skip some steps. :))

[...]
>>> -if   git merge --no-commit hot-fix &&
>>> +if   git merge --no-commit --no-ff hot-fix &&
>>
>> Good.

This part still looks like a good change to me. :)

Sincerely,
Jonathan

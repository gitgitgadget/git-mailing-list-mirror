Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5633C1F859
	for <e@80x24.org>; Mon, 15 Aug 2016 06:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbcHOGjT (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 02:39:19 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:36159 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbcHOGjS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 02:39:18 -0400
Received: by mail-yw0-f180.google.com with SMTP id u134so22292410ywg.3
        for <git@vger.kernel.org>; Sun, 14 Aug 2016 23:39:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Eo3M8A48ALt2PPpNA4whGoqjUTwMNfbGjuhzjJ313pI=;
        b=aXE77LvEgbTJimtFigUq3xzzF2BFYG12Xt/b6ERMNJkRh8CrYEHaRypQ6zHyVM5g60
         Nzn89jYo1MmNSRfnRQevj+fMmkML6z6ZKwSIaV3pCwbOBW6RNPCQstUBas26irswUFpV
         y/1/5iu1mKk6uFtUwkVpBt8IH6FjVgt8QZcvGGOP6NNCre8TftDCVfflJEXYrcXULWEe
         DPszQDJrtv4rXxgo28PXYC1crb1TLTL6DQziSrCg9iZIJoocE/rCUP9RX+dJJ1KXerQL
         7P0JPsEXaKzGXoIb28jQDXCTUAtfLyM+d1CPxd8/5HhjFPQ2E7XkVXfAsVnO9WDeJgXY
         ZfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Eo3M8A48ALt2PPpNA4whGoqjUTwMNfbGjuhzjJ313pI=;
        b=JUrZElJaxP50e+K3pLeonDTqKOfhkoPezv7uURp/T+BfAeDZvnw483XD6I/vpifG34
         1bqWBFenK04cxeibWfid+3fmqFHkoP0ONRGl3vvNF7ZfFSrfvKHFjK4iFPJSfFxuzdrP
         7cuHOR+ne9GXLxAFqfmFoxZr3snNt3XSRsj1RED7sM7/S/pEJdt5JyvUfwTXuj1xalWl
         XI3WKI+bHjOz3zIgFy9MAbYbmSt0/zz748JIlQvXTWtgqJ/VQ9+YPin095scOGvS+w7P
         uSecgeC3/yjK+i4sCi77jEivRkQ53JjmvbmcVxPjRgsjMyuIlsbqdNLR19ArB5sqk/UI
         b7Kw==
X-Gm-Message-State: AEkoouvVxRnYIZApV+eEoMsFTK9qxoSOR/KkgH8OVTcze6PpPTp9PnfAKa1O1h5l4j6ee04gWT/azCpBPzN0lw==
X-Received: by 10.129.46.136 with SMTP id u130mr20972363ywu.234.1471243157855;
 Sun, 14 Aug 2016 23:39:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Sun, 14 Aug 2016 23:38:57 -0700 (PDT)
In-Reply-To: <CAGZ79kb27JZepMD5AmrHjOnf8haE8LehZd_CkvOQ1UoLEDuxKQ@mail.gmail.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com>
 <CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com>
 <CA+P7+xo4UJ8W4G0gV=DMLs-9Ve4v0OKc0ZunmS5Y5B1k7L0P9w@mail.gmail.com> <CAGZ79kb27JZepMD5AmrHjOnf8haE8LehZd_CkvOQ1UoLEDuxKQ@mail.gmail.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Sun, 14 Aug 2016 23:38:57 -0700
Message-ID: <CA+P7+xpgzRGiNtWrzjebP4EJr1kCed4w5JX412FhSHoZZrkNRA@mail.gmail.com>
Subject: Re: storing cover letter of a patch series?
To:	Stefan Beller <sbeller@google.com>
Cc:	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Aug 14, 2016 at 11:28 PM, Stefan Beller <sbeller@google.com> wrote:
> I would imagine this is similar to the pull requests on the linux
> mailing list, i.e.
> how it is with merges. Back in the time we did not open the editor for you to
> talk about the merge you just did, and then we started doing that.
>
> So what to do when the description already exists?
>
> We could amend the description separated by a
>
>      # comment, below was added:
>
> line or such and then open the editor asked for user input.
>
> Thanks,
> Stefan
>

This is why my gut feeling is that we should instead have a separate
way to store a cover letter, as it doesn't necessarily have to apply
to a branch or a merge commit, but could just be annotation against a
series of commits (maybe stored as base + tip, since most series would
be linear in nature?)

However, opening an editor and amending seems quite reasonable to me
if we're just editing branch description, and then storing that as
part of merge commit would be reasonable?

I really think we want some alternative way to store it for other use
cases besides the description, though.

Regards,
Jake

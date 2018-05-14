Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2438C1F406
	for <e@80x24.org>; Mon, 14 May 2018 17:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753065AbeENROl (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 13:14:41 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:38144 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbeENROg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 13:14:36 -0400
Received: by mail-ot0-f172.google.com with SMTP id n3-v6so15163122ota.5
        for <git@vger.kernel.org>; Mon, 14 May 2018 10:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=NPdO2K0tDWOXnODs1v28SLdHMoQneyM7MxgHk9/+WkE=;
        b=GX8La1vaZPC9AU7dcuufnD5Sok47rxgGD1ovXFX7dPVYyEDSo+Jho5J/qNcgSaWRnB
         cOFn3HQz31mHAEvSJkPskEIWxrFMZdLMSLjSymLxuzSkigsLb1TZBju+qZzS4ExkKhLH
         fIVBLRbHtv9OI0R21VhpMzol4RgM3DVXjRmiA1b+/9EIjM331/rnmz+S80znjcCjZzfR
         7L2APPBCYW2OoSAUeBBt6ioIh2JDRY05M8271tjjvl4/agF30WhzMeaoFsDjBATKdE2O
         0YM6nDbcNzeSsf7lRErEH6K8s++tfEx9EdKQS6hRVSTX5D2H6MaXqcVo2q3H89QYb1sL
         yXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=NPdO2K0tDWOXnODs1v28SLdHMoQneyM7MxgHk9/+WkE=;
        b=cvBOnVIsOB9n/FMQLtpT0XjzavcGcc6xe81hO8AJQJ/bouiYJJnFCSjmlvoCsbfmgb
         9p/3ON++97kLraP9KzwPWatkpY14S/bRPlUgieor2wewSXxteUrWt9wPuBk9u4T71LEE
         uBPH3b7PA7DIIZHAnsx6JgtkZ08s0am6qTn1s7sQMBr/9kPWeCL5NBDG9AM6d7Qbba+1
         /Q7xj/OfPclO3HuRtUmha8bdAp8VYS6lEek0gvdfWOgLWn+FWLV8Y8o1Yi9g+E0p6Uu0
         uH5guh2ypmdsfvNKEq21TMWXV228HGSEhF2LXVHYKQbfvKBNlpfRasFjz/k5PxloCbyC
         pdyQ==
X-Gm-Message-State: ALKqPwdrtqWKi1DLlCTdogklL8FZSKbf/rdjPhgs02+Y/xqmxhPENchN
        mB/HeF6BwDgCMXzqtR4m4HpWv3NEds2vH54ZUX4=
X-Google-Smtp-Source: AB8JxZqCpaMyOfGSFo/PdCZniPiLXZgQhax9yYoHVzE5AkiQP5lp9Otf0lraQelHivAi7y2+h39kymNw4ASNCCkzoes=
X-Received: by 2002:a9d:c61:: with SMTP id 88-v6mr8081859otr.173.1526318075444;
 Mon, 14 May 2018 10:14:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Mon, 14 May 2018 10:14:04 -0700 (PDT)
In-Reply-To: <20180509032050.GA23510@pug.qqx.org>
References: <20180417181300.23683-1-pclouds@gmail.com> <CAPig+cRkUrdtbyGEsY=DQCDoEWTrC-9n4=vKXHEap2gokB2uQg@mail.gmail.com>
 <CACsJy8BGs7EOYFKayL-bgvEbKOJiROF52o3SneLyG9Nm6nUngA@mail.gmail.com> <20180509032050.GA23510@pug.qqx.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 14 May 2018 19:14:04 +0200
Message-ID: <CACsJy8BPPbaoecp_xecG2_Sa0eFKwxs60JJooQZoo9Wpo59wHw@mail.gmail.com>
Subject: Re: [PATCH/RFC] completion: complete all possible -no-<options>
To:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 9, 2018 at 5:20 AM, Aaron Schrab <aaron@schrab.com> wrote:
> At 17:24 +0200 08 May 2018, Duy Nguyen <pclouds@gmail.com> wrote:
>>
>> It took me so long to reply partly because I remember seeing some guy
>> doing clever trick with tab completion that also shows a short help
>> text in addition to the complete words. I could not find that again
>> and from my reading (also internet searching) it's probably not
>> possible to do this without trickery.
>
>
> Was that perhaps using zsh rather than bash? Below is some of the display
> from its git completion (this is likely affected somewhat by my
> configuration).  The group descriptions (lines that begin with "Completing")
> appear in a different color, and are not available for selection.

Ah. That's probably it.

>
> 1113$ git c<tab>
> Completing alias
> ci               -- alias for 'commit -v'
> cia              -- alias for 'commit -v -a'
> co               -- alias for 'checkout'
> conf             -- alias for 'config'
> Completing main porcelain command
> checkout         -- checkout branch or paths to working tree
> cherry-pick      -- apply changes introduced by some existing commits
> citool           -- graphical alternative to git commit
> clean            -- remove untracked files from working tree
> clone            -- clone repository into new directory
> commit           -- record changes to repository
> Completing ancillary manipulator command
> config           -- get and set repository or global options
> Completing ancillary interrogator command
> cherry           -- find commits not merged upstream
> count-objects    -- count unpacked objects and display their disk
> consumption
> Completing plumbing manipulator command
> checkout-index   -- copy files from index to working directory
> commit-tree      -- create new commit object
> Completing plumbing interrogator command
> cat-file         -- provide content or type information for repository
> objects

It's interesting that zsh could do this. I looked at the script and
these texts are hard coded in there. I don't use zsh myself and won't
be doing this, but this information should be now available from git
binary so you can lower maintenance cost for the zsh completion
script.

>
> 1114$ git commit -<tab>
> Completing option
> --all                  -a       -- stage all modified and deleted paths
> --allow-empty                   -- allow recording an empty commit
> --allow-empty-message           -- allow recording a commit with an empty
> message
> --amend                         -- amend the tip of the current branch
> --author                        -- override the author name used in the
> commit

Hm.. no idea where this is from. Maybe zsh can extract "git <command>
-h"? Anyway it does not matter.
-- 
Duy

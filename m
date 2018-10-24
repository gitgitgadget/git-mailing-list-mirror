Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4A501F453
	for <e@80x24.org>; Wed, 24 Oct 2018 15:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbeJYAQ5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 20:16:57 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39631 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeJYAQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 20:16:57 -0400
Received: by mail-ua1-f67.google.com with SMTP id j38so2041772uae.6
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 08:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xzU2r3Xa03MyuG4zxWi12yZHAgP3QIPIWUTioQ5BLF0=;
        b=diTKW0U7rTAWQMNN4VYUk/9hdX/5PE9O6OYdXN4D2/WQ8ubdRpMrCCF4Zct4hF5hsL
         6n39W6TzlybxEcg5NKQfKHFf0SQrsHp2MQq6RnzI6vjDPlNw2mirlgiTAyhb9uFAL+y+
         FWp8UyKAUICeEtsSiu/Dvah/8fSa/i1idmCiprDlnlNXC34gAL71pfYDUmk+PNvlagb5
         /ANxaByUwBf68BNmm1RFUkAc4esvjWFLIlGLXoJNR58wUPVCHT080qTB8JBManejz3LO
         8kyJjfOx+WW7pL/1E73apGddIFrC13Wi/0WaCdAecAnjreuRFd+0z6e2837F/l5uj9Oz
         mHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xzU2r3Xa03MyuG4zxWi12yZHAgP3QIPIWUTioQ5BLF0=;
        b=oNup4N+oOeLiTZBmB1RiRTp3RzFcdUgaAJD38vJ6BmlJz+UHj4h3uOEnnuhC+1JYdo
         3OkEJQ1SCY/9NXe5AuYdtplq0/JHm4bkTeScx9BtJJony6t82OltUZCniD16nD5c5M2s
         4lGfBIYNrX7kzC73ePRfPs8mUlAvL0F5Ortn/9tlzgUwW2YJzmRl3X7oddU/4bV4BCYQ
         z0PtThvClwC/FxvTrHXqiazJpeAvPQ8uGKgqblzFseCUOnfgPSXw76XUK02fQeVmljFw
         TAWGh74J4H2yOGNAsDlJSYG5AwirgsOL4ALX/1OUhj/GQaBun6Bcy4t1EQ/TrEeSL8pC
         gjqw==
X-Gm-Message-State: AGRZ1gLDRHS2HAQJ1So1KUxFCZjtXUHdr2HbftMHhnk7Gac+tE3bBGdD
        /Zi4p3V3rdX6QDP6qwzI5+w=
X-Google-Smtp-Source: AJdET5duh8Fo1ZvaQC7vUXUH3cALQkux6gShxGtK9awz6ZSsu0vtjPQmma9mQR0PvCdg+QiBkKRxXQ==
X-Received: by 2002:ab0:5e8f:: with SMTP id y15mr1362256uag.21.1540396100292;
        Wed, 24 Oct 2018 08:48:20 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3c92:d38f:3214:6b65? ([2001:4898:8010:0:25c8:d38f:3214:6b65])
        by smtp.gmail.com with ESMTPSA id n134-v6sm1219605vke.47.2018.10.24.08.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 08:48:19 -0700 (PDT)
Subject: Recommended configurations (was Re: [PATCH v1 2/2] reset: add new
 reset.quietDefault config setting)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ben Peart <peartben@gmail.com>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181017164021.15204-3-peartben@gmail.com>
 <CAPig+cQ3ia78pLtnHSq8tM3B-XnFgWhwowJxwacYEEzXosJ16g@mail.gmail.com>
 <20181017182337.GD28326@sigill.intra.peff.net>
 <874lddc9fs.fsf@evledraar.gmail.com>
 <1ba81f12-7040-1ba5-2009-fa681caf9874@gmail.com>
 <87zhv4bfck.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <29db5fed-4556-277e-7aad-7ff3233550a9@gmail.com>
Date:   Wed, 24 Oct 2018 11:48:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:63.0) Gecko/20100101
 Thunderbird/63.0
MIME-Version: 1.0
In-Reply-To: <87zhv4bfck.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/23/2018 4:03 PM, Ævar Arnfjörð Bjarmason wrote:
> [snip]
> The --ahead-behind config setting stalled on-list before:
> https://public-inbox.org/git/36e3a9c3-f7e2-4100-1bfc-647b809a09d0@jeffhostetler.com/
>
> Now we have this similarly themed thing.
>
> I think we need to be mindful of how changes like this can add up to
> very confusing UI. I.e. in this case I can see a "how take make git fast
> on large repos" post on stackoverflow in our future where the answer is
> setting a bunch of seemingly irrelevant config options like reset.quiet
> and status.aheadbehind=false etc.
>
> So maybe we should take a step back and consider if the real thing we
> want is just some way for the user to tell git "don't work so hard at
> coming up with these values".
>
> That can also be smart, e.g. some "auto" setting that tweaks it based on
> estimated repo size so even with the same config your tiny dotfiles.git
> will get "ahead/behind" reporting, but not when you cd into windows.git.

Generally, there are a lot of config settings that are likely in the "if 
you have a big repo, then you should use this" category. However, there 
is rarely a one-size-fits-all solution to these problems, just like 
there are different ways a repo can be "big" (working directory? number 
of commits? submodules?).

I would typically expect that users with _really_ big repos have the 
resources to have an expert tweak the settings that are best for that 
data shape and share those settings with all the users. In VFS for Git, 
we turn certain config settings on by default when mounting the repo 
[1], but others are either signaled through warning messages (like the 
status.aheadBehind config setting [2]).

We never upstreamed the status.aheadBehind config setting [2], but we 
_did_ upstream the command-line option as fd9b544 "status: add 
--[no-]ahead-behind to status and commit for V2 format". We didn't want 
to change the expected output permanently, so we didn't add the config 
setting to our list of "required" settings, but instead created a list 
of optional settings [3]; these settings don't override the existing 
settings so users can opt-out. (Now that we have the commit-graph 
enabled and kept up-to-date, it may be time to revisit the importance of 
this setting.)

All of this is to say: it is probably a good idea to have some 
"recommended configuration" for big repos, but there will always be 
power users who want to tweak each and every one of these settings. I'm 
open to design ideas of how to store a list of recommended 
configurations and how to set a group of config settings with one 
command (say, a "git recommended-config [small|large|submodules]" 
builtin that fills the local config with the important settings).

Thanks,
-Stolee

[1] 
https://github.com/Microsoft/VFSForGit/blob/7daa9f1133764a4e4bd87014833fc2091e6702c1/GVFS/GVFS/CommandLine/GVFSVerb.cs#L79-L104
     Code in VFS for Git that enables "required" config settings.

[2] 
https://github.com/Microsoft/git/commit/0cbe9e6b23e4d9008d4a1676e1dd6a87bdcd6ed5
     status: add status.aheadbehind setting

[3] 
https://github.com/Microsoft/VFSForGit/blob/7daa9f1133764a4e4bd87014833fc2091e6702c1/GVFS/GVFS/CommandLine/GVFSVerb.cs#L120-L123
     Code in VFS for Git that enables "optional" config settings.

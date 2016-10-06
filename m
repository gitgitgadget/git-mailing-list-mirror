Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCFB7207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 16:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942191AbcJFQKx (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 12:10:53 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36402 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753440AbcJFQKu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 12:10:50 -0400
Received: by mail-oi0-f48.google.com with SMTP id m72so26775657oik.3
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 09:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K9geQ5POQFhsg5+rqxnHPOFk4Y03S9FfRRJB5rPSbV0=;
        b=Djm8+WbBv02Qmfi9fjJ1svpMC0j+nhwz63ks1L50UBM9KTbCZ+vHYjSLzmnCCSMPp9
         qXgZCUjDltRCO+Kz+U7tJu1wshRHiN97+CqJQYWZh+QDQzI84QDW9gFuafWVL6NISuiU
         54c2+t3hIUaadF+GdoOYndUDdpzQClBi8gIyAo2093kCcANDNwPiyD9Fqqo26n8wz9Tl
         DW0T4RoG45/VCaeDu/cgLePnjDDyR3QAXdGu42LcKaJQGS39MX8wL/1xOXjffZuczEBB
         BmArvyMtm7Rx1Wafl6mShzJG3zjfh6s4NlozlLtmTAf1IQRuOo7//A+DaBuXA81dj2dE
         0N/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K9geQ5POQFhsg5+rqxnHPOFk4Y03S9FfRRJB5rPSbV0=;
        b=EPjTWhClfLS4+C1tzN1JPddNv/pFC1/MlDjzetXyg0/krtdJ7EZUa3eQhOMSdWcK2i
         IAt55Yi+y7kHVdfeKwvv7GdLfco4RCfdM13onjgEFILgjtj7b/NtfkpY75gG+gZlHeWn
         5+BnOS2IjsjeKRp0X3X8mVkc6sZXOt08O0I0cp6nNsV23FR769b6HfuIXsW01YND6SwU
         htUCWPV78ZcCk25HMz5OVcVZusNG8OLh3PRxr4n23H7cphkVYeqz06Krcclx44FaLb0y
         UkMqKWIfC0x0myQzRNc9adG/s1XfnfgS41ViQTmM58BsRtzhs9MNtRPftErqDgPvfgc2
         euhg==
X-Gm-Message-State: AA6/9Rn66c6Ade2dpaH3BeJ91iCVL4F7M1STXeWr6kWP9/+s/ZAbTifc8SJ7zuW9Vf/vebQJOxuRkD/FHy5tqQ==
X-Received: by 10.202.97.2 with SMTP id v2mr12573435oib.157.1475770220008;
 Thu, 06 Oct 2016 09:10:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.189.4 with HTTP; Thu, 6 Oct 2016 09:10:19 -0700 (PDT)
In-Reply-To: <20161006092040.GA38550@book.hvoigt.net>
References: <CAPOqYV+C-P9M2zcUBBkD2LALPm4K3sxSut+BjAkZ9T1AKLEr+A@mail.gmail.com>
 <20160914202907.GD7613@sandbox> <CAPOqYV+xsrLk7y1hJYHZFY8OfkxVRwPcZBdqhdgrhThqdZysQA@mail.gmail.com>
 <20161005133650.GB30930@book.hvoigt.net> <CAPOqYV+SR8=E24HR18ygJ-J-rV7=FedU+gGpq9mp+a7Mfk2LiQ@mail.gmail.com>
 <20161006092040.GA38550@book.hvoigt.net>
From:   =?UTF-8?Q?Thomas_B=C3=A9tous?= <th.betous@gmail.com>
Date:   Thu, 6 Oct 2016 18:10:19 +0200
Message-ID: <CAPOqYV+DWVeK3sfgtDXzTF=es3d23dZq+rMeMcTuJ7kF0UjNkA@mail.gmail.com>
Subject: Re: Bug Report: "git submodule deinit" fails right after a clone
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Sorry again for the mailing list...

On Thu, Oct 6, 2016 at 11:20 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> So I guess the same applies to 'git status'?

No, it is the strange thing.
As told in my very first message here what happens after git diff and
git status:

$ git clone https://github.com/githubtraining/example-dependency.git
Cloning into 'example-dependency'...
remote: Counting objects: 35, done.
remote: Total 35 (delta 0), reused 0 (delta 0), pack-reused 35
Unpacking objects: 100% (35/35), done.
Checking connectivity... done.
$ cd example-dependency
$ git submodule deinit js
fatal: Please stage your changes to .gitmodules or stash them to proceed
Submodule work tree 'js' contains local modifications; use '-f' to discard them
$ git diff
[no output]
$ git submodule deinit js
fatal: Please stage your changes to .gitmodules or stash them to proceed
Submodule work tree 'js' contains local modifications; use '-f' to discard them
$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
nothing to commit, working directory clean
$ git submodule deinit js
Cleared directory 'js'

So as you can see, the 'git status' makes the problem magically disappear.

Thomas

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0054120248
	for <e@80x24.org>; Thu, 18 Apr 2019 09:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbfDRJlY (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 05:41:24 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38309 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRJlY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 05:41:24 -0400
Received: by mail-it1-f196.google.com with SMTP id f22so2377049ita.3
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 02:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MkhZXfsGNDbYLJK5+QnFR/lClFvZJQXrTP2GRfCbtx8=;
        b=FQaNTBdkWqDfVUsUfyy5XZGKLcLJnMzh8Clm+8XbMbDz/MTj7tKwZqSvPNpYTAhINU
         KvGiyBWfPa6a2xmKarX9cVqcC0iXd36AN35q8Uf0xdjCxHEjgxKlszlaqBs+8lxPtP7i
         ujL8J6DPCFwowGVhnO0Q4E28EKZQuRIJr0QmjSM/m42u6csq8RrIwm3kqCS5X8PLHUWs
         ATLOhn8QooVNenGcJLCpmP/lI2U1DpsiDfBfuoBWVhiNP2NHLZmz6p3ZKAakWfNUMQrZ
         1NlTm7kXw1wiHiriDLDW6PnzGziggxTFNF7a//06G0LvsUDtuGTGpxV+3CBF3c+FTDxc
         Rd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MkhZXfsGNDbYLJK5+QnFR/lClFvZJQXrTP2GRfCbtx8=;
        b=atb1ubBr75SlXza4/MDxVuhTHodeVcGIKNrnEeFUIK+eW8Kchtv2Ir8QhwGYvbU1Zp
         oQQRaehC30HhSV3dnIFt6LYjjK1HV+/lIlBbIID0vS9T9rXtHlvAiZzXkk3wvEb0qXoA
         NCNJEIi9AU8IYZL4hzEzvmIa0tQ9BLY7a9GIaSp9eSlMk5KFkjVp6V/1JfjygzO+xeLk
         BPuENkdl4VMPIyko3tUIg+qCnBh2MDEqxfK6ZM8zoU551OHf9+LIt+exU9TPDRWqAT3k
         JMchKvUyFzF9t3/7Xvdp0i3UInuYr89xDYjUFJetQucK/zMWXj6SzF8oPhV/DJUAXuZ+
         RMHg==
X-Gm-Message-State: APjAAAWE5+d5kqbUrN5nGWxLAU2JzUZhB4V512K/jW5BH8un56Jow6Xp
        8jEV0ldC5fcOmEnWzL2e+zagsIPkFjcvYWeZafA=
X-Google-Smtp-Source: APXvYqzgOj+V8zq6oTYFGrTVFBXXapD+LJo2WRx7G3z0a/z4kH0BDMJSR7y1B5qwRAzX5qhslXWCSvcbdBEK1S3C/YI=
X-Received: by 2002:a24:5493:: with SMTP id t141mr2249241ita.10.1555580483644;
 Thu, 18 Apr 2019 02:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190411131218.19195-1-pclouds@gmail.com>
 <CACsJy8A9xfR7FheOHUoywNz_D7W1X1fv=mUBz-uu82CGZqYfVA@mail.gmail.com> <xmqqa7gojggg.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7gojggg.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 18 Apr 2019 16:40:56 +0700
Message-ID: <CACsJy8CSQDpDteYUH86n-e+sXfqVGmvV3pgminunZgKOVQNivg@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Add new command 'restore'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 18, 2019 at 7:38 AM Junio C Hamano <gitster@pobox.com> wrote:
> It would be an excellent addition to "restore-path" (and also to
> "checkout [<tree-ish> [--]] pathspec") to give "--dry-run".  Not
> just because it is destructive, but because unlike "reset --hard",
> it is selectively destructive.  Having a way to make sure that the
> given pathspec touches only the paths that the user intends to
> recover from the tree-ish or the index would be valuable.

Yep. I thought about that complicated pathspec stuff but forgot to
mention. When you start using wildcards and magic, it's sometimes hard
to predict the outcome on the first try.

Also about git-checkout but that's kinda weird. git-checkout has two
faces, the switching business is "safety first" and --dry-run does not
make sense. The restoring paths can make use of --dry-run, but then
we'll need to describe that this option only applies to one of the two
cases, urghhh

> But it is a new feature, and I'd think it can (and probably should)
> be done as a follow-on series outside the main series you have been
> working on.  Let's make sure that we have the basics ready by the
> end of this cycle.

Yeah, it's not going to happen now. I will also drop "rm --staged" in
the next reroll to stop expanding the scope of this series. "rm
[--staged] [--worktree]" may come back, but now is not its time.
-- 
Duy

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAD7C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 06:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7A764E0A
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 06:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhBEGIK convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 5 Feb 2021 01:08:10 -0500
Received: from mail-ej1-f45.google.com ([209.85.218.45]:39503 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbhBEGII (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 01:08:08 -0500
Received: by mail-ej1-f45.google.com with SMTP id p20so9913743ejb.6
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 22:07:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=64IFn4hYepZjvZn8GIjGhgvArZYDo6t4j7qy0UifT8s=;
        b=TY1hQpVwAWqM+EHKb0UWkJBRwC7wIKe2lvgX6b/r9yBN1FU9RoAxrOKjmErunk1KMW
         y8lMVWj7nq9NxbSDr2ps0z31byeQdDAN1Cvx0H7pVgY1glOyc0XsLV+PD1BZ1y2RETw2
         zAuTkL0ORXg9vbaOU9AdEpIsI/i6pD5Nm/R/5QKbUg1JP2+2wCmKlsekJMyOqfyZQkIg
         6I65hT2Jq9DxY8BKavg1zW2ksoS4eG3mkZMTcBxXRy8Q7eACWGPhTYOH5YQ422aoBZb+
         X96jeZtpQfXzlW/pKjCtKu3uMFOFWW76T0kgDF185kKvbcLtf1OaOAAReUOZJGaYDAFc
         uGcg==
X-Gm-Message-State: AOAM531cVAxdFC/CIfE0LGrzLhRAxzW1ryGBgmF/KIy5OP89D1w4lqp9
        /bRJdhK3NpwlDEsfmGekxZOGvqHDYA66bXOpBDY=
X-Google-Smtp-Source: ABdhPJyJ/zvVZSk+LREcqOEsLY+QlDF3qx4BKTw9jJL0Nh5FO0B0j4UKOGhcQn22VBC3DMSjbvk5U5WAPsJkuBC25ys=
X-Received: by 2002:a17:906:3105:: with SMTP id 5mr2661837ejx.168.1612505246454;
 Thu, 04 Feb 2021 22:07:26 -0800 (PST)
MIME-Version: 1.0
References: <7CE44CBE-DF7B-42DD-AC0F-8125CB6A8403@icloud.com>
In-Reply-To: <7CE44CBE-DF7B-42DD-AC0F-8125CB6A8403@icloud.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 5 Feb 2021 01:07:15 -0500
Message-ID: <CAPig+cRyCW3CtANyp6YyAOA5hddSRMX-Ld1YdwN--FPjTrpNzQ@mail.gmail.com>
Subject: Re: git command was killed
To:     LiuShiyang <wingsdream1943@icloud.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 4, 2021 at 1:48 AM LiuShiyang <wingsdream1943@icloud.com> wrote:
> I’d like to get your support to solve below issue. When I upgraded my MacBook Pro (appple silicon ) , all git commands can not be run, and it shows ******killed. I have tried to reset Xcode-select, switch the path, or install again..no luck to resolve it.
>
>  shiyangliu@ShiyangdeMacBook-Pro  ~  brew config
> CPU: octa-core 64-bit arm_firestorm_icestorm
> macOS: 11.2-arm64
> Rosetta 2: false

This problem may be specific to Homebrew's installation of Git.
Apparently, Homebrew wasn't originally able to build for Apple
"Silicon" and the various supported "formulas" need to be upgraded
manually for "Silicon". This page [1] shows a (perhaps) outdated
status of each package.

Somewhere in [1] there is mention that you may be able to install a
package as x86_64 rather than as arm64 and then run it via Rosetta, so
you might want to try that (assuming Rosetta works for you). Or maybe
you already installed x86_64 and Rosetta is failing for you(?), in
which case try the arm64 version. Otherwise, probably best would be to
ask at the Homebrew project.

[1]: https://github.com/Homebrew/brew/issues/7857

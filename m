Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA518C04A94
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 23:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjHGX3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 19:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjHGX2x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 19:28:53 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60EF172B
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 16:28:52 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-563379fe16aso5048829a12.3
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 16:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691450932; x=1692055732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h7HshU+G9aKZTHSu4wxWEE11KJJjUkz7Kew1R8UrbJ4=;
        b=Hq37wosh/rU0SbvstCUKWmWbhALGGtR2pBYA/ML3cLU1AiHOfIlJ6RSm2dFhseBcn+
         pDRisViIYtChnOhYoWjSh5o11h2YrHAEL/xHr9SQblfL/VjjswE56BpBvRWsoas6XCWV
         nhsWZCbHGcHpecQ2VbN660F/Ejy3hAku+rVP1x2zSUZEKnKi0R9EHSJ5SigYABZjaR7D
         Bct5QhZxHyMpD2WkOXKPpBDFACOjINLL3DyojVmxWxWo0w7cUedwuRpXltvllu7XVu9Y
         VKi+ckDzeLEDeYjLzK9q/OONxbNS20g23gUhKyVKQaZpiK7gQz1a8F81DAgjtSZ6yqRf
         xJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691450932; x=1692055732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7HshU+G9aKZTHSu4wxWEE11KJJjUkz7Kew1R8UrbJ4=;
        b=QaHnXFHmH7ZZfIW9lrK6BXGHwG9X1VANVd/uPcXvuoBKjqro3mMZ6jNXJ1zMg7JESz
         xQ83c2KpFTp6IX94J0SUDWIt84Fdr1Ye4kwHhkzg/m4Ir1G/KSAuDMdcmng14FMwzNVn
         18RUr90zKIp9hiWA8Le1VvXVStsXt46W2SiklLA5S2p0RoNaZQsqu3VRwvyw2Fz1BCea
         oc9qpuOV+zpkeEfOV2j02dNthziHayQmWYldIbSI6ijtRdqOYkseEaCIFykgQ8e0Mi77
         dv84zSjvNiF6iI+kgoZkVC7qTt+F+txx8se/BiSbCVKCbeEq+Xq76WDg4bG7m2KhECIA
         iC9w==
X-Gm-Message-State: AOJu0YzioxZvEdGyL8khUJRxBEGoAOJe+92Mb2xSQZMZj4F1tleZfZsG
        u/bA4M5J8XnsBTs+WpwEI0zq25f0TXFEcg==
X-Google-Smtp-Source: AGHT+IHqVLqU3GchrgSGqS1SWzHD9nl7TXngQSic9LBIAFA2EQN3NdsrY+TaZgThxFeRgeVR8YJ04oWGkDKIPw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:3755:0:b0:53f:6f7c:554e with SMTP id
 g21-20020a633755000000b0053f6f7c554emr42829pgn.12.1691450932412; Mon, 07 Aug
 2023 16:28:52 -0700 (PDT)
Date:   Mon, 07 Aug 2023 16:28:50 -0700
In-Reply-To: <1fc060041db11b3df881cb2c7bd60630dc011a15.1691211879.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com> <1fc060041db11b3df881cb2c7bd60630dc011a15.1691211879.git.gitgitgadget@gmail.com>
Message-ID: <kl6ly1im8ma5.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 4/5] trailer: teach find_patch_start about --no-divider
From:   Glen Choo <chooglen@google.com>
To:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch will make unit testing a bit more pleasant in this area in
> the future when we adopt a unit testing framework, because we would not
> have to test multiple functions to check how finding the start of a
> patch part works (we would only need to test find_patch_start).

Unit tests typically only test external-facing interfaces, not
implementatino details, so without seeing the unit tests or library
boundary, it's hard to tell whether find_patch_start() is something we
want to unit test or not. I would have assumed it's not, given that it's
tiny and only has a single caller, so I'm hesitant to say that we should
definitely handle no_divider inside find_patch_start().

> @@ -812,14 +812,14 @@ static ssize_t last_line(const char *buf, size_t len)
>   * Return the position of the start of the patch or the length of str if there
>   * is no patch in the message.
>   */
> -static size_t find_patch_start(const char *str)
> +static size_t find_patch_start(const char *str, int no_divider)
>  {
>  	const char *s;
>  
>  	for (s = str; *s; s = next_line(s)) {
>  		const char *v;
>  
> -		if (skip_prefix(s, "---", &v) && isspace(*v))
> +		if (!no_divider && skip_prefix(s, "---", &v) && isspace(*v))
>  			return s - str;
>  	}

Assuming we wanted to make this unit-testable anyway, could we just move
the strlen() call into this function? Performance aside (I wouldn't be
surprised if a smart enough compiler could optimize away the noops), I
don't find this easier to understand. Now the reader needs to read the
code to see "if no_divider is given, noop until the end of the string,
at which point str will point to the end, and s - str will give us the
length of str", as opposed to "there are no dividers, so just return
strlen(str)".

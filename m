Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E12101F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 02:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfAPCRD (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 21:17:03 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:44991 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbfAPCRD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 21:17:03 -0500
Received: by mail-pf1-f182.google.com with SMTP id u6so2234614pfh.11
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 18:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W1wOZezrgMpx1lv1ZS0c5/BD3lNHjrp4c68YLWFL0+g=;
        b=oJxfMGCPsiJez3V0V4ZmP0LTk+dtqnBzIoDzpFI/wPKN7FAnRYASn0ORfBPIOmBDXp
         qW1N/fJGC5l7HzQlwpZ8dHY5e2ptKfrd10Bl0Pceu6Zoy7s7RrcGYs7Jd7YbWiKpWikM
         VmXyFUmGg17s4DUmBzmTmxfu2UOA0ZA0UW8rH72xx2gnPJ8DpAHZdQSdFIiJh2Vi5eJ9
         NPp0KIpU5BKlBasDJqiciKu7rfY7kbkX9XH6vdMlHvDYyBmuxeWZoRgaZ3DFvGF7/Hay
         X1kvaCRZfJxpwxeLU+1P8K+ljlFBCAma62rl6hIek90SyHuv1Y26FmbhCnGOw1s9AKIY
         cjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W1wOZezrgMpx1lv1ZS0c5/BD3lNHjrp4c68YLWFL0+g=;
        b=DV6x04GsUrpjx2xRquw7Pvu0cp1go3lgIUD3pN9vrN4dLpQsF1SZTg5g0n25g752Ez
         moOy3OnKH4wskSOj7t3ZJn1mGTKqEAgbNPXH85pNmiBHn/mxQYUnRPtCstrv1g23zC/S
         ZwoMryYoZC1oU+eWf1xS5uo1dKBQoxWj9iIAGu7ZkUF0RvKdVejI8XFSJKCfPlWc0krd
         T4iH+YaUUYGHwRJOL/HwBXs9qalBz/CFVAeOZ5oGwDqw96rVLslDHrWpKpL0aCCaMSMT
         bTpE+hgVfm/WApQbll7s37TJqMsxltfW+PpaZR8RaOKGQ6I8JDm3uUAaNichzT7L2MKb
         aCGQ==
X-Gm-Message-State: AJcUukeLTdb4IHiAc2+vUlFgvEHHsSp8XKRrOZ/GAgO8OCG3w5Lxki+b
        /UhZq39H20H/BEM2F+7qXmdg9d/0
X-Google-Smtp-Source: ALg8bN7qSOXGyELUEGsMgp3B6F1brihFMmQb4k0957rUCO0qNUwp0bmBsHMT+BHjP/aFWVNG7LyL0g==
X-Received: by 2002:a63:af52:: with SMTP id s18mr6578598pgo.385.1547605021260;
        Tue, 15 Jan 2019 18:17:01 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id v5sm8380696pgn.5.2019.01.15.18.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 18:17:00 -0800 (PST)
Date:   Tue, 15 Jan 2019 18:16:58 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Nate Weaver <wevah@derailer.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, primenico@gmail.com,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [Bug report] Git incorrectly selects language in macos
Message-ID: <20190116021658.GB8864@google.com>
References: <CAKd-JgStGb4Ka9Rs6G2e4ADQKZVrsJMsNGz1sRP_4Ej4=FtxtA@mail.gmail.com>
 <CAKd-JgS3omKbN+OzQL2dUun6Seg9CjDNk8KEj9m83xdTZE=7FA@mail.gmail.com>
 <CAPig+cQWW9kibWYKu5oRDgo_Pt4wVmzkqzbTG=YGvwqRCXcNXw@mail.gmail.com>
 <BF7AD597-5C05-4A7A-8DB6-0FEA2F95AF72@derailer.org>
 <89DD4C7B-7F8B-42C5-81F2-F14D5B2D4CFD@derailer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89DD4C7B-7F8B-42C5-81F2-F14D5B2D4CFD@derailer.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nate Weaver wrote:
>>> On Fri, Sep 14, 2018 at 10:20 PM Niko Dzhus <primenico@gmail.com> wrote:

>>>> Looks like the issue appeared after updating git from brew.
[...]
>>>> A quick search revealed that brew changed how it builds git recently.
>>>> I think, it just didn't include i18n by default before, so I never
>>>> noticed this.
[...]
> Upon further digging, this is an issue in gettext's code on macOS:
> The function _nl_language_preferences_default (in langprefs.c) specifically
> breaks early when it sees the literal string "en" in the list (from the
> "AppleLanguages" defaults key), but not when it gets "en-US", etc.
>
> I.e., it doesn't check for a prefix.
>
> This can be fixed (though there might be a better way) simply by replacing
> both instances of
>
> if (strcmp (buf, "en") == 0)
>
> with
>
> if (strncmp (buf, "en", 2) == 0)
>
> in gettext's langprefs.c.

Nice sleuthing.  Do you have a bug tracking this in homebrew's issue
tracker, either for the git formula or the gettext formula?

Thanks,
Jonathan

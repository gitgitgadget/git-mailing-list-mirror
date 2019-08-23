Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADDA61F461
	for <e@80x24.org>; Fri, 23 Aug 2019 23:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbfHWXnn (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 19:43:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34168 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHWXnn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 19:43:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id d3so6455981plr.1
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 16:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Shw+nubukEh6ggw/HB14tBqUrDN9HYCSKMt2yhh5yE8=;
        b=tHNUCsOQS+FOpWzp1iRyT+PaVdbrPBuE+V3xKigPoGQswC1v776SG7RDHFRk/gSdmt
         4ryr2YbgkA2uCw67CuN5tNg37vNrs11UZmcWBRbOb2a6Dnu+XV78kwnRrFW2zv9Fp61B
         iKUT0O0ipWC5oSns/Aw/b6RXdmMCluXHnUIOgDTprjLptrliKT1U5Ak85ohhyOJtnzRv
         cVXdRhQk23eHl0nS3bJ/2JXZ1PZdjeZASnKpJOLAdnYKhp00NBXps8FCBosZ7+xoXJH9
         LaAIaqCyh7Q54taefA5a9ypNopuPkTR0OlFLNLJNl3nVqQqmLcFQhtfKX/3OMeWv3VsD
         rJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Shw+nubukEh6ggw/HB14tBqUrDN9HYCSKMt2yhh5yE8=;
        b=RRw19cQehuY79u6gQsW5QSTC9DPRgiEibLOF4rYJ9GcoIqQVsVx8zu6jL5YZu1r3UK
         H7qYQePPTDBV4biKpvLVb4oPQyhLmrl4ha6ikr2f0yp6sgkBW3+U/lyHIJkqv45TOrfC
         SSWwAhSLaDTqT/rw3cTkYpB4Iz98ayPabTKt+kwbTvH7PORuQkR1FbXPd3lS4SRPGNhi
         /j5kyNYe+zWQrtlNEyD9njbAu3h06BR97BdnjZ8dBNIEIwcajXUoTEFkkv0OL6otESoK
         /fbbvLzs+hRT9U2IVTwp/aohGHMHv2Up0rOkyyw2gux05KT9AuDbUjcmwx0jnsWLgMcF
         HH3A==
X-Gm-Message-State: APjAAAWk/8Lg41e83yg5L1Kp3Fs/T1gx+p7BKEo6/YtOt5x8isYkVAxm
        PVSDh56fTRlbXoP3riQzESA=
X-Google-Smtp-Source: APXvYqwmL/FgVjtkoAB2rsKI4RShiL/Wpjd7z/ZFbk6OWKid15jnPmCqRxX9WOQyeOxA0hoyM5xxwQ==
X-Received: by 2002:a17:902:20cc:: with SMTP id v12mr7001075plg.188.1566603822301;
        Fri, 23 Aug 2019 16:43:42 -0700 (PDT)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id j6sm3820553pfa.141.2019.08.23.16.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 16:43:41 -0700 (PDT)
Date:   Fri, 23 Aug 2019 16:43:39 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v2 0/4] git-gui: Add ability to revert selected hunks and
 lines
Message-ID: <20190823234339.GA17088@gmail.com>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190822220107.4153-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190822220107.4153-1-me@yadavpratyush.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 23, 2019 at 03:31:03AM +0530, Pratyush Yadav wrote:
> Hi,
> 
> This series adds the ability to revert selected lines and hunks in
> git-gui. Partially based on the patch by Bert Wesarg [0].
> 
> The commits can be found in the topic branch 'py/revert-hunks-lines'
> at https://github.com/prati0100/git-gui/tree/py/revert-hunks-lines
> 
> Once reviewed, pull the commits from
> 415ce3f8582769d1d454b3796dc6c9c847cefa87 till
> 0a1f4ea92b97e673fda40918dae68deead43bb27, or just munge the patches and
> apply them locally, whichever you prefer.
> 
> Changes in v2:
> - Add an option to disable the revert confirmation prompt as suggested
>   by Johannes Sixt.
> - Base the patches on Pat's git-gui tree instead of git.git.


We've had these features for years in git-cola.

Please copy our keyboard shortcuts.
IMO we should not re-invent the user interactions.

http://git-cola.github.io/share/doc/git-cola/hotkeys.html

Ctrl-u is our revert-unstaged-edits hotkeys.  "s" is for
staging/unstaging (or Ctrl-s if the file list is focused).

The same hotkey is used for operating at the line level.
If no lines are selected, the hunk surrounding the current cursor
position is used.

Please make keyboard interaction a first-class design consideration.


I have a very strong opinion about the confirmation dialog, so I'll just
mention that here since Hannes is on this thread.

In cola we do have a confirmation dialog, and I strongly believe this is
the correct behavior because it's an operation that drops data that
cannot be recovered.

In the other thread, it was mentioned that this dialog would be a
nuisance.  Perhaps that is true -- for the dialog that may have been
implemented in this series (I haven't run it to verify).

Let's dive into that concern.

In git-cola we have a confirmation dialog and it is by no way a
detriment to the workflow, and I use that feature all the time.
Why?  The reason is that we focused on the keyboard interaction.

The workflow is as follows:

	Ctrl-u to initiate the revert action
	The prompt appears immediately.
		- Hitting any of "enter", "y", or "spacebar" will
		  confirm the confirmation, and proceed.
		- Hitting any of "escape" or "n" will cancel the action.

So essentially the workflow for the power user becomes "ctrl-u, enter"
and that is such a tiny overhead that it really is not a bother at all.

On the other hand, if I had to actually move my hand over to a mouse or
trackpad and actually "click" on something then I would be super
annoyed.  That would be simply horrible with RSI in mind.

OTOH having to hit "enter" or "spacebar" (which is the largest key on
your keyboard, and your thumbs have good hefty muscles) is totally
acceptable in my book because it strikes the right balance between
safety for a destructive operation and convenience.

Now, let's consider the alternative -- adding an option to disable the
prompt.  I don't like that.

Why?  It's yet another option.  It's yet another thing to document, yet
another code path, and yet another pitfall for a user who might run
git-gui in a different configuration (and becomes surprised when revert
doesn't prompt and suddenly loses their work).

Do we really need an option, or do we need better usability instead?
My opinion is that the latter is the real need.


That's my $.02 from having used this feature in practice since 2013.
-- 
David

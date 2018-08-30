Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B2C1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 15:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeH3TrF (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 15:47:05 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:42037 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeH3TrF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 15:47:05 -0400
Received: by mail-wr1-f50.google.com with SMTP id v17-v6so8511630wrr.9
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 08:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WQkRXPsqXrWalIIwYGgzQUZh0mmhBTQSZoP+mjwrVw0=;
        b=cy8Se4LuPM/xgZgJcM956dHclIL8luejeP3mapYYorUwqKOESYP8S7a0cvUjF/UZtp
         equ4vDpjWAF07BrbooTcAlQDhj/1bVREaUH1j1CyuuOFsTt5Px/P3YaT4Ioqep0WRYNC
         a8XxxpHhc5qhYeKMwaOiwyjyINNX4WMZO8tMU2OxZiYGoZ2ONCErP68TxYqJK0MDhtOJ
         OtmnN/dz4XS/Ry+fzUQBUnunChXzmx3cWwEhtnOrF6W2kaQoywPw1WDMWEShTR6p6ioH
         OCFedJz7bdRFGhWCs+4kFnRYytnc9yZ3Q5zJJh8XqsekeRdrASl4dGHmckouveMbDu1Y
         nJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WQkRXPsqXrWalIIwYGgzQUZh0mmhBTQSZoP+mjwrVw0=;
        b=l+Go5xNIlpMUIKb1gflqJBICgREOvvDF88KmNCiQRwzHIRhKFmUSO+rcJj7WrZXf3L
         7SVJTB/OQLGT9ODnBQPKBiDydBlbgIhtEFPV05J/whTUR9VahM6z1dt/dvA/zRvrHzvA
         1H2K/xC222PpGj8D/Wn25l12r+i3G4vcE/fxXa7LS/hG67NMqMOUPQIYs3of6/mVRZlx
         oO8GTae+go1frUG0lpSjA5gYZ2W5LLfxbxziYFsKLbTwURFzC6mzO2tXs/y5m8XsTlLY
         9fAHeYvczWvbPI0WIkBnV3nXbJmNe9JEQH9bNPw+s15rU61kPMOgvTUAkzJgbjj2r067
         5WxQ==
X-Gm-Message-State: APzg51BxSDcO0bdm7dpvUWshtRzHjj4JthV+k9+BL+02Bpc5apAtnfPE
        1w4iETn/ONUAC4OYohBuw9s=
X-Google-Smtp-Source: ANB0VdZQDmnOC10dSlmjwfZqF+sbZYmmfygpyNQ9i0FNPagkogc29qo4lNUxdro0Wo+kD2cpl/j34A==
X-Received: by 2002:adf:eaca:: with SMTP id o10-v6mr7456240wrn.98.1535643858522;
        Thu, 30 Aug 2018 08:44:18 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l12-v6sm9342101wrv.29.2018.08.30.08.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 08:44:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2018, #06; Wed, 29)
References: <xmqqbm9kajhu.fsf@gitster-ct.c.googlers.com>
        <CABPp-BG1VCmCMHe=5qayS0G_Z_=e8aVQ121LWuo-OBuiUxiCYg@mail.gmail.com>
Date:   Thu, 30 Aug 2018 08:44:17 -0700
In-Reply-To: <CABPp-BG1VCmCMHe=5qayS0G_Z_=e8aVQ121LWuo-OBuiUxiCYg@mail.gmail.com>
        (Elijah Newren's message of "Wed, 29 Aug 2018 17:22:43 -0700")
Message-ID: <xmqqzhx36er2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>  Recent addition of "directory rename" heuristics to the
>>  merge-recursive backend makes the command susceptible to false
>>  positives and false negatives, but the risk is even more grave when
>>  used in the context of "git am -3", which does not know about any
>>  surrounding unmodified paths while inspecting a patch.  The
>>  heuristic is disabled to keep the machinery "more stupid but
>>  predicable".
>
> I had separate comments about the SQUASH patch in the relevant thread,
> but I've got a few comments on the release note itself, which I hope
> are helpful:

Yes indeed.

> - Perhaps change the last sentence to '...heuristic is disabled for
> "git am -3" to keep...', just to be slightly more clear about where it
> is disabled?

Yes, indeed that is a very good idea.

> - Small spelling error: s/predicable/predictable/

This too.

> - Do we really want to say "even more" here?  I'd rather we left those
> two words off or found another rewording.  Obviously, I'm biased, but
> there's more than just my own opinion of and vested interest in the
> directory rename detection feature.  I'm afraid users may interpret
> this sentence as saying the git project feels we've shipped a
> generally bad/unsafe feature, but are only taking corrective action in
> the most egregious of cases.  That seems to me like a scary message to
> send.  Maybe I'm just mis-reading what you meant, but I wanted to at
> least check what you meant here and, if that meaning was not
> intentional, ask whether we could improve the wording.

I am biased towards "keep it stupid and simple and predictable"
camp, and want to make sure that users do not to blindly trust
overly-clever behaviour of the tool.  As heuristics can always make
mistakes either way, I felt that not saying "more" would be sending
the opposite message---"in normal cases, dir-rename code will notice
presence or absense of whole-directory renames without mistakes but
when used in 'am -3' it misbehaves".

But it was not my intention to say "it is generally bad/unsafe".  I
just wanted to make sure that the users would understand it is "not
fool-proof and can make mistakes".

Suggestions for a better rewrite is very much appreciated.

Thanks.

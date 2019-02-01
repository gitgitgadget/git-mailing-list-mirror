Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82FFD1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 22:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfBAWyK (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 17:54:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36418 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfBAWyK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 17:54:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so8766879wrp.3
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 14:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=R9WO9UaOjEH+kOg04utQWbjHbVO6so+E2Iosf+5nlDo=;
        b=AVYV0P1rvcStFxiF5Z2+re/a8/AzNdL3EUMKRVXi66iBKfED4UixXsS/1LOZM4t358
         t7opwG3I7Jzehxp7/jO+CQ3DBAoWpihdy0KHsKLSLkgRZj/HPtRbp91+38yNB+MxLc0X
         5BhWu7lmzU3Z/kSgY68BnIeKlWDRgyl9jDgsKTSU8aTop6GbtMs6yoVFrVBChdw2z4cF
         v6SbcPh8iOsfvpbaL9sr05o8jO04EH7893mWjmcLngkD+GZTzFS6apaPi2wJ7RqknRAE
         b7Y40CT/SUH2l59yfZ1R42Gutl70NI09rOOyoAPVSh3YKTAFYdFoktF2gz067Hl33lKO
         nSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=R9WO9UaOjEH+kOg04utQWbjHbVO6so+E2Iosf+5nlDo=;
        b=DKkGrxXSDSr9u8pPu6MsmhJ3QSpx3B0ooUI3HVxiSWUp4R1wPa85cjT30jGTAtY6yl
         QG4fuxrTIlZ4T5CfMbEO4SMGrpJfi1z/mWsfAHxMZVYQRrFUP9D5wjeYmUnS2VUHLSZz
         UvcLlM98CxOZDG4wt83+R/1q75LrBxy5co4QDvC+laamSJ53coTTpNket1lYjit3rQPN
         dq2urAXs9gFH7Auf8tnKb/D1B7Mx0gA5gj7J99fS/KRJuW81CQ0ilqZFpeMEt25WPD2b
         Yvt837erVqoPOdFp1J6O630KPbkEkfgpowHtb9JymWdke6dD6o7VIiXEnn1dVVmQKfS9
         REJw==
X-Gm-Message-State: AHQUAuapgADcg3R/o0TFjsF+iBYra5fjATcZkVQU/IgUHVkHh6UbbQIP
        FTagrBr8WrzfEyILw5Rle48=
X-Google-Smtp-Source: AHgI3IbcWOhp4rrbzhQNiEF1r/7nM+IUCYCTr6exnH2HfEMAiPynIGKvjKKHPChjDK7uXjIvN+DzVg==
X-Received: by 2002:a5d:55c1:: with SMTP id i1mr732555wrw.149.1549061648157;
        Fri, 01 Feb 2019 14:54:08 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s66sm2577490wmf.34.2019.02.01.14.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 14:54:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, rafa.almas@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v7 0/3]
Date:   Fri, 01 Feb 2019 14:28:04 -0800
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>">
        <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190201220420.36216-1-nbelakovski@gmail.com>
Message-ID: <xmqqwomjw25s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nbelakovski@gmail.com writes:

>   ref-filter: add worktreepath atom
>   branch: Mark and color a branch differently if it is checked out in a
>     linked worktree
>   branch: Add an extra verbose output displaying worktree path for refs
>     checked out in a linked worktree

As you can see in "git shortlog --no-merges", later two patches
would look quite out of place by having overlong title and starting
the description(i.e. after "<area>: ") in a capital letter.

It is still not clear why we would want 2/3, even though I think 3/3
is a good idea.

This round signs off all the three patches, which is a great
improvement ;-)


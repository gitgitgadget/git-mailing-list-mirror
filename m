Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1715E1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 20:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfBAUhK (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 15:37:10 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39061 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfBAUhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 15:37:09 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so3462152pgp.6
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 12:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=61h5OcLuSGXOrbWwpKT4fieLLb/sSpwTHV6BW20bjAA=;
        b=lqia0mdwufk0PjGTZzHqnaR1uVqHHkzz7u8qE01Ql62k53faffDriiRoVgczOOyl+K
         IDB0xC0sLfWuuofgIiX/VuGT1UY59Ci4xKaKrBZ4YbvyepNqRL+0dPEOm12zzppGW9Yz
         rM91mULwgqs8zTlGitKKJkn5eRSMHCgUYlnSJmUbAJIZDrTWZU7HzWN3NwqELhTg49BG
         Z0Rt8d/oClg2veq6Ydrr0KWWahxRRpf+1q3oTEI/oLIMpz4H6GyyG0askCQo4y6EBS+e
         DckUmaRU1GLD39PfsQu2njq2atFzxIjiozlfUw7i67MWvxiCfkwYTt5nLXlXAQOfMGIJ
         4YYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=61h5OcLuSGXOrbWwpKT4fieLLb/sSpwTHV6BW20bjAA=;
        b=WUu/KRnUSYvIXEJhTaOCb7P1MADUjZXVW1DNQ6376m4KyLrczlaflwSXaz3Qhp8AgE
         Qmz5hcYcwwVL7W93U7fVUQSnicLBZtHgNc/3a7+GQHA4TEngXX0Qc1ZBmkjmLQb8oPS+
         cdwFxzZrtTMItJ9lGmRV0WmqbADrI4Cs55Zp/rGvylg72r582YY5v2bPVU6Z/oNM1UDM
         UEIDK+LQMpZ+qsdsBPzmSpETCt96UNH0QxWp8h7kA38liggObvTBMuGK1Z5xwEcoUl6G
         DXq8yOCV5Wes0FU6A4axZwhHm+njQlwVKsKU9PxvugfDESLL/S0dWD99535Nh3v9oJW+
         +euQ==
X-Gm-Message-State: AHQUAuZlopw/WdDOU5BPKxoOLBO5wrXk1y+M28A+zlNP0sKsoTKRnd53
        pDdVcl/WEy1Nyoq7djzL4+6KBntCeFcN9Q==
X-Google-Smtp-Source: AHgI3IZjE4DJcbe+A5+c8+YrbfcjD095tQXcePJgAqZqVMEGvulWSXOkkVbcKKH/SQ2e07hgPjzeew==
X-Received: by 2002:a63:d104:: with SMTP id k4mr3609748pgg.227.1549053428266;
        Fri, 01 Feb 2019 12:37:08 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id x27sm19314080pfe.178.2019.02.01.12.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 12:37:07 -0800 (PST)
Date:   Fri, 1 Feb 2019 15:37:02 -0500
From:   Barret Rhoden <brho@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 2/3] blame: add the ability to ignore commits and
 their changes
Message-ID: <20190201153702.2d029143@gnomeregan.cam.corp.google.com>
In-Reply-To: <xmqqo987b2g5.fsf@gitster-ct.c.googlers.com>
References: <20190107213013.231514-1-brho@google.com>
        <20190117202919.157326-1-brho@google.com>
        <20190117202919.157326-3-brho@google.com>
        <f5170cb1-4109-4ae3-7722-8e3b62fb0b92@web.de>
        <xmqqlg3ch85x.fsf@gitster-ct.c.googlers.com>
        <20190122143500.397abc8e@gnomeregan.cam.corp.google.com>
        <xmqqo987b2g5.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-01-23 at 11:26 Junio C Hamano <gitster@pobox.com> wrote:
> Yeah, and if the original had two adjacent lines, and replacement
> has three adjacent lines, the algorithm would not even know if 
> 
>  - the first line in the original was split into first two in the
>    update and the second line was modified in place; or
> 
>  - the first line in the original was modified in place and the
>    second line was split into the latter two lines in the update
> 
> In short, there is no answer to "what is the corresponding line of
> this line before this commit changed it?" in general, and any
> algorithm, as long as it tries to see what was the "corresponding
> line" of the line that is blamed to a commit, would not produce
> results human readers would expect all the time.
> 
> As you said, heuristics may get us far enough to be useful, though
> ;-).

Yeah.  We can do one more thing: when we ignore a change that added
more lines than it removed, we can at least not report totally
unrelated commits.  

For example, the parent of an ignored commit has this, say at line 11:

commit-a 11) void new_func_1(void *x, void *y);
commit-b 12) void new_func_2(void *x, void *y);
commit-c 13) some_line_c
commit-d 14) some_line_d

After a commit 'X', we have:

commit-X 11) void new_func_1(void *x,
commit-X 12)                 void *y);
commit-X 13) void new_func_2(void *x,
commit-X 14)                 void *y);
commit-c 15) some_line_c
commit-d 16) some_line_d

In my existing code, if you ignore commit X, the blames look like this:

commit-a 11) void new_func_1(void *x,
commit-b 12)                 void *y);
commit-c 13) void new_func_2(void *x,
commit-d 14)                 void *y);
commit-c 15) some_line_c
commit-d 16) some_line_d

Lines 13 and 14 are blamed on the nearby commits C and D.  The reason
is the blame entry for X is four lines long, rooted at line 11, but when
we look back through the history, we'll look at the parent's image of
the file where that diff hunk is only two lines long.  The extra two
lines just blame whatever follows the diff hunk in the parent's image.
In this case, it is just the lines C and D repeated again.

I can detect this situation when we ignore the diffs from commit X.  If
X added more lines than it removed, then I only pass the number of
lines to the parent that the parent had.  The rest get their own
blame_entry, marked 'unblamable', which I'll catch when we create the
output.  The parent can't find blame for lines that don't exist in its
image of the file.  

With that change, the above example blames like this:

commit-a 11) void new_func_1(void *x,
commit-b 12)                 void *y);
00000000 13) void new_func_2(void *x,
00000000 14)                 void *y);
commit-c 15) some_line_c
commit-d 16) some_line_d

As we discussed, we still can never be certain about which commits
*should* be blamed for which lines.  (Note that line 12 was blamed on
B, though B was the commit for new_func_2(), not new_func_1()).  But I
can avoid blaming commits that just happen to be in the area and would
only be 'correct' due to dumb luck.

This also handles cases where an ignored commit only adds lines,
which is a specific case of "added more than removed."

Handling this case is a surprisingly small change.  I'll post it once I
sort out the tests and other comments on this patch series.  

For now, I went with unconditionally marking the commit as all 0s for
the case where we know it is 'wrong.'  I can do that conditionally
based on blame.markIgnoredLines if you want, though I think any commit
attributed to those lines would be misleading.

Thanks,

Barret


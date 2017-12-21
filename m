Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EEA21F424
	for <e@80x24.org>; Thu, 21 Dec 2017 16:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754024AbdLUQm1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 11:42:27 -0500
Received: from mail-pl0-f52.google.com ([209.85.160.52]:34068 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753875AbdLUQmX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 11:42:23 -0500
Received: by mail-pl0-f52.google.com with SMTP id d21so11254685pll.1
        for <git@vger.kernel.org>; Thu, 21 Dec 2017 08:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=HvA/JJgUNhbP50FRF0z7Eid411/kAXRf4eNmiS/svNw=;
        b=hlTh1C3mNfY/wpsDwmKE48UVm2He3pvo3wfbu7JYbX49mol7v5G8T6iwc58KmweYFm
         WL/f2+KcbynZHopItN878ZRH0gkNdzQFJIQ9DTCERpwZthIwh7fihHbwOmHlAdHM67Ms
         kphNa3cijU0AvvOOvSyyrolDuFGfJZQsQopgUiQFmCHmFJqp2eOD2/kFxpyCmg00bEsU
         x7Kqnv6qU4vNrWoWhyTRQ+/t/khSHhkpNdBe/0NhE8o2QFBGHQf3UFcFUFAJbJo5hGV5
         v514vbzxSNOAcP7S1yyRFSPlE6p1ZOxaZMJ+C2wNwCU6HsMDb1seTeS8Px/5CtSDkujU
         ydNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=HvA/JJgUNhbP50FRF0z7Eid411/kAXRf4eNmiS/svNw=;
        b=PyvyhryE60H5csAaL8jt8T4taXY7UCekZnCGZ95EhmUxRD+cOvZNWX7DyeCsc67Um/
         7LrSqhFZ3CzyriMyT0manATSez/n+o6XhISypJxK0wy7hfhY8R3IkIWCxYt+SwK8Xb0V
         SaL/x1v9ox1NBTEzHVxXilVaA66up0FZxyO33HtMu5BjGh3rDVf4RaIM2BBScjIZ9oua
         pCCSfCFrsRzCgqRN0sEngOCEJhkp+pTByKNiB494lsl/GzcSE2WmLiTmE1Rmx0yyUzs9
         w6b2ngIq7DkA2IQ5bxIAWQn3NYFwY0pomYBYoy8TfkHTDVQZ5/gdCc/wjccyR6XeFq2T
         5JYQ==
X-Gm-Message-State: AKGB3mIuJpYkocLzwYnZN4j86dB7N/Zlbrlal7u32XBsDNlr/k8HySjH
        fvU0uAe1Kr+ybVlRTdSbR6M=
X-Google-Smtp-Source: ACJfBotfiicgYMEea7EjN3r29w3pnMv03+TYyDlL9clj3KkhK8fSXkU0hTcAJuNBJj53Z2nNDWuwIg==
X-Received: by 10.84.134.132 with SMTP id 4mr11333135plh.32.1513874543106;
        Thu, 21 Dec 2017 08:42:23 -0800 (PST)
Received: from unique-pc ([117.209.225.41])
        by smtp.gmail.com with ESMTPSA id g10sm44246832pfe.77.2017.12.21.08.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Dec 2017 08:42:22 -0800 (PST)
Message-ID: <1513874528.9646.2.camel@gmail.com>
Subject: Re: Error in `git': free(): invalid pointer (was Re: [PATCH]
 sequencer: improve config handling)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
In-Reply-To: <alpine.DEB.2.21.1.1712211442470.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <xmqq8te84yo6.fsf@gitster.mtv.corp.google.com>
          <20171213114621.30250-1-phillip.wood@talktalk.net>
         <1513794792.9785.2.camel@gmail.com>
         <alpine.DEB.2.21.1.1712211442470.406@MININT-6BKU6QN.europe.corp.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Thu, 21 Dec 2017 22:12:08 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-12-21 at 15:06 +0100, Johannes Schindelin wrote:
> Hi Kaartic,
> I fear that the strace does not cover the `git-rebase` process nor the
> `git-rebase--helper` process (which must have been part of your run, as
> the commit affected only that part of the rebase operation).
> 

Yep. It striked me only later that the entry point of "git rebase" is
essentially a script.


> If you have valgrind installed, you may want to give it a try. Since
> git-rebase is (still, much to my dislike) a Unix shell script, you will
> have to work quite hard to get it to valgrind correctly.
> 

You're right about that it's quite hard to get to the right point of
the issue when scripts are involved.


> This is how I typically do it: 
<snip>
> Then, I look for that call (I imagine it is the `exec git rebase--helper
> ${force_rebase:+--no-ff} --continue` line), then copy-edit it and guard it
> by an environment variable:
> 
> 	test -z "$DDDD" || {
> 		valgrind git rebase--helper ${force_rebase:+--no-ff} \
> 			--continue
> 		exit
> 	}
> 	exec git rebase--helper ${force_rebase:+--no-ff} --continue
> 
> After that, you can run the same command, and trigger the new code path by
> that environment variable:
> 
> 	DDDD=1 /mnt/Source/Git/git rebase -i HEAD~10
> 
> That way, you can keep the rest of your Git calls be unaffected by the
> patch.
> 

Thanks for detailing the way to get the right information for this
issue. That was intriguing.


> BTW from your invocation, I imagine that you wanted to actually run your
> Git just-built-from-source, in-place. But for that, you would need to pass
> the --exec-path option, too, like so:
> 
> 	DDDD=1 /mnt/Source/Git/git --exec-path=/mnt/Source/Git \
> 		rebase -i HEAD~10
> 
> That way, you could edit the git-rebase--interactive file that is *not*
> installed, and avoid affecting other Git operations (you would also not
> need to guard the new code path behind a conditional).
> 

Makes sense. (I had actually used incorrect directories in my previous
mail as I did part of it manually (big mistake!) so the trace itself
might not have much sense in some parts, sorry)

Speaking of trace, (thanks to Dscho!) the one I got using 'valgrind'
(with `--leak-check=full` option) can be found below. I've kept only
relevant parts of it to avoid unwanted noise of `set -x`. Let me know
if that's needed too.

...

+ git diff-files --quiet --ignore-submodules
+ git diff-index --cached --quiet --ignore-submodules HEAD --
+ test 0 = 1
+ test -z 1
+ valgrind --leak-check=full git rebase--helper --continue
==10384== Memcheck, a memory error detector
==10384== Copyright (C) 2002-2015, and GNU GPL'd, by Julian Seward et al.
==10384== Using Valgrind-3.12.0.SVN and LibVEX; rerun with -h for copyright info
==10384== Command: git rebase--helper --continue
==10384== 
==10384== Invalid free() / delete / delete[] / realloc()
==10384==    at 0x4C2CDDB: free (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==10384==    by 0x24E3F8: read_populate_opts (sequencer.c:1964)
==10384==    by 0x24E3F8: sequencer_continue (sequencer.c:2753)
==10384==    by 0x1735DC: cmd_rebase__helper (rebase--helper.c:52)
==10384==    by 0x11B847: run_builtin (git.c:346)
==10384==    by 0x11B847: handle_builtin (git.c:554)
==10384==    by 0x11BB05: run_argv (git.c:606)
==10384==    by 0x11BB05: cmd_main (git.c:683)
==10384==    by 0x11AC0B: main (common-main.c:43)
==10384==  Address 0x2a898a is in a r-x mapped file /mnt/Source/Git/git-next/git segment
==10384== 
Successfully rebased and updated refs/heads/public.
==10384== 
==10384== HEAP SUMMARY:
==10384==     in use at exit: 680,882 bytes in 332 blocks
==10384==   total heap usage: 717 allocs, 386 frees, 1,709,293 bytes allocated
==10384== 
==10384== 2,053 (2,048 direct, 5 indirect) bytes in 1 blocks are definitely lost in loss record 75 of 83
==10384==    at 0x4C2BADF: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==10384==    by 0x4C2DE5F: realloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==10384==    by 0x27E0FE: xrealloc (wrapper.c:138)
==10384==    by 0x2072A3: add_object_array_with_path (object.c:319)
==10384==    by 0x23D745: add_pending_object_with_path (revision.c:163)
==10384==    by 0x24030E: add_pending_object_with_mode (revision.c:170)
==10384==    by 0x24030E: add_pending_object (revision.c:176)
==10384==    by 0x24030E: add_head_to_pending (revision.c:188)
==10384==    by 0x280EFA: has_uncommitted_changes.part.17 (wt-status.c:2288)
==10384==    by 0x24DF88: commit_staged_changes (sequencer.c:2705)
==10384==    by 0x24DF88: sequencer_continue (sequencer.c:2749)
==10384==    by 0x1735DC: cmd_rebase__helper (rebase--helper.c:52)
==10384==    by 0x11B847: run_builtin (git.c:346)
==10384==    by 0x11B847: handle_builtin (git.c:554)
==10384==    by 0x11BB05: run_argv (git.c:606)
==10384==    by 0x11BB05: cmd_main (git.c:683)
==10384==    by 0x11AC0B: main (common-main.c:43)
==10384== 
==10384== LEAK SUMMARY:
==10384==    definitely lost: 2,048 bytes in 1 blocks
==10384==    indirectly lost: 5 bytes in 1 blocks
==10384==      possibly lost: 0 bytes in 0 blocks
==10384==    still reachable: 678,829 bytes in 330 blocks
==10384==         suppressed: 0 bytes in 0 blocks
==10384== Reachable blocks (those to which a pointer was found) are not shown.
==10384== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==10384== 
==10384== For counts of detected and suppressed errors, rerun with: -v
==10384== ERROR SUMMARY: 2 errors from 2 contexts (suppressed: 0 from 0)
+ exit


I think I didn't mention I've set `commit.gpgsign` to `true` for that
repo, did I?

Let me know if anything else is needed.


HTH,
Kaartic

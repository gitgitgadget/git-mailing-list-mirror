Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF62C3F6B0
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 21:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbiHXVFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 17:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239719AbiHXVFu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 17:05:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839165E657
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661375139;
        bh=Unlyzwuqgxer82E2NcI9tTlmMAK0Q3Ocxt2m4whXh1U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=M2gSA7dpyRk7hAlgknoDbDTf3AQSbl+tfQrsw31GVO52HfDC945xy5m5ERYbFQNMH
         NiNel7RD75afYq+04Dns1CUzLRgYYYIquic1qDEGQttZBtGoFeOPQrKuYhmNEbi0LE
         A9xXnH/CO94fQR+l+2jQv7/Hfd0gvDBOOGQyqxUo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9o21-1oUWTW0Zpl-005qM3; Wed, 24
 Aug 2022 23:05:39 +0200
Date:   Wed, 24 Aug 2022 23:05:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/3] built-in add -p: support diff-so-fancy better
In-Reply-To: <xmqqmtbt7b5p.fsf@gitster.g>
Message-ID: <34qs5607-001o-0n6o-rson-9587q8r909qn@tzk.qr>
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>        <ab012782-1d02-b90b-9a4a-179ecc3f8e9e@gmail.com>        <1r3pq48q-s728-8r2r-r4q3-72413r5483o1@tzk.qr>        <41781ceb-bfad-2534-2970-c74618c93f2a@gmail.com>       
 <145ddce5-8084-a024-39b5-9dea870d1afe@gmail.com> <xmqqmtbt7b5p.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0kBZkzcnws4b2WlZ8CpV/+VrWS8gur8Z3oZixGbZrlQt1rnoe2O
 lqgSgg4mcm2Ip2taIO36ECwzzxxi5ElSoBFiLH/02ZBtJvButtb/jezRPru8w7gCXlrCUAA
 rWjDTeqEIQArbXsaCXVwJxwlmLSUwTRmmfo0qsm3LkO8bIw9Cnjd2ADjQLXiFiWo90PNX04
 5DPm8eibiU3ZiRdD3UP+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oDIQtXI6Z9k=:PlfuhoNQ3/ifPE2H1T82Kc
 P1hfd3BcYpjijeM2adHxiTZzk1i91NdmXuiF5UPwF/mjmKGtanJd/bmdQZR68lJLMBMxhwpdl
 LAq/BAoEonRssjrX2qyPDvRMbPFZ43LcxTrZZ8L4ONyeHTsS9vZuapxdl0OCTIWJSQwW7IJhS
 ywHrPs9S0jo7zBst4a8nvRjka09lgAdVjBhKSapOF/Kx6ElPslYHqI5fzR4COFvO+2OWWcNez
 odCZ5V7+q8ysCRGbPr/DYKoxok5lN0bGEM3MsqFSbiX7bj7S9v3OTmQUQ+TZxBL0kLDmh9JXw
 M6N8J+cWoxY/88D0hmS1I9MAk4TpJip8WPweAQxabmNdNTgyIxL5bEViZxX1g/IjGuVczfWyk
 VB2BT5KenC+4QEEyAgfNqdb44+Cme0JDTJlPOuu9g5tHH778ROZHpe2jwSPhYY/TMgB0zIjoW
 g+G+7ddDvUIZEtDjh443Af6OG42cS3kX7u0NNvkLpyuB+UcPy+6X26S4oA/FvCHR3JHXkogkG
 SCeQRkEx+QjvRluw9Ec50v2Jcjm3CLQq3COQrCFtLnRDZxNgX9zwXg6E/1ZwZvlmlzgkSg/3k
 D7QbS3o0IWj6M7HgFZ8v6UD/xEYvl2sH2bSDDZ6r6I+DUNR/N/BLvfsahLI+16aWollCay+QJ
 I6iHlAiHJM57yGIGXFr5w6/wVRvZNhCKLY2iACFlN5SCcwmDxXNt7nCAptNmPrkuGl0XsGZuC
 GtX58YV1vtR4XJdzA4/eAAJEM1fpqWnUyh4j1eGvMgPbPBzrobB/N3ogyp/rLgNer/TAh9KzE
 vGp2V/usm0muiOqkzHzzHZ1XbaShf+Kx++R1s6gMCjgIW5LWjZNWbbSahjnmK4BmMdJdXzxcw
 ngtVD9cJzV2gOW67NGqy0OLi3JxlB5RKnIFKEjqewHJ1CIwm3c1goLBnyjvEVDcnKmwBasmp1
 aS8iJ5XYWf9cUfCydbu5e2pkkzIsvVUNQYiNTyz1qd1rXK2hLm499PPYrZkEJNGsgcxlBwWtp
 V4mIaVSMUDLFypU70J075LSo6FWOLgDQk0KFy+oGqAItCG1OELUnRd+5smPM7ydeTA1CK4uuT
 qAMCSb8hYkm5iIzK+5iMtroywDGLZeRLE5ZGKg3X++h0LOg4+HXmztkHQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Philippe,

On Wed, 24 Aug 2022, Junio C Hamano wrote:

> Philippe Blain <levraiphilippeblain@gmail.com> writes:
>
> >>>> However, I've tried it on a more "real-life" example, and then I ge=
t:
> >>>>
> >>>>     error: mismatched output from interactive.diffFilter
> >>>>     hint: Your filter must maintain a one-to-one correspondence
> >>>>     hint: between its input and output lines.
> >>>>
> >>>> This is despite using "diff-so-fancy --patch" as interactive.diffFi=
lter, which should
> >>>> keep the number of lines the same.
> >>>
> >>> Would you mind sharing the example with me?
> >>
> >> In trying to write a reproducer, I realize that this is in fact a sep=
arate "bug".
> >> I happened to have a submodule in the repository I was testing, and i=
t had modified
> >> content. This is what was causing the "mismatched output" error, alth=
ough I'm not
> >> sure why. If I use a pathspec that does not include the submodule whe=
n invoking
> >> 'git add -p', it works correctly.
> >>
> >> I'm a bit out of time now but I'll try to write a separate
> >> reproducer for this later today.
> >
> > So in trying to write a new reproducer, I found the cause of the
> > bug. ...

Ah. Submodules. The gift that keeps on giving.

I'm not _really_ complaining, though. It seems that with beautiful
regularity, submodules come up as crucial parts of attack vectors in
exploits that are reported to the git-security mailing list, requiring
somebody with my abilities to implement fixes. Therefore, submodules award
me with a sort of job security. :-)

> I somehow had an impression that that the C reimplementation was
> designed to be a bug-for-bug compatible faithful rewrite of the
> original scripted version,

Yes, it was designed as that, with a few things done differently, though,
such as avoiding unnecessary `git diff` invocations, and using C-native
data structures and memory management.

One unfortunate consequence of avoiding the `git diff` invocations of
`git-add--interactive.perl` that are not actually necessary is that I
missed that one of those invocations specifically ignores dirty
submodules, and that the Perl script then only processes files whose
numstat shows up in _that_ diff output.

Fortunately, the fix is easy: simply ignore dirty submodules in _all_ `git
diff` invocations of `add -p`.

I will submit the next iteration as soon as the PR builds pass.

> but looking at the way how this bug is handled, I am not sure (it looks
> as if the initial fix was to patch the code to match the symptom, not to
> make the code to behave more faithfully to the scripted version).

The built-in `add -p` does something slightly different from the Perl
version when it comes to the line ranges in hunk headers: instead of
storing stringified versions of them and parsing & re-rendering them when
the hunks are modified, the C version stores the actual numbers, adjusts
them as needed (e.g. when hunks are split), and, crucially, renders them
on the fly when displaying the hunks.

That means that also the colorized hunk headers are generated on the fly
whenever the hunks are displayed, and they are never stored in rendered
form, neither while parsing diffs nor when hunks are split or otherwise
edited. That's why the built-in `add -p` looked for a `@@ ... @@` part in
the colorized diff, so that it can display the remainder of that line
after showing the rendered line range.

And yes, this is a deviation from the bug-for-bug principle I follow for
conversions from scripted commands to built-in C code, but it was for a
good reason: memory management in C is less trivial than in Perl (where
one essentially YOLOs memory management), and I was not prepared to invent
a rope data structure just to be able to replace parts of a long string
buffer with rendered text of a different length, nor was I prepared to
call `memmove()` tons of times.

Note that the Perl version does something slightly iffy, too: if a diff
colorizer is configured, it initially shows the original hunk headers
(e.g. "@ file:16 @" in the `diff-so-fancy` case) but when the hunk is
modified in any way, it generates "@@ -1,6 +1,7 @@"-style hunk headers and
does not show the ones generated by the diff colorizer _at all_ anymore.

In this patch series, I teach the built-in `add -p` to be more lenient and
simply show the entire original hunk header after the rendered line range
if no `@@ ... @@` part was found. If that part was found, we still replace
it with the rendered line range.

Yes, it is a deviation from what the Perl version does. I consider it an
improvement, though.

> As with any big rewrite, a complete re-implementation always has risks
> to introduce unintended regressions and that is why starting with
> faithful rewrite with the staged transition plan is valuable.
>
> In this case, the staged transition plan, the step to flip the
> default without before remove the old one, is working beautifully.
> And it was only made possible with the actual users reporting issues
> before they say "the new one is broken, so let's use the knob to
> retain the old implementation".

Indeed, and thank you, Philippe, for bringing this to the Git mailing list
so that I could do something about the bug.

Ciao,
Dscho

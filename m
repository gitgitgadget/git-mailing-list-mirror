Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54D1C636D4
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 09:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjBMJM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 04:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjBMJMz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 04:12:55 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B348619E
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 01:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1676279568; bh=VX7rWVkGVSbbXgPTy9gNfpeTlqG0lPwg2ozEDCMhtcM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GnJBNkkm/WpeH5Wznm6PNBVjNAn7iUoqxi56tsirPk6n6wvbDhGJypH2pt8zEebF2
         jTSaqW50I0lEJoNB9uLmKo8YnTYfOc4hR02L3fNxjKeQADXm+Jq+7jfMAEDpod5xji
         dh24ug2Bv4QhSvhYfPR2geWpmrZx0yEiNAV3err1f/9jlNx3+ygXR8uEZMYnjxCd2U
         Zg1F1sPmP9edci53GWVv4MTfAp9QC2jCbJMfyAmN6GZqx1aZGVDA1VcnXXspQXc32S
         s8SRJY1ocHNLCzB1salaA2HASd4jOn47FRgnyTw7WxLJCv5rMX1HGh3OfRY9fbOU1H
         5g9yMRxOpkTHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.128.75] ([213.196.212.16]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Fnj-1pXFNn2Zlv-006RcH; Mon, 13
 Feb 2023 10:12:48 +0100
Date:   Mon, 13 Feb 2023 10:12:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH] test: make SYMLINKS prerequisite more robust
In-Reply-To: <xmqqk00pjuli.fsf@gitster.g>
Message-ID: <ef19e164-b0ba-531d-95e6-75ef61c4fc9d@gmx.de>
References: <xmqqwn4sq73f.fsf@gitster.g> <230209.86k00rzqsz.gmgdl@evledraar.gmail.com> <xmqqbkm3ppn8.fsf@gitster.g> <xmqqk00pjuli.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1114573115-1676279568=:10350"
X-Provags-ID: V03:K1:/CmPP9gdUQ7f6HRQ/E1BDK/wxc4ZKXiAEwzpEHESMM6hKWxGouI
 Bh7dSPxwqexZnAA+3eWtHr/pz2dksH0nl07G2rFlrsQAnzLsXqCwgN+dV9HM5kbRljBjxAA
 i8Ao6xzeiV0tHj4u6W11u0ED4FPJeTahP3vAeXlALU33qfw/8fqBD+0t+0B9sZ/JAfmF5+8
 eIqPXzL6GFT7UV75F5QDQ==
UI-OutboundReport: notjunk:1;M01:P0:jqYOmTpRYUs=;fkEaWVARAcuKR8rIQ+aZPwS1xBP
 H8oTxxfnQQHoJVnpCpa06QjvtW5hB3efhMi90la5KIJwMLowdNB28hUgOqLkhS/A28L9SH2ud
 KrspYzvlwjjxxar3hAsosSded3nh9dpTZtv2ZjvpYGBtzxV97NKtgZB2QMhD4+oj6JEeOJRcO
 6+z7IPey8d0FW0j3O7wwu71Z182KUyjzEYUHakxWQ5hFFp8ygiqbWtssP9Yt/LNOCpG/ZZnJS
 Vu9vROt0oYugESV+GnhjtDT1sJpgrdhAiNxL0IY15hlmZpzScST2DHlfpC4hvjuxdKL+IRrGP
 wwMXFnUPk1a7Uec6Xietl+YgI6JRwDTDb1tfluTFS1PSqas25A3/eTDM7jfUPps4twPmh5PXe
 GeoVdr68OrdFDPJHKokZnmVVPP2MJ0pEIDS+X63gs5t/Y8eXZMQxSJHtsxOndoiB6wkre4Eyy
 CYuWe+CUqY6mj9ehubB5GKrJuRgm4IPPMVNmARn2aPMSsuwGO49FNdIPrultKav7EdGRiCcdO
 hwAZpu3K3iRzKzIQn2xV6oUhe+zcoHFSjOG2yWiCZiuoFkmrScx0HV2imcwf3mNm9lhQ81d+i
 AYfY9+B3YP9Cl32CVht4noSmSJJqcFk1UL5SchvTgzHGCCtL6mDUcu2J8goKxR9UHbNLGfOJa
 ClT/rK7M+rqZqGkbYiVRJS6Do13YR3KcnLO8GqIcCOTaRIRfIM/pADaqkHG5BdN9tRPEJyaYF
 M3L9Y6QelGGFKqAT4RA05QkrUydC8HNIW7Z3ol0ELzCmVk+lX+g8u87+H5W83sEB6RD5nsqz5
 7Nn59/q9OLEnoGC6vTSGvzjOjw5gwoRaTt/KI519uY6UgKGHW9fGFYjc0R1PbliNzDeL9NiNR
 ams/NVrEw44wMNbfjKJsfNTHWQoIkoQdFK9nQQxLHrciBVMBrRS9qH3082FEnM8WtrdvbypQL
 fKFL2A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1114573115-1676279568=:10350
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 10 Feb 2023, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >
> >>> I wonder if something like this is in order?
> >>
> >> I don't have much to contribute on that front, but this is really
> >> missing some "why", this worked before, why is it failing now? Do we
> >> have any idea.
> >
> > Your guess is as good as mine.  I do not do Windows.
>
> This morning, I notice that those CI jobs I ran last night that
> failed with "whoa, windows tests are somehow reporting that symlinks
> are available but not really" issue the patch in this thread were
> attempting to address has passed even for branches like 'master' and
> 'next' that do not yet have it, and it seems to be because you
> re-run these failed jobs.
>
> Whatever magic you used to fix these failing tests, thanks.

The magic was to pester the maintainers of the dependency of the
`setup-git-for-windows-sdk` GitHub Action that broke said action.

Background (you can skip this unless you're interested in details):

Since Git's test suite relies so heavily on Unix shell
scripting, which is really foreign on Windows, we have to use the MSYS2
Bash to run it. And when I say "MSYS2 Bash", it is short-hand for "a Bash
that uses the POSIX emulation layer provided by the MSYS2 runtime".

The MSYS2 runtime _does_ have support for actual symbolic links, it just
depends on certain Windows features (and then it still is not quite the
same as Unix symbolic links because on Windows, the symbolic links are
either pointing to files or to directories and you have to specify that
when creating them).

This support is toggled via the environment variable `MSYS`. To enable
support for symbolic links, set it to `winsymlinks:nativestrict`.

Now, the dependency of `setup-git-for-windows-sdk` that is used for
caching the minimal subset of Git for Windows' SDK needed for git/git's CI
runs is called `@actions/cache`, and it recently saw a contribution to
allow for caching symbolic links even on Windows.

This change set the `MSYS` environment variable in the way indicated
above. Unfortunately, it set it not only for the `tar` invocation that
needed it, but it was generous enough to extend that setting to the
entirety of the containing workflow run. Affecting, among other things,
Git's test suite.

The `@actions/cache` PR with the bug fix was actually already opened when
I noticed the problem, which was only because I released a new version of
the `setup-git-for-windows-sdk` Action that supports Windows/ARM64 better
(and which unfortunately dragged in the borked dependency). But that PR
had not been merged yet.

Once it had been merged, and a new version of that dependency had been
fast-tracked (I want to believe that my gentle nudging played a part in
expediting this), I released a new version of the
`setup-git-for-windows-sdk` Action and re-ran the failed workflow runs.

And subsequently I ran out of time and could not update anyone about what
I had done to fix this.

> Do you have an insight on why and how these were failing?  The patch
> in this thread was a band-aid without knowing why all of a sudden
> "ln -s x y && test -h y" started passing (while compat/mingw.c still
> says readlink() is not supported).  If we know that such a breakage
> is not expected, we can drop this workaroun, which would be great.

The patch that started this thread looks a lot like papering over the
issue to me. And a cleaner way to accomplish that would be to force-set
`MSYS` to an explicit value.

It would be nice to eventually get to a point to have Git's test suite
pass with symbolic links enabled on Windows, but introducing a new test
helper won't do that.

The actual root cause of the failures we saw when
`MSYS=3Dwinsymlinks:nativestrict` was graced onto us was that Git's test
suite creates a symbolic link to `/dev/null` and then expects Git's
`opendir()` call on the symbolic link to do something which it does not do
on Windows.

I _guess_ that the symptom is caused by `opendir()` resolving the symbolic
link and then trying to open the `NUL` device as a directory, which makes
no sense whatsoever.

But I would contend that the actual culprit is (from the cursory look I
took) that Git's test suite is abusing `/dev/null` as being some kind of
empty directory instead of explicitly creating an empty directory and
using _that_.

This is _not_ at all the full and thorough analysis I expect of code
reviews, especially of my own reviews, please do not mistake my reply for
that. I have more pressing things to attend to than to fix what seems like
a "wouldn't it be nice" rather than an "OMG must fix rn!" problem, and
therefore I cannot justify spending more time on it for the time being.

Ciao,
Johannes

--8323328-1114573115-1676279568=:10350--

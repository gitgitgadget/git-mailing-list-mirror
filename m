Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A040C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 11:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242954AbiEYLbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 07:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237620AbiEYLbd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 07:31:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D5D77F34
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653478262;
        bh=JHbpluIsTVylPigkl4RxjexyZWt+eBoNM3drFmMPp3Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gklpIx4IzoNr0Z6jkKD+WtJ1+HedhIPBADILRpg9A0gY+EFZhAOMU9cnkYmlFN5Mx
         /EiX9UY+vkfSQEjiCof8DQaz5ynuNXSb7rujcWkl4kTWGtY+VXrRBE5r10QXCaei4o
         C0+f7dS/34CjsE6cjPsVEGMDX7ME5OjQZLi6aQJ4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWAOW-1oLxuu1Vrm-00Xav4; Wed, 25
 May 2022 13:31:02 +0200
Date:   Wed, 25 May 2022 13:30:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/8] hook API: connect hooks to the TTY again, fixes
 a v2.36.0 regression
In-Reply-To: <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205251308381.352@tvgsbejvaqbjf.bet>
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-715222152-1653478262=:352"
X-Provags-ID: V03:K1:bPNg3QAGZgbUaxipn4YcFiR/4JJw5kg3DorWbcTvGvJDHvVYQ3H
 YVHJ0ZD3J63d2jFY2TVJU4vd1TrcE//Zrjrw4bR8lYJM2VVJxyl5Aqn8RR4yGRCBJNAZcWW
 zkdfWnr4+q5qAvfTdzuzjKjDxriGnN3Qh+qdm6/F78DcoPcI9UW1xMZC2emrjTySzroi8bD
 71symnn3GzBV3t5w3F3uA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aw7W+myHjSg=:Auvo2bjF4ZT5oL9iDDHFgC
 y2aGLRsEeaJg2RoQiMAO+e+MmeokDI7C+r7ttMpIFB8pbEKMchD5jqLwxHNBmKvd+e922lEkT
 vmI+0E79TO5j4wkjRWo6HwEYvoA2z7RCz1HqbVik6bJncYw3G2j/2Nnf6LIn1OPOAmA83awVR
 r8uYqSQ2bX8XGFlb36sNCE+MZM8xE4I8W72//M6jLFpbNus4KwyPEXLfKCK+TfnEoAD4KuFVn
 MuleIV6WHvLtxZEciJXNWEK1p5WZX1wE3meKFwHGQLyvy+L/TGygcIUm0IyaqrHujw99XIk+K
 l5J/LvIYGDT70KZVBuawfwdyAxFEqVzK6rq7SM5fCcV14biGAR7u1g+7ydFdlD3UqIq8IP6LV
 KNYcTnyYd10z9z3KrLVEK+6yq+qH+MC92UJ6yoK6M5DgQeJlNdVU+3ZNMAld1IQS52ZsWumAj
 raLZf3VoM30fcnzxzZuU4mjGWtgKJIF/DbASBOr0fg0orKlXVZcC+dCM9n+Sjay8U6Jn2dPJy
 Fmw7nJjg5BWBOSfJU7uxkFrJdanKvUTNw73ffU0Dc2mjSIAo0LbgAE6Oh6s2IFAnsoAu9gCTc
 0CgoZExtCiQ05qqSOYmTZOWxARp3jI5Zoj4uOdpgNWQKXTm7U5Gbg+N4j4hQ58+4b22ot8He8
 h58qsX2D2p5ydhmQVgyNyhYonxKKZkO5Q2+m3djsqcRY0q53CxcUiIt7PI78Q9Y2cNGVHsWdx
 cZTUrLmDQr3tpeT3Octuv7QS1X0E1Wby1nIcwCaqNi3XFANQkS6vdxEaW9/6x7dQ+qmN1NWru
 8In0ilg0D79DeU5gYyf6nRjHzi26GxFrDeGxtECNbFbqWwJTydP4fveqlELXFK1zjBaXOy8FL
 EbAaZz0drPMeGmj+kuyEg0xomvMQ91QHN/HlKHTfRPsuW40rAfrXN5n4Uwb8fXv3yQjKs+rdE
 XrrtF95xVwi41e9p51nJIl0eVdsBGbMmu4SO103RKw8VD90WBEejyklAbWPotSazaqJXSncDw
 CTioVe/RuizFrsg1qnADGBAEx9zgHcrRCN4V3Toew3VYBSm/Xv/+e44k2MWipdXMY8VU5BMmk
 BVuQfA7x8hnLIf92goyEXY0pCQjfpIqL2tylPZC0E6D+fYf/AZmkc/IGQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-715222152-1653478262=:352
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

as promised in the Git IRC Standup [*1*], a review.

On Wed, 18 May 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (8):
>   run-command tests: change if/if/... to if/else if/else
>   run-command API: use "opts" struct for run_processes_parallel{,_tr2}()
>   run-command tests: test stdout of run_command_parallel()
>   run-command.c: add an initializer for "struct parallel_processes"
>   run-command: add an "ungroup" option to run_process_parallel()
>   hook tests: fix redirection logic error in 96e7225b310
>   hook API: don't redundantly re-set "no_stdin" and "stdout_to_stderr"
>   hook API: fix v2.36.0 regression: hooks should be connected to a TTY

I started reviewing the patches individually, but have some higher-level
concerns that put my per-patch review on hold.

Keeping in mind that the intention is to fix a regression that was
introduced by way of refactoring (most of our recent regressions seem to
share that trait [*2*]), I strongly advise against another round of
refactoring [*3*], especially against tying it to fix a regression.

In this instance, it would be very easy to fix the bug without any
refactoring. In a nutshell, the manifestation of the bug amplifies this
part of the commit message of 96e7225b310 (hook: add 'run' subcommand,
2021-12-22):

    Some of the implementation here, such as a function being named
    run_hooks_opt() when it's tasked with running one hook, to using the
    run_processes_parallel_tr2() API to run with jobs=3D1 is somewhere
    between a bit odd and and an overkill for the current features of this
    "hook run" command and the hook.[ch] API.

It is this switch to `run_processes_parallel()` that is the root cause of
the regression.

The current iteration of the patch series does not fix that.

In the commit message from which I quoted, the plan is laid out to
eventually run more than one hook. If that is still the plan, we will be
presented with the unfortunate choice to either never running them in
parallel, or alternatively reintroducing the regression where the hooks
run detached from stdin/stdout/stderr.

It is pretty clear that there is no actual choice, and the hooks will
never be able to run in parallel. Therefore, the fix should move
`run_hooks_opt()` away from calling `run_processes_parallel()`.

In any case, regression fixes should not be mixed with refactorings unless
the latter make the former easier, which is not the case here.

Ciao,
Johannes

Footnote *1*:
https://colabti.org/irclogger/irclogger_log/git-devel?date=3D2022-05-23#l4=
4

Footnote *2*: I say "seem" because it would take a proper retro to analyze
what was the reason for the uptick in regressions, and even more
importantly to analyze what we can learn from the experience.

Footnote *3*: The refactoring, as Junio suspected, might very well go a
bit over board. Even if a new variation of the `run_processes_parallel()`
function that takes a struct should be necessary, it would be easy -- and
desirable -- to keep the current function signatures unchanged and simply
turn them into shims that then call the new variant. That would make the
refactoring much easier to review, and in turn it would make it less
likely to introduce another regression.

--8323328-715222152-1653478262=:352--

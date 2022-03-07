Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB89C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 16:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240094AbiCGQIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiCGQIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 11:08:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955BF13E2E
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 08:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646669263;
        bh=EBaJ5F31kL0AvalK1U3bteCD/WHvzlmZx55Txr7P1Ss=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OuWd1ezikj2Bm6JVVw9BdvD9Ng80Nklp2P0xESlG0NCj/z1yatEcbZGTuxzCyqe0K
         WPRdudU1BCyzebjuu5ckGsKa8oomsmzae7aL+wIFC3H/3H3YerVGaYKC8ke2Kn+F2Y
         2fQUzrXIUvzN7mYROL7RC+yH4wezKNkbgWftky+Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.214.47]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzhj9-1oMwrG0XU9-00vjFU; Mon, 07
 Mar 2022 17:07:43 +0100
Date:   Mon, 7 Mar 2022 17:07:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
In-Reply-To: <30dbc8fb-a1db-05bc-3dcb-070e11cf4715@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203071657180.11118@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet> <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com> <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet> <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
 <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com> <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet> <30dbc8fb-a1db-05bc-3dcb-070e11cf4715@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:16no14mOUFgL6iZyKzTd6uLRpymcvTv8F3MpbhoYAy8Kbo/SCuV
 JFsBbw1Cldcidc6eBIcZF1dy2BW0UtqtiC0i7MzFqOtFGST/5inloa3vQwSKK0D9SvyvaUC
 1+S8/JXyL9kVi8Tb8O2j1YHYi7dT/A6Cs0YA31Uqc6yMOB3rVKCuIH4PyZ02il4Go8yNTs8
 m1wCrzXGPJqxUB97PlIYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5s3C8h+oTX0=:06dFN0zQIIxqiLzsPtplsB
 nfyeB+c8cy/vJ6noSH2H1vta9z81lhO5Lal8bNAI5LlgZ9+NuykjB7a96DpBw/lmvKzACD4uh
 qetOIp+rb3axkxjjhngPUyVvx4Bt3HgCYspRCc8TcU5aAgeq0l65yt9cMOqio+y2h3HUXZeO3
 l38rGshb0qkN60fg5PElkyt967xJxbWyhL1cQ4P6E6d5J5U1rhW1G66C9qKflXjnh6UH5QuWj
 u2xaEFzPbC2FikATzwW4c0Tcgz18UBWnLwj1msP6fMMbg59UsINJ6+hkT744+FUiVLngx98Ro
 c/BsV7TJh9DzWtRbYC/VaGpBbK3N0lYWA0TFgy/cktwImM154uHCepRtQhEp0lKaVz48rLnC3
 gztFt/BupBorhVBtQHoHi27LYohh2swD1yeR7CmLP/H1MsP7Dh1nvz3eJA4gQOM67ysx6+nZf
 rWgFv0sJaXJ4cMtgkD9DG6Qn60zgFRFv/z6yLNbK+IoUGgXJMjlNRF5FCUYPFTBHb32pEXFyP
 2GvmZNcIvFsqTLUsk6Y9nUVQfmIpw1d0Ao7LbrkwWmfmGIMYz8TOCVL3zHEO7cBh7NnK539V5
 l3NWfHbtlhqYq1cC+fB9KEDX9nSg0uLPaT6w0YpFYEL/yb3Y11deXPb7ynfoLwqtU8qYRRWGc
 e0iUU1c7TDw6PDfOvBaT0Ui4vOspOyRdxBxtB9WsQHL07uQYdSRozf/u9HzO8a0zirGrV+45R
 4lCJmGp5DcuR9SfJsDBBMwix53I+8z1jYSQKeq8D8K/rLlhdm6QUJolsPBFVcrGCPXBZQcPNs
 er5pkfozstu8qxA0NNvFuXGWi0OSvrImnt0ITxh52A0CvC3hpXpox7PapWfgkq8CVUjqdMkGi
 eHqHWRnKMon1OUs3YC5Wr844Gvco9q5UahxZMTheGNwpoXvM9bGfRnXuGP1XXrVHkOWXMWM3r
 gYO/8ccXY1uUpXdYt1lyv0RZ6uAs7C1Jb4DZ+DB1RFQSvF6oLHtrs0pYTh3T6l3SNQ9PzERFQ
 eWZfwT7YbacVbdKqI1XU8I1P9lZvjPCwnEdCbZSPvYR11Z4YzakzjmmJznGg+wBbxph/z6NGK
 vXwVhQDTP6/ZRg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 2 Mar 2022, Phillip Wood wrote:

> On 25/02/2022 14:10, Johannes Schindelin wrote:
>
> > On Wed, 23 Feb 2022, Phillip Wood wrote:
> >
> > > With the first link above the initial page load is faster but to get
> > > to the output of the failing test case I have click on "Run
> > > ci/print_test_failures.sh" then wait for that to load and then
> > > search for "not ok" to actually get to the information I'm after.
> >
> > And that's only because you are familiar with what you have to do.
> >
> > Any new contributor would be stuck with the information presented on t=
he
> > initial load, without any indication that more information _is_ availa=
ble,
> > just hidden away in the next step's log (which is marked as "succeedin=
g",
> > therefore misleading the inclined reader into thinking that this canno=
t
> > potentially contain any information pertinent to the _failure_ that ne=
eds
> > to be investigated).
>
> Yes it took we a while to realize how to get to the test output when I f=
irst
> started looking at the CI results.

Thank you for saying that. Since nobody else said it as clearly as you, I
really started to doubt myself here.

> One thing I forgot to mention was that when you expand a failing test it=
 shows
> the test script twice before the output e.g.
>
> Error: failed: t7527.35 Matrix[uc:false][fsm:true] enable fsmonitor
> failure: t7527.35 Matrix[uc:false][fsm:true] enable fsmonitor
>   				git config core.fsmonitor true &&
>   				git fsmonitor--daemon start &&
>   				git update-index --fsmonitor
>
>   expecting success of 7527.35 'Matrix[uc:false][fsm:true] enable fsmoni=
tor':
>   				git config core.fsmonitor true &&
>   				git fsmonitor--daemon start &&
>   				git update-index --fsmonitor
>
>  ++ git config core.fsmonitor true
>  ++ git fsmonitor--daemon start
>  ...
>
> I don't know how easy it would be to fix that so that we only show "expe=
cting
> success of ..." without the test being printed first

It's not _super_ easy: right now, the patch series does not touch the code
that prints the latter message. In fact, that latter message is generated
_before_ the test fails, and redirected via `tee` into
`GIT_TEST_TEE_OUTPUT_FILE`. Then, once the verdict is clear that this test
case failed, the first message is printed (the one that is colored in the
output via `::error::`), and the output from the
`GIT_TEST_TEE_OUTPUT_FILE` file is pasted, starting at the offset marking
the start of the test case.

The easiest workaround would probably to add a flag that suppresses the
header `expecting success` in case we're running with the
`--github-workflow-markup` option.

I'll put it on my ever-growing TODO list, but maybe in the interest of
heeding the mantra "the perfect is the enemy of the good", this can be
done on top of this series rather than blocking it?

Thanks,
Dscho

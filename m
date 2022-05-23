Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B50C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 19:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiEWToO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 15:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiEWTf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 15:35:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D85512756
        for <git@vger.kernel.org>; Mon, 23 May 2022 12:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653333698;
        bh=6fJlBtT6dK4dG/kmKVol6eiPx0UvOhuHMK+aVjM4pOM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=REI6SAJnoHBd1O7SgtiYM7jHo5pwCMBfuzonuhkD20gIpauruGrseq6YO0spuYl3y
         QifDLjZEWin90rSK4tKNluTBPu3qAK9Ng4zmGsvvo8yWSmonu4Z//LnsPLuBysLCrB
         fu18zKVUGcj5TvZw9OdsLUoybfmXWN3ARt9tV3aM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdNY8-1nJsnq16pM-00ZSRR; Mon, 23
 May 2022 21:21:38 +0200
Date:   Mon, 23 May 2022 21:21:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
In-Reply-To: <xmqqwnecqdti.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205232108440.352@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com> <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com> <6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com> <nycvar.QRO.7.76.6.2205212307090.352@tvgsbejvaqbjf.bet> <xmqq35h2cwrm.fsf@gitster.g>
 <xmqqee0l9mhl.fsf@gitster.g> <xmqqwnecqdti.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:calzggH0G/xwS+IHaw25+ZSvu+r8INaA6dbbiCL9K75tWVHeQc+
 zeeHkL6RjnZ2uqQ1SSvF1ql+t/aqwQTp5SnF3F2H2rPNuOvLPSYcwrj60nvh0xDDKfDs3X5
 hDqbRDt9Nbprn1TxQEEuK65lg9A3hrbwFknojDZnW4kB3ag7Fa4B1CD+GlsyYe1cscr7RNf
 12Gs4dF0X9ott0r90muaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9hLWC8Wq69Y=:xjQKfZG9RTybLuufTVlezd
 +uEdpWhsVPXS50eVN9kcevI1aLScbjDpn4RS0eFWkd9vi3cMzQ8ydzI+WQIrqv0xiPjkpSAUh
 dEAS20vrO23uruGHWA/L1vHrYQtKJ8tsh9vNMPUsgAe4Rzrkzt5v07CUkGb8miD2pd4PW/xHk
 LbKiqWah+aLPdCokiRKh8aI8gWgOx+UGS7et1IZzHf/kgQTm54jNIc8o1eVSJ0T+VbJQ3Nglj
 FWXUXvI5MkINe/cUNLgyeAFesLlFGmJNdin1mDl5IkuZ1dsOz9g6PsJNgqB1t+BEDvLKtSfqz
 MGL0Y4FtSZW6cEuLqrSsq5FDYfON2ZZrpJUe+Nx2rcqloVZjjixIXNptnqx9BdPhY2fFJiNSF
 tAv3/tz9BG9f9WOcDSBaxLBm6KoXgzZN58Q5SNZNbQHumSzm2i3mm43cUnG3S4D6idlkdYqME
 cpubZWdWxG/3uecy6S2d+LRBxDXoMQNtO7JkxQwZxv01J2fN7ShVdjq+ZzgTMFdE2jVW/IT2c
 2y9knlF+Eb3ynpEL+Rc2yYZxRLW+uiHZEJcbezh9iQj3+3oluCErsieQ/7/XZyQR9qnbRuCr5
 XRgvLi0Ypw6oaeahy90FZOoryI4dVQVTw+o3xnQ9jYtw0stw9pTvIQx/Cl3UYWdZABpbAmujc
 bQJBNxuhF3mCl1D8lFwQYr0UE7VVG+L2U/9vT8hJL7xGXAeEkJ0q5dRJhVaX9t4TqwD/VFB1a
 3UoWqR7KKcO5u8tmasVTj8sB4aAgD7p7ryOf5Rt/JXhyCZcQseVGV/2HbKTb1IuI2PRW8HAXp
 e5+/wtHFemz0+xpHiqKWTS9XwMb+8SoItrVH9e/sIDxkkeuLxnDuYH7XlchGOAc4D9lS5QYe5
 VYPgFX8tKHQsaA14AiV9QCQ+/xWHM6KfQHbfJKIHun5zXJS/07gcHz9XYoaLF72CFEHl6NI26
 pbsw0JoepoDZHDVCZVHchVmrq6Fl2PZbjYlGe7llUQVwcaU8HQO3R55tC3FmkJYha4GavI2DC
 F3dXJBfLP6Cy8Jl/RgfHhbvQ0ftoTAYBRwwheoYkpelM9/293Zk+YEzoBLHBP0k0MsPpfLkCa
 wJHggo064xsxyZ+GWu1OYcvM/AXDUOKv2Kt/ApiEjbEKZLfzrAZu30Ziw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 23 May 2022, Junio C Hamano wrote:

> [...] the test output got a lot shorter by discarding the "ok" output
> and keeping only the failures and skips.  Because the readers are mostly
> interested in seeing failures (they can download the full log if
> they want to), and this design decision probably makes sense to me.

For the record, Victoria suggested to group by file rather than by failed
test case.

However, I do speak from a lot of experience diagnosing test failures in
CI/PR runs when I say: it is frequently very helpful to have a look at one
failed test case at a time. I'd much rather suffer a minor lag while
scrolling than having to find the boundaries manually, in particular when
`test_expect_failure` test cases are present (which are reported as
"broken" in the current iteration instead of "failed").

Besides, the scroll issue is probably similar between both approaches to
grouping (and may be independent of the grouping, as you pointed out by
reporting similar issues in the current `print-test-failures` step), and
is something I hope the Actions engineers are working on.

> Common to the both approaches, folding output from each test piece
> to one line (typically "ok" but sometimes "failed" heading) may be
> the source of UI responsiveness irritation I have been observing,
> but I wonder, with the removal of all "ok" pieces, it may make sense
> not to fold anything and instead give a flat "here are the traces of
> all failed and skipped tests".

As I mentioned above, I'd rather keep the grouping by failed test case.

Obviously, the ideal way to decide would be to set up some A/B testing
with real people, but I have no way to set up anything like that.

> In any case, either implementation seems to give us a good improvement
> over what is in 'master'.

There are two things I would like to add:

- In the current iteration's summary page, you will see the failed test
  cases' titles in the errors, and they are clickable (and will get you to
  the corresponding part of the logs). I find this very convenient.

- The addition of the suggestion to look at the run's artifacts for the
  full logs might not look like a big deal, but I bet that it will help in
  particular new contributors. This was yet another great suggestion by
  Victoria.

Thanks,
Dscho


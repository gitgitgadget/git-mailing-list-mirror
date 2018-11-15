Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BAAE1F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 16:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbeKPClR (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 21:41:17 -0500
Received: from mout.gmx.net ([212.227.17.21]:44551 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbeKPClQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 21:41:16 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LfGo0-1fhP6e0pC4-00onvM; Thu, 15
 Nov 2018 17:32:32 +0100
Date:   Thu, 15 Nov 2018 17:32:15 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ga=C3=ABl_Lhez?= <gael.lhez@gmail.com>
Subject: Re: [PATCH v2 1/1] bundle: cleanup lock files on error
In-Reply-To: <20181115133749.GA26164@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1811151725310.41@tvgsbejvaqbjf.bet>
References: <pull.79.git.gitgitgadget@gmail.com> <pull.79.v2.git.gitgitgadget@gmail.com> <c88887f05a145709be9e86d56f4c1e620eb5ea89.1542209112.git.gitgitgadget@gmail.com> <CAN0heSqsjKksKnBHjffVMDEyX4A2DAY6Naw4tbBXEm+AdhOLtA@mail.gmail.com>
 <CAGZ79kZ_wrQ=OdJ6xWbL+F5RDb38YAmzc87o8A=Zb8zBywMJBQ@mail.gmail.com> <20181115043409.GA3419@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1811151354150.41@tvgsbejvaqbjf.bet> <20181115133749.GA26164@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XfP6U6oMqiRwnuUW5t+RQ7YmugCjUfEbMp/bSQHY9JgxqL6xCdd
 8Um0LSD25AM0lp575DTWhNJn1fQuQ3S5sVcc4eOVy4PHqyyzk/QYEl7uy8oFdhCL8gqbQxp
 eSZTRb0FeQMyVMiYDBic5qttudC3izJP3U0wBxXUUl3MHtS2rSQsEZfM6Cgipfw56Zcmp5d
 ZznPhi7TD+DHN5Yx9W5vA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1sqvjd7Bu/0=:X3hcZDNulwtyJavlkAx+WL
 p7b608tooimCV3t19846JyWB6JGJ07Zue4T94NWqN/TJqL+BkY5EytQf4brWgM0xUNFuLes2g
 0sy+Qn3V3M2oalhje67GS6K2GwiYokBZMStBn0NhQk12lRFzIF42cOd4BVGipcjZFjeT6FMRL
 S2ERpW0ZS+dXT5LIEQ2TjbGdhqk6p91zFVIibRd9z1uuBR57vziLN9O1yhUFVAD4W2gdKT6NM
 vAk2cE7HLfUbgPp3aDHvq4aDNBOVvPo28dQz6maCkk/X2fnijgEorz4kb3pw2CW0rwa4d7gfO
 UKr1+v5zXkyYMwNeQb1QM+xJNOEaue10OFpk0m6LcgQvZhgXAb1A1vcH1Mp/VeEjYCO9y90qD
 ZnrxIzDpfzT/EZ0Yg3lGRsIamy8oKB3SY8bC66ER5TDA/6nLLJXrF2qrQsMUTkCMlClovnF5r
 VkaWSe97D/QlDWGdtI6tNGaUyLEdLoKUIKVjhSDfrfPfCvLihF7FnaRltCRgperJ03SYHPHx9
 I6P0P1wTPO/Tr0Cnne9VGDoRb7+EHVD0HWBTD+N340nYCh+nQmzRes3sWP2SfULZd/i+6ECVg
 /jKNUPtrskpj+I++P/uBSWsfG6A8XQwSH5OiMNhZkPVS79bcnju1hofNpMl4IUXIDqREbkinL
 iv3RQESzLH7NtkKUcuceO507CNfk5jt98oRgzVG4Dbg0z3J7+zL9mgtrFKSHfDrx+LikyuM2P
 jZ+zpP2odwEnvpLalq21X9onYSVMFV5F11AAhSNVeSCP7hg4y/BZLu7QUpJPSQ3jLge+0AF5Z
 kt1/b9oLqy4keWmSjEaC7+IVnAaJqJG/wr9bXcpZNLgq4XiJtcD8dZOXp2fHjwB4kiOLqwCyK
 iRRjMGF6dAjFNoSdPa87Yzo3xnwmrFJC4wmzGoESgZmj5BBW9azV9FyDFaQrFsZduJquuyniV
 MyfVJ4HaK/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 15 Nov 2018, Jeff King wrote:

> On Thu, Nov 15, 2018 at 01:57:45PM +0100, Johannes Schindelin wrote:
> 
> > > I looked at the test to see if it would pass, but it is not even
> > > checking anything about lockfiles! It just checks that we exit 1 by
> > > returning up the callstack instead of calling die(). And of course it
> > > would not have a problem under Linux either way. But if I run something
> > > similar under strace, I see:
> > > 
> > >   $ strace ./git bundle create foobar.bundle HEAD..HEAD
> > >   [...]
> > >   openat(AT_FDCWD, "/home/peff/compile/git/foobar.bundle.lock", O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0666) = 3
> > >   [...]
> > >   close(3)                                = 0
> > >   unlink("/home/peff/compile/git/foobar.bundle.lock") = 0
> > >   exit_group(128)                         = ?
> > > 
> > > which seems right.
> > 
> > Without the fix, the added regression test fails thusly:
> > 
> > -- snip --
> > [...]
> > ++ test_expect_code 1 git bundle create foobar.bundle master..master
> > ++ want_code=1
> > ++ shift
> > ++ git bundle create foobar.bundle master..master
> > fatal: Refusing to create empty bundle.
> > warning: unable to unlink 'C:/git-sdk-64/usr/src/git/wip2/t/trash directory.t5607-clone-bundle/foobar.bundle.lock': Permission denied
> 
> Hmph. So who has it open, and why isn't the tempfile code working as
> designed?
> 
> Aha, I see the problem. We dup() the descriptor in create_bundle(). So
> the patch _is_ necessary and (fairly) correct. But the explanation
> probably ought to be something like:
> 
>   In create_bundle(), we duplicate the lockfile descriptor via dup().
>   This means that even though the lockfile code carefully calls close()
>   before unlinking the lockfile, we may still have the file open. Unix
>   systems don't care, but under Windows, this prevents the unlink
>   (causing an annoying warning and a stale lockfile).
> 
> But that also means that all of the other places we could die (e.g., in
> write_or_die) are going to have the same problem. We've fixed only one.
> Is there a way we can avoid doing the dup() in the first place?
> 
> The comment there explains that we duplicate because write_pack_data()
> will close the descriptor. Unfortunately, that's hard to change because
> it comes from run-command. But we don't actually need the descriptor
> ourselves after it's closed; we're just trying to appease the lockfile
> code; see e54c347c1c (create_bundle(): duplicate file descriptor to
> avoid closing it twice, 2015-08-10).
> 
> We just need some reasonable way of telling the lock code what's
> happening. Something like the patch below, which is a moral revert of
> e54c347c1c, but instead wrapping the "lock->fd = -1" in an official API.
> 
> Does this make your warning go away?
> 
> diff --git a/bundle.c b/bundle.c
> [...]

I cannot claim that I wrapped my head around your explanation or your diff (I am
busy trying to prepare Git for Windows' `master` for rebasing to v2.20.0-rc0),
but it does fix the problem. Thank you so much!

The line `test_expect_code 1 ...` needs to be adjusted to `test_expect_code
128`, of course, and to discern from the fixed problem (which also exits with
code 128), the error output should be verified, like so:

-- snip --
test_expect_success 'try to create a bundle with empty ref count' '
	test_must_fail git bundle create foobar.bundle master..master 2>err &&
	test_i18ngrep "Refusing to create empty bundle" err
'
-- snap --

Do you want to integrate this test into your patch and run with it, or do you
want me to shepherd your patch?

Ciao,
Dscho

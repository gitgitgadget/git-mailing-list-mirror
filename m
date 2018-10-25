Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD3901F453
	for <e@80x24.org>; Thu, 25 Oct 2018 18:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbeJZD0U (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 23:26:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:56837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbeJZD0U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 23:26:20 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTjua-1g73Yi1YK8-00QS6g; Thu, 25
 Oct 2018 20:52:12 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTjua-1g73Yi1YK8-00QS6g; Thu, 25
 Oct 2018 20:52:12 +0200
Date:   Thu, 25 Oct 2018 20:52:16 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Brendan Forster via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Brendan Forster <github@brendanforster.com>
Subject: Re: [PATCH 2/3] http: add support for disabling SSL revocation checks
 in cURL
In-Reply-To: <xmqq1s8oxbpc.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810252049210.4546@tvgsbejvaqbjf.bet>
References: <pull.46.git.gitgitgadget@gmail.com> <764791d13d20478639402e7af95e901223444240.1539598481.git.gitgitgadget@gmail.com> <xmqq1s8q34g2.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1810161225310.4546@tvgsbejvaqbjf.bet>
 <xmqq1s8oxbpc.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VizN0ZgWKCPJ4RW0qnW1wSAbL7mw6bK1Q5nafXc3c89Tb4xhAJh
 29ry0E0uN11VJToZAY044EesI6EUnTANzdpChsJLWDFSRfGhSwz592w5Xy0HaHL55g1TiqB
 GWJddbcgtqd1/SIX2zR7JkbnDNv0IIxIyJNXrsSL9mB9WaNUDk0wI6pO1Lf+fLdqEBEzqYc
 FL/cmIn88fAhuABefnvLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YNIMn2/LKro=:vnT7iEcRXI+r6bAZL8kkVr
 Tfo7JvGjMhz4cluuOGYna67rtmEUfHcmKoAg/EF28gHUZTMqGrSkLMCS3HvrxkpcZGIpfEViy
 Jm4rNx7GdOdEjxAIhVnRAjG74hWBYy4Y6u5/hsYEfPBy+eIEsnqDyJqs2r+1AXn04yJfdSijA
 N7sROoXlSOJCeLoaTJixCR0P1MAvOdI+fCIuvRGnNZ/fKd6pI0wWXMYqHwDW40eVR6TMqCS09
 AvY/XewtV5R7Gso4mEUOtw7mFKzAzRl/f5KrSSxjSpGJbD9oYzZE7I5dXfH+Fe0uH3ZJK77jd
 yzk0aHXzRHo/EcwNA6e+ssWMBqUzyuT1C01Z67UULJlzGqOU0Z5qPXIrHoU8vUQ9RCBTDmaZC
 uXGXs/ptS+4hMfEjQL5dUxWG2v71MBkG1cbpC5Ym3lxUjjfAGRzFHVtzjsiGKEXVXNg1cpckm
 RaapmDUz8jNS1PidhRR17Wgpmpv8CiTsbXUeEsv3jgybmX2D1VCZJ/jP+sdWYtwPXPNuX/EvQ
 OiwH+RQZfUs+qzNgR8PvhuBZ406ymvWQ++Z+OGeNF6UeXRFxYcYPMX62MrieyuiV+ioVQgBvu
 +AicIDaVeOUtuaTpqXblDoDJZQ6RH6r3UiboiGr/v8BlM2CuITKtTm4ryCtPSno5fxU9INXWD
 mk363GzafJzXWc+FS52cYxRaQqyRR4+RW9B+THs+XpLILqw8UCC5NHMkUQJmpPgZCMGWtGjJ/
 YjK01KXrRTyitFGxjlaOIPZnFyD1V1DNZb2LyxF+DxLrr5LK1Stmc3KBV7+XyoRLuYfr0wRfF
 Y3n9I2nTt2LjpjMN/18K6VJ1fVDo47+ZuWM4YAKi2+t6eS1ph4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 18 Oct 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> In any case, you can use "http.<url>.$variable" to say "I want the
> >> http.$variable to be in effect but only when I am talking to <url>".
> >> Does it make sense for this new variable, too?  That is, does it
> >> benefit the users to be able to do something like this?
> >> 
> >>     [http] schannelCheckRevoke = no
> >>     [http "https://microsoft.com/"] schannelCheckRevoke = yes
> >> 
> >> I am guessing that the answer is yes.
> >
> > Frankly, I do not know.  Does it hurt, though?
> 
> I did not and I do not think it would.  I was wondering if the
> ability to be able to specify these per destination is something
> very useful and deserves to be called out in the doc, together with
> ...

I do not think that it needs to be called out specifically in the docs. It
is just yet another http.* setting that can be overridden per-URL. It
would be different if it had not worked.

> >> I guess the same comment applies to the previous step, but I suspect
> >> that the code structure may not allow us to switch the SSL backend
> >> so late in the game (e.g. "when talking to microsoft, use schannel,
> >> but when talking to github, use openssl").
> 
> ... this bit.
> 
> > Crucially, this fails. The short version is: this is good! Because it
> > means that Git used the OpenSSL backend, as clearly intended.
> >
> > <skip if="uninterested in the details">
> > Why does it fail?
> > ...
> > </skip>
> 
> So there may still be some polishing needed, but as long as people
> are not using the "per destination" thing, the code is already good?
> That is something we may want to document.

Actually, just because there is a peculiar bug in this particular code
flow in Git for Windows should not necessarily be interesting to Git's
commit history.

On Linux, for example, it would work.

So I don't think we need to mention anything about that unrelated bug.

Thanks,
Dscho

> Thanks.
> 

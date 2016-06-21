Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04FFF1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 12:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbcFUMDm (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 08:03:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:61638 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537AbcFUMDl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 08:03:41 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LymHf-1bU5ZP24Wt-01668i; Tue, 21 Jun 2016 14:03:28
 +0200
Date:	Tue, 21 Jun 2016 14:03:27 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH] Make find_commit_subject() more robust
In-Reply-To: <xmqqeg7ru00i.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606211402320.22630@virtualbox>
References: <34ef85eb4e2aef0b342ef5d3bce9e468c8339486.1466255489.git.johannes.schindelin@gmx.de> <xmqqeg7ru00i.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:r88QgPsM3Gl7yA5W2aGHWWRoZq3+ZcFKO5Od+J5Ypj/Trt05+Iy
 A6TRigrwdvj5v1d5OWRwP9qCsAKUGUcVri+t2Ti9qg1Sk2R13amnQ94hPH1ulqukEzP96LW
 x/7rgWMpwkW0QL5sNKQPR8Cb+Hz73utqeJFBKNm2dfTHVu9iT//eduGsVidYmX2B5D5j/Ed
 wcOsRMh2q0I/irbzAXJ3g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Rbt2G44j5Ow=:kMEZ212rYSHBbkBaaMwq7B
 hJCIQR6fbWJqPMDAIOgmp4AX5IO7s9RpcYfE7KacsVwRGl9WvT3SRkhMxjxB2oC62ZoZNgK2r
 Lduo0UzpC4Q+46HRzyMO3tDu3kM3tPvocJObH7eHUxwtPCvr1W82MmCvn/0ztEfZ9OV9mx8x0
 GZPg0FImho7BosQJuaT4a/wP8wAxM8Ikdxct+sUX1CUbXXPd8o6zp3FQsGN2REyhnHaHolNhK
 dTkQoiMsldAthPfrZ1xdcft7FFsLlch+iqVDEAL1lUW66vqIU5FtUeStLPgptQk/s2x1g1RHX
 j+ihbBQalBurZXZOdgYBQAIowaP4RnbGg0jXDN9HKeXbF/Ykq73qz5LRvya1e+OiHV4aR6nbv
 wQNO7uQ8/G5gGmp/WGoUiuY89C3w9hMjIyDr3L7eMHQxdkd5sKWM1QiW8BkuB9Vh9UjaPbeWm
 Ii6WI2OvUyzValLx1011x8nnGYJZxMKhT8wKqg+fblFchKeuMc8hl//Scm/Z9csEzBZR0mpWF
 bSREEiDzhhx+kfcW8svbm+/58qC9qDh6+WkLHVjLvLm1/eL/HL+zck1jfpATkqUq69dgNnqIu
 FcFNiGh+RP4plIUOZQ1faGZfiss6LTiE9OodxUoiFNAvCacAC4FVrjMRNHIsAXJh6G+xYz4oK
 oVYKpv47/tSl0k6wpBrMCCTzKzsh372eSlfxPznH7gA6Bv9HAKlPZmIEPF9oHm5BBPrL5nhA6
 8GeBIG2MNF3cT1u1EV3QtSV9NRwRvIS7cfOo4DNATqSErEvcdjbbFKkurpD9YbZAKzKo54lZ2
 M1UqDHR
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 20 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Just like the pretty printing machinery, we should simply ignore empty
> > lines at the beginning of the commit messages.
> >
> > This discrepancy was noticed when an early version of the rebase--helper
> > produced commit objects with more than one empty line between the header
> > and the commit message.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > Published-As: https://github.com/dscho/git/releases/tag/leading-empty-lines-v1
> >
> > 	Aaaaand another patch from the rebase--helper front. I guess I'll
> > 	call it a day with this one.
> 
> Makes sense.  This has a trivial textual conflict with cleanup
> patches in flight, I think, but that is not a big problem.

I will gladly resend rebased to `next`, if you wish.

> It does hint that we might want to find a library function that can
> replace a hand-rolled while loop we are adding here, though ;-)

Heh. I cannot help you with that ;-)

> Perhaps cast this new behaviour in stone by adding a test?

Will do.

Ciao,
Dscho

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A30CC2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 15:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422760AbcHEP6e (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 11:58:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:50495 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759999AbcHEP6c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 11:58:32 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MJXEd-1bYjO53ZVL-0039cD; Fri, 05 Aug 2016 17:58:26
 +0200
Date:	Fri, 5 Aug 2016 17:58:25 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH] git mv: do not keep slash in `git mv dir
 non-existing-dir/`
In-Reply-To: <xmqqtwezxlf2.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608051754080.5786@virtualbox>
References: <e0415c55e9bc651e7fa9f5f7717b4f6e44eb9ce1.1470407827.git.johannes.schindelin@gmx.de> <xmqqtwezxlf2.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XeLbBAT9d+68bxYVmGmKDdzm+d6Gh6Q6x7MTjIqFlY5HJbBVPbd
 QP5wFjscV8O0wO+xDLqHxX2EvdwYFa+D1qX/kKU91FKrgugpHEDI38E47I5w3K+fTLuAnCl
 tGi1iuafOPtmKX2VIppShgJ1AuV12Ucc78k5JfGpIMBCBqMYEo8G/o8WXp8qXFWbyNcQmIZ
 jzeM6396P0QcJs1TASjRg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:7Qub8bRS2vw=:KFk6UaZHRJETIrS+DUdCYf
 7apVgIgSAf8/wEX4vIdnS9hhIziUSdL3zbaLfdTwG9ecfaKTW/sn5ZCHNE0JHyyqbxxpQcB9q
 CJMNhjleWLiqYqm43mHbV3Ys8umYDIwfsst/MauKmsVQBRvCYsS3ElZvuKMxSu1d58TTEs/4V
 ufwHqHL2Hj9H7cTTjnB77FTPmMxEbUmWBLggWCXgVludpk/df5z51sPVjAP/BF69xyMS9AcZ9
 9EuuEXxJ1RsS1JLCw9F9+O7+HE9gYtyxjI94Em/1Bc0ra+QRj5Tq1TkxakqmVtNk/7xi8IC9x
 VE6vjeG04gKWfBiPn7hPZMkaLudU35oP9+l4lKkOLUqJG1E4ovt7FMi1v9niBVSuxJRj79lHo
 NSgVtuDrKcdn3ujTc00rcyUDckjcxmzllrdfQx6fwMc7pJeldDyJx/8pEfS9shPA/baZ0pK4M
 X9rWwm3d1tzKzXJkg9t7Kb7KXSJ9WrmJeBAJGGU02qZ+3LF43hf8b0Y0tu1S2aYXmrRHuNLxS
 esRUJwCEIKaPN/47ipHjOzOJpIlRrSXvQwTAETx8vPqGoRPLY4m1jhNUQTfVkJAUifmH4oBvQ
 OCboqS7Lo32VD5ajn74fPvs3nkvfcQlWC1D4G1SY+iPWcvKbHfIpd4rNKCkBO3ei2Li+NtwEK
 7pBuchNLn9gMICNj/yB/zYHOyDf5w6aKLBxCV211Vq74kkGhMZB07ZJv8dzvzV66N/PCgAaQa
 6wCz1UosPbBn0AQl5u2h6NIJdTzd2WHwVml8+dhXeU3s+3KDLphLLItEJq12mHoUiQNttUH29
 5AzzKEH
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Fri, 5 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > When calling `rename("dir", "non-existing-dir/")` on Linux, it silently
> > succeeds, stripping the trailing slash of the second argument.
> >
> > This is all good and dandy but this behavior disagrees with the specs at
> >
> > http://pubs.opengroup.org/onlinepubs/9699919799/functions/rename.html
> >
> > that state clearly regarding the 2nd parameter (called `new`):
> >
> > 	If the `new` argument does not resolve to an existing directory
> > 	entry for a file of type directory and the `new` argument
> > 	contains at least one non- <slash> character and ends with one
> > 	or more trailing <slash> characters after all symbolic links
> > 	have been processed, `rename()` shall fail.
> 
> I agree with all of the above.  But
> 
> > Of course, we would like `git mv dir non-existing-dir/` to succeed (and
> > rename the directory "dir" to "non-existing-dir").
> 
> I do not think I want that.  When I say "mv A B/", I want it to fail
> if I made a typo for B; the trailing slash after B is an explicit
> statement "I expect B to exist and I want A to appear at B/A".

Please note that t7001 *specifically* tests for the opposite of what you
want, then ;-)

	https://github.com/git/git/blob/v2.9.2/t/t7001-mv.sh#L79-L80

> Current Git behaviour on Linux seems to allow "git mv dir no-such-dir/"
> but "dir" is renamed to "no-such-dir", which fails two expectations,
> and I think this is broken.  If Windows port does not share this
> breakage, that is a good thing.  We should fix Git behaviour on Linux
> instead, I would think.

To be precise, Git for Windows displays the same behavior as Git on Linux,
because rename("dir", "no-such-dir/") succeeds.

The breakage fixed by this here patch happens when running plain Linux Git
in "Bash on Windows" (i.e. Bash on Ubuntu on Windows, the new Linux
subsystem of Windows, allowing to run unmodified Linux binaries on Windows
without the need for a Virtual Machine).

Ciao,
Dscho

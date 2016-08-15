Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E9BF1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 14:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbcHOOHv (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 10:07:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:60772 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752881AbcHOOHa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 10:07:30 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M4nM5-1bG7hG3Hyf-00yzFB; Mon, 15 Aug 2016 16:07:23
 +0200
Date:	Mon, 15 Aug 2016 16:07:21 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] squash! diff: add --diff-line-prefix option for passing
 in a prefix
In-Reply-To: <xmqqinv3krpe.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608151519480.4924@virtualbox>
References: <5ca415f99718b1792cd0a9c31606b45d27befc48.1471164824.git.johannes.schindelin@gmx.de> <xmqqinv3krpe.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kv3nxfyhYUowGPqa17tSsWsKAAVBBj8bxarO+b07WCzSJw5/11r
 jK7/Opu+QqHZ+0cZ/dbVX/e56pZSmDCV47ZNOVohvdKYV39c/QMsQUJlj4p9rgUhlscDEOV
 mf3gFBnPUHclsR//MjErbKbLsFZOslcXStmFvluEC2Lzoje+Oz1gze1C0RCuUgdEXM3Vrud
 fdt4hNUxOARK2uU7gGGpQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:4jmTwhvjfis=:f5gMuWeTtBr7kutOJDK0EG
 adPhvczVRervl12Zs61CKwFMyQCRHTvWCUxr0AEqAbP0Pai3dDUrWig/3kz9T2wpX1r+RE37v
 aMaDhgBYdWNgFeehh/z9KQ8S64kNPr9IIDirQwoivCRapZJ7JHm8icbtgxfkkIhaXQ9dSTu9F
 xtItGM4wxkBQ1ELeUcdyTNbLmhRGamAMCuAQeFLKDgpBQDc0t44jcBD8KaDd2+DVNTwgRlNhR
 vugKUFx/QM068DziFvqS5jfBPDkptTit2ZMAwCtgQw36G6L3E8cYeZhYGmsc2/REkOCiInd8Q
 nid6c+OuTwb6pPc2RnxNdAM8BWBtOqEiT9u444tYMgL4Z6l33tVFCKtdrtVtMP4tdOZhuv8on
 Vk2CRi9rLs8tBi/fPtuyfMuMwvBt6sTd93Yao7/nRehaq3tVvTV1StcVt3Cy9zJYk4F8SOgRC
 qbqjD0J4CjKNC2LtCmG16WR4Xvf+VIJRQ2tsHJRU/uP5/F2/opZPk7QBZ24SvyV4Zmn3LXfcc
 q6VaDDSCxBSZAvCkHjdg8ZgE6B+9290bTM4McFv7KZXNy7kO0c0mUY4zbYpHdr2Mv8yJEHc/N
 cef2Ex6JRw8eJpKWAmtfBwsb7L03e2Y9QasRi2RTXhLfVPh5lodg4FaVLI0bKfO1MnXg6UF8x
 4XBs0QMUJRPStM9x4xnSsi3MwblbUurY0G8BMwMQ/1qkNb/iZTyvhR2Pdr12+SktKgJNFmc4F
 Sv8pl8tYs80l0pRt76Wxm0b+7Bkxhqnlja+A2AJATtcGSmwV0ixZ4xKUbsTlB2LTakWU7R4An
 qcnp5IU
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Sun, 14 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > -	test=$(echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g')
> > +	test=$(echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g' -e 'y/>/_/')
> 
> The existing sed scriptlet says "we cannot have slash and do not
> want to have space in filename, so we squash runs of them to a
> single underscore".  If you have more characters that you do not
> want, you should add that to the existing set instead.

No, we cannot do that. I even mentioned it in my commit message why:

	We have to take particular care not to confound the existing
	conversion of unwanted characters to underscores with the new
	substitution of '>': the existing conversion chose to collapse
	runs of multiple unwanted characters into a single underscore. If
	we allowed '>' to be collapsed, too, the file name generated from
	the command "diff [...]=-- [...]" would be identical to the one
	generated from "diff [...]=--> [...]".

And as there is exactly this case (two command-lines, differing only in
the '>' character), doing what you suggested would *break* the test since
it would now look at the wrong file.

I know that this is so because my first iteration of the patch did exactly
what you suggested.

> While you are at it, it may be sensible to add a colon to that set, too,
> no?
> 
> Something like this, perhaps?
> 
> > -	test=$(echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g')
> > +	test=$(echo "$cmd" | sed -e 's|[/ <:>][/ <:>]*|_|g')

Maybe. But what other characters are missing? Those are not the only ones
illegal on Windows: [/ \0-\x1f"*:<>?\\|] would be a more complete version
of what you suggested. Except that it is not a valid basic regex.

But is that really necessary?

I think not, for the following reasons:

- my patch was specifically designed to stop my CI from pestering me about
  a totally broken revision that cannot even be checked out (and causes
  subsequent problems because of it),

- as such, my patch was meant not to be an all-encompassing solution to
  the problem of filenames that are illegal on Windows, but really a tiny
  patch that you could apply as quickly as possible so that my CI jobs
  would stop pestering me (which they did not, because `pu` is still
  broken),

- I even meant this little patch to be so small that it can be easily
  squashed into Jacob's patch,

- I do not want to complicate regular expressions unless *really* needed
  (and you have to admit that we do not need to address any more
  characters than the '>' *right now*), as

	- regular expressions are not exactly an easy meal, so it makes
	  sense to keep them as simple as possible both for contributors'
	  as well as for maintainers' sake, and

	- when trying to come up with a super-complete solution, it is
	  really easy not only to spend waaaaay too much time on it, but
	  also to introduce bugs that are not spotted for a loooong time
	  because nothing actually exercises the newly introduced code, and

	- If It Ain't Broke, Don't Fix It.

- the broader solution must come separately, and not as a mere add-on to
  one test case: we really need to ensure that such file names do not
  enter Git's source code.

I will send my proposal to address the larger issue in a moment, in the
meantime I *beg* you to add this here patch as a quick fix to my CI woes,
either by squashing it into the indicated commit, or by appending it to
the topic branch. I do not care which one, as long as `pu` gets fixed.

Thanks,
Dscho



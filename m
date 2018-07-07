Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96FB61F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 22:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754226AbeGGWXr (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 18:23:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:60219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753758AbeGGWXq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 18:23:46 -0400
Received: from MININT-6BKU6QN ([89.204.154.202]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXIov-1fYMgr1KPV-00WGKi; Sun, 08
 Jul 2018 00:23:40 +0200
Date:   Sun, 8 Jul 2018 00:23:39 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 01/20] linear-assignment: a function to solve least-cost
 assignment problems
In-Reply-To: <nycvar.QRO.7.76.6.1807072116570.75@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1807080017160.75@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com> <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807071320110.75@tvgsbejvaqbjf.bet>
 <xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807072116570.75@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XCtbaIhIS6pNwtH/+FjeP67E893ytkJz7JWC9tujGp+JKXNMdRE
 b+hkK/c4ufJUyPV05cl3MzwrO7Xb3cwNFz6VfDlToqMDCUjTzWSBXzPiYhM5SWyY7i2guo5
 Nvpc3p2JSIVTEGX8FrlryHjjKvyGUaVbWcUuesll04fpSplTT+aLyQJ4tWtBpW4P3SPO/El
 yDDAgTNbMOjSrywE4qSgA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JyhUb75lKJA=:GZHNcy34DhAQqCIZetgdmi
 vJN7/e8OXcIHG3ZQxnkiD6dqGNlGZgZvzRSIOmmZ6yvJjnUjQ0rTNLzVFduQ/ojNeb8pb1gGq
 FMjiBapewiBzKrBW64dwuRraSRU2whL/EwUN9lggGObEuwpSHdgagR0f6HeI5G/jkpXBIVLv9
 a9t1Doy6MNGsVYtnDDvjZcxShRJvwUGpfoTZMjSINfdcp0hbtwSH1Hx0fQCPhLr1GIzVASwvg
 1zB/TjPDhE2Zol1KIHrHxEsKvcPSdzN9l4zyT+AYVUMcJbKgMWKx6bcIgETlu0rgH2iJyAQSM
 JecwEDV/ls82oIQZEZ5c2a2mK6p5FrwRu6DLgrCm3Ku3PiMTym2Ew1cJSdpevucAhaAoxWU2N
 83GcWnsXQwfiAToedL3eAuGxlt7pSoTCR+GZnWgbpGN5pYwsRvz8r8JEALpnDw3kYrI0kRjiQ
 93GfbUnhCv6qlIqjw+8nmwef/ZB/oc5cz5je8y7CIQeL8E3IIHUyywXatflIzBj2oAexTwbyb
 VN0rRSYj2siLcQNztV9upZ1V1xaiFOXrmilmnLrUJaRiqfSdlf0rXLBku8+sWvhWBD6v6dASp
 MPTjKffUaWN4usbBSEdiUdlB6rg5Gjvi/fwA7nDE33H5YTCs0EnEGX7tYrr4243VTULBH+PVP
 oJ5fldGx4f0129SITACIdMt4uD1PexEq28cfRFjsu6Dun29LC3N2yh3HC6T3HGbn/XFLH1ITS
 tjOhSgUgbyxEpL5u61yuuec06EEiZic2Oc6wSOTJBQJ5Ewf6wpIcOvyoPTmx+p5nnTVhfaBa9
 7YkE5k7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 7 Jul 2018, Johannes Schindelin wrote:

> On Sat, 7 Jul 2018, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > >> Does the "gitgitgadget" thing lie on the Date: e-mail header?
> > >
> > > No, GitGitGadget takes the literal output from `git format-patch`, as far
> > > as I can tell. So if at all, it is `format-patch` that is lying.
> > 
> > format-patch faithfully records the fact about the commit that is
> > made into the patch.  How pieces of information should (or should
> > not) be used depends on the purpose of the application that uses
> > its output.
> 
> I guess this is one of the fallouts for abusing the `format-patch|am`
> dance for `rebase--am`.

Speaking of GitGitGadget: I just encoutered a problem with your
`refs/notes/amlog` and I hope you can help me with that.

Concretely, I want GitGitGadget to be able to identify the commit that
corresponds to a given mail that contained a patch (if it ever made it
into `pu`), to automate all kinds of tedious things that I currently have
to perform manually.

And here I hit a block: I am looking for the commit corresponding to
aca087479b35cbcbd7c84c7ca3bcf556133d0548.1530274571.git.gitgitgadget@gmail.com

When I ask `git notes --ref=refs/notes/gitster-amlog show
4cec3986f017d84c8d6a2c4233d2eba4a3ffa60d` (the SHA-1 is the one
corresponding to `Message-Id: <...>` for that mail), it insists on
outputting

	5902152ab02291af4454f24a8ccaf2adddefc306

However, I cannot find that commit anywhere.

When I look for the commit in the same manual, tedious way that I want to
automate, I find that it *is* in `pu`, but as

	5cf8e064747be2026bb23be37f84f2f0b2a31781

Even curiouser: when I now ask for the commit notes for both of those
SHA-1s, I get back the correct, same Message-Id *for both of them*, which
makes me think that it was recorded correctly, but then overwritten due to
some process I don't understand.

Would you be able to shed light into this?

Thank you,
Dscho

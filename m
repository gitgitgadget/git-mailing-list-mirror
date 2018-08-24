Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC9841F404
	for <e@80x24.org>; Fri, 24 Aug 2018 16:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbeHXT4l (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 15:56:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:48361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeHXT4l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 15:56:41 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MAhWl-1g52Wo0tQ3-00BtqG; Fri, 24
 Aug 2018 18:21:13 +0200
Date:   Fri, 24 Aug 2018 18:21:12 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Pratik Karki <predatoramigo@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, sbeller@google.com,
        alban.gruin@gmail.com
Subject: Re: [PATCH 01/11] builtin rebase: support --onto
In-Reply-To: <xmqq600kheb7.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808241813420.73@tvgsbejvaqbjf.bet>
References: <20180808134830.19949-1-predatoramigo@gmail.com> <20180808134830.19949-2-predatoramigo@gmail.com> <xmqq600kheb7.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JvOpjGb2jlsNrlCponuVbDyjlJ3tBtoyjJKdNsfI2A8AZ6edfBj
 E+Y8EnPlRTLUN7YZoP0gMuSVuSkCKsG7wuE1HXNVl211hlTsVHaOGXzhHqBJJxRHebBSuP+
 Wa7yzveelHaIZYZm2ZVA1FFRV1Lg4rrWBOMDlycRpj64asknrFYQewzXuAfjd4JuIxyjCTg
 BVDxiMVMBVQR0P22omVjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J0ssiTQKxck=:bfRqPwD0T3XayvTJZeaN86
 l+CDnhOVgHARl8mGSgQCjI/dXupywsIX04zvoKQ3Y4YTJZMGAJUsvjrg6rW4v0TWKgmjaLqY6
 NLQvbCs3k/v2RDc5xJkgLzLYhNU/uB/LuU8T+KI8f4tuDH5768XefO/IrL4PWWA+9eFra8l/Y
 rn5dJJD9u5zsV7WLxc99zUVBzQEncruCggAn8EWm76K9ARKXM92/SO6dDo7deatcRdRucxtlJ
 nMBUv9GFM4ip/VFWEi7pjdhgtk3WRqRvtxAb79QDcBg9BiBM0h4bPidx2cfo6n/f276NO4HV1
 YdJRntUg0h0J4qhBImspXJVaYr7BU74NgLZFOfqUgcvgVmMDrHWGJz+A7jN4+XOgkBfazpfBF
 HJ121HBMxeqsCmw6aE2ulKMUmbo3aquOnDseCbT5bjIuKu7OMc9WpQC2IJMVYd/OO2HwXRGas
 9oaN0mEkf+TY4m/FC7ZMONKMetCiZaARyBUbGZtXTQL/DBjztnXRPa3sgYoyWOSaNncWJjIJm
 O/FGhEAdSO1422UconBT4WcfiKxkN2iG8qRSzJ8re2bvQ82APaTAEPXkTYnuyif1d8t8+9Vtf
 bulfsP2djh1u2hqfGTRa6WTSAPFZInYbrdjiYIQlNUDCR9njN5pHSHz8B2U3T4WR2gfNNeRYz
 IOYNEii9OijZC8qDO8qRh4/zsw/LP3nj46DdgF6ZMOPA7uFo+4v2EQ7UwOQXbeXpzMJ4U/dAg
 UgcjOTa7VyJ61L4L/Bt7Cu0w/vvEtTpC6yK6/KooTxl1nwFfrFYeOERsPeVJ4wFlKQbSqDmRW
 QsM/oJN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 8 Aug 2018, Junio C Hamano wrote:

> Pratik Karki <predatoramigo@gmail.com> writes:
> 
> > The `--onto` option is important, as it allows to rebase a range of
> > commits onto a different base commit (which gave the command its odd
> > name: "rebase").
> 
> Is there anything unimportant?  A rhetorical question, of course.

You might think it is a rhetorical question, but obviously it is not, as
your reaction testifies.

But certainly there are more important options and less important options!
The most important options are those that are frequently used.

> The quite casual and natural use of "to rebase" as a verb in the
> first sentence contradicts with what the parenthetical "its odd
> name" comment says.  Perhaps drop everything after "(which..."?
> 
> i.e.
> 
> 	The `--onto` option allows to rebase a range of commits onto
> 	a different base commit.  Port the support for the option to
> 	the C re-implementation.

I'd rather keep it.

Remember, a story is easier to read than a dull academic treatise. I want
to have a little bit of a personal touch when I stumble over these commit
messages again. And I know I will.

> > This commit introduces options parsing so that different options can
> > be added in future commits.
> 
> We usually do not say "This commit does X", or (worse) "I do X in
> this commit".

Oh, don't we now? ;-)

(This *was* a rhetorical question, as *I* use this tense all the time, and
unless you have quietly rewritten my commit messages without my knowledge
nor consent, the Git commit history is full of these instances.)

> Instead, order the codebase to be like so, e.g.  "Support command line
> options by adding a call to parse_options(); later commits will add more
> options by building on top." or something like that.

To be quite frank with you, I hoped for a review that would focus a teeny
tiny bit on the correctness of the code.

If you want to continue to nit-pick the commit messages, that's fine, of
course, but do understand that I am not really prepared to change a whole
lot there, unless you point out outright errors or false statements. Those
naturally need fixing.

Also, please note that I will now *definitely* focus on bug fixes, as I am
really eager to get those speed improvements into Git for Windows v2.19.0.

And I don't know whether I have said this publicly yet: I will send the
next iterations of Pratik's patch series. He is busy with exams (GSoC
really caters for US schedules, students who are in countries with very
different university schedules are a bit out of luck here), and I really
want these patches.

Ciao,
Dscho

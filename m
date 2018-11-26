Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0A5A1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 18:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeK0FOF (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 00:14:05 -0500
Received: from mout.gmx.net ([212.227.17.22]:38859 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbeK0FOF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 00:14:05 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMpYB-1gKRym43DD-008dpu; Mon, 26
 Nov 2018 19:19:08 +0100
Date:   Mon, 26 Nov 2018 19:18:52 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
cc:     Pranit Bauva <pranit.bauva@gmail.com>, tanushreetumane@gmail.com,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v16 Part II 2/8] bisect--helper: `bisect_write` shell
 function in C
In-Reply-To: <CAN0heSpaW5C_dMh7gh0ezyzACBgZ2SYXP67E_3moeKNyTvu9xg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811261918170.41@tvgsbejvaqbjf.bet>
References: <0102015f5e5ee22c-ea9c3a38-5d42-4dce-a54b-45c59768a70b-000000@eu-west-1.amazonses.com> <20171027172845.15437-1-martin.agren@gmail.com> <CAFZEwPP7dkWwRJD2ohDfnV_Phb0ga7YPZoVC920JPrQXLAGekw@mail.gmail.com> <nycvar.QRO.7.76.6.1811231111030.41@tvgsbejvaqbjf.bet>
 <CAN0heSpaW5C_dMh7gh0ezyzACBgZ2SYXP67E_3moeKNyTvu9xg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1727838089-1543256348=:41"
X-Provags-ID: V03:K1:iTPQya4soqMdADlKuQJO5WM5iHoynSUFQXrMKTnHFrd7RnG9eNq
 6cMtowYsPehmGtTbb7JBmHDeAHD5SYr7IUhVUuclsBGmv/kpksBfp6T6e5VQ2ViYr0uiHbs
 AXBe/oakdpDcqCjS0Rd7WMNUl1KKR82MX0j81TSrNuhZA2rCzB4rzedBAGHjqsDCmkFqp7v
 nAq9YCnIsv9ChFsrbcoMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nh1iQUhGf8Y=:9JkPZK+Quj8zctWNRHyJHH
 ZDqBWdRvnVOcZl3dWtkFuAb1YJ4lpYk9lJCAyynf0GT/KtxJ/n57QV0vn5H2APPCgcloYRLxy
 wXyA7MmrfA3G/MvcguYXEB7KbSqxUgDDtzGgV9Ov3PIFoupDZkstZnniT+jqIDZScVaHlR3kd
 MDOQB8pnMdVQET7TNILnxuhwRoagjwoTarozQ3fQjTIig7r0v/aKY6EH3NOvMoEukyXqxBqd2
 K9Ofgb9kEaJudOzH5lmnBdXqJl7ZY/A99XZ42PuqFtQbHewILXVIyIrFIwCpaHhRkM7Xo7ldi
 sTdaC3XzEL0WPyYJngk1MXXr29jaKPhr0ObvfxWelnpnHMsDvNH82I97cBx26p0K4cjo/rU44
 afEsx1/vy1A1y4+hr3myBx6qKQ8DgnTKWW89o6XNeXWpOZ64culsNH96EE/eSGIZFdqp5wZ3Q
 AfWGifY7ozb81QCJQMti1a+40fL7nyz9MfWF3h9QDVgoXUMWU0qgFneLPF48z/M0VzjfX88a6
 UXP250qXsEYFkMiRHD+xV/38EyKjUUji3OKeY8ZwQ0lZmZ/ZH1DhT+yefsmB62aAvvq5IbV0G
 9f+ZyDrrOh2+p7Qfp5yYMoyetFH4GWHrHck9Tr2nMiHuOEmp+zTVYQJH3jv8NWNaQGt9epFeV
 TXuXTvsPR/p9sfUNZliLYRZ1fRv6OF93VXvDG98gWKHwSSYFxdkOIctLMxjbil0uw7wcaTaHf
 Nf5pARRl9RrXuF6IDGeZfg+zcwnR62ouQ0UyeGAlblsmxCjTQ/sz0advgv/XU/gtX+COqn7u8
 U2K+G/3sUC2xhsU5LInEsrwy5DULWPWmtvkL2gYIoC17dTl/YdazJa2Kfr5Q08yCBwOgsNR40
 0Xjn00I9LktkkVZO2VPEPgANK4m0opH1XBorgE7kO/2hwbWhubq2fVkS+hi4kg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1727838089-1543256348=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Martin,

On Fri, 23 Nov 2018, Martin Ågren wrote:

> On Fri, 23 Nov 2018 at 11:13, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Mon, 30 Oct 2017, Pranit Bauva wrote:
> >
> > > On Fri, Oct 27, 2017 at 10:58 PM, Martin Ågren <martin.agren@gmail.com> wrote:
> > > > On 27 October 2017 at 17:06, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> > > >> +static void free_terms(struct bisect_terms *terms)
> > > >> +{
> > > >> +       if (!terms->term_good)
> > > >> +               free((void *) terms->term_good);
> > > >> +       if (!terms->term_bad)
> > > >> +               free((void *) terms->term_bad);
> > > >> +}
> 
> > > > You leave the pointers dangling, but you're ok for now since this is the
> > > > last thing that happens in `cmd_bisect__helper()`. Your later patches
> > > > add more users, but they're also ok, since they immediately assign new
> > > > values.
> > > >
> > > > In case you (and others) find it useful, the below is a patch I've been
> > > > sitting on for a while as part of a series to plug various memory-leaks.
> > > > `FREE_AND_NULL_CONST()` would be useful in precisely these situations.
> > >
> > > Honestly, I wouldn't be the best person to judge this.
> >
> > Git's source code implicitly assumes that any `const` pointer refers to
> > memory owned by another code path. It is therefore probably not a good
> > idea to encourage `free()`ing a `const` pointer.
> 
> Yeah, I never submitted that patch as part of a real series. I remember
> having a funky feeling about it, and whatever use-case I had for this
> macro, I managed to solve the memory leak in some other way in a
> rewrite.
> 
> Thanks for a sanity check.

I am glad you agree, and it's just fair that I contribute a sanity check
on this here list when I have benefitted so many times from the same.

Ciao,
Johannes
--8323328-1727838089-1543256348=:41--

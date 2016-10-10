Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8CEA20989
	for <e@80x24.org>; Mon, 10 Oct 2016 19:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbcJJTkS convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 10 Oct 2016 15:40:18 -0400
Received: from mail.pdinc.us ([67.90.184.27]:51574 "EHLO mail.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751307AbcJJTkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 15:40:16 -0400
Received: from black7 (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail.pdinc.us (8.14.4/8.14.4) with ESMTP id u9AJeArp005637;
        Mon, 10 Oct 2016 15:40:10 -0400
Reply-To: "Stefan Beller" <sbeller@google.com>, <git@vger.kernel.org>,
          "Ian Kelling" <ian@iankelling.org>,
          "Xiaolong Ye" <xiaolong.ye@intel.com>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "'Ian Kelling'" <ian@iankelling.org>,
        "'Xiaolong Ye'" <xiaolong.ye@intel.com>,
        "'Stefan Beller'" <sbeller@google.com>
References: <1476039798.3060702.750483225.1DE6C48B@webmail.messagingengine.com> <4B3747D8D2724E98B6AC000FE4072A09@black7> <CAGZ79kaHOBaVCsVPen-K_5LyitcDzVbjL_kAqMkYKk_fQxH4PQ@mail.gmail.com> <AB0A757A7BE241B39C8193A633C61FED@black7> <CAGZ79kb2HWmaW3XpfHRj8vcOStPoQmR_NZe7RCRhw=FnnHbZ8A@mail.gmail.com>
In-Reply-To: <CAGZ79kb2HWmaW3XpfHRj8vcOStPoQmR_NZe7RCRhw=FnnHbZ8A@mail.gmail.com>
Subject: RE: How to watch a mailing list & repo for patches which affect a certain area of code? [OT]
Date:   Mon, 10 Oct 2016 15:40:08 -0400
Organization: PD Inc
Message-ID: <52BC7ECD34B54548BE67AE3E51EC1C74@black7>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdIjKbJZDx61SatPTOiBedNrwv0IgQAArv8Q
X-MimeOLE: Produced By Microsoft MimeOLE V6.1.7601.23403
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Stefan Beller
> Sent: Monday, October 10, 2016 15:08
> 
> On Mon, Oct 10, 2016 at 11:56 AM, Jason Pyeron wrote:
> >> -----Original Message-----
> >> From: Stefan Beller
> >> Sent: Monday, October 10, 2016 14:43
> >>
> >> +cc Xiaolong Ye <xiaolong.ye@intel.com>
> >>
> >> On Sun, Oct 9, 2016 at 2:26 PM, Jason Pyeron wrote:
> >> >> -----Original Message-----
> >> >> From: Ian Kelling
> >> >> Sent: Sunday, October 09, 2016 15:03
> >> >>
> >> >> I've got patches in various projects, and I don't have
> >> time to keep up
> >> >> with the mailing list, but I'd like to help out with
> >> >> maintenance of that
> >> >> code, or the functions/files it touches. People don't cc me.
> >> >> I figure I
> >> >> could filter the list, test patches submitted, commits made,
> >> >> mentions of
> >> >> files/functions, build filters based on the code I have in
> >> >> the repo even
> >> >> if it's been moved or changed subsequently. I'm wondering
> >> what other
> >> >> people have implemented already for automation around
> >> this, or general
> >> >> thoughts. Web search is not showing me much.
> >> >>
> >> >
> >> > One thought would be to apply every patch automatically (to
> >> the branches of interest?). Then trigger on the 
> [successful] changed
> >> > code. This would simplify the logic to working on the
> >> source only and not parsing the emails.
> >> >
> >> > -Jason
> >> >
> >>
> >> I think this is currently attempted by some kernel people.
> >> However it is very hard to tell where to apply a patch, as it
> >
> > This is one of the reasons why I use bundles instead of 
> format patch.
> 
> Oh! That sounds interesting for solving the problem where to apply
> a change, but the big disadvantage of bundles to patches is 
> the inability
> to just comment on it with an inline response. 

Yep. It is a big one. I have a personal project to add a footer to a format patch with the missing "binary" data. The thoughts were for the main cases using a RLE bitmap for the whitespace in the above patch and the remainder of the commit blob data. This would allow minimal duplicate information in the email but pure text changes would be binary perfect so the commit id will still be correct.

Sigh, never have enough free time.

> So I assume you follow
> a different workflow than git or the kernel do. Which project 
> do you use it
> for and do you have some documentation/blog that explains 
> that workflow?

This is used when collaborating cross enterprise. In these situations enterprise A will not give access to enterprise B on their CI system, or git repo, etc...

We all have a mailing list in common (encrypted/signed emails when it contains sensitive info). The rules prevent us from using cloud solutions for almost all of our work.

I have also worked on git for cross domain (tin foil hat time) source code transfer.

As to a blog, never thought about it. Ask questions on the list and I will help.

> 
> 
> >
> >> is not formalized.
> >> See the series that was merged at 72ce3ff7b51c
> >> ('xy/format-patch-base'),
> >> which adds a footer to the patch, that tells you where
> >> exactly a patch ought
> >> to be applied.
> >
> > Cant wait for that.
> 
> Well it is found in 2.9 and later. Currently the base footer is
> opt-in, e.g. you'd
> need to convince people to run `git config format.useAutoBase 
> true` or to
> manually add the base to the patch via `format-patch --base=<commit>`.

Please make default in 2.10.2 .

> 
> >
> >>
> >> The intention behind that series was to have some CI 
> system hooked up
> >> and report failures to the mailing list as well IIUC. Maybe
> >> that helps with
> >> your use case, too?
> >
> > I envisioned that it would try for each head he was interested in.
> >
> 
> Well the test system can be smart enough to differentiate between:

For the OP's case 

Test 1: does it cleanly apply to any head, if no for all raise flag.

> * the patch you sent did not even compile on your base, so why
>    are you sending bogus patches?

Test 2: is it in an area I care about, if not stop.

Test 3: does it compile for clean application, if no for all raise flag.

> * the patch you sent was fine as you sent it, but in the mean time
>   the target head progressed, and it doesn't compile/test any more.
>   collaboration is hard.

Yes, especially when you have no time, or management is in the way.

> * or an extension to the prior point: this patch is fine but is broken
>   by the series xyz that is also in flight, please coordinate with
>   name@email.


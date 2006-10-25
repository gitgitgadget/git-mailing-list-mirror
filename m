X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: David Lang <dlang@digitalinsight.com>
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 15:40:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0610251459160.1754@qynat.qvtvafvgr.pbz>
References: <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com> 
 <87zmbozau2.wl%cworth@cworth.org> <20061022185350.GW75501@over-yonder.net>
  <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>  <20061023222131.GB17019@over-yonder.net>
  <Pine.LNX.4.64.0610231534010.3962@g5.osdl.org>  <20061024002622.GC17019@over-yonder.net>
  <Pine.LNX.4.63.0610240853160.10841@qynat.qvtvafvgr.pbz> 
 <20061024163458.GH17019@over-yonder.net>  <Pine.LNX.4.63.0610241038060.10841@qynat.qvtvafvgr.pbz>
 <20061025002713.GN17019@over-yonder.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
NNTP-Posting-Date: Wed, 25 Oct 2006 22:41:57 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <20061025002713.GN17019@over-yonder.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30114>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcrRK-0001RY-LN for gcvg-git@gmane.org; Thu, 26 Oct
 2006 00:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965170AbWJYWlf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 18:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbWJYWlf
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 18:41:35 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:11741 "HELO
 warden.diginsite.com") by vger.kernel.org with SMTP id S965170AbWJYWlf (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 18:41:35 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com via smtpd (for
 vger.kernel.org [209.132.176.167]) with SMTP; Wed, 25 Oct 2006 15:41:34 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by
 wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Wed, 25
 Oct 2006 15:41:19 -0700
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
Sender: git-owner@vger.kernel.org

On Tue, 24 Oct 2006, Matthew D. Fuller wrote:

> On Tue, Oct 24, 2006 at 11:03:20AM -0700 I heard the voice of
> David Lang, and lo! it spake thus:
>>
>> it sounded like you were saying that the way to get the slices of
>> the DAG was to use branches in bzr. [...]
>
> I'm not entirely sure I understand what you mean here, but I think
> you're saying "Nobody's written the code in bzr to show arbitrary
> slices of the DAG", which is true TTBOMK.

I think we are talking past each other here.

what I think was said was

G 'one feature of git is that you can view arbatrary slices trivially'

B 'bzr can do this too, you just use branches to define the slices'

G 'but this limits you becouse branches are defined as code is developed, git 
lets you define slices at viewing time'

by the way, I think it's more then just saying 'well, the code could be written 
to do this in $VCS' some decisions and standard ways of doing things can impact 
how hard it is to implement a feature, and some decisions can make it 
impossible (without doing unexpected things).

>
>> everyone agrees that bzr supports the Star topology. Most people
>> (including bzr people) seem to agree that currently bzr does not
>> support the Distributed topology.
>
> I think this statement arouses so much grumbling because (a) bzr does
> support such a lot better than often seems implied, (b) where it
> doesn't, the changes needed to do so are relatively minor (often
> merely cosmetic), and (c) disagreement over whether some of the
> qualifications included for 'distributed' are really fundamental.
>
>
>> it's just fine for bzr to not support all possible topologies,
>
> I think there's a real intent for bzr TO support at least all common
> topologies.  I'll buy that current development has focused more on
> [relatively] simple topologies than the more wildly complex ones.  I
> look forward to more addressing of the less common cases as the tool
> matures, and I think a lot of this thread will be good material to
> work with as that happens.  It's just the suggestion that providing
> fruit for simple topologies _necessarily_ prejudices against complex
> ones that I find so onerous.

one concern that the git people are voicing is that the things that work for 
simple topologies (revno's) can't be used with the more complex ones (where you 
need the refid's). especially the fact that users need to do things 
significantly different when there are fairly subtle changes to the topology.

the scenerio that came up elsewhere today where you have

    Master
    /    \
dev1   dev2

and then dev1 and dev2 both start working on the same thing (without knowing 
it), then discover they are working on the same thing. they now have threeB 
options

1. merge their stuff up to the master so that they can both pull it down.
   but this puts broken, experimental stuff up in the master

2. declare one of the dev trees to be the master

this changes the topology to

Master--dev1--dev2

3. pull from each other frequently to keep in sync.

this changes the topology to

    Master
    /   \
dev1--dev2

if they do this with bzr then the revno's break, they each get extra commits 
showing up (so they can never show the same history).

in git this is a non-issue, they can pull back and forth and the only new 
history to show up will be changes.

this is the situation that the kernel developers are in frequently. it sounds as 
if you haven't needed to do this yet, so you haven't encountered the problems.

David Lang

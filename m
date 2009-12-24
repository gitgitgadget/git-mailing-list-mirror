From: David Greaves <david@dgreaves.com>
Subject: Re: elegant(?) debian topgit workflow?
Date: Thu, 24 Dec 2009 16:34:10 +0000
Message-ID: <4B339802.7040003@dgreaves.com>
References: <200912161113.38396.thomas@koch.ro> <94a0d4530912240714y798085d8r3bf88011e8ec782b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: thomas@koch.ro, debian-devel@lists.debian.org, git@vger.kernel.org, 
 vcs-pkg-discuss@lists.alioth.debian.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: bounce-debian-devel=debian-devel=m.gmane.org@lists.debian.org Thu Dec 24 17:51:20 2009
Return-path: <bounce-debian-devel=debian-devel=m.gmane.org@lists.debian.org>
Envelope-to: debian-devel@m.gmane.org
Received: from liszt.debian.org ([82.195.75.100])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNqu7-0006RO-AV
	for debian-devel@m.gmane.org; Thu, 24 Dec 2009 17:51:11 +0100
Received: from localhost (localhost [127.0.0.1])
	by liszt.debian.org (Postfix) with QMQP
	id 8173013A6CAA; Thu, 24 Dec 2009 16:51:08 +0000 (UTC)
Old-Return-Path: <david@dgreaves.com>
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on liszt.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=4.0 tests=LDO_WHITELIST,
	MURPHY_DRUGS_REL8 autolearn=failed version=3.2.5
X-Original-To: lists-debian-devel@liszt.debian.org
Delivered-To: lists-debian-devel@liszt.debian.org
Received: from localhost (localhost [127.0.0.1])
	by liszt.debian.org (Postfix) with ESMTP id AE6EB2D0D65
	for <lists-debian-devel@liszt.debian.org>; Thu, 24 Dec 2009 16:34:22 +0000 (UTC)
X-Virus-Scanned: at lists.debian.org with policy bank en-ht
X-Amavis-Spam-Status: No, score=-6.98 tagged_above=-10000 required=5.3
	tests=[BAYES_00=-2, LDO_WHITELIST=-5, MURPHY_DRUGS_REL8=0.02]
	autolearn=ham
Received: from liszt.debian.org ([127.0.0.1])
	by localhost (lists.debian.org [127.0.0.1]) (amavisd-new, port 2525)
	with ESMTP id gl6pR+e2IfIY for <lists-debian-devel@liszt.debian.org>;
	Thu, 24 Dec 2009 16:34:15 +0000 (UTC)
X-policyd-weight: DYN_NJABL=SKIP(0) NOT_IN_SBL_XBL_SPAMHAUS=-1.5 NOT_IN_BL_NJABL=-1.5 DSBL_ORG=SKIP(0) CL_IP_EQ_FROM_MX=-3.1; rate: -6.1
Received: from mail.ukfsn.org (mail.ukfsn.org [77.75.108.10])
	by liszt.debian.org (Postfix) with ESMTP id 4C0252D0D20
	for <debian-devel@lists.debian.org>; Thu, 24 Dec 2009 16:34:14 +0000 (UTC)
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id 283BDDEFBE;
	Thu, 24 Dec 2009 16:34:12 +0000 (GMT)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id N0AL0iWlkoG4; Thu, 24 Dec 2009 16:34:11 +0000 (GMT)
Received: from elm.dgreaves.com (unknown [78.32.229.233])
	by mail.ukfsn.org (Postfix) with ESMTP id E8F2FDEC8F;
	Thu, 24 Dec 2009 16:34:11 +0000 (GMT)
Received: from ash.dgreaves.com ([10.0.0.111])
	by elm.dgreaves.com with esmtp (Exim 4.69)
	(envelope-from <david@dgreaves.com>)
	id 1NNqdf-0004fJ-B0; Thu, 24 Dec 2009 16:34:11 +0000
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090701)
In-Reply-To: <94a0d4530912240714y798085d8r3bf88011e8ec782b@mail.gmail.com>
X-Enigmail-Version: 0.95.0
X-Rc-Spam: 2008-11-04_01
X-Rc-Virus: 2007-09-13_01
X-Rc-Spam: 2008-11-04_01
Resent-Message-ID: <MqGIYf3aGhJ.A.aMD.8v5MLB@liszt>
Resent-From: debian-devel@lists.debian.org
X-Mailing-List: <debian-devel@lists.debian.org> archive/latest/258235
X-Loop: debian-devel@lists.debian.org
List-Id: <debian-devel.lists.debian.org>
List-Post: <mailto:debian-devel@lists.debian.org>
List-Help: <mailto:debian-devel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-devel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-devel-request@lists.debian.org?subject=unsubscribe>
Precedence: list
Resent-Sender: debian-devel-request@lists.debian.org
Resent-Date: Thu, 24 Dec 2009 16:51:08 +0000 (UTC)

Felipe Contreras wrote:
> On Wed, Dec 16, 2009 at 12:13 PM, Thomas Koch <thomas@koch.ro> wrote:
>> branches
>> --------
>>
>> upstream
> 
> I would call it 'master'. That's how upstream would call it.
> 
>> debian/*, fixes/*, features/* - topgit branches based on upstream
>> patches - the hero
>> master - contains the debian/ dir and is the branch we build from
> 
> Think about other systems, like Ubuntu and Maemo, it would be nice to
> have branches both for Maemo and Debian on the same repo:
> debian - what you call 'master'
> debian-patches - what you call 'patches'
> maemo5 - contains the debian/ dir, but for Maemo 5
> maemo5-patches - patches for Maemo 5, might be based on top of debian-patches

I've been touting for feedback on this for a while :)

http://wiki.maemo.org/Mer/Build/UsingGitorious

David

-- 
"Don't worry, you'll be fine; I saw it work in a cartoon once..."

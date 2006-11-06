X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: git bug? + question
Date: Mon, 06 Nov 2006 12:32:27 +0000
Message-ID: <454F2B5B.8090405@shadowen.org>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <200611041852.23867.Josef.Weidendorfer@gmx.de> <454F0636.1060406@shadowen.org> <200611061200.08972.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 6 Nov 2006 12:33:14 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, Sean <seanlkml@sympatico.ca>,
	Junio C Hamano <junkio@cox.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org,
	=?ISO-8859-1?Q?Karl_?= =?ISO-8859-1?Q?Hasselstr=F6m?= 
	<kha@treskal.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
In-Reply-To: <200611061200.08972.Josef.Weidendorfer@gmx.de>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31009>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh3el-0005aF-I1 for gcvg-git@gmane.org; Mon, 06 Nov
 2006 13:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752908AbWKFMct (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 07:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752910AbWKFMct
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 07:32:49 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:41738 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1752902AbWKFMcs
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 07:32:48 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1Gh3do-0005qk-HM; Mon, 06 Nov 2006 12:31:52 +0000
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer wrote:
> On Monday 06 November 2006 10:53, Andy Whitcroft wrote:
>> Josef Weidendorfer wrote:
>>> On Saturday 04 November 2006 06:03, Shawn Pearce wrote:
>>>> After reading your reply you are probably correct.  I can see there
>>>> may be workflows that want every remote branch also created as a
>>>> local branch.
>>>>
>>>> I could certainly live with a command line option to clone, e.g.:
>>>>
>>>> 	git clone --only vmdvt,vmtip user@host:/path...
>>> Still missing here: What branch should be checked out after
>>> cloning?
>> Does any need to be checked out?
> 
> We should not change existing behavior. IMHO, checking out a branch is
> mostly the right thing to do. Of course, you often want to specify which one.
> The current requirement for a master branch in the origin repository
> is really bad, as it obviously requires ugly workarounds in some cases
> (and totally confuse newbies in such use cases).

We are not changing existing behaviour, if we do not check anything out
only when specifying '--only'.
> 
>> Or perhap I should put it another way, 
>> when we make a virgin repository we default to master checked out but
>> its not joined to the DAG.
> 
> I do not understand this. By creating a local branch, the commit DAG
> is never changed.

In a virgin repository there is no DAG to speak of and master doesn't
really point anywhere until the first commit.  I was proposing that when
--only is specified, we just leave things as they are.  The master half
pointing into the zero element DAG we have in an entirely empty repo.
The new unconnected DAG or DAG's we have downloaded in the clone will be
attached to their respective branch names.


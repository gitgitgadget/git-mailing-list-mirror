From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: clarify git clone --local --shared --reference
Date: Wed, 13 Jun 2007 18:07:29 -0500
Message-ID: <467078B1.8080104@nrlssc.navy.mil>
References: <4664A5FE.30208@nrlssc.navy.mil> <20070605045008.GC9513@spearce.org> <46658F98.6020001@nrlssc.navy.mil> <20070606051111.GF9513@spearce.org> <466701E0.4000108@nrlssc.navy.mil> <20070608053750.GB18521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 01:07:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HybwD-0004Ex-D5
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 01:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755697AbXFMXHj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 19:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755857AbXFMXHj
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 19:07:39 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34109 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755697AbXFMXHi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 19:07:38 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l5DN4peI030079;
	Wed, 13 Jun 2007 18:04:54 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Jun 2007 18:07:30 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <20070608053750.GB18521@spearce.org>
X-OriginalArrivalTime: 13 Jun 2007 23:07:30.0019 (UTC) FILETIME=[9DE60B30:01C7AE0F]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15234001
X-TM-AS-Result: : Yes--8.291500-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY2OC0xNTA2?=
	=?us-ascii?B?NzMtMTQ3MDE4LTcwMjU3Mi03MDAwNzUtMTM5MDEwLTcwMDE2MC03?=
	=?us-ascii?B?MDAwNDAtNzA0OTI3LTcwMTU3Ni03MDYxNTAtNzAxMTYzLTcwNDQ5?=
	=?us-ascii?B?Ni03MTE5NTMtNzAxNDU1LTcwNjQ1NC03MDQ0MjUtNzAzNzg4LTcw?=
	=?us-ascii?B?NDQzMC03MDEyOTgtNzA5NTg0LTcwMTE2Mi03MDM3MTItNzAwMTA3?=
	=?us-ascii?B?LTE0ODA1MS0yMDA0Mg==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50144>

Shawn O. Pearce wrote:
> Brandon Casey <casey@nrlssc.navy.mil> wrote:

>> The docs (git-repack.txt) seem to suggest that git-repack (without -d) 
>> does not delete any objects. And if -d is used, then at most objects 
>> already referenced in other packs will be deleted. This makes me think 
>> that repack is safe on the source repository.
> 
> You are correct that leaving off the '-d' won't delete objects.
> But a pack is created by listing the objects we need, and if we don't
> need the object in source, we don't include it into the new pack.
> 
> -a -d implies delete all packs that existed when we started the
> repack.  So if an object was in the old packfile, and we didn't
> copy it to the new packfile, it gets deleted.  ;-)

Ok. There is the connection I did not make. repack -d is NOT harmless, 
since a pack that contains only objects referenced in other packs and 
dangling unreferenced objects, will be deleted. Which will be all of the 
preexisting packs in the case of git-gc since as you mentioned it 
repacks using -a -d -l.

Thanks for taking the time.

-brandon

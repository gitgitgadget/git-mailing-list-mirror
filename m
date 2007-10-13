From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: Imports without Tariffs
Date: Sat, 13 Oct 2007 19:04:52 -0400
Message-ID: <814D00AE-B89A-45ED-A500-4643C825D0EB@mit.edu>
References: <30817A88-4313-4D38-95B0-FEC47C651CB0@mit.edu> <20071013040712.GA27227@coredump.intra.peff.net> <1240801C-F4CC-4290-8C3D-2038F1957DF3@MIT.EDU> <20071013075723.GA27533@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 01:06:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igq2v-0007jU-HR
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 01:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbXJMXFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 19:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753986AbXJMXFG
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 19:05:06 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:42574 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751639AbXJMXFF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Oct 2007 19:05:05 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9DN4wcr014260;
	Sat, 13 Oct 2007 19:04:58 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9DN4vKi018728
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 13 Oct 2007 19:04:57 -0400 (EDT)
In-Reply-To: <20071013075723.GA27533@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60785>


On 13 Oct 2007, at 3:57:23 AM, Jeff King wrote:

> On Sat, Oct 13, 2007 at 12:30:09AM -0400, Michael Witten wrote:
>
>>> except that git-rebase is smart enough to realize that C == C'  
>>> and skip
>>> it (so it's a "safe" way of moving forward).
>>
>> This is good to know! The documentation should mention this case!
>
> Yes, it probably should. Can you submit a patch describing the  
> behavior
> where you think it ought to go?

I can make a patch, but at the moment I'm swamped and I don't want to  
think
about doing that.

I'll get around to it eventually, I hope.

Do I just submit the patch to this list? How do I know it will be used?

>> Basically, the imported cvs history should be treated like
>> a remote that's being tracked. It seems like the solution
>> I proposed kind of does this and would work for other SCM
>> imports too.
>
> I think it's an interesting avenue to pursue, though I would worry a
> little about robustness. I like the fact that after rebasing, the
> commits have done a complete git->cvs->git loop and look identical

Frankly, I don't know how robust my idea is either, but it's simple
enough not to have many problems lurking in the shadows.

It would certainly be more useful than not.

> As an alternate idea, why not try to have the CVS commit contain all
> information necessary to create a particular git commit. IOW, describe
> all of the data that goes into the commit hash as textual comments in
> the CVS commit (committer name/time, author name/time). And then
> theoretically git-cvsimport can reconstruct the exact same commits
> again, and your git->cvs->git merge really _will_ be a fastforward.

I considered this too, but this exposes what we're doing. We don't
want the old farts to wonder what all these hash thingies are.

Michael Witten

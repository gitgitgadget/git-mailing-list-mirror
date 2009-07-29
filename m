From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH v3] Demonstrate bugs when a directory is replaced with a
 symlink
Date: Thu, 30 Jul 2009 01:01:40 +0200
Organization: private
Message-ID: <86prbjm6uj.fsf@broadpark.no>
References: <1248819198-13921-1-git-send-email-james.e.pickens@intel.com>
 <1248819198-13921-2-git-send-email-james.e.pickens@intel.com>
 <4A70062A.4040008@drmicha.warpmail.net>
 <7v4osvyjl2.fsf@alter.siamese.dyndns.org>
 <3BA20DF9B35F384F8B7395B001EC3FB342402AD9@azsmsx507.amr.corp.intel.com>
 <7v63dbuyru.fsf@alter.siamese.dyndns.org>
 <3BA20DF9B35F384F8B7395B001EC3FB342402D3C@azsmsx507.amr.corp.intel.com>
 <alpine.LFD.2.01.0907291440480.3161@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Pickens, James E" <james.e.pickens@intel.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 30 01:03:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWIBD-0008FC-UP
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 01:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbZG2XDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 19:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbZG2XDV
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 19:03:21 -0400
Received: from bgo1smout1.broadpark.no ([217.13.4.94]:55832 "EHLO
	bgo1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbZG2XDU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 19:03:20 -0400
Received: from bgo1sminn1.broadpark.no ([217.13.4.93])
 by bgo1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KNK0098PG1GQ940@bgo1smout1.broadpark.no> for
 git@vger.kernel.org; Thu, 30 Jul 2009 01:03:16 +0200 (CEST)
Received: from localhost ([80.203.106.16]) by bgo1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KNK007ZIG1FM7J0@bgo1sminn1.broadpark.no> for
 git@vger.kernel.org; Thu, 30 Jul 2009 01:03:16 +0200 (CEST)
In-reply-to: <alpine.LFD.2.01.0907291440480.3161@localhost.localdomain>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124408>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 29 Jul 2009, Pickens, James E wrote:
>>
>> This test creates two directories, a/b and a/b-2, then replaces a/b with
>> a symlink to a/b-2, then merges that change into the 'baseline' commit,
>> which contains an unrelated change.
>
> Great tests.
>
> This patch should fix the 'checkout' issue.
>
> I made it use a new generic helper function ("check_path()"), since there 
> are other cases like this that use just 'lstat()', and I bet we want to 
> change that.
>
> The 'merge' issue is different, though: it's not due to a blind 'lstat()', 
> but due to a blind 'unlink()' done by 'remove_path()'. I think 
> 'remove_path()' should be taught to look for symlinks, and remove just the 
> symlink - but that's a bit more work, especially since the symlink cache 
> doesn't seem to expose any way to get the "what is the first symlink path" 
> information.
>
> Kjetil, can you look at that? 

  Yes, I will take a look.  Also, on all the other mails CC'ed to me
  today. Give me a cople of days.

  Sorry, I do not work at "full normal speed" for the moment.  But, I
  will try to my best.

  -- kjetil

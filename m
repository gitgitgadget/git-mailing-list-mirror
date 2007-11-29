From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: problem with git detecting proper renames
Date: Thu, 29 Nov 2007 13:32:47 -0600
Message-ID: <AE325F31-6EDD-4A79-B5EF-5F1D4EBCDBDB@kernel.crashing.org>
References: <Pine.LNX.4.64.0711291050440.1711@blarg.am.freescale.net> <alpine.LFD.0.9999.0711290934260.8458@woody.linux-foundation.org> <28BD703B-24D3-41D6-8360-240A884B1305@kernel.crashing.org> <alpine.LFD.0.9999.0711291122050.8458@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 20:33:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixp8K-0005Li-GI
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 20:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbXK2Tcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 14:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761136AbXK2Tcx
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 14:32:53 -0500
Received: from gate.crashing.org ([63.228.1.57]:54398 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758001AbXK2Tcw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 14:32:52 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id lATJWlLf001381;
	Thu, 29 Nov 2007 13:32:48 -0600
In-Reply-To: <alpine.LFD.0.9999.0711291122050.8458@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66555>


On Nov 29, 2007, at 1:27 PM, Linus Torvalds wrote:

>
>
> On Thu, 29 Nov 2007, Kumar Gala wrote:
>>
>> In the case of multiple identical matches can we look at the file  
>> name as a
>> possible heuristic?
>
> We already do. But we only do the base-name part and check it for
> exactness, since moving across directories is very common, and we
> explicitly want to pick up files that have the same base name.
>
> However, in your case, not only did you have the same content, you  
> had the
> same basename too! So git considered your renames to be totally  
> identical
> wrt scoring with the current heuristics, and just picked one source at
> random.
>
> And the current heuristics don't even have any "if you already found a
> rename, avoid picking the same one twice", so it would pick the *same*
> source both times, which is why it looked like "two copies and one
> delete".
>
> This is why I'd like to have a real-life example. I can change the
> heuristics, and I even know what are likely to be better heuristics,  
> but I
> still want to actually see and play with an example so that when I  
> send
> Junio a patch, I can explain it and say I've tested it with something
> real..

Ok, this is a real example from the u-boot tree.  If you give me a  
little while I can point you at a kernel.org git tree that showed this  
issue.

- k

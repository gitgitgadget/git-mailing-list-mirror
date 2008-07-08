From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current branch
Date: Tue, 8 Jul 2008 10:32:28 -0400
Message-ID: <D66F511D-CDBE-4261-AA28-07ED73F6C593@silverinsanity.com>
References: <1215379370-34265-1-git-send-email-benji@silverinsanity.com> <7v7iby9ucx.fsf@gitster.siamese.dyndns.org> <803A3528-2451-4C5D-A48D-5E0C37B8E90E@silverinsanity.com> <7vbq1a8ay3.fsf@gitster.siamese.dyndns.org> <20080707111803.GF31490@mit.edu> <m34p71gbuk.fsf@localhost.localdomain> <F0AD23BC-FA9A-4593-8942-228C428B661E@silverinsanity.com> <20080708042607.GC7186@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 08 16:33:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGEG2-0006Fp-IW
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 16:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbYGHOcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 10:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753240AbYGHOcb
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 10:32:31 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:46793 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbYGHOcb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 10:32:31 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id D6E861FFC023;
	Tue,  8 Jul 2008 14:32:26 +0000 (UTC)
In-Reply-To: <20080708042607.GC7186@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87766>


On Jul 8, 2008, at 12:26 AM, Jeff King wrote:

> On Mon, Jul 07, 2008 at 11:03:46AM -0400, Brian Gernhardt wrote:
>
>> I personally expected @{1} to be identical to HEAD@{1}.  Since  
>> omitting a
>> ref usually refers to HEAD, why shouldn't omitting it when  
>> referring to
>> the reflogs mean the HEAD log?  The definition of @{1} is useful  
>> since
>> there's no other easy way to get "current branch's reflog", but I  
>> think
>> it's non-obvious.  (Since HEAD@{1} is something completely  
>> different, I
>> think the only other way to refer to @{1} is $(git symbolic- 
>> ref)@{1}.)
>
> FYI, there was much discussion about this exact point:
>
>  http://thread.gmane.org/gmane.comp.version-control.git/38379
>
> (I don't know that it has that much bearing on the current discussion,
> but since I went to the trouble of digging it up, I thought you might
> find it useful).

Oh, it is useful.  And, thinking about it, I agree completely.  The  
syntax isn't immediately obvious, but clear and useful.  The need to  
distinguish between HEAD@{} and $branch@{} is apparent after a  
moment's reflection, and the chosen solution is fairly obvious at that  
point.  I just never took that moment in my day-to-day working with git.

There's even documentation for it that is clear and understandable.   
If I was a new user to git, I would have read the documentation and  
found it.  Having used git for a while, I don't bother to look things  
up and instead try to alter git to match my three years of  
experience.  ;-)

That said, I still want clear and consistent semantics for ORIG_HEAD.   
And since that now (IMNSHO) exists in next, I'm happy.

~~ Brian

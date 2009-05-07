From: david@lang.hm
Subject: RE:
Date: Thu, 7 May 2009 16:31:09 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0905071629230.15782@asgard>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain> <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
 <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain> <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain> <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain> <alpine.DEB.1.10.0905071521130.15782@asgard> <alpine.LFD.2.01.0905071531030.4983@localhost.localdomain>
 <alpine.DEB.1.10.0905071543120.15782@asgard> <alpine.LFD.2.01.0905071553570.4983@localhost.localdomain> <alpine.DEB.1.10.0905071607080.15782@asgard> <alpine.LFD.2.01.0905071613130.4983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Bevan Watkiss <bevan.watkiss@cloakware.com>,
	"'Alex Riesen'" <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 08 01:32:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2D5D-0005zF-Dx
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 01:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810AbZEGXcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 19:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752217AbZEGXcV
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 19:32:21 -0400
Received: from mail.lang.hm ([64.81.33.126]:32906 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284AbZEGXcU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 19:32:20 -0400
Received: from asgard.local (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n47NV99f025494;
	Thu, 7 May 2009 16:31:09 -0700
X-X-Sender: dlang@asgard
In-Reply-To: <alpine.LFD.2.01.0905071613130.4983@localhost.localdomain>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118540>

On Thu, 7 May 2009, Linus Torvalds wrote:

> On Thu, 7 May 2009, david@lang.hm wrote:
>>
>> what about a reset --hard? (is there any command that would force the files to
>> be re-written, no matter what git thinks is already there)
>
> No, not "git reset --hard" either, I think. Git very much tries to avoid
> rewriting files, and if you've told it that file contents are stable, it
> will believe you.
>
> In fact, I think people used CE_VALID explicitly for the missing parts of
> "partial checkouts", so if we'd suddenly start writing files despite them
> being marked as ok in the tree, I think we'd have broken that part.
>
> (Although again - I'm not sure who would use CE_VALID and friends).
>
> If you want to force everything to be rewritten, you should just remove
> the index (or remove the specific entries in it if you want to do it just
> to a particular file) and then do a "git checkout" to re-read and
> re-populate the tree.
>
> But I'm not really seeing why you want to do this. If you told git that it
> shouldn't care about the working tree, why do you now want it do care?

to be able to manually recover from the case where someone did things that 
they weren't supposed to

removing the index and doing a checkout would be a reasonable thing to do 
(at least conceptually), I will admit that I don't remember ever seeing a 
command (or discussion of one) that would let me do that.

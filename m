From: Joe Fiorini <joe@faithfulgeek.org>
Subject: Re: Undo git-rm without commit?
Date: Wed, 26 Mar 2008 02:38:42 -0400
Message-ID: <0535D2B4-0C4A-40D0-879A-7E0C5B3B48E4@faithfulgeek.org>
References: <D6386C1A-92D3-4E11-8DE6-CC7553211A33@faithfulgeek.org> <20080326062635.GC26286@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 07:41:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JePK2-0004iI-L2
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 07:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbYCZGk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 02:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbYCZGk3
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 02:40:29 -0400
Received: from mail-out1.fuse.net ([216.68.8.175]:55938 "EHLO
	mail-out1.fuse.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbYCZGk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 02:40:29 -0400
X-CNFS-Analysis: v=1.0 c=1 a=HRlTNrPiG5T7XV-NfsUA:9 a=CEjlzc9nF8EFwuOjuV4A:7 a=mA6n0zgqU_nGbn6hRm5vP_gioIYA:4 a=WN8zLioqDSwA:10
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Authentication-Results: gwout1 smtp.user=jfiorini@zoomtown.com; auth=pass (LOGIN)
Received: from [66.93.11.195] ([66.93.11.195:65282] helo=[192.168.1.33])
	by mail-out1.fuse.net (ecelerity 2.1.1.22 r(17669)) with ESMTPA
	id 15/76-08390-27FE9E74 for <peff@peff.net>; Wed, 26 Mar 2008 02:38:43 -0400
In-Reply-To: <20080326062635.GC26286@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78266>

Yeah, it warned me, I wasn't being careful enough.  I guess I didn't  
think it would remove from the working tree, just the repository.  My  
err for not reading the docs until _after_ the mistake.  Live &  
learn.  Thanks for the help, opening lost-found/other in TextMate  
solved my problem quickly!

Thanks again!
Joe

On Mar 26, 2008, at 2:26 AM, Jeff King wrote:

> On Wed, Mar 26, 2008 at 02:17:18AM -0400, Joe Fiorini wrote:
>
>> I hadn't done a git-commit yet, but I used git-rm thinking it would
>> remove files that I had just added.  Instead, it deleted everything  
>> I had
>> added from the disk.  Is there a way to undo this?  I'm doubtful, but
>> would love to not have to rewrite what I was working on.
>
> If by "added" you mean "git add"ed, then yes. The file is hashed and  
> the
> blob is put in the object database during the add. Unfortunately,
> nothing actually _refers_ to it, so you will have to pick it out
> manually by its hash. Try:
>
>  git fsck --lost-found
>
> and then poke around .git/lost-found/other for your missing content.
>
> As an aside, didn't git-rm warn you? While confirming that the  
> command I
> was giving you was correct, I did this:
>
>  git init
>  echo content >file
>  git add file
>  git rm file
>
> and got:
>
>  error: 'file' has changes staged in the index
>  (use --cached to keep the file, or -f to force removal)
>
> -Peff

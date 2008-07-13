From: Poojan Wagh <poojanwagh@gmail.com>
Subject: Re: Q: How to tag individual files
Date: Sun, 13 Jul 2008 01:14:51 -0500
Message-ID: <g5c6hs$glo$1@ger.gmane.org>
References: <g5bvte$52j$1@ger.gmane.org> <20080713053537.GA32746@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 08:16:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHusw-0004p9-G7
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 08:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbYGMGPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 02:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbYGMGPg
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 02:15:36 -0400
Received: from main.gmane.org ([80.91.229.2]:43473 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984AbYGMGPf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 02:15:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KHuru-0006XH-8l
	for git@vger.kernel.org; Sun, 13 Jul 2008 06:15:34 +0000
Received: from 64-135-221-188.foxvalley.net ([64.135.221.188])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 06:15:34 +0000
Received: from poojanwagh by 64-135-221-188.foxvalley.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 06:15:34 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 64-135-221-188.foxvalley.net
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <20080713053537.GA32746@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88288>

Thanks, Shawn, for the clarification. Your explanation--together with 
http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#the-object-database-- 
makes it clear.

So, to summarize (with the intent of fixing any misunderstanding on my 
part): You can tag the contents of files (blobs), but not files per se, 
because:
1. Git doesn't store files as an object as such. It stores the contents 
of files ("blobs")
2. Git stores directories (which define their constituent file names and 
contents=>blobs) as "tree" objects. So, the association between a file's 
name and a its contents occurs in a tree object.

One thing I notice about this structure is that a tree object can at 
least theoretically give me what I want: the ability to have files 
organized with labels (a la gmail) rather than folders--I would like to 
be able to have a single file show up under many different labels rather 
than mutually exclusive folders/directories. I know that this won't 
happen automatically, but it's nice to know that I *could* do it if I 
wanted to.

Thanks!

P.S. I also found http://www.gitcasts.com/posts/browsing-git-objects 
useful for as illustration of all the object structure.

Shawn O. Pearce wrote:
> Poojan Wagh <poojanwagh@gmail.com> wrote:
>> The crash course at: http://git.or.cz/course/svn.html says:
>>
>>> You usually tag commits but if you want, you can tag files (or trees, 
>>> but that's a bit low-level) as well. 
>> I've done a bit of searching, and I can't for the life of me figure out  
>> how to tag an individual file. Help from the group would be much  
>> appreciated. Thanks.
> 
> You don't tag individual files.  Git is snapshot based.  You tag
> the entire project at once.
> 
> The comment you quoted was talking about tagging a single listing of
> blobs (a tree) or a single blob (stream of bytes).  This can be handy
> in rare cases.  In the linux kernel for example the prior history
> was stored by tagging the tree of that prior history, as there was
> no git based history preceeding that snapshot, so there were no
> commits to tag.  In git.git Junio publishes his GnuPG public key
> as a tagged blob, making it available to validate signed tag objects.
> 
> So you can't tag individual files.  The comment is a bit misleading
> and gets far too low-level for an otherwise high-level conversion
> guide.
> 

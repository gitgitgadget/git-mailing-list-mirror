From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git pull opinion
Date: Fri, 9 Nov 2007 16:36:12 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711091633380.15101@woody.linux-foundation.org>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com> 
 <7vd4uomfn8.fsf@gitster.siamese.dyndns.org>  <18223.46848.109961.552827@lisa.zopyra.com>
  <3abd05a90711052230y4d6151c6o3e7985a0c8e18161@mail.gmail.com> 
 <alpine.LFD.0.999.0711060812170.15101@woody.linux-foundation.org>
 <3abd05a90711071325y397434efq7d4e50cb7a1cf07e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 01:38:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqeMk-0005XY-Rk
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 01:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbXKJAiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 19:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbXKJAiL
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 19:38:11 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47118 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751525AbXKJAiK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 19:38:10 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAA0aDOa031384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 Nov 2007 16:36:14 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAA0aC4x007205;
	Fri, 9 Nov 2007 16:36:12 -0800
In-Reply-To: <3abd05a90711071325y397434efq7d4e50cb7a1cf07e@mail.gmail.com>
X-Spam-Status: No, hits=-2.739 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64287>



On Wed, 7 Nov 2007, Aghiles wrote:

> > [...]
> > Now, I do think that we could relax the rule so that "files that are
> > modified must be clean in the working tree" could instead become "files
> > that actually don't merge _trivially_ must be clean in the working tree".
> > But basically, if it's not a trivial merge, then since it's done in the
> > working tree, the working tree has to be clean (or the merge would
> > overwrite it).
> >[...]
> 
> I really think this is a good idea. It seems to me that the first "bad"
> surprise a svn/cvs/bk user will have is the result of a "git pull" command
> on a dirty tree. With the proposed change, and if I understand correctly:
>   - users that are used to commit often and fetch into clean trees
> will never be bothered by this change.
>   - users that are used to "update" often are expecting to resolve
> conflicts in their working copy anyway.
> 
> In both cases git does not get in your way and everyone is happy.

Well, there will still be cases where people won't be happy.

That said, all fast-forward cases (which is, I guess, a fairly common way 
of operating for anybody who has ever just uses anoncvs to track others) 
would be handled by the "three-way-merge dirty data for trivial merges". 

So even if it would only handle that special case (and it handles a *lot* 
of other cases too!) it probably would be useful to some people.

That said, I still don't think I have the energy to actually try to do it. 
I do suspect it's not that hard, and I outlined where it would go, but 
it's really quite core and important code... IOW, this needs *lots* of 
deep thought and care.

			Linus

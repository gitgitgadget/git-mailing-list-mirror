From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Mon, 01 Feb 2010 15:56:31 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-ABA66E.15563101022010@news.gmane.org>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com> <7vpr4o3lg9.fsf@alter.siamese.dyndns.org> <87aavsu9b3.fsf@osv.gnss.ru> <ron1-6F8B85.14520801022010@news.gmane.org> <7vwrywplxz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 00:57:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc68b-0003Eu-OS
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 00:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691Ab0BAX44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 18:56:56 -0500
Received: from lo.gmane.org ([80.91.229.12]:59608 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754432Ab0BAX4z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 18:56:55 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nc68U-0003Ba-7q
	for git@vger.kernel.org; Tue, 02 Feb 2010 00:56:54 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 00:56:54 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 00:56:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138660>

In article <7vwrywplxz.fsf@alter.siamese.dyndns.org>,
 Junio C Hamano <gitster@pobox.com> wrote:

> Ron Garret <ron1@flownet.com> writes:
> 
> >> For my rather fresh eye it looks more like unnamed (anonymous?) branch
> >> than a temporary one. Doesn't detached HEAD behave exactly like a
> >> regular HEAD but pointing to the tip of an unnamed branch?
> >
> > I strongly concur with this.
> >
> > And as long as I'm weighing in, it would also help to prevent confusion 
> > if it were made clear that this unnamed branch doesn't actually come 
> > into existence unless and until you do a commit.
> 
> This shows that you are still thinking a branch is a line (or multiple
> lines).  It is not.

The git user's guide says it is:

"When we need to be precise, we will use the word "branch" to mean a 
line of development..."

But I understand that a branch is not necessarily a line.  In general 
it's a DAG.  I get that.

The manual goes on to say:

"...and "branch head" (or just "head") to mean a reference to the most 
recent commit on a branch."

There are two ways this can be interpreted:

1.  A commit pointed to by a branch head cannot have any descendants.  
Because if it did it would not be the most recent commit on that branch, 
and by definition a branch head must point at the most recent commit.

2.  Any commit can be considered a branch head for a branch consisting 
of (for example) the transitive closure of its ancestors.

(Note that if I were being really strict with my terminology I would 
have to say: any commit can be considered the most recent commit for a 
branch consisting of...  Because a branch head by definition is a 
*reference* to a commit, so strictly speaking a commit cannot be a 
branch head.  The problem is that there are three concepts in play, but 
only two terms by which to refer to them.)

I personally think interpretation #1 makes more sense, and is a better 
match to most people's intuitions about what it means to be a branch 
head.  But in neither case does simply moving HEAD "create" a branch.  
Even under interpretation 2, all those anonymous branches were there all 
along.  You don't "create" anything, temporary or otherwise, simply by 
moving HEAD.

rg

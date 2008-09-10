From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert, and more about porcelain-level metadata
Date: Wed, 10 Sep 2008 13:49:40 +0200
Message-ID: <20080910114940.GA14127@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080909230525.GC10360@machine.or.cz> <48C794D6.20001@gnu.org> <20080910104424.GH10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Sep 10 13:50:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdODj-0004OB-2e
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 13:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbYIJLtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 07:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbYIJLtm
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 07:49:42 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:39792 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbYIJLtl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 07:49:41 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id AB8135465; Wed, 10 Sep 2008 13:49:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080910104424.GH10360@machine.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95512>

Petr Baudis wrote:
>On Wed, Sep 10, 2008 at 11:35:18AM +0200, Paolo Bonzini wrote:
>But that is irrelevant. If you already have the objects, whether to
>follow the origin link does not matter at all.

>I argue that the following the origin link by one step is harmful as it
>violated the internal Git object model and does not have real benefits.
>If you want to have the origin links, do not follow them at all - the
>commit objects themselves are not useful. (Or, optionally, follow them
>fully - that of course can make sense.)

The origin links are rarely followed, not even by one step.  They are
only followed if a certain operation requires them (not a lot do).

>> > And why are the notes created by git cherry-pick -x insufficient for that?

>> For example, these notes (or the ones created by "git revert") are
>> *wrong* because they talk about commits instead of changesets (deltas
>> between two commits).

>(BTW, I don't feel strongly enough about the header-freeform distinction
>to argue about it and some of your and others' points are good. But even
>if we have the origin links, I think we should only follow them not at
>all or fully.)

Maybe we have a misunderstanding about what "follow a link" means and
when it is done.
During most normal git operation, the origin links are just read, but
not followed.
The only commands that I expect to follow them are log --graph, gitk, fsck
and blame.  I may have missed some corner use-cases, but this should
cover most of it; i.e. most of git ignores them or just makes note of
the hashvalues provided.
-- 
Sincerely,
           Stephen R. van den Berg.

"Am I paying for this abuse or is it extra?"

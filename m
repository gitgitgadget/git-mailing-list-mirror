From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 15:30:48 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-D69CAB.15304829012010@news.gmane.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <op.u7a909hf4oyyg1@alvarezp-ws> <ron1-1F1799.13340029012010@news.gmane.org> <op.u7bfjni44oyyg1@alvarezp-ws> <ron1-0EE62E.14474929012010@news.gmane.org> <7vk4v0fqts.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 00:31:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb0JE-0007DJ-DN
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 00:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298Ab0A2XbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 18:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185Ab0A2XbO
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 18:31:14 -0500
Received: from lo.gmane.org ([80.91.229.12]:51439 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094Ab0A2XbO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 18:31:14 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nb0Iv-00070H-U4
	for git@vger.kernel.org; Sat, 30 Jan 2010 00:31:09 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 00:31:09 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 00:31:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138400>

In article <7vk4v0fqts.fsf@alter.siamese.dyndns.org>,
 Junio C Hamano <gitster@pobox.com> wrote:

> Ron Garret <ron1@flownet.com> writes:
> 
> > My actual use case is very complicated, but here's a simplified version:
> >
> > Suppose I'm using git as a back-end for a wiki.  I want to look at the 
> > state of the entire wiki as it was in some point in the past, and I also 
> > want to be able to look at the diffs between individual pages as they 
> > were then and as they are now.
> 
> Don't think you are so special ;-)

Never.  :-)

> "git checkout $that_old_commit" was
> invented _exactly_ for that use case.  You can look around from that
> state, and when you are done sightseeing, you can come back by doing a
> "git checkout master" (or whichever branch you want to be on).

Yes, that's what I would have expected.  Except that it not only updates 
my working tree, it updates my head also, so git diff doesn't give me 
the diffs that I want.  (This makes sense for the usual use case.)

> You don't necessarily have to check out an old state if the only thing
> you are interested in is to review how the contents changed over time.
> Use "git log -p" (from the current tip) for that.
> 
> If you chose to have an old checkout and then traverse the changes over
> time leading to the current tip, you would say "git log -p ..master"
> instead.

There's also this:


git rev-list HEAD -- [filename]

git ls-tree [some-hash-from-the-list-above]

Then for each line in the result:

git cat-file blob [hash] > [filename]


which seems like a horrible hack, but actually does what I want.

rg

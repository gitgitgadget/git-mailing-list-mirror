From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] post-checkout hook, and related docs and tests
Date: Tue, 25 Sep 2007 06:42:12 +0200
Message-ID: <46F891A4.9070407@op5.se>
References: <1190406421-15620-1-git-send-email-jjengla@sandia.gov>	<7vzlzfh7xd.fsf@gitster.siamese.dyndns.org>	<1190654052.6078.14.camel@beauty>	<7vsl53ap5x.fsf@gitster.siamese.dyndns.org>	<1190662396.6078.63.camel@beauty>	<7vejgnai1z.fsf@gitster.siamese.dyndns.org>	<1190671558.6078.87.camel@beauty> <7vfy138vql.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Josh England <jjengla@sandia.gov>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 06:42:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia2Fj-0007k3-6a
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 06:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755740AbXIYEmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 00:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754938AbXIYEmR
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 00:42:17 -0400
Received: from mail.op5.se ([193.201.96.20]:39306 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754914AbXIYEmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 00:42:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 66466194428;
	Tue, 25 Sep 2007 06:42:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1VFFy7EryVOD; Tue, 25 Sep 2007 06:42:13 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 4D7411943F7;
	Tue, 25 Sep 2007 06:42:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <7vfy138vql.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59091>

Junio C Hamano wrote:
> "Josh England" <jjengla@sandia.gov> writes:
> 
> But I am obviously not the one who is interested in tracking
> extended attributes attached to git contents, and I do not feel
> too strongly about one way or the other.  I am Ok with it if you
> think "checkout is magical" is easier to teach [*1*].
> 
> [Footnote]
> 
> *1* I actually suspect this might be the case.

I think so too, if nothing else than for the simple reason than that
the hook is called 'post-checkout', so the explanation is likely to
go something like 'the checkout program activates it after having
updated the worktree'.


> I consider that
> per-path checkout from a commit is just a fancy and handy way to
> edit individual files but that probably comes from knowing how
> git works too much and I lost my git virginity too long ago.  A
> pure "user" who types "git checkout commit path" may actively
> expect "checkout" command to do something more magical than
> simply updating the index and the work tree files to a random
> state that happens to match the state recorded in one commit.

Like, run the post-checkout hook? I should think it wouldn't be
too hard to believe it will.

I imagine the people using this feature will be either git-fanatics
that use it for everything and only in their own environment, or
sysadmins that get a handy tool for managing config in a corporate
environment. I wouldn't be surprised if those sysadmins weren't
all too keen on learning the 1001 ways there is to create a file
from a special revision in git (and personally I only knew about 2
of the 4 you listed), so for them there'll most likely *only* be
git-checkout to edit the work-tree.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

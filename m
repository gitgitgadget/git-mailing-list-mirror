From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH try 2] t1301-shared-repo.sh: don't let a default ACL 
	interfere with the test
Date: Fri, 17 Oct 2008 02:28:40 +0000
Message-ID: <1224210520.2952.39.camel@mattlaptop2.local>
References: <1224022020.2699.4.camel@mattlaptop2.local>
	 <1224022216.2699.5.camel@mattlaptop2.local>
	 <7vzll66c5u.fsf@gitster.siamese.dyndns.org>
	 <48F589EC.6050307@viscovery.net>
	 <7vmyh64bgy.fsf@gitster.siamese.dyndns.org>
	 <48F59928.5040502@viscovery.net>
	 <7v7i8a47f6.fsf@gitster.siamese.dyndns.org>
	 <48F5A590.3050905@viscovery.net>
	 <7vzll5jepj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 04:29:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqf6C-0004bl-GA
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 04:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbYJQC2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 22:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbYJQC2o
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 22:28:44 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:56170 "EHLO
	jankymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751145AbYJQC2n (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Oct 2008 22:28:43 -0400
Received: from [129.2.207.232] (ml2.student.umd.edu [129.2.207.232])
	by jankymail-a1.g.dreamhost.com (Postfix) with ESMTP id 3186A9869A;
	Thu, 16 Oct 2008 19:28:42 -0700 (PDT)
In-Reply-To: <7vzll5jepj.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98443>

On Wed, 2008-10-15 at 22:23 -0700, Junio C Hamano wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> > We have to decide case by case. In the case of shared directories it makes
> > sense to suggest "do not play ACL games". In other cases, however, this
> > suggestion could not work out that well, and a workaround in the code is
> > the better solutions. But we do not know what those other cases are, and
> > the test suite may be a tool to uncover them.
> 
> Although I am not particularly interested in hypothetical case that does
> not have concrete examples, I do not care deeply enough either.  So let's
> take this patch (with updated/corrected log message) that minimally covers
> the parts that can be broken by ACL games.

As I said in my other message, default ACLs do not break git, they only
break the way git is being tested in t1301-shared-repo.sh .  There is no
cause for concern.

In fact, default ACLs obsolete core.sharedrepository as a means of
setting default permissions on a repository because default ACLs apply
to files created by any program while core.sharedrepository is
recognized only by git.  Thus, a user who has a default ACL would be
unlikely to also have core.sharedrepository, so even if there were a bad
interaction between the two, no one would be likely to encounter it.

Updated patch to follow.

Matt

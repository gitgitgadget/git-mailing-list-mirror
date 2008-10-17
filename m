From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH try 2] t1301-shared-repo.sh: don't let a default ACL
	interfere with the test
Date: Fri, 17 Oct 2008 00:33:14 -0400
Message-ID: <1224217994.10291.2.camel@mattlaptop2.local>
References: <1224022020.2699.4.camel@mattlaptop2.local>
	 <1224022216.2699.5.camel@mattlaptop2.local>
	 <7vzll66c5u.fsf@gitster.siamese.dyndns.org>
	 <48F589EC.6050307@viscovery.net>
	 <7vmyh64bgy.fsf@gitster.siamese.dyndns.org>
	 <48F59928.5040502@viscovery.net>
	 <7v7i8a47f6.fsf@gitster.siamese.dyndns.org>
	 <48F5A590.3050905@viscovery.net>
	 <7vzll5jepj.fsf@gitster.siamese.dyndns.org>
	 <1224210520.2952.39.camel@mattlaptop2.local>
	 <7viqrrq1wz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 06:34:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqh2j-0001gA-9T
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 06:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbYJQEdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 00:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbYJQEdR
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 00:33:17 -0400
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:37455 "EHLO
	jankymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750745AbYJQEdR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Oct 2008 00:33:17 -0400
Received: from [129.2.207.232] (ml2.student.umd.edu [129.2.207.232])
	by jankymail-a1.g.dreamhost.com (Postfix) with ESMTP id 1D23498657;
	Thu, 16 Oct 2008 21:33:16 -0700 (PDT)
In-Reply-To: <7viqrrq1wz.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98447>

On Thu, 2008-10-16 at 21:30 -0700, Junio C Hamano wrote:
> Matt McCutchen <matt@mattmccutchen.net> writes:
> > As I said in my other message, default ACLs do not break git, they only
> > break the way git is being tested in t1301-shared-repo.sh .  There is no
> > cause for concern.
> 
> Is it also true if the default is too tight?  Wouldn't that interfere with
> the attempt to loosen the permission bits by core.sharedrepository?

No.  adjust_shared_perm does an explicit chmod, which always sets
exactly the requested permissions.  A default ACL just replaces the
umask in the calculation of a file's *initial* permissions.

Matt

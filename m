From: Keith Whitwell <keithw@vmware.com>
Subject: Re: [Mesa3d-dev] mesa_7_7_branch -> master merges
Date: Tue, 26 Jan 2010 10:59:55 +0000
Message-ID: <1264503595.18994.5.camel@toffee>
References: <1264424650.3029.155.camel@jfonseca-laptop>
	 <auto-000021765525@sci.utah.edu>
	 <1264443264.3029.255.camel@jfonseca-laptop>
	 <auto-000021766217@sci.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jose Fonseca <jfonseca@vmware.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	mesa3d-dev <mesa3d-dev@lists.sourceforge.net>
To: tom fogal <tfogal@alumni.unh.edu>
X-From: git-owner@vger.kernel.org Tue Jan 26 12:00:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZj9Z-000101-Ex
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 12:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248Ab0AZLAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 06:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753197Ab0AZLAA
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 06:00:00 -0500
Received: from smtp-outbound-1.vmware.com ([65.115.85.69]:39069 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753180Ab0AZK77 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2010 05:59:59 -0500
Received: from jupiter.vmware.com (mailhost5.vmware.com [10.16.68.131])
	by smtp-outbound-1.vmware.com (Postfix) with ESMTP id 2A86D4046;
	Tue, 26 Jan 2010 02:59:59 -0800 (PST)
Received: from [10.20.218.207] (unknown [10.20.218.207])
	by jupiter.vmware.com (Postfix) with ESMTP id 59721DC149;
	Tue, 26 Jan 2010 02:59:58 -0800 (PST)
In-Reply-To: <auto-000021766217@sci.utah.edu>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138027>

On Mon, 2010-01-25 at 11:04 -0800, tom fogal wrote:
> I think we've touched on a core git workflow issue here, and its likely
> others have hit this && have a solution, so I've added the git ML to
> the CC list.
> 
> Git: the situation in this repo is a fast-moving master that is
> including many changes to internal interfaces.  Stable branches just
> get bugfixes, and are periodically merged to master.  However, the more
> the heads diverge, the more difficult it is for a bugfix to merge into
> the head.  The major issue is that more experienced developers should
> really weigh in on these merges, because they tend to automagically
> undo some of the interface changes.  Yet during such a delay, master
> inevitably moves, and the bugfixer has to do even more work to "redo"
> the merge (and potentially get more review!).
> 
> Of course, if there are two bugfixers trying to make separate changes
> in the same time period, this gets worse.
> 
> Is there a workflow that can solve this issue?
> 

Speaking from the Mesa side, I think part of our problem is that it's
not easy to build the entire mesa tree, which means that the developer
doing the merge cannot even compile-test the result, meaning that many
trivial failures go unnoticed.

I'd argue that if we had a maximal mesa build target that compiled
*everything*, regardless of whether it produced drivers or not, we'd
have a much better chance of catching bogus merge droppings.

Despite Jose's valid concerns, I'd still argue that the situation we
have now is superior to what came before - where people were supposed to
be cherry-picking bugfixes but more likely they were forgotten or it
fell on Brian's shoulders to do manually.

Keith

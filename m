From: Stephen Bash <bash@genarts.com>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Fri, 23 Sep 2011 08:49:08 -0400 (EDT)
Message-ID: <33047451.27244.1316782148569.JavaMail.root@mail.hq.genarts.com>
References: <4E7C44C8.10000@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>,
	Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 23 14:49:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R75Bx-0003mj-Rw
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 14:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255Ab1IWMtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 08:49:19 -0400
Received: from hq.genarts.com ([173.9.65.1]:14991 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754242Ab1IWMtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 08:49:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id CC2DAEA236D;
	Fri, 23 Sep 2011 08:49:14 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YnjmEcXXPu0n; Fri, 23 Sep 2011 08:49:08 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 9B002EA2308;
	Fri, 23 Sep 2011 08:49:08 -0400 (EDT)
In-Reply-To: <4E7C44C8.10000@alum.mit.edu>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181960>

----- Original Message -----
> From: "Michael Haggerty" <mhagger@alum.mit.edu>
> Sent: Friday, September 23, 2011 4:35:20 AM
> Subject: Re: How to use git attributes to configure server-side checks?
>
> On 09/22/2011 07:26 PM, Junio C Hamano wrote:
> > Michael Haggerty <mhagger@alum.mit.edu> writes:
> >
> >> I would like the checking configuration to be *versioned* along with the
> >> code. For example, suppose my project decides to enforce a rule that
> >> all Python code needs to be indented with spaces. It might be that not
> >> all of our old code adheres to this rule, and that we only want to clean
> >> up the code in master.
> >
> > You want to sneak in a badly formatted code? Add an entry to the
> > in-tree attributes file to disable whitespace checking to cover that file!
> 
> No, the scenario that I was trying to describe is a project that wants
> to tighten up its code formatting rules after years of laxity. It is
> convenient to support legacy branches that still contain nonconforming
> code without having to reformat it all, just as it is convenient to
> fix the current code incrementally rather than requiring all of the
> cleanup to be done in one big bang. Thus it is important that new rules not be
> enforced retroactively on old code.

We're in the process of a similar change over (we're dealing with EOL rather than indents), but I attacked it from a different angle...  I wrote our update script to examine modified files and ensure compliance (diff-tree -r, iterate over blobs).  That way legacy files are left alone (even in master), but active development must live up to the current rules.  Is there a reason you need to go tree-by-tree rather than file-by-file?

Thanks,
Stephen

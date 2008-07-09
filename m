From: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
Subject: Re: Git, merging, and News/Relnotes files
Date: Tue, 08 Jul 2008 21:14:28 -0400
Message-ID: <487410F4.1050808@thewritingpot.com>
References: <g4n7j6$359$1@ger.gmane.org> <37fcd2780807060753h26d9391crff5f9ba5531db654@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: dpotapov@gmail.com, torvalds@linux-foundation.org, pdebie@ai.rug.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 03:15:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGOHT-000143-8k
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 03:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbYGIBOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 21:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbYGIBOl
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 21:14:41 -0400
Received: from main.gmane.org ([80.91.229.2]:41226 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003AbYGIBOl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 21:14:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KGOGS-0003qh-VW
	for git@vger.kernel.org; Wed, 09 Jul 2008 01:14:37 +0000
Received: from ool-18e45099.dyn.optonline.net ([24.228.80.153])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 01:14:36 +0000
Received: from edwardzyang by ool-18e45099.dyn.optonline.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 01:14:36 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ool-18e45099.dyn.optonline.net
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <37fcd2780807060753h26d9391crff5f9ba5531db654@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87824>

Dmitry Potapov wrote:
> Having one file changed on almost every commit is not a good idea, and
> not only because it will cause unnecessary conflicts but also it may
> considerable increase the size of the whole repository. By default, the
> delta compression has limit 50, which means that every 50 change of file
> will become its full copy. If the changelog file is changed very often
> and it is long, it may turn out that changelog alone takes as much space
> as the rest of the source tree.

That is certainly a good technical point, and I will certainly look into
building a log parser after we wrap up our next release cycle.

P.S. Linus, we ended up manually merging the NEWS file; in some cases
there were branch specific changes in the file which would have been
completely inappropriate with a union merge. Thank you for the
suggestion, however.

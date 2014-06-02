From: James Spencer <james.s.spencer@gmail.com>
Subject: Re: 2.0.0 regression? request pull does not seem to find head
Date: Mon, 2 Jun 2014 22:10:25 +0000 (UTC)
Message-ID: <loom.20140602T235730-544@post.gmane.org>
References: <20140602210131.GA17171@redhat.com> <CA+55aFyuj=B4jhc9vPkxHotSgJnRXMj_P_QkHCt-TKXtj8tOFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 00:15:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WraVe-0006q8-9I
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 00:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbaFBWPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 18:15:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:47854 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbaFBWPG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 18:15:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WraVT-0006k2-IO
	for git@vger.kernel.org; Tue, 03 Jun 2014 00:15:03 +0200
Received: from 88-105-38-76.dynamic.dsl.as9105.com ([88.105.38.76])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 00:15:03 +0200
Received: from james.s.spencer by 88-105-38-76.dynamic.dsl.as9105.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 00:15:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 88.105.38.76 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250604>

Linus Torvalds <torvalds <at> linux-foundation.org> writes:

>
> On Mon, Jun 2, 2014 at 2:01 PM, Michael S. Tsirkin <mst <at> redhat.com>
wrote:
> >
> > [mst <at> robin linux]$ git request-pull net-next/master
> git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git net-next
> > warn: No match for commit 2ae76693b8bcabf370b981cd00c36cd41d33fabc found
at git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> > warn: Are you sure you pushed 'net-next' there?
>
> git request-pull is clearly correct. There is no "net-next" in that
> public repository.

I am seeing something similar:

$ git request-pull master origin > /dev/null
warn: No match for commit 64ea29197d5e13772b1f7b6c24feaa79cc97d997 found at
origin
warn: Are you sure you pushed 'HEAD' there?

but I pushed 64ea29197d5e13772b1f7b6c24feaa79cc97d997:

$ git show-ref bug_fix/init_report
64ea29197d5e13772b1f7b6c24feaa79cc97d997 refs/heads/bug_fix/init_report
64ea29197d5e13772b1f7b6c24feaa79cc97d997 
refs/remotes/origin/bug_fix/init_report

The warning goes away if I give an explicit end commit.

Should the default value for $remote in the call to $find_matching_ref be
$head rather than HEAD (and similarly for the warning message)?

   --James

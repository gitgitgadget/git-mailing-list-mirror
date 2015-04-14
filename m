From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v2 1/4] t4059: test 'diff --cc' with a change from only
 few parents
Date: Tue, 14 Apr 2015 07:22:52 +0300
Message-ID: <20150414042252.GC786@wheezy.local>
References: <1428006853-21212-1-git-send-email-max@max630.net>
 <1428076716-4449-1-git-send-email-max@max630.net>
 <1428076716-4449-2-git-send-email-max@max630.net>
 <xmqqa8ye5q7m.fsf@gitster.dls.corp.google.com>
 <20150412054332.GA28555@wheezy.local>
 <xmqq1tjp6gj5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 06:22:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhsN5-0000M2-3E
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 06:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbbDNEWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 00:22:43 -0400
Received: from p3plsmtpa09-04.prod.phx3.secureserver.net ([173.201.193.233]:50769
	"EHLO p3plsmtpa09-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750968AbbDNEWl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2015 00:22:41 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-04.prod.phx3.secureserver.net with 
	id FgNb1q00F5B68XE01gNfDK; Mon, 13 Apr 2015 21:22:41 -0700
Content-Disposition: inline
In-Reply-To: <xmqq1tjp6gj5.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267115>

On Sat, Apr 11, 2015 at 10:51:10PM -0700, Junio C Hamano wrote:
> Max Kirillov <max@max630.net> writes:
> 
>> My exact case was that there was a change in one branch
>> which was overwritten during merge conflict resolution by
>> fully acepting the other branch - in a 2-parent merge. I
>> started looking for a way to visualize such cases. They
>> are not visible in usual diff, because they look same as
>> accepting change compared to the unchange branch.
> 
> Hmph, isn't that exactly why "diff -c" exists, not "diff --cc"
> that omits (usually) uninteresting hunks?

No, this shows too many. If a change is done in one branch
but the other branch did not introduce any changes since
mergebase and they merged cleanly the merge should not be
shown, and `diff -c` seems to show them.

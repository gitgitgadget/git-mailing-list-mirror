From: Marc Branchaud <mbranchaud@xiplink.com>
Subject: Re: [PATCH v2] gitk: Add a horizontal scrollbar for commit history
Date: Mon, 04 Nov 2013 10:50:04 -0500
Message-ID: <5277C22C.8050605@xiplink.com>
References: <1383130702-4966-1-git-send-email-ncornu@aldebaran-robotics.com> <5270F4FC.60900@viscovery.net> <CAMXp-VMku0eSQmmbdy-NQDedH4VSgZN5XmpTeBHvN8qX1=ersg@mail.gmail.com> <20131031090526.GA9164@iris.ozlabs.ibm.com>
Reply-To: marcnarc@xiplink.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>,
	Nicolas Cornu <ncornu@aldebaran-robotics.com>
X-From: git-owner@vger.kernel.org Mon Nov 04 16:56:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdMWH-0007ZJ-8s
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 16:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239Ab3KDP4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 10:56:44 -0500
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:57766 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659Ab3KDP4o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 10:56:44 -0500
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Nov 2013 10:56:44 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp14.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 7DDFE31847D;
	Mon,  4 Nov 2013 10:49:57 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp14.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 2BA3B3185A9;
	Mon,  4 Nov 2013 10:49:57 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131031090526.GA9164@iris.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237289>

On 13-10-31 05:05 AM, Paul Mackerras wrote:
> On Wed, Oct 30, 2013 at 01:47:08PM +0100, Nicolas Cornu wrote:
>> This is useful on all our repos, every times, as we put a tag per day.
>> If the HEAD didn't move during 150 days, we got 150 tags.
> 
> Here is a patch that I did some time ago but have never pushed out.
> Do you think it is an improvement when using gitk on a repo with lots
> of tags?

I like this a lot!  Thanks for putting it together.  I think it's worth
releasing this as-is.

My only wish is that it be generalized for any kind of ref:  Each refs/*
namespace should form a distinct display category.  For example, given refs
like this (note the non-standard "builds" namespace):

	refs/heads/maint
	refs/heads/master
	refs/heads/next
	refs/remotes/origin/maint
	refs/remotes/origin/master
	refs/remotes/origin/next
	refs/remotes/origin/pu
	refs/tags/v1.1.1
	refs/tags/v2.2.2
	refs/tags/v3.3.3
	refs/tags/v4.4.4
	refs/builds/1.1.1-1
	refs/builds/1.1.1-2
	refs/builds/1.1.1-3
	refs/builds/1.1.1-4
	refs/builds/1.1.1-5

And let's say that somehow all these refs refer to the same commit that's
being displayed in gitk, then I'd like to see something like:

	[3 branches...][4 remote refs...][4 tags...][5 builds...]

Gitk can be smart about how it displays standard namespaces (as it already is
for tags, heads, remote heads, etc.), but for non-standard namespaces gitk
can just display the namespace's name directly.

		M.

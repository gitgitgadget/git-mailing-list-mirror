From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: persistent memoization
Date: Fri, 5 Feb 2010 02:02:31 -0800
Message-ID: <20100205100230.GA16881@dcvr.yhbt.net>
References: <1264821262-28322-1-git-send-email-amyrick@apple.com> <20100201040312.GA26199@dcvr.yhbt.net> <49FDA6F7-21D8-4280-A6A7-80EC2F749EA9@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sam@vilain.net,
	Andrew Myrick <amyrick@apple.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:09:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdL4v-0003Bj-El
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265Ab0BEKCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 05:02:33 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:43156 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab0BEKCc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 05:02:32 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDBF01F4F3;
	Fri,  5 Feb 2010 10:02:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49FDA6F7-21D8-4280-A6A7-80EC2F749EA9@apple.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139040>

Andrew Myrick <amyrick@apple.com> wrote:
> On Jan 31, 2010, at 8:03 PM, Eric Wong wrote:
> > Andrew Myrick <amyrick@apple.com> wrote:
> >> Make memoization of the svn:mergeinfo processing functions persistent with
> >> Memoize::Storable so that the memoization tables don't need to be regenerated
> >> every time the user runs git-svn fetch.
> >> 
> >> The Memoize::Storable hashes are stored in ENV{GIT_DIR}/svn/caches.
> > 
> > Hi Andrew,
> > 
> > Perhaps "$ENV{GIT_DIR}/svn/.caches" is better here since older versions
> > of git svn used "$ENV{GIT_DIR}/svn/$refname" in the top-level and
> > "caches" may conflict with existing repos.
> > 
> >> -use File::Path qw/mkpath/;
> >> +use File::Path qw/mkpath make_path/;
> > 
> > File::Path::make_path is very recent not in Perls distributed by most
> > vendors.  My 5.10.0 installation (Debian stable) doesn't have it, and I
> > also don't see a good reason to use it over the traditional mkpath.
> > 
> > I think I'll squash the following patch and Ack.  Let me know if
> > you have any objections, thanks.!
> > (also wraps long lines to 80 chars)
> 
> Makes sense to me.  Thanks, Eric.

Hi Junio,

I've acked and pushed this out to git://git.bogomips.org/git-svn

  Andrew Myrick (1):
        git-svn: persistent memoization

Sorry for the delay, my mind has slipped.  Thanks to Andrew
for the patch and reminder.

-- 
Eric Wong

From: Bill Lear <rael@zopyra.com>
Subject: Re: Git vs svn. Is ... possible ?
Date: Fri, 28 Mar 2008 08:09:04 -0600
Message-ID: <18412.64512.269165.652979@lisa.zopyra.com>
References: <20080328132438.GA32646@blackspire>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: =?utf-8?B?UmFmYcWCIE11xbx5xYJv?= <galtgendo@o2.pl>
X-From: git-owner@vger.kernel.org Fri Mar 28 15:10:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfFHZ-0006rw-Ke
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 15:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbYC1OJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 10:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753072AbYC1OJb
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 10:09:31 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60033 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222AbYC1OJa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 10:09:30 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id m2SE98v32296;
	Fri, 28 Mar 2008 08:09:08 -0600
In-Reply-To: <20080328132438.GA32646@blackspire>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78413>

On Friday, March 28, 2008 at 14:24:38 (+0100) =?utf-8?B?UmFmYcWCIE11xbx5xYJv?= writes:
>Well, the actual question is:
>In svn I can do a remote diff (diff between two remote revisions) without
>having to do a checkout, is this possible for git ?

I'm not sure what you mean by "two remote revisions".  Do you mean you
are on machine X, and you want to diff content on machine Y and
machine Z?  If so, you could probably do that in git fairly easily
with some script magic that would fetch the remote branches into local
tracking branches, and then diff them.  This would not literally
require you to perform a "checkout", but you would need a git repo
(actually a script could take care of creating a temporary repo, fetch
into it, do the diff and then remove the temporary repo when done).

If you are talking about having an existing repo on machine X and
diffing content that is on machine Y, you can do a fetch followed by a
diff, so in that case you can do it literally "without having to do a
checkout".  Example: if you are working on master and want to see what
is different between what you have and what is in a remote repo you
are tracking, you can do "git fetch" then "git diff origin/master".


Bill

From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2 0/3] git-svn: use YAML format for mergeinfo cache
 when possible
Date: Sun, 10 Jun 2012 09:00:39 +0000
Message-ID: <20120610090039.GA12868@dcvr.yhbt.net>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
 <20110823081546.GA28091@dcvr.yhbt.net>
 <7vobzgrrbg.fsf@alter.siamese.dyndns.org>
 <20120527192541.GA29490@burratino>
 <20120527201450.GA3630@dcvr.yhbt.net>
 <20120609222039.GD28412@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jason Gross <jgross@MIT.EDU>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 11:01:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sde1P-0001F0-EW
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 11:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566Ab2FJJAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 05:00:41 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38728 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152Ab2FJJAk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 05:00:40 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 060301F4E6;
	Sun, 10 Jun 2012 09:00:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20120609222039.GD28412@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199577>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Eric Wong wrote:
> > These should die on errors, right?
> 
> Yep, they do.  I didn't bother doing the CARP_NOT thing --- let's wait
> for a bug report or rainy day and then handle errors properly (by
> invalidating the cache when appropriate).

OK.

> Patches 1-2 are independent from patch 3.  I'm sending them this way
> for no particular reason.
> 
> Thoughts of all kinds welcome, as usual.

Thanks!  I only had a trivial conflict with 2/3, but fixed it,
signed-off and pushed to master of git://bogomips.org/git-svn

> Jonathan Nieder (3):
>   git-svn: make Git::SVN::Editor a separate file
>   git-svn: make Git::SVN::RA a separate file

2/3 had a conflict with commit c26ddce86d7215b4d9687bd4c6b5dd43a3fabf31
which I resolved by hand
(git-svn: platform auth providers are working only on 1.6.15 or newer)

--- a.mbox	2012-06-10 08:58:19.000000000 +0000
+++ b.mbox	2012-06-10 08:58:23.000000000 +0000
@@ -64,7 +64,7 @@
 -
 -	# earlier 1.6.x versions would segfault, and <= 1.5.x didn't have
 -	# this function
--	if (::compare_svn_version('1.6.12') > 0) {
+-	if (::compare_svn_version('1.6.15') >= 0) {
 -		my $config = SVN::Core::config_get_config($config_dir);
 -		my ($p, @a);
 -		# config_get_config returns all config files from
@@ -688,7 +688,7 @@
 +
 +	# earlier 1.6.x versions would segfault, and <= 1.5.x didn't have
 +	# this function
-+	if (::compare_svn_version('1.6.12') > 0) {
++	if (::compare_svn_version('1.6.15') >= 0) {
 +		my $config = SVN::Core::config_get_config($config_dir);
 +		my ($p, @a);
 +		# config_get_config returns all config files from

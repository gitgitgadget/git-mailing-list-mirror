From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: teach git-svn to populate svn:mergeinfo
Date: Tue, 6 Sep 2011 13:57:50 -0700
Message-ID: <20110906205750.GB12574@dcvr.yhbt.net>
References: <20110902140702.066a4668@robyn.woti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Bryan Jacobs <bjacobs@woti.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 22:57:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R12iT-0001lk-85
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 22:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219Ab1IFU5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 16:57:52 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34669 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754921Ab1IFU5v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 16:57:51 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1826C21062;
	Tue,  6 Sep 2011 20:57:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20110902140702.066a4668@robyn.woti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180835>

Bryan Jacobs <bjacobs@woti.com> wrote:
> +sub split_merge_info_range {
> +	my ($range) = @_;
> +	if ($range =~ /(\d+)-(\d+)/o) {

No need for "/o" in regexps unless you have a (constant) variable
expansion in there.

> +sub merge_commit_fail {
> +	my ($gs, $linear_refs, $d) = @_;
> +	#while (1) {
> +	#	my $cs = shift @$linear_refs or last;
> +	#	command_noisy(qw/cherry-pick/, $cs);
> +	#}
> +	#command_noisy(qw/cherry-pick -m/, '1', $d);

Huh?  If there's commented-out code, it must be explained or removed.

> +	fatal "Aborted after failed dcommit of merge revision";
> +}

> +++ b/t/t9160-git-svn-mergeinfo-push.sh
> @@ -0,0 +1,97 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2007, 2009 Sam Vilain

That should be: "Copyright (c) 2011 Brian Jacobs", correct?

> +test_expect_success 'check svn:mergeinfo' '
> +	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb1)
> +	echo "$mergeinfo"

No need to echo unless you're debugging a test, right?

-- 
Eric Wong

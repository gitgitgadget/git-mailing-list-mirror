From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] svn: Create config options for common args
Date: Mon, 14 Nov 2011 13:46:02 -0800
Message-ID: <20111114214602.GA22399@dcvr.yhbt.net>
References: <1321302310-28793-1-git-send-email-ted.percival@quest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ted Percival <ted.percival@quest.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 22:46:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ4M2-0004pJ-34
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 22:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123Ab1KNVqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 16:46:05 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:53726 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754954Ab1KNVqD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 16:46:03 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 001D221266;
	Mon, 14 Nov 2011 21:46:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1321302310-28793-1-git-send-email-ted.percival@quest.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185406>

Ted Percival <ted.percival@quest.com> wrote:
>  Documentation/git-svn.txt |   10 ++++++++++

Thanks, documentation part is very much appreciated

> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -21,6 +21,9 @@ $Git::SVN::default_repo_id = 'svn';
>  $Git::SVN::default_ref_id = $ENV{GIT_SVN_ID} || 'git-svn';
>  $Git::SVN::Ra::_log_window_size = 100;
>  $Git::SVN::_minimize_url = 'unset';
> +$Git::SVN::_localtime = Git::config_bool('svn.localtime');
> +$Git::SVN::_add_author_from = Git::config_bool('svn.addAuthorFrom');
> +$Git::SVN::_use_log_author = Git::config_bool('svn.useLogAuthor');

I don't think these are needed.  The read_git_config() function /should/
be checking all GIT_CONFIG equivalents of the Getopt::Long option specs.
Can you verify?  Thanks.

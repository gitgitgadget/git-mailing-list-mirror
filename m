From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git-svn: New flag to add a file in empty
	directories
Date: Wed, 18 May 2011 08:22:15 +0000
Message-ID: <20110518082215.GA21899@dcvr.yhbt.net>
References: <1305669635-10861-1-git-send-email-rchen@cs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ray Chen <rchen@cs.umd.edu>
X-From: git-owner@vger.kernel.org Wed May 18 10:22:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMc1P-0007uT-8U
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 10:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755420Ab1ERIWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 04:22:17 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53957 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754316Ab1ERIWP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 04:22:15 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D4701F404;
	Wed, 18 May 2011 08:22:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1305669635-10861-1-git-send-email-rchen@cs.umd.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173859>

Ray Chen <rchen@cs.umd.edu> wrote:
> I needed this functionality when I was migrating a repository from SVN to
> Git.

This feature sounds reasonable for folks making one-shot or read-only
mirrors with git svn.

> My knowledge of SVN is limited, so I'm not sure how correct this patch is.
> I created a little test SVN repo, and `git svn clone --preserve-empty-dirs`
> did the right thing, but that's hardly a complete test.

Please provide an automated test case so it's easier to review (I almost
never see SVN repos anymore) and to ensure it stays working when other
changes are made.

> Specifically, I experimentally noticed that my patch worked with lines 4532
> and 4533 commented out.  I'm not sure what problems might occur when adding
> a file Git without associated SVN properties.

These two lines?

> +	# The following two lines don't seem to be necessary, but I'm not
> +	# familiar enough with SVN properties to know if correctness is
> +	# compromised without them.
> +#	$self->{file_prop}->{$path} = $self->{dir_prop}->{$dir};
> +#	$self->add_file($path, { 'path' => $dir }, undef, '-1');

It's been years since I dealt with the SVN library, so I'm not sure I
still remember.  I think add_file is only for files that exist in the
SVN side, not sure about the file_prop/dir_prop assignment, either.

(more in my reply to Michael's email)

-- 
Eric Wong

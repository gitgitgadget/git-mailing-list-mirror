From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 4/5] git-svn: fix bottleneck in stash_placeholder_list()
Date: Wed, 1 May 2013 21:30:31 +0000
Message-ID: <20130501213031.GA13056@dcvr.yhbt.net>
References: <1438528085.20130501090926@gmail.com>
 <1409591910.20130501123153@gmail.com>
 <7vhaim8w48.fsf@alter.siamese.dyndns.org>
 <455264907.20130501235104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Ray Chen <rchen@cs.umd.edu>
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 23:33:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXedG-0006Ge-GG
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 23:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759495Ab3EAVcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 17:32:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51643 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762299Ab3EAVac (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 17:30:32 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4F5E1F425;
	Wed,  1 May 2013 21:30:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <455264907.20130501235104@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223146>

Ilya Basin <basinilya@gmail.com> wrote:
> JCH> comment line "# added by git-svn only to keep the directory" and
> JCH> consider a directory that has nothing but .gitignore that consists
> JCH> of only that exact comment line an "added placeholder" directory to
> JCH> work it around.
> Sounds good, but it's not I who decided to use the config file.

Ugh, I didn't review Ray's original commit closely enough to notice
this :x

Perhaps we should migrate users to use YAML storage for this, instead
(we already use YAML for Git::SVN::Memoize::YAML).


Fwiw, I've never been a fan of placeholders only accepted it since it's
off-by-default but it worked well enough for Ray.

My personal philosophy has always been: git svn users should leave
no trace or indication they're using a non-standard SVN client.

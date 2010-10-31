From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] cherry-pick/revert: transparently refresh index
Date: Sun, 31 Oct 2010 18:26:44 -0400
Message-ID: <20101031222644.GA31257@arf.padd.com>
References: <20101031174430.GA30236@arf.padd.com>
 <20101031195933.GA21240@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 23:27:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCgMY-00048z-2Q
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 23:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756794Ab0JaW0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 18:26:49 -0400
Received: from honk.padd.com ([74.3.171.149]:36344 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053Ab0JaW0s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 18:26:48 -0400
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id E5E01276;
	Sun, 31 Oct 2010 15:26:46 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 7A11D319E9; Sun, 31 Oct 2010 18:26:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20101031195933.GA21240@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160454>

jrnieder@gmail.com wrote on Sun, 31 Oct 2010 14:59 -0500:
> A stat-dirty index is not a detail that ought to concern the operator
> of porcelain such as "git cherry-pick".
> 
> Without this change, a cherry-pick after copying a worktree with rsync
> errors out with a misleading message.
> 
> 	$ git cherry-pick build/top
> 	error: Your local changes to 'file.h' would be overwritten by merge.  Aborting.
> 	Please, commit your changes or stash them before you can merge.
> 
> Noticed-by: Pete Wyckoff <pw@padd.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks, this works well.  I tested it and am happy with the
change.  It is needed for correctness.

Since I know that I just copied the repo, I'd prefer not to
make people wait to refresh the index.  A new flag to
update-index improves performance by avoiding the initial
re-read of all files in the repository.  Patch follows in
next mail.

		-- Pete

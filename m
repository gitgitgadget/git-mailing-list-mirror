From: David Brown <git@davidb.org>
Subject: Maintaining two branches.
Date: Tue, 3 Jun 2008 09:34:31 -0700
Message-ID: <20080603163431.GA1244@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 18:35:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3ZTs-0005Vn-1I
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 18:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbYFCQed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 12:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbYFCQed
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 12:34:33 -0400
Received: from mail.davidb.org ([66.93.32.219]:54436 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751918AbYFCQec (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 12:34:32 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1K3ZSx-0000dw-QM; Tue, 03 Jun 2008 09:34:31 -0700
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83679>

Looking for some advice/ideas on a git workflow:

We have three branches of the code:

   - upstream - The upstream release versions, tracks outside git repo.
   - external - Other external patches not included in the main git repo.
   - local - Our local development.

For release reasons, we need to keep our local branch separate, but normal
development needs to be done on a merge of 'external' and 'local' (the tree
needs the merge of both just to build).  Developers will generate patches,
and maintainers will apply these patches to 'local'.

I've tried creating a 'next' branch where I merge each change from local
and/or external, and this seems to work, but the history gets very
cluttered with merge commits.  For some reason, history simplification
doesn't seem to eliminate any of these merges.

We also have an automated build/test system that checks out versions of
'next', and when the build and test moves 'master' forward to that version.
Because of this, it would be nice to keep 'next' fairly up-to-date, which
implies having a lot of merges.

Does anyone have any better ideas on how to maintain this process?  The
'next' and 'master' branches won't be exported too far, so could be
replaced with simpler history occasionally, but there is a good number of
developers who will be using them, so it would be best to not do this too
often.

Thanks,
David Brown

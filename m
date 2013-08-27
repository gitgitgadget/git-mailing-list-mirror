From: Uwe Storbeck <uwe@ibr.ch>
Subject: Asymmetric default behavior of git stash
Date: Tue, 27 Aug 2013 16:07:09 +0200
Message-ID: <20130827132210.GA14266@ibr.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 16:14:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEK2D-0004Ds-NX
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 16:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071Ab3H0OOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 10:14:12 -0400
Received: from gate.ibr.ch ([213.144.140.114]:41280 "EHLO gate.ibr.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152Ab3H0OOM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 10:14:12 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Aug 2013 10:14:11 EDT
Received: from bacardi.ibr.ch (bacardi.ibr.ch [172.16.1.1])
	by gate.ibr.ch (Postfix) with ESMTP id 6E82617F5D
	for <git@vger.kernel.org>; Tue, 27 Aug 2013 16:07:09 +0200 (CEST)
Received: from grappa.ibr.ch (grappa [172.16.8.20])
	by bacardi.ibr.ch (Postfix) with ESMTP id 420CC153F3
	for <git@vger.kernel.org>; Tue, 27 Aug 2013 16:07:08 +0200 (CEST)
Received: by grappa.ibr.ch (Postfix, from userid 1111)
	id 283E5D1E97; Tue, 27 Aug 2013 16:07:09 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233089>

Hi,

is there any reason why the default behavior of git stash is
asymmetric?

When I save my current state with 'git stash save' it saves the
worktree changes and the index changes (and resets both). When I
restore the state with 'git stash pop' it restores the worktree
changes, but not the state of the index. Your work preparing the
index is lost.

Although this behavior is documented it is kind of unexpected.
From a save-restore mechanism I would expect that the default
behavior would restore the state as it was before the save. So
I would expect it to either save and restore the worktree and
leave the index alone or save and restore both, the worktree
and the index.

Regards

Uwe

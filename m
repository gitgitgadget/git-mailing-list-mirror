From: "George Spelvin" <linux@horizon.com>
Subject: Is there a way to cherry-pick a merge?
Date: 14 Jun 2013 15:37:29 -0400
Message-ID: <20130614193729.17663.qmail@science.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 14 21:37:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnZoX-0007VU-9U
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 21:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919Ab3FNThc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 15:37:32 -0400
Received: from science.horizon.com ([71.41.210.146]:19466 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753830Ab3FNThb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 15:37:31 -0400
Received: (qmail 17664 invoked by uid 1000); 14 Jun 2013 15:37:29 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227915>

Sometimes I'd like to repeat a previously performed merge, preserving
the commit message.  And, if possible, the conflict resolutions.

"git cherry-pick -m 1 <commit>" gets me the changes, but makes an
ordinary single-parent commit, not a merge.

"git rebase -p --onto HEAD commit^ commit" does the right thing,
but has two annoying properties:

1) It actually checks out "commit", then goes back to HEAD, thus
   forcing a lot of recompiltion of source files that experience
   no net change from the operation.
2) Because it's intended for multi-step use, it stops and waits for
   confirmation if there are rerere changes.  I'd rather it just did the
   commit if there are no remaining conflict markers, and I'll reset or
   amend it if I'm not happy with the result.

Does something like this exist already?

Thank you!

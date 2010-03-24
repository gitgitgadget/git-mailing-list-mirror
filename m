From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCHv4 0/2] Teach the --no-ff option to 'rebase -i'.
Date: Wed, 24 Mar 2010 11:40:59 -0400
Message-ID: <1269445261-2941-1-git-send-email-marcnarc@xiplink.com>
References: <7vzl1yd5j4.fsf@alter.siamese.dyndns.org>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 24 16:56:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuSwT-0007xE-TW
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 16:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756369Ab0CXPjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 11:39:19 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:39167 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756273Ab0CXPjS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 11:39:18 -0400
Received: from rincewind (rincewind.xiplink.com [192.168.1.136])
	by farnsworth.xiplink.com (8.14.2/8.14.2/Debian-2build1) with ESMTP id o2OFcHbl012147;
	Wed, 24 Mar 2010 11:38:18 -0400
Received: by rincewind (Postfix, from userid 1000)
	id 86FEB33666B; Wed, 24 Mar 2010 11:41:03 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.3.1.g59254.dirty
In-Reply-To: <7vzl1yd5j4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143089>

Thanks to both Junio and Jonathan for your patience in working through this.

Junio, I think I see what you mean.  I like teaching --no-ff to 'rebase -i'
because it allows me to combine two commands into one for this situation.

I've split this work into two patches:

The first one simply teaches "rebase -i" to accept and ignore -f.  I feel
this is better than adding text to the man page explaining why interactive
rebase has --no-ff but not -f, while non-interactive has the opposite.

The second is a re-roll of the --no-ff patch.  The only significant
differences are in the documentation:

 - The rebase man page mentions reverting a merge under both the -f and
   --no-ff options.

 - Rewrote the last 3 paragraphs of the revert-a-faulty-merge.txt howto
   (starting at "But if you don't ...").

I'm wondering now if it would make sense to also teach non-interactive
rebase to accept --no-ff as a synonym for -f.  Thoughts?

		M.

 Documentation/git-rebase.txt                  |   23 +++++++++-
 Documentation/howto/revert-a-faulty-merge.txt |   61 +++++++++++++++++++++++++
 git-rebase--interactive.sh                    |   13 +++++-
 t/t3404-rebase-interactive.sh                 |   36 +++++++++++++--
 4 files changed, 125 insertions(+), 8 deletions(-)

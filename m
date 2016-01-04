From: greened@obbligato.org
Subject: Detecting redundant commits
Date: Mon, 04 Jan 2016 09:59:09 -0600
Message-ID: <nngtwmtwd2q.fsf@lnx-dag.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 04 16:59:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG7XZ-0007Ue-MO
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 16:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbcADP7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 10:59:23 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:44594 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751581AbcADP7V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 10:59:21 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=lnx-dag.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.1:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aG7YK-00075Y-8K
	for git@vger.kernel.org; Mon, 04 Jan 2016 10:00:12 -0600
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283308>

I am attempting to teach cherry-pick to handle redundant commits
gracefully (via a new --skip-redundant-commits option) instead of
aborting.  However, I'm struggling a bit with how to check if the
changes in a commit will become redundant when appied to the new HEAD.

I found diff_tree_sha1 which seems promising.  Am I on the right track?
If not, what's the best way to determine whether a commit object is
redundant with respect to HEAD?

                           -David

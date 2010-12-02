From: thussvm <thuss@volunteermatch.org>
Subject: git p4 submit always tries to re-apply every patch
Date: Wed, 1 Dec 2010 18:30:39 -0800 (PST)
Message-ID: <1291257039313-5794578.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 03:30:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNywa-00062v-8t
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 03:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756743Ab0LBCak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 21:30:40 -0500
Received: from kuber.nabble.com ([216.139.236.158]:42642 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606Ab0LBCaj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 21:30:39 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <thuss@volunteermatch.org>)
	id 1PNywR-0003Ee-CC
	for git@vger.kernel.org; Wed, 01 Dec 2010 18:30:39 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162663>


Whenever I run a git p4 submit after a git pull from the origin it tries to
re-apply every commit, even ones that were already submitted previously
(which results in self generated conflicts). What's interesting is that this
works:

git p4 submit <--- submit some changes
git p4 submit <--- no changes to submit, so it recognizes that it's up to
date

but as soon as I throw in a git pull origin master (even if there is nothing
new on the origin) it loses track and on the next submit it tries to
re-apply EVERYTHING. For example:

git p4 submit <--- no changes to submit
git pull origin master <--- no activity on the git server side so no changes
applied
git p4 submit <--- tries to re-apply all changes that were already submitted
earlier

Is git pull origin master somehow wiping out git p4's notion of which
changes have been applied and which haven't?
-- 
View this message in context: http://git.661346.n2.nabble.com/git-p4-submit-always-tries-to-re-apply-every-patch-tp5794578p5794578.html
Sent from the git mailing list archive at Nabble.com.

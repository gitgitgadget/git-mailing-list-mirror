From: Todd Rinaldo <toddr@cpanel.net>
Subject: git clean --exclude broken?
Date: Wed, 24 Aug 2011 14:15:29 -0500
Message-ID: <A04A4D84-16CC-438C-8828-0D11BE9DE2DA@cpanel.net>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 22:17:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwJtC-0003hX-NC
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 22:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379Ab1HXURZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 16:17:25 -0400
Received: from mx1.cpanel.net ([208.74.121.68]:55560 "EHLO mx1.cpanel.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617Ab1HXURX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2011 16:17:23 -0400
X-Greylist: delayed 3713 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Aug 2011 16:17:23 EDT
Received: from ng1.cptxoffice.net ([208.74.121.102] helo=[10.1.4.99])
	by mx1.cpanel.net with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <toddr@cpanel.net>)
	id 1QwIvB-0003EN-Te
	for git@vger.kernel.org; Wed, 24 Aug 2011 14:15:30 -0500
X-Mailer: Apple Mail (2.1244.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mx1.cpanel.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cpanel.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180033>

I think I have found a new bug in 1.7.5:
# Setup:
mkdir tmp && cd tmp
git init
mkdir foo && touch foo/bar
mkdir bar && touch bar/baz
echo "/foo" > .gitignore
echo "/bar" >> .gitignore
git add .gitignore
git commit -m ignore

# The problem (Why is foo/ removed?)
$>git clean -dXf --exclude=/foo
Removing bar/
Removing foo/

I apologize if this isn't the correct channel to report a bug. Does anyone know if this is a known issue?

Thanks,
Todd Rinaldo

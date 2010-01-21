From: Yaroslav Halchenko <debian@onerussian.com>
Subject: problem cloning via http since v1.6.6-rc0
Date: Wed, 20 Jan 2010 19:47:56 -0500
Message-ID: <20100121004756.GA18213@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 21 02:22:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXlkz-0007CD-0K
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 02:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725Ab0AUBWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 20:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753657Ab0AUBWa
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 20:22:30 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:55189 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839Ab0AUBW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 20:22:28 -0500
X-Greylist: delayed 2071 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jan 2010 20:22:28 EST
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1NXlDI-00019J-Gu
	for git@vger.kernel.org; Wed, 20 Jan 2010 19:47:56 -0500
Received: from yoh by washoe.onerussian.com with local (Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1NXlDI-00019G-AI
	for git@vger.kernel.org; Wed, 20 Jan 2010 19:47:56 -0500
Content-Disposition: inline
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137609>

Dear Git Developers,

Some users of our project started recently to complain that they could not
clone the repository via http (git:// wasn't a choice due to heavy firewalling)
and because http:// was used as a protocol to get sources in some distributions
(e.g. macports).

Cloning of the repository works fine with v1.6.5.7 but fails with v1.6.6-rc0.
I haven't done full bisection since that repository is relatively bulky and
poor server is quite loaded anyways, so I thought you just would get a clue
without going brute-force.  But here are the details:  in case of failing
operation, I immediately get failure:

$> GIT_TRACE=2 ./git clone http://git.debian.org/git/pkg-exppsy/pymvpa.git
trace: built-in: git 'clone' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
warning: templates not found /home/yoh/share/git-core/templates
Initialized empty Git repository in /home/yoh/proj/misc/git/pymvpa/.git/
trace: run_command: 'remote-curl' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
trace: exec: 'git' 'remote-curl' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
trace: exec: 'git-remote-curl' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
trace: run_command: 'git-remote-curl' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
fatal: http://git.debian.org/git/pkg-exppsy/pymvpa.git/info/refs?service=git-upload-pack not found: did you run git update-server-info on the server?

on the server, 1.6.3.3 version of git was used to run git
update-server-info.

Thanks in advance
-- 
Yaroslav O. Halchenko
Postdoctoral Fellow,   Department of Psychological and Brain Sciences
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        

From: Ed Avis <eda@waniasset.com>
Subject: Running pre-commit hook
Date: Fri, 31 Jul 2015 14:57:21 +0000 (UTC)
Message-ID: <loom.20150731T164948-964@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 16:58:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLBlU-0000tX-0n
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 16:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbbGaO6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 10:58:25 -0400
Received: from plane.gmane.org ([80.91.229.3]:40962 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbbGaO6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 10:58:24 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZLBl6-0001Qm-1r
	for git@vger.kernel.org; Fri, 31 Jul 2015 16:58:04 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 16:58:04 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 16:58:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:39.0) Gecko/20100101 Firefox/39.0 Cyberfox/39.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275049>

Currently, git commit --dry-run does not run any hooks, not even pre-commit:

% mkdir test
% cd test
% git init
Initialized empty Git repository in /home/eda/test/.git/
% ln -s /bin/false .git/hooks/pre-commit
% touch a
% git add a
% git commit --dry-run -m. a >/dev/null && echo yes
yes
% git commit -m. a && echo yes
(fails)

It would sometimes be useful to run the pre-commit hook without committing,
for example to get some initial checks done before prompting the user to enter
a log message.  (git commit itself works this way, of course, but I am
thinking of development environments and editors that interface to git.)

Is there a way to do a dry run commit that also runs some of the hooks?

-- 
Ed Avis <eda@waniasset.com>

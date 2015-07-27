From: Ed Avis <eda@waniasset.com>
Subject: Log messages beginning # and git rebase -i
Date: Mon, 27 Jul 2015 11:38:23 +0000 (UTC)
Message-ID: <loom.20150727T133256-715@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 13:38:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJgjx-0000f7-Ih
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 13:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbbG0Lih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 07:38:37 -0400
Received: from plane.gmane.org ([80.91.229.3]:49950 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753AbbG0Lih (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 07:38:37 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZJgjl-0000Ya-3E
	for git@vger.kernel.org; Mon, 27 Jul 2015 13:38:29 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 13:38:29 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 13:38:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:39.0) Gecko/20100101 Firefox/39.0 Cyberfox/39.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274668>

git commit will happily let you specify log messages beginning with #.
But then on git rebase -i, when squashing some commits, the editing for the
combined log message treats lines beginning with # as comments.  This means
that if you are not careful the commit message can get lost on rebasing.

I suggest that git rebase should add an extra space at the start of existing
log message lines which begin with #.  That is a bit of a kludge but it is
better than losing them because they got mixed up with comments.

-- 
Ed Avis <eda@waniasset.com>

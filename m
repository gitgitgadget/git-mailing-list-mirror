From: Alex Cornejo <acornejo@gmail.com>
Subject: git init with template dir
Date: Fri, 12 Jun 2015 07:09:18 +0000 (UTC)
Message-ID: <loom.20150612T085835-977@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 09:15:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3JBL-0005GZ-Mv
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 09:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbbFLHPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 03:15:11 -0400
Received: from plane.gmane.org ([80.91.229.3]:38419 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753274AbbFLHPI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 03:15:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Z3JBB-0005BH-FZ
	for git@vger.kernel.org; Fri, 12 Jun 2015 09:15:05 +0200
Received: from cpe-172-91-14-114.socal.res.rr.com ([172.91.14.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 09:15:05 +0200
Received: from acornejo by cpe-172-91-14-114.socal.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 09:15:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 172.91.14.114 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.124 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271474>

I was surprised to see that when using git-init, if the template folder
is itself a symlink, then the contents of the template is NOT copied to
the resulting git repository, but instead each individual file is
symlinked.

For my particular use case, this is undesirable (since if I am not
careful, then when I change the hook of one git repo, it
actually changes the hooks of all other repos too). It is easy
enough for me to work around this (i.e. by instead pointing my gitconfig
to use a template dir which is not a symlink), but I was
wondering weather this is a feature folks use (and for what end), or if
this is unintended behavior.

Furthermore, would a patch be welcome that either disables this
feature through an option (or perhaps permanently by just copying the
contents of the symlinked folder instead of creating individual
symlinks), or am I the only git user that was surprised by this
behavior and wanted to disable it?

- Alex

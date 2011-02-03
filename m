From: Alexey Shumkin <zapped@mail.ru>
Subject: Re: [PATCH] gitk: Honor encoding conversion in a sole place for all possible cases
Date: Thu, 3 Feb 2011 17:20:57 +0000 (UTC)
Message-ID: <loom.20110203T181237-77@post.gmane.org>
References: <1296751353-8632-1-git-send-email-zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 03 18:21:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl2rs-0007yV-Vn
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 18:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756595Ab1BCRVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 12:21:10 -0500
Received: from lo.gmane.org ([80.91.229.12]:43387 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581Ab1BCRVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 12:21:09 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pl2rj-0007qW-MA
	for git@vger.kernel.org; Thu, 03 Feb 2011 18:21:08 +0100
Received: from 212.34.37.3 ([212.34.37.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 18:21:07 +0100
Received: from zapped by 212.34.37.3 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 18:21:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.34.37.3 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.10 (KHTML, like Gecko) Chrome/8.0.552.237 Safari/534.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165984>

> Still buggy on Cygwin 1.7: on a clear working copy shows
> non-latin named files as removed and not indexed

Oh! Fixed! The matter was in LC_ALL enviroment variable.
It is set in my cygwin.bat (or ~/.bashrc).
For some reason it is not set with bash when running "gitk" command
(moreover when I ran gitk with "%CYGPATH%\bin\wish84.exe %CYGPATH%\bin\gitk")
I set it in system environment. That fixes incorrect working copy
status detection.

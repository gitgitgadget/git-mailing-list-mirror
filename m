From: doki_pen <doki_pen@doki-pen.org>
Subject: minor git-svn bug
Date: Thu, 02 Jul 2009 13:16:49 -0400
Message-ID: <4A4CEB81.4080309@doki-pen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 19:17:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMPuZ-0008Bj-3H
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 19:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbZGBRRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 13:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbZGBRRQ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 13:17:16 -0400
Received: from doki-pen.org ([74.207.224.154]:38810 "EHLO doki-pen.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbZGBRRP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 13:17:15 -0400
Received: from [192.168.32.11] (unknown [209.190.172.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by doki-pen.org (Postfix) with ESMTPSA id AC4665382A
	for <git@vger.kernel.org>; Thu,  2 Jul 2009 13:15:19 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090511)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122656>

Is this the right place to bring up bugs?  Or only patches?  Anyway, I 
found a small bug.

Due to some strange structure on the svn host, I have manually added the 
fetch lines to the [svn-remote] section of config.  There are hundreds 
of branches and tags, so I only have lines for what I need.  I removed 
one that I thought I didn't need anymore, and also removed the remote 
tracking branch.  When I discovered that I needed the branch again, I 
added it back to svn-remotes and did a git svn fetch.  There were no new 
commits on the branch, so the remote tracking branch was not recreated.  
The work around was to do a commit on the branch via svn, then git svn 
fetch.  This caused the remote tracking branch to reappear. 

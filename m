From: Dane Jensen <careo@fastmail.fm>
Subject: [Bug] Segfault in git status
Date: Mon, 18 Feb 2008 00:36:52 -0800
Message-ID: <F8D3F7F0-3A98-4576-BD89-6E5C682B351C@fastmail.fm>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 09:37:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR1VE-0006DE-3b
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 09:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049AbYBRIg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 03:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755058AbYBRIg4
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 03:36:56 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:52009 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754936AbYBRIg4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Feb 2008 03:36:56 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 5120D91685
	for <git@vger.kernel.org>; Mon, 18 Feb 2008 03:36:55 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 18 Feb 2008 03:36:55 -0500
X-Sasl-enc: 0YRx+AECdBOBSMdHDGulMSKMMiBHP49qeJS6JkqtlqMq 1203323815
Received: from [192.168.1.146] (unknown [208.71.31.193])
	by mail.messagingengine.com (Postfix) with ESMTP id E812BA5E3
	for <git@vger.kernel.org>; Mon, 18 Feb 2008 03:36:54 -0500 (EST)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74244>

Hi all-

Somehow I've managed to create a repository that causes git status to  
segfault. To be honest, I'm not entirely sure how just yet. This comes  
after a weekend of splitting a repository into two separate  
repositories, filtering out a directory from one, and then creating  
grafts in those repositories to skip commits that now change nothing.

This was in OS X 10.5.2 with git compiled from cf5c51e. Falling back  
to 1.5.4.2 cleared it up, so with the help of git bisect I've narrowed  
the bug down to cf55870.

I'll spend some time this week trying to find the exact point in my  
filtering that git status went south and report back if I can  
replicate it in a more-controlled test.

-Dane

From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: git rev-list --author/--committer b0rked with -F/--fixed-strings
Date: Thu, 04 Sep 2008 08:47:37 +0200
Message-ID: <g9o0ac$qig$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 08:49:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb8eL-00031B-CH
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 08:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbYIDGrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 02:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbYIDGry
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 02:47:54 -0400
Received: from main.gmane.org ([80.91.229.2]:57625 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870AbYIDGry (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 02:47:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kb8dA-0006eK-HZ
	for git@vger.kernel.org; Thu, 04 Sep 2008 06:47:48 +0000
Received: from 78.15.13.249 ([78.15.13.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 06:47:48 +0000
Received: from giuseppe.bilotta by 78.15.13.249 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 06:47:48 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 78.15.13.249
User-Agent: KNode/0.10.9
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94899>

Hello all,

I was recently looking into the reason why the gitweb search box
failed to provide results when using the author and committer
search and NOT using regexp searches.

I managed to track the fault down to the inability for git
rev-list to handle --author and --committer in conjunction with
the --fixed-strings option.

It's not difficult to see that the reason for this is that the
author and committer search patterns are *always* built as regular
expressions. However, I couldn't see any obvious way to do things
in a *different* way ...

So, is this a known bug (I would call it a bug, yes) in rev-list?
Are there any ideas around on how to fix it?

-- 
Giuseppe "Oblomov" Bilotta

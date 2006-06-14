From: Jakub Narebski <jnareb@gmail.com>
Subject: 'sparse' clone idea
Date: Wed, 14 Jun 2006 10:23:54 +0200
Organization: At home
Message-ID: <e6oh2g$ngh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jun 14 10:24:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqQfm-0006rM-QV
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 10:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWFNIYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 04:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWFNIYM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 04:24:12 -0400
Received: from main.gmane.org ([80.91.229.2]:44491 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751242AbWFNIYL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jun 2006 04:24:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FqQfP-0006mA-89
	for git@vger.kernel.org; Wed, 14 Jun 2006 10:24:00 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jun 2006 10:23:59 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jun 2006 10:23:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21832>

I wonder if 'sparse clone' idea described below would avoid the most
difficult part of 'shallow clone' idea, namely the [sometimes] need to
un-cauterize history. See: (<7vac8lidwi.fsf@assigned-by-dhcp.cox.net>).

'sparse clone' begins like 'shallow clone': full history is copied down to
specified point of history (cut-off or cauterization point for shallow
clone), but instead of cauterizing the history from that point downwards,
the history is simplified using grafts.

In the sparse part we need:
 * all commits pointed by tags (if we clone/copy tags) 
   and other refs (if we clone/copy those tags)
 * merge bases for all commits in full, and in the sparse part,
   _including_ merge bases themselves
 * all roots

Commits in sparse part would be connected like in original history, only
skipping "uniteresting" commits.


Thoughts? Comments?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

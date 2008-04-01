From: Teemu Likonen <tlikonen@iki.fi>
Subject: BUG: "git add --interactive" does not work with UTF-8 filenames
Date: Tue, 1 Apr 2008 22:32:03 +0300
Message-ID: <200804012232.03559.tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 01 21:33:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgmE0-0004CK-7v
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 21:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561AbYDATcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 15:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754377AbYDATcI
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 15:32:08 -0400
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:58796 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753516AbYDATcG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2008 15:32:06 -0400
Received: from [192.168.0.2] (80.220.180.181) by pne-smtpout3-sn1.fre.skanova.net (7.3.129)
        id 47A78857003269F7 for git@vger.kernel.org; Tue, 1 Apr 2008 21:32:04 +0200
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78660>

I just learnt that "git add --interactive" does not work with UTF-8 
encoded filenames. Maybe it's about all 8-bit characters.

The menu invoked with command

  git add -i <file>

does not even show this <file> if the name contains UTF-8 characters. 
Command and menu

  git add -i

shows the file but nothing can be done with it. Neither "patch" 
nor "update" does work, for example.


As a side note/rant: Git tends to show non-Ascii characters in filenames 
as \xxx escape sequences. It's not a big problem but surely it's not 
very nice to read if (say) half of the word's letters are escaped like 
this. I believe Git is mostly used for tracking source codes where 
Ascii-only filenames are a common practice. I'm using Git to develop 
Finnish spell-checking system (called Voikko) and we have some 
non-Ascii filenames in the repo.

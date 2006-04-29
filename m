From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Do not use zlib 1.1.3 with git packs!
Date: Sat, 29 Apr 2006 02:52:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604290245510.30565@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Apr 29 02:53:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZdhh-0005x4-Kp
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 02:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWD2Awy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 20:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWD2Awy
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 20:52:54 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:32975 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030270AbWD2Awx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Apr 2006 20:52:53 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id AAB8414C2
	for <git@vger.kernel.org>; Sat, 29 Apr 2006 02:52:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 9EDE81433
	for <git@vger.kernel.org>; Sat, 29 Apr 2006 02:52:52 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 811DEBC2
	for <git@vger.kernel.org>; Sat, 29 Apr 2006 02:52:52 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19289>

Hi,

I had a strange effect when trying to repack a git repository on my iBook: 
first, "git-repack -a -d" would quit without an error message when about 
57% of the objects were written (*not* when deltifying them!).

It became even stranger when I tracked it to a segmentation fault in 
adler32(), where the debugger insisted that a buffer was NULL, but the 
calling code insisted it was not.

Upgrading to zlib 1.2.3 helped. That is, after I had a complete systen 
fsck-up, since virtually every binary, including su, login and getty, are 
linked to zlib on Mac OS X. (Yeah, yeah, no Linux, I know.)

Ciao,
Dscho

P.S.: This _might_ be related to the git-repack issue that came up a few 
days ago.

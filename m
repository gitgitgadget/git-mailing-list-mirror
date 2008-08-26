From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Something fishy with master.  After a ./configure on OpenServer 6
Date: Tue, 26 Aug 2008 04:16:23 -0600
Message-ID: <alpine.LNX.1.10.0808260410580.6723@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 12:17:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXvcA-0001Ik-17
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 12:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356AbYHZKQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 06:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbYHZKQZ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 06:16:25 -0400
Received: from suse104.zenez.com ([198.60.105.164]:1064 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbYHZKQY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 06:16:24 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id C0CC6A7C8AA; Tue, 26 Aug 2008 04:16:23 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id A7CB6A7C891
	for <git@vger.kernel.org>; Tue, 26 Aug 2008 04:16:23 -0600 (MDT)
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93731>

Hello,

This is just a heads up on what I am seeing with the latest master.  I 
never saw any of this with 1.5.X.X

Every thing compiled just fine.  But when I tried to do a gmake check I 
noticed I have things defined that should not be.For example powerpc and 
BIG_ENDIAN should not have been defined.  I will look into this, but 
things are a bit broken with master.  See below.

$ gmake check
for i in *.c; do sparse -Kalloca -Kthread -I/usr/local/include 
-DNO_D_TYPE_IN_DIRENT -DSHA1_HEADER='<openssl/sha.h>' 
-DSNPRINTF_RETURNS_BOGUS -DFREAD_READS_DIRECTORIES -DNO_STRCASESTR 
-DNO_MKDTEMP -DNO_HSTRERROR -DNO_MEMMEM -D__BIG_ENDIAN__ -D__powerpc__ $i 
|| exit; done
/usr/bin/bash: sparse: command not found


--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047

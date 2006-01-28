From: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Subject: [RFC] Adding specialized indexes to speed up slow operations
Date: Sat, 28 Jan 2006 18:18:19 +1300
Message-ID: <43DAFE9B.7080508@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 28 06:18:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2iTo-0008IL-81
	for gcvg-git@gmane.org; Sat, 28 Jan 2006 06:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWA1FSZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jan 2006 00:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWA1FSZ
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jan 2006 00:18:25 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:53950 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S932523AbWA1FSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2006 00:18:25 -0500
Received: from [202.53.187.9] (helo=[10.2.250.255])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1F2iTd-0001PE-J9; Sat, 28 Jan 2006 18:18:21 +1300
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15191>

The git internal storage model is optimized for some operations (those 
that Linus considers common in his workflow), while some other commands 
end up being rather expensive, like git-whatchanged 
/some/deep/path/file.c or git-log /someother/file/deep/in/the/tree.c

For some stuff I'm working on (cvs daemon emulation) my plan is to have 
a stupid && rebuildable set of indexes to speed up cvs-like annotates 
and per-file cvs-like changelogs. Knowing very little about efficient 
data structures, I'll probably use something uninspiring like SQLite. 
But it's one of those things that perhaps belongs in the core -- not 
cvs-like stuff, but utilities to build and maintain some specialized 
indexes.

cheers,


martin
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224                              MOB: +64(21)364-017
       Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------

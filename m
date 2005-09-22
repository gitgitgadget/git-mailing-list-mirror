From: Wolfgang Denk <wd@denx.de>
Subject: cg-export incompatible with older versions of GNU tar
Date: Thu, 22 Sep 2005 13:23:31 +0200
Message-ID: <20050922112331.75971353A0B@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 22 13:26:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIPC4-000199-SC
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 13:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbVIVLYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 07:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbVIVLYH
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 07:24:07 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:14229 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030255AbVIVLYF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 07:24:05 -0400
Received: from fwd29.aul.t-online.de 
	by mailout04.sul.t-online.com with smtp 
	id 1EIPBG-0000kM-02; Thu, 22 Sep 2005 13:23:58 +0200
Received: from denx.de (TiSfowZLwerKpR3lvwKoFsOqtmUAozcGR5G5A6vLcEwM920K-O8eU+@[84.150.102.249]) by fwd29.sul.t-online.de
	with esmtp id 1EIPAw-0Lz5Qu0; Thu, 22 Sep 2005 13:23:38 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id B91AD42A4A; Thu, 22 Sep 2005 13:23:37 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 75971353A0B;
	Thu, 22 Sep 2005 13:23:31 +0200 (MEST)
To: git@vger.kernel.org
X-ID: TiSfowZLwerKpR3lvwKoFsOqtmUAozcGR5G5A6vLcEwM920K-O8eU+@t-dialin.net
X-TOI-MSGID: e504f922-a0c8-4137-98e2-1c2c86da3a08
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9108>

Minor compatibility issue:

The archives created by the "cg-export" command contain entries  that
cause problems with older versions of GNU tar:

-> cg-export /tmp/foo.tar.bz2
-> tar jtvf /tmp/foo.tar.bz2
?rw------- git/git          52 1970-01-01 01:00:00 pax_global_header unknown file type `g'
drwxr-xr-x git/git           0 2005-09-22 09:46:19 foo/
-rw-r--r-- git/git      134225 2005-09-22 09:46:19 foo/CHANGELOG
-rw-r--r-- git/git       15701 2005-09-22 09:46:19 foo/COPYING
-rw-r--r-- git/git        9960 2005-09-22 09:46:19 foo/CREDITS
-rw-r--r-- git/git        9578 2005-09-22 09:46:19 foo/MAINTAINERS
...
-> tar jxf foo.tar.bz2 
tar: pax_global_header: Unknown file type 'g', extracted as normal file
...
-> tar --version
tar (GNU tar) 1.13.25
...
-> rpm -q git-core cogito
git-core-0.99.7-1
cogito-0.15-1


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Man is the best computer we can put aboard a spacecraft ...  and  the
only one that can be mass produced with unskilled labor.
                                                 -- Wernher von Braun

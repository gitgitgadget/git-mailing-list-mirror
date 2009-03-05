From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: bug in checkout/status ?
Date: Thu, 5 Mar 2009 12:48:01 -0800
Message-ID: <20090305204801.GA16213@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 21:49:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfKVa-0007O3-Oi
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 21:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbZCEUsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 15:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754061AbZCEUsF
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 15:48:05 -0500
Received: from george.spearce.org ([209.20.77.23]:51643 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530AbZCEUsE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 15:48:04 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 48C9738211; Thu,  5 Mar 2009 20:48:01 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112338>

WTF.  This shows up in git 1.6.0.2 through current 'next':

$ git clone git://android.git.kernel.org/platform/external/elfutils std_git
$ cd std_git/
$ git status
# On branch master

# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   libelf-po/ChangeLog
#       modified:   libelf-po/Makefile
#       modified:   libelf-po/Makefile.in
#       modified:   libelf-po/Makefile.in.in
#       modified:   libelf-po/Makevars
#       modified:   libelf-po/POTFILES
#       modified:   libelf-po/POTFILES.in
#       modified:   libelf-po/Rules-quot
#       modified:   libelf-po/boldquot.sed
#       modified:   libelf-po/insert-header.sin
#       modified:   libelf-po/libelf.pot
#       modified:   libelf-po/quot.sed
#

$ git diff-index HEAD
:000000 100644 0000000000000000000000000000000000000000 78eb2ff1b7e79d00e827c97a7d4f52ca7d129155 A      libelf-po/ChangeLog
:000000 100644 0000000000000000000000000000000000000000 afd56475e1ae3a51ed30124a7671821581fbf833 A      libelf-po/Makefile
:000000 100644 0000000000000000000000000000000000000000 21eb20d30794c6d9151c89a3b35c4365902221fc A      libelf-po/Makefile.in
:000000 100644 0000000000000000000000000000000000000000 4a7a26885ff4ed63205538741a45950b10b8cf95 A      libelf-po/Makefile.in.in
:000000 100644 0000000000000000000000000000000000000000 0accb70a14c5808668bdf7a21668767f0fa2e608 A      libelf-po/Makevars
:000000 100644 0000000000000000000000000000000000000000 f17f924d6f5748e15c238d1006e568abb4c3240e A      libelf-po/POTFILES
:000000 100644 0000000000000000000000000000000000000000 b25620fba0f1b74f351909d525a3e41101396260 A      libelf-po/POTFILES.in
:000000 100644 0000000000000000000000000000000000000000 5f46d237d2593c674ab34518cf342553fe0f6aef A      libelf-po/Rules-quot
:000000 100644 0000000000000000000000000000000000000000 4b937aa517bcff9f5adfc2a01d6d780445999297 A      libelf-po/boldquot.sed
:000000 100644 0000000000000000000000000000000000000000 b26de01f6c88c7b15bb4815a8fcd5120d479300d A      libelf-po/insert-header.sin
:000000 100644 0000000000000000000000000000000000000000 dfcd7704b3b16f040158b435acb9244a6d6cfa6a A      libelf-po/libelf.pot
:000000 100644 0000000000000000000000000000000000000000 0122c46318dc8bc115167fa2c259f8456668f861 A      libelf-po/quot.sed
:100644 000000 78eb2ff1b7e79d00e827c97a7d4f52ca7d129155 0000000000000000000000000000000000000000 D      libelf-po/ChangeLog
:100644 000000 afd56475e1ae3a51ed30124a7671821581fbf833 0000000000000000000000000000000000000000 D      libelf-po/Makefile
:100644 000000 21eb20d30794c6d9151c89a3b35c4365902221fc 0000000000000000000000000000000000000000 D      libelf-po/Makefile.in
:100644 000000 4a7a26885ff4ed63205538741a45950b10b8cf95 0000000000000000000000000000000000000000 D      libelf-po/Makefile.in.in
:100644 000000 0accb70a14c5808668bdf7a21668767f0fa2e608 0000000000000000000000000000000000000000 D      libelf-po/Makevars
:100644 000000 f17f924d6f5748e15c238d1006e568abb4c3240e 0000000000000000000000000000000000000000 D      libelf-po/POTFILES
:100644 000000 b25620fba0f1b74f351909d525a3e41101396260 0000000000000000000000000000000000000000 D      libelf-po/POTFILES.in
:100644 000000 5f46d237d2593c674ab34518cf342553fe0f6aef 0000000000000000000000000000000000000000 D      libelf-po/Rules-quot
:100644 000000 4b937aa517bcff9f5adfc2a01d6d780445999297 0000000000000000000000000000000000000000 D      libelf-po/boldquot.sed
:100644 000000 b26de01f6c88c7b15bb4815a8fcd5120d479300d 0000000000000000000000000000000000000000 D      libelf-po/insert-header.sin
:100644 000000 dfcd7704b3b16f040158b435acb9244a6d6cfa6a 0000000000000000000000000000000000000000 D      libelf-po/libelf.pot
:100644 000000 0122c46318dc8bc115167fa2c259f8456668f861 0000000000000000000000000000000000000000 D      libelf-po/quot.sed

WTF. Add -M and it sees modifies:

$ git diff-index -M HEAD
:100644 100644 78eb2ff1b7e79d00e827c97a7d4f52ca7d129155 78eb2ff1b7e79d00e827c97a7d4f52ca7d129155 M      libelf-po/ChangeLog
:100644 100644 afd56475e1ae3a51ed30124a7671821581fbf833 afd56475e1ae3a51ed30124a7671821581fbf833 M      libelf-po/Makefile
:100644 100644 21eb20d30794c6d9151c89a3b35c4365902221fc 21eb20d30794c6d9151c89a3b35c4365902221fc M      libelf-po/Makefile.in
:100644 100644 4a7a26885ff4ed63205538741a45950b10b8cf95 4a7a26885ff4ed63205538741a45950b10b8cf95 M      libelf-po/Makefile.in.in
:100644 100644 0accb70a14c5808668bdf7a21668767f0fa2e608 0accb70a14c5808668bdf7a21668767f0fa2e608 M      libelf-po/Makevars
:100644 100644 f17f924d6f5748e15c238d1006e568abb4c3240e f17f924d6f5748e15c238d1006e568abb4c3240e M      libelf-po/POTFILES
:100644 100644 b25620fba0f1b74f351909d525a3e41101396260 b25620fba0f1b74f351909d525a3e41101396260 M      libelf-po/POTFILES.in
:100644 100644 5f46d237d2593c674ab34518cf342553fe0f6aef 5f46d237d2593c674ab34518cf342553fe0f6aef M      libelf-po/Rules-quot
:100644 100644 4b937aa517bcff9f5adfc2a01d6d780445999297 4b937aa517bcff9f5adfc2a01d6d780445999297 M      libelf-po/boldquot.sed
:100644 100644 b26de01f6c88c7b15bb4815a8fcd5120d479300d b26de01f6c88c7b15bb4815a8fcd5120d479300d M      libelf-po/insert-header.sin
:100644 100644 dfcd7704b3b16f040158b435acb9244a6d6cfa6a dfcd7704b3b16f040158b435acb9244a6d6cfa6a M      libelf-po/libelf.pot
:100644 100644 0122c46318dc8bc115167fa2c259f8456668f861 0122c46318dc8bc115167fa2c259f8456668f861 M      libelf-po/quot.sed


I'm trying to debug it now, but I'd appreciate any help from
those that know more about this part of diffcore and the working
tree code..

-- 
Shawn.

From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 00/16] GSOC remote-svn, rewritten patch series
Date: Thu, 26 Jul 2012 09:32:21 +0200
Message-ID: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 09:34:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuIaP-0004Zi-RE
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 09:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329Ab2GZHeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 03:34:11 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58737 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125Ab2GZHeK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 03:34:10 -0400
Received: by bkwj10 with SMTP id j10so1067267bkw.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 00:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=cY7nZt4A6FZp0x4/7l9VIKEIzJBJqnYYYf2OS1nwN/s=;
        b=cvcYp6p7uZWg5fwOuezWpOpL1Mae4hKhkOzPOJSiaLr4y8UAajekwxTSSEPYZPHqMk
         2Ccf30Rec5zNJrzrUH1+gApUuGrNo6mNaeGyad8A6PzeqU8ciYa1tAhHCfGElHibL5Jk
         12D0O69tg3HQPdpICsvOZCyyWe+p8eJlKG6p6JyqALchrTpGFE0fwOHQYcMDjf98brIo
         N9Wtle8P2kvclIUPnG0wx0xX2ZOhx0OVRDGxSAatXfxsnSlKz69bDLFKx3m8/gIQVIBW
         3rv34ABzKBp0FgWUP/cgS+VbX+inOLxvH+I0pAmas5oCiWhS3mX0GUAEktvJwyr+X6wY
         akZg==
Received: by 10.204.152.145 with SMTP id g17mr13247515bkw.120.1343288048649;
        Thu, 26 Jul 2012 00:34:08 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id n5sm13880348bkv.14.2012.07.26.00.34.04
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 00:34:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202230>

Hi!

I decided to completely rewrite my commit history, I split, dropped, squashed, and reordered.
And finally rebased it all onto the current master.
Hope this removed a lot of my personal confusion and makes the patches 
more useful and understandable.
I think the remote helper does what it should now, except creating branches.
Several patches depend on each other, but some are purely optional and there are
working intermediate states.
I'll add some comments in the table of contents below.


[RFC 01/16] Implement a remote helper for svn in C.
[RFC 02/16] Integrate remote-svn into svn-fe/Makefile.
[RFC 03/16] Add svndump_init_fd to allow reading dumps from
[RFC 04/16] Add cat-blob report fifo from fast-import to #this one is still in discussion
[RFC 05/16] remote-svn, vcs-svn: Enable fetching to private refs.
[RFC 06/16] Add a symlink 'git-remote-svn' in base dir.
# basic functionality is available from here.
# additional features follow
[RFC 07/16] Allow reading svn dumps from files via file:// urls.
[RFC 08/16] vcs-svn: add fast_export_note to create notes
[RFC 09/16] Create a note for every imported commit containing svn
[RFC 10/16] When debug==1, start fast-import with "--stats" instead #optional
[RFC 11/16] Add explanatory comment for transport-helpers refs #optional
[RFC 12/16] remote-svn: add incremental import.
[RFC 13/16] Add a svnrdump-simulator replaying a dump file for
[RFC 14/16] transport-helper: add import|export-marks to fast-import
[RFC 15/16] remote-svn: add marks-file regeneration.
[RFC 16/16] Add a test script for remote-svn.


--
Florian

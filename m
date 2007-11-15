From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: [PATCH] Fix Solaris compiler warnings
Date: Thu, 15 Nov 2007 23:19:11 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711152317140.7416@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 23:19:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isn3f-00079X-Rt
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 23:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759440AbXKOWTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 17:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764677AbXKOWTR
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 17:19:17 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54330 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757750AbXKOWTQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2007 17:19:16 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 4F0AF477C0
	for <git@vger.kernel.org>; Thu, 15 Nov 2007 17:19:15 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 15 Nov 2007 17:19:15 -0500
X-Sasl-enc: so7KXiUJOxNbcukQQxZVYuFlv+PMIr45OIE0ubMdX2Fy 1195165154
Received: from [192.168.2.101] (p549A10B1.dip0.t-ipconnect.de [84.154.16.177])
	by mail.messagingengine.com (Postfix) with ESMTP id 8D7BA2A57E
	for <git@vger.kernel.org>; Thu, 15 Nov 2007 17:19:14 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65174>

Hello,

the below patch fixes some compiler warnings returned by Solaris Workshop 
Compilers.

     CC builtin-apply.o
"builtin-apply.c", line 686: warning: statement not reached
     CC utf8.o
"utf8.c", line 287: warning: statement not reached
     CC xdiff/xdiffi.o
"xdiff/xdiffi.c", line 261: warning: statement not reached
     CC xdiff/xutils.o
"xdiff/xutils.c", line 236: warning: statement not reached

Signed-off-by: Guido Ostkamp <git@ostkamp.fastmail.fm>
---
  builtin-apply.c |    1 -
  utf8.c          |    1 -
  xdiff/xdiffi.c  |    2 --
  xdiff/xutils.c  |    2 --
  4 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 8edcc08..91f8752 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -683,7 +683,6 @@ static char *git_header_name(char *line, int llen)
  			}
  		}
  	}
-	return NULL;
  }

  /* Verify that we recognize the lines following a git header */
diff --git a/utf8.c b/utf8.c
index 8095a71..9efcdb9 100644
--- a/utf8.c
+++ b/utf8.c
@@ -284,7 +284,6 @@ int print_wrapped_text(const char *text, int indent, int indent2, int width)
  			text++;
  		}
  	}
-	return w;
  }

  int is_encoding_utf8(const char *name)
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 5cb7171..1bad846 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -257,8 +257,6 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
  			return ec;
  		}
  	}
-
-	return -1;
  }


diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 2ade97b..d7974d1 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -232,8 +232,6 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
  		return i1 >= s1 && i2 >= s2;
  	} else
  		return s1 == s2 && !memcmp(l1, l2, s1);
-
-	return 0;
  }

  static unsigned long xdl_hash_record_with_whitespace(char const **data,
-- 
1.5.3.5.721.g039b

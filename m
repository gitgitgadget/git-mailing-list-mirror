From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/5] Makefile: remove wt-status.h from LIB_H
Date: Sat, 23 Jan 2010 08:44:48 -0600
Message-ID: <20100123144448.GD11903@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 15:44:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYhEJ-00029Z-Ak
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 15:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754960Ab0AWOoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 09:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754798Ab0AWOoq
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 09:44:46 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:45694 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727Ab0AWOop (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 09:44:45 -0500
Received: by iwn16 with SMTP id 16so927041iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 06:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2RuGwreR3NXyBZl1y2+YTt+rJFhAZy+m03yTRQDhyGs=;
        b=Bg/MWYY8KQRwjOVezZc85Hu1f8rFsHE2DWim8kV7EY5jCh+MIRA/ledxzVSZEhMUW/
         FRPNivhATSQ6aOzXw923UtuDeQUzM0olUhVNiBadzRixwMfjBORjCnYwMAEWxN0ogsOS
         3iRWmPTVBYqoVEh1MpE5qXILgokbetlk7u8wA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AphAd9PEC8uhXpPE9vDA4VtqMlcS/kzLRWnzv8VqNftK5mzIq7s9kvVRuJfUGOMmj6
         4xqfIHUbBrk7VkqElHpIkienUAwPhSmWkRXAiMfxRJN6RuMhpRtbJfZj7nHU1nV9dsgw
         z1kudEY1Dp87E2t89pc+JutY3p8QVsxohDqy0=
Received: by 10.231.146.66 with SMTP id g2mr784993ibv.88.1264257884371;
        Sat, 23 Jan 2010 06:44:44 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm2827813iwn.5.2010.01.23.06.44.43
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 06:44:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100123144201.GA11903@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137845>

A list of the few translation units using this header is
half-populated already.  Including the dependency on this header
twice (once explicitly, once through LIB_H) makes it difficult to
figure out where future headers should be added to the Makefile.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I imagine the 'status' output is not used widely enough to consider it
a library header yet, but I could be easily convinced otherwise.
More important is to avoid the confusing double-dependency.

 Makefile |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 448d552..7da52a3 100644
--- a/Makefile
+++ b/Makefile
@@ -512,7 +512,6 @@ LIB_H += tree-walk.h
 LIB_H += unpack-trees.h
 LIB_H += userdiff.h
 LIB_H += utf8.h
-LIB_H += wt-status.h
 LIB_H += xdiff-interface.h
 LIB_H += xdiff/xdiff.h
 
@@ -1663,7 +1662,7 @@ builtin-bisect--helper.o builtin-rev-list.o bisect.o: bisect.h
 builtin-clone.o builtin-fetch-pack.o transport.o: fetch-pack.h
 builtin-send-pack.o transport.o: send-pack.h
 builtin-log.o builtin-shortlog.o: shortlog.h
-builtin-revert.o wt-status.o: wt-status.h
+builtin-commit.o builtin-revert.o wt-status.o: wt-status.h
 builtin-prune.o builtin-reflog.o reachable.o: reachable.h
 builtin-tar-tree.o archive-tar.o: tar.h
 builtin-pack-objects.o: thread-utils.h
-- 
1.6.6.rc2

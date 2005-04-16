From: Paul Jackson <pj@sgi.com>
Subject: [PATCH] missing mkdir -p flag in gitdiff-do
Date: Sat, 16 Apr 2005 16:27:54 -0700 (PDT)
Message-ID: <20050416232800.23430.72770.sendpatchset@sam.engr.sgi.com>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
Cc: Petr Baudis <pasky@ucw.cz>, Paul Jackson <pj@sgi.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 01:25:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwf5-0004GF-EQ
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 01:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVDPX24 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 19:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVDPX24
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:28:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:22224 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261196AbVDPX2q (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 19:28:46 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3H186B2004742;
	Sat, 16 Apr 2005 18:08:16 -0700
Received: from sam.engr.sgi.com (sam.engr.sgi.com [163.154.6.103])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with ESMTP id j3GNRslU15234591;
	Sat, 16 Apr 2005 16:27:56 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

First mkdir in gitdiff-do missing -p, so useless error

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: git-pasky-0.4/gitdiff-do
===================================================================
--- git-pasky-0.4.orig/gitdiff-do	2005-04-16 13:18:29.000000000 -0700
+++ git-pasky-0.4/gitdiff-do	2005-04-16 13:19:07.000000000 -0700
@@ -37,7 +37,7 @@ trap 'rm -fr $t.?; trap 0; exit 0' 0 1 2
 diffdir=$t.1
 diffdir1="$diffdir/$id1"
 diffdir2="$diffdir/$id2"
-mkdir "$diffdir1" "$diffdir2"
+mkdir -p "$diffdir1" "$diffdir2"
 
 while [ "$1" ]; do
 	declare -a param

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401

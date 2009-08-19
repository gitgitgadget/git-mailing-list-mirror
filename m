From: Thell Fowler <git@tbfowler.name>
Subject: [PATCH 0/6 RFC] Series to correct xutils incomplete line handling.
Date: Wed, 19 Aug 2009 18:05:16 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908191713070.2012@GWPortableVCS>
References: <1249428804.2774.52.camel@GWPortableVCS>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 20 01:05:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MduE0-0005Ur-Tc
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 01:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbZHSXFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 19:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbZHSXFk
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 19:05:40 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:59142 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbZHSXFk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 19:05:40 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1MduDs-0008Jp-NG; Wed, 19 Aug 2009 18:05:40 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <1249428804.2774.52.camel@GWPortableVCS>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126588>


[1/6]
Add supplemental test for trailing-whitespace on incomplete lines.

-- This patch is for illustrative purposes only. It exposes the current 
failures of git diff whitespace ignore options when dealing with trailing-
spaces on incomplete lines.

[2/6] through [5/6]
Make xdl_hash_record_with_whitespace ignore eof
Make diff -w handle trailing-spaces on incomplete lines.
Make diff -b handle trailing-spaces on incomplete lines.
Make diff --ignore-space-at-eol handle incomplete lines.

-- These alter the record ptr loops to go to the end of the record and to 
treat the terminator as it would '\n'.

[6/6]
Add diff tests for trailing-space on incomplete lines

-- Just the seven test cases that would identify future breakage.


 t/t4015-diff-trailing-whitespace.sh |   95 +++++++++++++++++++++++++++++++++++
 t/t4015-diff-whitespace.sh          |   33 ++++++++++++
 xdiff/xutils.c                      |   20 ++++----
 3 files changed, 138 insertions(+), 10 deletions(-)
 create mode 100755 t/t4015-diff-trailing-whitespace.sh

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 0/9] misc. cleanups
Date: Tue, 6 Mar 2007 20:44:04 -0500
Message-ID: <20070307014403.GA26482@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 02:46:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOlED-00070d-0L
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 02:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbXCGBoW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 20:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161184AbXCGBoT
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 20:44:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49190 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161175AbXCGBoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 20:44:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOlC8-0003oR-1p; Tue, 06 Mar 2007 20:43:56 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C3EE220FBAE; Tue,  6 Mar 2007 20:44:04 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41636>

This is a series of various cleanups that I have pending at the
front of my pack v4 topic.  The earlier ones are annoying nits,
the later ones fix compiler errors caused by compiling with:

--snip--
  CFLAGS += -Wall -ansi -pedantic -std=c99
  
  ifdef strict
          CFLAGS += -Werror
          CFLAGS += -Wfour-char-constants
          CFLAGS += -fnon-lvalue-assign
          CFLAGS += -Wdeclaration-after-statement
          CFLAGS += -Wpointer-arith
          CFLAGS += -Wbad-function-cast
          CFLAGS += -Wcast-align
          CFLAGS += -Wwrite-strings
          CFLAGS += -Wshorten-64-to-32
  
          # No, currently a huge set.
          #CFLAGS += -Wsign-compare
  
          # No, only in diffcore-rename and that's ok.
          #CFLAGS += -Wfloat-equal
  
          # No, unused parameters, -Wsign-compare, missing initializers.
          # CFLAGS += -Wextra
  
          # No, memcmp trips on signed/unsigned conversion.
          # CFLAGS += -Wconversion
  endif
--snap--

-- 
Shawn.

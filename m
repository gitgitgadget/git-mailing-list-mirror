From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 0/5] sha1_file.c pack reading cleanups
Date: Sat, 26 Aug 2006 04:10:16 -0400
Message-ID: <20060826081016.GB22343@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 26 10:10:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGtFS-0002p6-5Q
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 10:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422834AbWHZIKW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 04:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422740AbWHZIKW
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 04:10:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:5569 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1422834AbWHZIKU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 04:10:20 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GGtFA-00073Y-VV; Sat, 26 Aug 2006 04:10:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CE5D320FB7F; Sat, 26 Aug 2006 04:10:16 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26035>

This is a 5 patch series built on `master`.  I discovered these
cleanups when I lifted code from sha1_file.c for fast-import.c
(as I needed to read the pack I was writing and thus didn't have
a nice sorted index to work with).

I'll probably follow this series with another one which libifies
more of these functions to the point that I can actually use them
from within fast-import.c, without having an index file.  But I
might first send partial pack mapping as I'm also doing that in
fast-import.c right now.

In this series:

  1/5 Reorganize/rename unpack_non_delta_entry to unpack_compressed_entry.
  2/5 Reuse compression code in unpack_compressed_entry.
  3/5 Cleanup unpack_entry_gently and friends to use type_name array.
  4/5 Cleanup unpack_object_header to use only offsets.
  5/5 Convert unpack_entry_gently and friends to use offsets.

-- 
Shawn.

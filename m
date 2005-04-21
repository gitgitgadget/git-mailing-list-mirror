From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 00/19] summary of patch set
Date: Thu, 21 Apr 2005 11:34:26 -0700
Message-ID: <200504211834.j3LIYQuc026089@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:31:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgRY-0007hb-NI
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVDUSeu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVDUSet
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:34:49 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:60807 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261620AbVDUSea (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:34:30 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LIYOQO027738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:34:25 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LIYRWp026091
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:34:27 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LIYQuc026089
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:34:26 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Tonight I did a bunch of tiny steps towards making the cache management
code behave more like a library.  There are no longer any global variables
in read-cache.c.  Nothing ever uses more than one cache yet, but I can
see how it might simplify some of the merge code.

They're also visible here:  http://gameboy2.puremagic.com:8090/

[PATCH 01/19] write_cache api signature change, isolate active_cache and active_nr inside read-cache.c
[PATCH 02/19] Add new api's to front the active_cache and active_nr cache internals
[PATCH 03/19] convert show-diff.c to use new cache hiding api's
[PATCH 04/19] Migrate update-cache.c to use the new cache api's
[PATCH 05/19] migrate checkout-cache.c to the new cache api's
[PATCH 06/19] migrate show-files.c to the new cache api's
[PATCH 07/19] migrate merge-cache.c over to the new cache api's
[PATCH 08/19] rename remove_entry_at to remove_cache_entry_at and expose as a public api
[PATCH 09/19] migrate read-tree.c to the new cache api's
[PATCH 10/19] migrate check-files.c to the new cache api's
[PATCH 11/19] migrate write-tree.c to use the new cache api's
[PATCH 12/19] fix up diff-cache.c to use new cache api's
[PATCH 13/19] Remove active_cache, active_nr, and active_alloc from public view
[PATCH 14/19] move cache_header out of the public view
[PATCH 15/19] introduce a cache struct and move the various cache globals into it.
[PATCH 16/19] change all call sites that use the return value of read_cache to get the # of cache entries.
[PATCH 17/19] temporarily change add_cache_entry to create an empty cache on demand
[PATCH 18/19] rename cache_match_stat to ce_match_stat to match other cache_entry related functions/macros
[PATCH 19/19] the end goal of the last dozen or so commits, there's no longer a global cache variable

[PATCH 01-19/19] All of the above combined

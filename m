From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] dir.c: mark a file local function as static
Date: Thu, 30 Oct 2014 16:01:46 +0000
Message-ID: <545260EA.7050903@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 17:01:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjsAd-0001sP-Tz
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 17:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbaJ3QBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 12:01:51 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:49599 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758284AbaJ3QBv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 12:01:51 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 3F0FE38408D;
	Thu, 30 Oct 2014 16:01:01 +0000 (GMT)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id EF265384087;
	Thu, 30 Oct 2014 16:01:00 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Thu, 30 Oct 2014 16:01:00 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit b74884b86 ("untracked cache: make a wrapper around
{open,read,close}dir()", 27-10-2014) added the read_cached_dir()
function as an external symbol.

Noticed by sparse. ("'read_cached_dir' was not declared. Should it
be static?").

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Duy,

If you need to re-roll your 'nd/untracked-cache' branch, could you
please squash this into the relevant patch.

Thanks!

[If this function is destined to be used from external call sites
in future patches, then adding an extern declaration to "dir.h"
would be an alternative, of course. ;-) ]

ATB,
Ramsay Jones


 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 0040ca1..e999cc8 100644
--- a/dir.c
+++ b/dir.c
@@ -1582,7 +1582,7 @@ static int open_cached_dir(struct cached_dir *cdir,
 	return 0;
 }
 
-int read_cached_dir(struct cached_dir *cdir)
+static int read_cached_dir(struct cached_dir *cdir)
 {
 	if (cdir->fdir) {
 		cdir->de = readdir(cdir->fdir);
-- 
2.1.0

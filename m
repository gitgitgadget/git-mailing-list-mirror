From: Sven Strickroth <sven@cs-ware.de>
Subject: [PATCH 3/3] Initialize variables with values
Date: Thu, 09 May 2013 03:13:39 +0200
Message-ID: <518AF843.6040501@cs-ware.de>
References: <518AF79A.5000408@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 09 03:20:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaFXD-0002wd-JZ
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 03:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326Ab3EIBUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 21:20:08 -0400
Received: from srv1.79p.de ([213.239.234.118]:33165 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754798Ab3EIBUE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 21:20:04 -0400
X-Greylist: delayed 550 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 May 2013 21:20:04 EDT
Received: from [192.168.0.20] (p5B03ACDA.dip0.t-ipconnect.de [91.3.172.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id 3E933441055;
	Thu,  9 May 2013 03:13:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
	s=mail2013; t=1368062019;
	bh=2rkv3GSnNiGvjUyPM5iRQ/n16bYkYT7aKEnB88b+1+U=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=dN1AQzfGF+MOELvdYeB3sBJ0w5uJeoslBYUid70VNRW/FLJGTsdaveJ17d3QJzoeD
	 LiTGxaxEdW5srbexHxydZa1QkcFT5fI4fOGRLhl5nvPEPZzSk9KvgUof2q4E/vHH8y
	 ABzKuyLmLtka5GPkn1r0LGFhCzq4b7g5OgB4jzF0=
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <518AF79A.5000408@cs-ware.de>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223703>

With MSVC initializing a variable with "int a=a" causes a warning about
using an uninitialized value.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 builtin/rev-list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 67701be..13afacd 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -338,7 +338,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		mark_edges_uninteresting(revs.commits, &revs, show_edge);
 
 	if (bisect_list) {
-		int reaches = reaches, all = all;
+		int reaches = 0, all = 0;
 
 		revs.commits = find_bisection(revs.commits, &reaches, &all,
 					      bisect_find_all);
-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server

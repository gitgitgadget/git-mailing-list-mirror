From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] sparse: suppress an "using sizeof on a function" warning
Date: Fri, 07 Nov 2014 13:50:27 +0000
Message-ID: <545CCE23.5080507@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: ockham@raz.or.at
X-From: git-owner@vger.kernel.org Fri Nov 07 14:50:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmjw1-0001BH-NI
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 14:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbaKGNuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 08:50:35 -0500
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:37688 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752188AbaKGNud (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 08:50:33 -0500
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 261096A8011;
	Fri,  7 Nov 2014 13:50:31 +0000 (GMT)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 9372A6A800E;
	Fri,  7 Nov 2014 13:50:30 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Fri,  7 Nov 2014 13:50:29 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit d57da44b1 ("imap-send: use libcurl for implementation",
06-11-2014) updates the implementation of the imap-send command
to make use of libcurl's high(er)-level API functions.

In doing so, this introduces a sparse warning about "using sizeof
on a function". In order to suppress the warning, we use the same
solution used in commit 9371322a6 ("sparse: suppress some "using
sizeof on a function" warnings", 06-10-2013) which solved exactly
this problem for the other commands using libcurl.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Bernhard,

If you need to re-roll your 'br/imap-send-via-libcurl' branch, could
you please squash this into your patch.

Thanks!

ATB,
Ramsay Jones

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1ded274..0fc2790 100644
--- a/Makefile
+++ b/Makefile
@@ -1930,7 +1930,7 @@ gettext.sp gettext.s gettext.o: GIT-PREFIX
 gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
 	-DGIT_LOCALE_PATH='"$(localedir_SQ)"'
 
-http-push.sp http.sp http-walker.sp remote-curl.sp: SPARSE_FLAGS += \
+http-push.sp http.sp http-walker.sp remote-curl.sp imap-send.sp: SPARSE_FLAGS += \
 	-DCURL_DISABLE_TYPECHECK
 
 ifdef NO_EXPAT
-- 
2.1.0

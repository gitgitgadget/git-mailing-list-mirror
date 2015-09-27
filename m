From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] builtin/apply.c: make a file local symbol static
Date: Sun, 27 Sep 2015 19:33:46 +0100
Message-ID: <5608368A.4010607@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 27 20:34:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgGlt-0003Cj-HD
	for gcvg-git-2@plane.gmane.org; Sun, 27 Sep 2015 20:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbbI0Sdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2015 14:33:55 -0400
Received: from avasout07.plus.net ([84.93.230.235]:56838 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbbI0Sdy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2015 14:33:54 -0400
Received: from [10.0.2.15] ([81.174.177.104])
	by avasout07 with smtp
	id NJZm1r0012FXpih01JZnqX; Sun, 27 Sep 2015 19:33:52 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=JN/GyJ+b c=1 sm=1 tr=0
 a=IMS4QkGEsjO3VZZSAZDX8w==:117 a=IMS4QkGEsjO3VZZSAZDX8w==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=6dFJbPxCmTPggXJKGdgA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278710>


Commit dddaaab62 ("apply: convert root string to strbuf", 24-09-2015)
converted a <char *str, int len> combination of variables into a
single 'struct strbuf' variable. In doing so, it unintentionally
increased the visibility of the variable. In order to reduce the
visibility to file local, add the static keyword to the declaration
of the 'root' symbol.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jeff,

If you need to re-roll your 'jk/war-on-sprintf' series, could you
please squash this into the relevant patch.

Thanks!

ATB,
Ramsay Jones

 builtin/apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5dc908a..ec49658 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -77,7 +77,7 @@ static enum ws_ignore {
 
 
 static const char *patch_input_file;
-struct strbuf root = STRBUF_INIT;
+static struct strbuf root = STRBUF_INIT;
 static int read_stdin = 1;
 static int options;
 
-- 
2.5.0

Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43AE91FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 21:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbcFQVBf (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 17:01:35 -0400
Received: from avasout04.plus.net ([212.159.14.19]:51683 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbcFQVBe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 17:01:34 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout04 with smtp
	id 7x1R1t0065VX2mk01x1UDB; Fri, 17 Jun 2016 22:01:32 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=Gd3sjZ20Or010ox_uTcA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH:	ramsayjones@:2500
From:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] run-command: mark file-local symbols static
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
Message-ID: <57646524.7040708@ramsayjones.plus.com>
Date:	Fri, 17 Jun 2016 22:01:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jeff,

If you need to re-roll your 'jk/gpg-interface-cleanup' branch, could
you please squash this into the relevant patch (commit 74287e34,
"run-command: add pipe_command helper", 16-06-2016).

BTW, also on that branch, commit 6fec0a89 ("verify_signed_buffer: use
tempfile object", 16-06-2016) removes the last use of the git_mkstemp()
function. Should it be removed?

Thanks!

ATB,
Ramsay Jones

 run-command.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index 609fa4c..33bc63a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -886,7 +886,7 @@ struct io_pump {
 	struct pollfd *pfd;
 };
 
-int pump_io_round(struct io_pump *slots, int nr, struct pollfd *pfd)
+static int pump_io_round(struct io_pump *slots, int nr, struct pollfd *pfd)
 {
 	int pollsize = 0;
 	int i;
@@ -950,7 +950,7 @@ int pump_io_round(struct io_pump *slots, int nr, struct pollfd *pfd)
 	return 1;
 }
 
-int pump_io(struct io_pump *slots, int nr)
+static int pump_io(struct io_pump *slots, int nr)
 {
 	struct pollfd *pfd;
 	int i;
-- 
2.9.0

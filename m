From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] receive-pack.c: mark file local symbols as static
Date: Thu, 23 Oct 2014 23:58:21 +0100
Message-ID: <5449880D.1020506@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: sahlberg@google.com
X-From: git-owner@vger.kernel.org Fri Oct 24 00:58:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhRKv-0004Vo-HG
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 00:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbaJWW6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 18:58:25 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:42731 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750964AbaJWW6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 18:58:24 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id B12F64014E0;
	Thu, 23 Oct 2014 23:58:19 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 6173A4014DD;
	Thu, 23 Oct 2014 23:58:19 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Thu, 23 Oct 2014 23:58:18 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit 8796e182 ("receive-pack.c: use a single transaction when
atomic-push is negotiated", 21-10-2014) added the 'transaction'
and 'err' variables as external symbols.

Noticed by sparse. ("'err' was not declared. Should it be static?")

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Ronnie,

If you need to re-roll your 'rs/ref-transaction-send-pack' branch, could
you please squash this into the re-rolled version of commit 8796e182.

Thanks!

ATB,
Ramsay Jones


 builtin/receive-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 030698c..7f6d814 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -68,8 +68,8 @@ static const char *NONCE_SLOP = "SLOP";
 static const char *nonce_status;
 static long nonce_stamp_slop;
 static unsigned long nonce_stamp_slop_limit;
-struct strbuf err = STRBUF_INIT;
-struct transaction *transaction;
+static struct strbuf err = STRBUF_INIT;
+static struct transaction *transaction;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
-- 
2.1.0

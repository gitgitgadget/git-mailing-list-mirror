From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [PATCH] Fix warning about non-void return in a void function.
Date: Mon, 01 Aug 2005 10:05:57 -0400
Message-ID: <42EE2C45.4050004@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Aug 01 16:06:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dzavv-0004gZ-TZ
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 16:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVHAOGK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Aug 2005 10:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVHAOGK
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Aug 2005 10:06:10 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:21508 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262062AbVHAOGF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2005 10:06:05 -0400
Received: by wproxy.gmail.com with SMTP id i6so1078357wra
        for <git@vger.kernel.org>; Mon, 01 Aug 2005 07:06:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=EOm2DG7V7Uz8/q2kg82PicZDUsOusEGivdPykqC6wcfFv6FVMxuq0+3MXeygXPBjB/s7Box7dIiy+cbLK5eGi8g8qtHr8GfC7TyclYyNYKix0oJwJupC8TdfmKH6m5cWJd3MlhRMEHHtljxPhI9T+0kcn+G00WNHaex5NdzTdTI=
Received: by 10.54.46.20 with SMTP id t20mr2907988wrt;
        Mon, 01 Aug 2005 07:06:01 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id g12sm4093763wra.2005.08.01.07.06.00;
        Mon, 01 Aug 2005 07:06:01 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Fix warning about non-void return in a void function.

Signed-off-by: A Large Angry SCM <gitzilla@gmail.com>
---

 receive-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

8eda2e60f24221255b77e48f4dd60e2b025839ed
diff --git a/receive-pack.c b/receive-pack.c
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -186,7 +186,7 @@ static void unpack(void)
 	int code = run_command(unpacker, NULL);
 	switch (code) {
 	case 0:
-		return 0;
+		return;
 	case -ERR_RUN_COMMAND_FORK:
 		die("unpack fork failed");
 	case -ERR_RUN_COMMAND_EXEC:

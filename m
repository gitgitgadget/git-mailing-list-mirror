Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0664F1F404
	for <e@80x24.org>; Mon, 25 Dec 2017 10:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750899AbdLYKfC (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 05:35:02 -0500
Received: from relay1.telecom.mipt.ru ([81.5.91.10]:34754 "EHLO
        relay1.telecom.mipt.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdLYKfC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 05:35:02 -0500
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Dec 2017 05:35:01 EST
Received: from localhost (localhost [127.0.0.1])
        by relay1.telecom.mipt.ru (Postfix) with ESMTP id 64C75128CAD;
        Mon, 25 Dec 2017 13:26:50 +0300 (MSK)
X-Virus-Scanned: Debian amavisd-new at relay1.telecom.mipt.ru
Received: from relay1.telecom.mipt.ru ([127.0.0.1])
        by localhost (relay1.telecom.mipt.ru [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id MLRnrDD0-MlB; Mon, 25 Dec 2017 13:26:48 +0300 (MSK)
Received: from mail.mipt.ru (mail.mipt.ru [81.5.91.32])
        by relay1.telecom.mipt.ru (Postfix) with ESMTPS id 732AA128CAE;
        Mon, 25 Dec 2017 13:26:45 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mipt.ru; s=mail;
        t=1514197608; i=@mipt.ru;
        bh=lSQhbYJ5bdt3K0CjgTV7jNzdYoTFBrKho4usvjMfyJk=;
        h=From:To:Cc:Subject:Date:From;
        b=vRbi+P+gA7ChZuTizyyZ2BHTX/M3BFSTQeYif0scpmz0QhJPkoI87zDVSowFq9lAc
         xxcHMh75T7urtKyS6XciI4jyfzd758efK+zEtqWwO4s0QpEk9rbrNus23fkFkFi1/v
         aIZCLTbI/YptOKi7QV/WEBKdfJFwbEz8nfs0IgjA=
Received: from mail.mipt.ru (localhost [127.0.0.1])
        by mail.mipt.ru (Postfix) with ESMTPS id B4D159C7B71;
        Mon, 25 Dec 2017 13:26:44 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.mipt.ru (Postfix) with ESMTP id A7EE19C7B43;
        Mon, 25 Dec 2017 13:26:44 +0300 (MSK)
Received: from mail.mipt.ru ([127.0.0.1])
        by localhost (mail.mipt.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yQUvmSBIySK3; Mon, 25 Dec 2017 13:26:44 +0300 (MSK)
Received: from [192.168.0.134] (81.5.104.8.dhcp.mipt-telecom.ru [81.5.104.8])
        by mail.mipt.ru (Postfix) with ESMTPSA id 94E3A9C7B2D;
        Mon, 25 Dec 2017 13:26:44 +0300 (MSK)
From:   Ivan Pozdeev <vano@mail.mipt.ru>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH] Fix confusing wording
Message-ID: <8da9d436-88b9-7959-dd9c-65bdd376bf54@mail.mipt.ru>
Date:   Mon, 25 Dec 2017 13:26:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not sure if I should add a CVE-2009-0037 reference as well.

---
http.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 215bebe..26b3386 100644
--- a/http.c
+++ b/http.c
@@ -802,7 +802,7 @@ static CURL *get_curl_handle(void)
get_curl_allowed_protocols(-1));
#else
warning("protocol restrictions not applied to curl redirects because\n"
- "your curl version is too old (>= 7.19.4)");
+ "your libcurl version is too old (< 7.19.4)");
#endif
if (getenv("GIT_CURL_VERBOSE"))
curl_easy_setopt(result, CURLOPT_VERBOSE, 1L);
-- 
2.10.0.windows.1

-- 
Regards,
Ivan


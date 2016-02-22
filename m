From: larsxschneider@gmail.com
Subject: [PATCH v7 1/2] fixup: config: add 'origin_type' to config_source struct
Date: Mon, 22 Feb 2016 10:23:45 +0100
Message-ID: <1456133026-15355-2-git-send-email-larsxschneider@gmail.com>
References: <xmqqd1rsd0ac.fsf@gitster.mtv.corp.google.com>
 <1456133026-15355-1-git-send-email-larsxschneider@gmail.com>
Cc: gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 10:24:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXmit-0004ah-87
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 10:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbcBVJXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 04:23:54 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38013 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbcBVJXv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 04:23:51 -0500
Received: by mail-wm0-f41.google.com with SMTP id a4so153089210wme.1
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 01:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MNZYLbepB6vsnPWdDhyi6ud3bCvKmYIOpJuSBLm62BQ=;
        b=CNk3zmPSLGTqWYB0DQfeTPT3tOMNfBn2qOnC+spRzflywdlI4sV02Kg9ywg+TVj8Zk
         lta7YfCzFnOgfBluZKk5dKlqdXW4L2JeWIkGPhFgSJGNag5osFiFF+TiYSeY18ifneWr
         GgyrOI1eq9mUqE7uQlI6A+vQ0yO9kzFGR1HdjyqZQ+EYaoXmdh3CNeRVIViQN7KYL19n
         7Kf9KOErXAV7evm9j3OTxeaRhsLLJDuQU+MQUXutG70O0QhGB9HS7YhQqF/3cC5Zji7u
         yeFQ9xsqgRFzF+kUrwUu9rVEYrY7/Ocf8GZWdgJ/dzMJQ3O1qPvHAsoUxrD6QtfO1NlX
         7A/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MNZYLbepB6vsnPWdDhyi6ud3bCvKmYIOpJuSBLm62BQ=;
        b=flslCHIjZomtAp7LncZ8cQARjLbmmbcD/JR3aG5LHxw5ogISPJuc94KaeXHkbtAelc
         QrKJwvPtiL72sKF2W/WDOTEqUgr2XMh+xfD9juWbAfRrq6dhB1JuZFOGVj7SNIU3tUV/
         /Gttke8YRd3cD/8HWVwCxLy0NQAlyiu48+ok7qal5uX3XpsxDiw6KO9/3Mt6a1McZboX
         A+7iIadFavndMA2i26uoRuvfRwrdymudghlMJNnxou8j+koomP6SpQo7LarLcNwnjXam
         LntNlEyhE2C3z2rVQ3QQaxxCLtDGm5f/RXbO8+JLslLXDrvdwoVDgE0GPwJRsiieo4VZ
         C6FA==
X-Gm-Message-State: AG10YOTHLTnRk0Lg6Gn0nMZC7prprYyj80uhJdSsIcyuynnrZMPk+MVOql7rDMP/ZCoyTw==
X-Received: by 10.28.4.134 with SMTP id 128mr10618723wme.96.1456133030121;
        Mon, 22 Feb 2016 01:23:50 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB49D4.dip0.t-ipconnect.de. [93.219.73.212])
        by smtp.gmail.com with ESMTPSA id g126sm20054279wmf.16.2016.02.22.01.23.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 22 Feb 2016 01:23:49 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1456133026-15355-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286897>

From: Lars Schneider <larsxschneider@gmail.com>

---
 config.c               | 4 ++--
 t/t1300-repo-config.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 3be2cbc..0fce371 100644
--- a/config.c
+++ b/config.c
@@ -1081,7 +1081,7 @@ static int do_config_from_file(config_fn_t fn,
 
 static int git_config_from_stdin(config_fn_t fn, void *data)
 {
-	return do_config_from_file(fn, "stdin", "", NULL, stdin, data);
+	return do_config_from_file(fn, "standard input", "", NULL, stdin, data);
 }
 
 int git_config_from_file(config_fn_t fn, const char *filename, void *data)
@@ -2392,7 +2392,7 @@ int parse_config_key(const char *var,
 
 const char *current_config_origin_type(void)
 {
-	return cf && cf->origin_type ? cf->origin_type : "cmdline";
+	return cf && cf->origin_type ? cf->origin_type : "command line";
 }
 
 const char *current_config_name(void)
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index e54f6d5..254643a 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -707,7 +707,7 @@ test_expect_success 'invalid unit' '
 '
 
 test_expect_success 'invalid stdin config' '
-	echo "fatal: bad config line 1 in stdin " >expect &&
+	echo "fatal: bad config line 1 in standard input " >expect &&
 	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
 	test_cmp expect output
 '
-- 
2.5.1

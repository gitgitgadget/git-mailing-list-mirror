From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv14 2/7] submodule-config: drop check against NULL
Date: Fri, 19 Feb 2016 10:17:08 -0800
Message-ID: <1455905833-7449-3-git-send-email-sbeller@google.com>
References: <1455905833-7449-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 19 19:17:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWpce-00015c-9h
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 19:17:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992773AbcBSSRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 13:17:25 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36730 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992705AbcBSSRU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 13:17:20 -0500
Received: by mail-pa0-f54.google.com with SMTP id yy13so54132226pab.3
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 10:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kHPxlclB2dLoMgI7+PoVgzGzIgzvBSibPOE7Q79Ed4A=;
        b=bJyhqVg7jKqQxbFlCN3qNAlyrZW6hGAhFkZAe9KkHujhnWxMJtpU5TILE/YIkT8MD+
         7EYK0zMrpZRqC3hF0xMhw2qlbSbE7y3v+haRdBvnOe1XwttCK2yyRTRJESVjAHPBnT8p
         Ek8CcJWgBISnlpgysC3m7wZNEvq4vetiT8ln73Qu4SzwemT8UCbifsobmonABRhhkMFi
         BvS5mdWvEqucboOe0Bxauzn1F5dB0QpSo8uIcVWeDQbPbCUv8uhs/bYUOZYjsBDRU6Q8
         9IKDbmo8+/jM2Sq+8Fo8u7VXFJI912CWinAZuc0eCc6DuFHf8m1QhMZR67kr4wcZ/D0U
         nVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kHPxlclB2dLoMgI7+PoVgzGzIgzvBSibPOE7Q79Ed4A=;
        b=FGcBdGtovfB2aOeDuAt3JIvvp0gnpNJEAEdaCc03MPzkC/RZFsCUPhZ1dN8l0pED6N
         xQOAr8ZR+egAp0u9gVHT6XPJmKPjT4XKe94ThCcVYQKcd15iw3AhdhJI8huL+3Yitnzy
         zwBrJQj8KNfDXkFNfJ1dYw/nla6+h61XN8WG/19WtE37Zh0y/ch2QQhtbL5EVxukgupQ
         eG4mpEHoCFmTPuPRth8w5klRmY3dPAaBV2c+iBHTusjoZT9QBsUUmybSZxoFDK5/YYmv
         xafYBFK37Kby8IC5sNgGmjZhQM/OEEgWz0r587c3yQwsLlt2n4gyMHx2Nn2F5CrwcV9x
         Wg8w==
X-Gm-Message-State: AG10YOTBGzrD5ER7RiCM5GHM+WwqRpVlJGJD7cQ5jNpPptkY1T7jR4v3zLOt5yP40/fGOzrq
X-Received: by 10.66.147.164 with SMTP id tl4mr19627460pab.40.1455905840164;
        Fri, 19 Feb 2016 10:17:20 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d444:f36c:1851:bb54])
        by smtp.gmail.com with ESMTPSA id z7sm19325335pfi.19.2016.02.19.10.17.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 19 Feb 2016 10:17:19 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.ga06e0b3.dirty
In-Reply-To: <1455905833-7449-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286727>

Adhere to the common coding style of Git and not check explicitly
for NULL throughout the file. There are still other occurrences in the
code base but that is usually inside of conditions with side effects.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule-config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index a5cd2ee..9fa2269 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -267,7 +267,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	if (!strcmp(item.buf, "path")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->path != NULL)
+		else if (!me->overwrite && submodule->path)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"path");
 		else {
@@ -291,7 +291,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	} else if (!strcmp(item.buf, "ignore")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->ignore != NULL)
+		else if (!me->overwrite && submodule->ignore)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"ignore");
 		else if (strcmp(value, "untracked") &&
@@ -307,7 +307,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	} else if (!strcmp(item.buf, "url")) {
 		if (!value) {
 			ret = config_error_nonbool(var);
-		} else if (!me->overwrite && submodule->url != NULL) {
+		} else if (!me->overwrite && submodule->url) {
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"url");
 		} else {
-- 
2.7.0.rc0.34.ga06e0b3.dirty

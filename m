From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv20 02/12] submodule-config: drop check against NULL
Date: Mon, 29 Feb 2016 11:14:00 -0800
Message-ID: <1456773250-5510-3-git-send-email-sbeller@google.com>
References: <1456773250-5510-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 29 20:14:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTH5-0005dx-WA
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbcB2TOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:14:22 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34903 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbcB2TOT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:14:19 -0500
Received: by mail-pf0-f175.google.com with SMTP id w128so52171838pfb.2
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 11:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4WJwqmkwyd0hJ/yXlbOhK3ga12X5JFZjxreX5zH0AYo=;
        b=WDmkCdUNFywXqNxt+8IXU1AJRBizAvcKd53fhu/FJCl7cax24sa1VGGIkDvajZ3hYk
         AcG/MvAxZ3fJnUTzJuF84Oa+y0pnyPyb9dJhmXOsKkBleBwYo7Yq6UsEYqdSuV8ghA/0
         RybyzwT/ezivew6vO6sBl3oEW4QvxLoJc4/TzYD7/TB231uILfvUkoKfLtGyylGb11Oe
         F8nyDhQZWur1MC6d2v7zyjJRhvYpzWEZc0LVbmehk5idJoa7Wb7LopR/QR0d4mcy2cCG
         RUULWFF5D/cfEXHMrHW2KrTwaidaDUUQr6fVo9jywgoY8Meb9m0/e0mukut1BNHdQsyG
         cOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4WJwqmkwyd0hJ/yXlbOhK3ga12X5JFZjxreX5zH0AYo=;
        b=NYw5j+tQGkPmTl3CKCTXy0k+GVwpUBgdZLZyvRo8hZinAn7UcJ5wIKc1wqIdMs8qXH
         G+sYwDhB5NxCCG8xAPwCvpmQEEQyQfJ2NoLBmY82ou7IfggeuKjikYnSu9Iog6kRUwNX
         mmjCi4XhW32ktGY98AKNhYEhm9roT8sNoi0exW46tMKlnXcpeK/iCndhTktBkuYPfqO/
         QKtKgCqzw37MN9jDcQpiWmi6CB690nM/RS6dYrcP8j5dNDFUEDR8xDvHX9PuUw9aqrPw
         0g57ziB3WCSShebrFo04JuFi4deP4Na5psS+Mwo9QeTe0jGJo09nCB115zqt23A8ONzh
         U3Hg==
X-Gm-Message-State: AD7BkJIMufE2gcxsrTkmJ1WG8RPHUv+Y6lWM3O05DRsU6hCuGtFx6jz+uOKwpp2tjTPZuZKt
X-Received: by 10.98.80.150 with SMTP id g22mr24346075pfj.132.1456773258946;
        Mon, 29 Feb 2016 11:14:18 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id i23sm39846617pfj.68.2016.02.29.11.14.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 11:14:17 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.37.gb7b9e8e
In-Reply-To: <1456773250-5510-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287875>

Adhere to the common coding style of Git and not check explicitly
for NULL throughout the file. There are still other occurrences in the
code base but that is usually inside of conditions with side effects.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
2.7.0.rc0.37.gb7b9e8e

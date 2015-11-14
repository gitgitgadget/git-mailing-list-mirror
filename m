From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 3/9] submodule-config: drop check against NULL
Date: Fri, 13 Nov 2015 17:06:56 -0800
Message-ID: <1447463222-12589-4-git-send-email-sbeller@google.com>
References: <1447463222-12589-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 02:07:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxPJQ-0003PS-Gx
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 02:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825AbbKNBHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 20:07:19 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33414 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbbKNBHR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 20:07:17 -0500
Received: by pabfh17 with SMTP id fh17so115997766pab.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 17:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DQpLqP4kmfN3hJl8xNm0UjZ91KutMYPWi32Md6LhwKk=;
        b=e1K9rlsSA28F+j0Mj2J89+12k8leuOB9pDNtVtecY24k5lMlGoGU03gdVHbD25n4WD
         nz33V7w/wueM/bw/Gu1IlRMpdQtuv5NeRvrqCZxRb1TT82cNwKe01T1Sl80igZ4+lwKX
         OHBigWpIiKVhuHAQpjJrW95+v0lqwADVOLoAzZ6eo4YJDLNgEo4+2WNx1NxGcHS0MLA5
         XsLipePe/hGqFfRp0S/KP816VUGrxzQVv0ZtGw+QfrrQR917MC3vETHDknxM9+9wFODB
         gc6vVSThfi9sXq4nOYwE6M7sog+8/Ac7os2btZuxc7IWuPjFaEjNZs6IRxwhZuVRETfL
         TNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DQpLqP4kmfN3hJl8xNm0UjZ91KutMYPWi32Md6LhwKk=;
        b=I3IzkUjN9280rgrn8Eeh2leuycwyvw8+jqNWkZzIVk2jJt8RAiGq1w/jZQmpu2LLfC
         DEjIHD8Qf0SCDFxSubKTvHUsdSlbX/DblrvapkScGusEHN7M0ciPNxHJnJCxP2gk26pA
         D5y/NIJ4uS23X34Y0D/B1D4E0fwQuvnWCuWreGzpY/HbW5Ga7w0bfCfwloFY4x3XIp+m
         xG6aAWtsc1DIK6778O8M8MLL5UGO4vwEStfXHry1C+gtmW+Y/+2lSKdsDLo+P3beG/z/
         HtoonepzY+r+W5h2yD0q5xHVyRuIrSgxqeQgoj5ynsXb2cszjnd0HSMWEg40SblXKiy6
         GFlw==
X-Gm-Message-State: ALoCoQkmBGiQ3R+elSbW8umdZFk5jJIIjK0CbUYDJBz7FIbWZ3KDC95K9qtJ8RWd3dIWoUSsGjim
X-Received: by 10.68.241.41 with SMTP id wf9mr25410810pbc.145.1447463237405;
        Fri, 13 Nov 2015 17:07:17 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:f5eb:b7b9:3afa:a95c])
        by smtp.gmail.com with ESMTPSA id f5sm14084892pas.8.2015.11.13.17.07.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 13 Nov 2015 17:07:16 -0800 (PST)
X-Mailer: git-send-email 2.6.3.369.gea52ac0
In-Reply-To: <1447463222-12589-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281291>

Adhere to the common coding style of Git and not check explicitly
for NULL throughout the file. There are still other occurrences in the
code base but that is usually inside of conditions with side effects.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 4239b0e..6d01941 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -265,7 +265,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	if (!strcmp(item.buf, "path")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->path != NULL)
+		else if (!me->overwrite && submodule->path)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"path");
 		else {
@@ -289,7 +289,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	} else if (!strcmp(item.buf, "ignore")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->ignore != NULL)
+		else if (!me->overwrite && submodule->ignore)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"ignore");
 		else if (strcmp(value, "untracked") &&
@@ -305,7 +305,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	} else if (!strcmp(item.buf, "url")) {
 		if (!value) {
 			ret = config_error_nonbool(var);
-		} else if (!me->overwrite && submodule->url != NULL) {
+		} else if (!me->overwrite && submodule->url) {
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"url");
 		} else {
@@ -315,7 +315,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	} else if (!strcmp(item.buf, "update")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->update != NULL)
+		else if (!me->overwrite && submodule->update)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					     "update");
 		else {
-- 
2.6.3.369.gea52ac0

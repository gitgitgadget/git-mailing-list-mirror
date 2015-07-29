From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] parse-options: align curly braces for all options
Date: Wed, 29 Jul 2015 14:36:27 -0700
Message-ID: <1438205787-23214-1-git-send-email-sbeller@google.com>
References: <xmqq7fpi904h.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 29 23:36:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKZ1h-000516-MK
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 23:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305AbbG2Vgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 17:36:33 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33224 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270AbbG2Vgb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 17:36:31 -0400
Received: by padck2 with SMTP id ck2so11765951pad.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 14:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jpVgKaLSeMrQoW4thoScJQZWFLxmx0siI+JQGjvbeG8=;
        b=jiLVHNTt0MyBBmqj0v2e2krO5S5/7U8ybMQfvSuugzq+aeXUSGsQYJz6qeau/289Ac
         Vq7t41YRHSvrZZc/EJTZdJigHdQAK1cFE2sVGnwm4Atp8O9UbZdRhodsG6OVhcTYs/gp
         BTji6rUxkCUBZ0TXgNGdcky87eUD+Zs24KBrzJJEAox5vRv0owjC2odaOvT84eRUjkud
         JPyBnV9QvNNy1XmoWF0+t7Ub1gd7xK3GwsULRrcoOfHMfkcPN7EOjP20uKgFmV9A2boG
         +rDFhOroad4F+1fcGqKpTFuJqMS2s+oL69s5KCuaZdbT0vlGc3lLbKjNpW+ooUo94HLb
         chRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jpVgKaLSeMrQoW4thoScJQZWFLxmx0siI+JQGjvbeG8=;
        b=hAyyQvRJyWTJry9PONHOtarS6ireYOEcfr/KWAi+qXsqJ8w9hDWk5FuQipUX2qH6Y3
         YShbovabg852OzBVXocf+9gbDIfdIA+J3Cl7mTDB3a/Tb9VES2lO4xI6+GuAMaofki1o
         ogjyBzvZvUc8oW73ET1cqAp2Z7UcfTyGLwUzVG4Wi3x96VbOgA3pRmv2cHHcpd7G4M8L
         r0BLzuDVtAmBwgBv5kxnWz9ACpQwBVwLxLbNoPCNxqLd8STko1MdwDczGMWJH/sIffDM
         E+TRbQYjATMfgoNBH18csYVnSU2tQbEqViN5xeuJl3kLliN+kBuRIDyp/S6Z9Z/L/v5h
         ixIg==
X-Gm-Message-State: ALoCoQkJhEMR+S5hGFrlUKCCGnzMZTtr6QBl+wtPFUalcJaQYKwJi2yDVuSEo1XxkBjwgjejdETv
X-Received: by 10.66.145.74 with SMTP id ss10mr99603718pab.28.1438205790536;
        Wed, 29 Jul 2015 14:36:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:d0b2:591c:7542:4aff])
        by smtp.gmail.com with ESMTPSA id tx5sm42672669pab.30.2015.07.29.14.36.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Jul 2015 14:36:29 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.391.g15b60ce
In-Reply-To: <xmqq7fpi904h.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274959>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

>> The non alignment of white space harmed my feelings for aesthetics more
>> than it should have.
>
> Hmm, but this does not align curlies for OPT_DATE(),
> OPT_EXPIRY_DATE(), etc...

That's true, but that was the least invasive fix to appease the aesthetics
as it was all nicely aligned in the beginning, then there was one outlier,
and it was nice again, at the end it is a mess.

Here is the another way to make it look nicer, though not minimally but rather
extensive.

 parse-options.h | 79 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index c71e9da..78e4462 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -111,46 +111,45 @@ struct option {
 	intptr_t defval;
 };
 
-#define OPT_END()                   { OPTION_END }
-#define OPT_ARGUMENT(l, h)          { OPTION_ARGUMENT, 0, (l), NULL, NULL, \
-				      (h), PARSE_OPT_NOARG}
-#define OPT_GROUP(h)                { OPTION_GROUP, 0, NULL, NULL, NULL, (h) }
-#define OPT_BIT(s, l, v, h, b)      { OPTION_BIT, (s), (l), (v), NULL, (h), \
-				      PARSE_OPT_NOARG, NULL, (b) }
-#define OPT_NEGBIT(s, l, v, h, b)   { OPTION_NEGBIT, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG, NULL, (b) }
-#define OPT_COUNTUP(s, l, v, h)     { OPTION_COUNTUP, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG }
-#define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG, NULL, (i) }
-#define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
-#define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
-#define OPT_CMDMODE(s, l, v, h, i) { OPTION_CMDMODE, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
-#define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }
-#define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (a), (h) }
-#define OPT_STRING_LIST(s, l, v, a, h) \
-				    { OPTION_CALLBACK, (s), (l), (v), (a), \
-				      (h), 0, &parse_opt_string_list }
-#define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
-#define OPT_DATE(s, l, v, h) \
-	{ OPTION_CALLBACK, (s), (l), (v), N_("time"),(h), 0,	\
-	  parse_opt_approxidate_cb }
-#define OPT_EXPIRY_DATE(s, l, v, h) \
-	{ OPTION_CALLBACK, (s), (l), (v), N_("expiry-date"),(h), 0,	\
-	  parse_opt_expiry_date_cb }
-#define OPT_CALLBACK(s, l, v, a, h, f) \
-	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), 0, (f) }
-#define OPT_NUMBER_CALLBACK(v, h, f) \
-	{ OPTION_NUMBER, 0, NULL, (v), NULL, (h), \
-	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, (f) }
-#define OPT_FILENAME(s, l, v, h)    { OPTION_FILENAME, (s), (l), (v), \
-				       N_("file"), (h) }
-#define OPT_COLOR_FLAG(s, l, v, h) \
-	{ OPTION_CALLBACK, (s), (l), (v), N_("when"), (h), PARSE_OPT_OPTARG, \
-		parse_opt_color_flag_cb, (intptr_t)"always" }
+#define OPT_END()                      { OPTION_END }
+#define OPT_ARGUMENT(l, h)             { OPTION_ARGUMENT, 0, (l), NULL, NULL, \
+					(h), PARSE_OPT_NOARG}
+#define OPT_GROUP(h)                   { OPTION_GROUP, 0, NULL, NULL, NULL, \
+					(h) }
+#define OPT_BIT(s, l, v, h, b)         { OPTION_BIT, (s), (l), (v), NULL, \
+					(h), PARSE_OPT_NOARG, NULL, (b) }
+#define OPT_NEGBIT(s, l, v, h, b)      { OPTION_NEGBIT, (s), (l), (v), NULL, \
+					(h), PARSE_OPT_NOARG, NULL, (b) }
+#define OPT_COUNTUP(s, l, v, h)        { OPTION_COUNTUP, (s), (l), (v), NULL, \
+					(h), PARSE_OPT_NOARG }
+#define OPT_SET_INT(s, l, v, h, i)     { OPTION_SET_INT, (s), (l), (v), NULL, \
+					(h), PARSE_OPT_NOARG, NULL, (i) }
+#define OPT_BOOL(s, l, v, h)           OPT_SET_INT(s, l, v, \
+					(h), 1)
+#define OPT_HIDDEN_BOOL(s, l, v, h)    { OPTION_SET_INT, (s), (l), (v), NULL, \
+					(h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
+#define OPT_CMDMODE(s, l, v, h, i)     { OPTION_CMDMODE, (s), (l), (v), NULL, \
+					(h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
+#define OPT_INTEGER(s, l, v, h)        { OPTION_INTEGER, (s), (l), (v), N_("n"), \
+					(h) }
+#define OPT_STRING(s, l, v, a, h)      { OPTION_STRING,  (s), (l), (v), (a), \
+					(h) }
+#define OPT_STRING_LIST(s, l, v, a, h) { OPTION_CALLBACK, (s), (l), (v), (a), \
+					(h), 0, &parse_opt_string_list }
+#define OPT_UYN(s, l, v, h)            { OPTION_CALLBACK, (s), (l), (v), NULL, \
+					(h), PARSE_OPT_NOARG, &parse_opt_tertiary }
+#define OPT_DATE(s, l, v, h)           { OPTION_CALLBACK, (s), (l), (v), N_("time"), \
+					(h), 0, parse_opt_approxidate_cb }
+#define OPT_EXPIRY_DATE(s, l, v, h)    { OPTION_CALLBACK, (s), (l), (v), N_("expiry-date"), \
+					(h), 0, parse_opt_expiry_date_cb }
+#define OPT_CALLBACK(s, l, v, a, h, f) { OPTION_CALLBACK, (s), (l), (v), (a), \
+					(h), 0, (f) }
+#define OPT_NUMBER_CALLBACK(v, h, f)   { OPTION_NUMBER, 0, NULL, (v), NULL, \
+					(h), PARSE_OPT_NOARG | PARSE_OPT_NONEG, (f) }
+#define OPT_FILENAME(s, l, v, h)       { OPTION_FILENAME, (s), (l), (v), N_("file"), \
+					(h) }
+#define OPT_COLOR_FLAG(s, l, v, h)     { OPTION_CALLBACK, (s), (l), (v), N_("when"), \
+					(h), PARSE_OPT_OPTARG, parse_opt_color_flag_cb, (intptr_t)"always" }
 
 #define OPT_NOOP_NOARG(s, l) \
 	{ OPTION_CALLBACK, (s), (l), NULL, NULL, \
-- 
2.5.0.rc1.391.g15b60ce

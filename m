From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 3/3] string_list: Remove string_list_insert_at_index from its API
Date: Mon, 24 Nov 2014 17:31:40 -0800
Message-ID: <1416879100-32321-1-git-send-email-sbeller@google.com>
References: <CAPc5daXuecn9bvuQ4qa6p5Ln-RqoUxkh=9nfOZCWAdwHZYJD5g@mail.gmail.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 02:31:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt4yq-0000HD-UJ
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 02:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbaKYBbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 20:31:45 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:45707 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbaKYBbo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 20:31:44 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so10046266iec.22
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 17:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=An04Pey0yqLxTeEoe/1f4pb8zLj/oEzZRRWilhKhGkc=;
        b=Y6HbvjK5xXEFH/5uz7dpyBKTVhGDS/9bDehcikvBGUprix1HcZizcN3kWuPED1N6gM
         Ii1a5Cherx9qEJYl7c/9Zko0VqOJCuMA5CBuuHMLsxdKzoEvX5GjMq4v2v7DVypR/HO4
         uSp9QkUQPgw+XF3Lln3CiHJOUOIZ2f0L1L5hF8qS20X7w2mcdr56GUOuhBFp3fj7OVCM
         nzYXtKoXHCSYtsrpXuYBCZKjXmb2DpeV1XDQNzTJVMf3W9IhrMGUna7va5m9oB3aFePR
         IQIUT6bPwI21UrgzuWt7XzrnZRWKUOTvuLm5ucJ6sJLcdZwqXp6YtzB53MHpiOVZF4tX
         T8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=An04Pey0yqLxTeEoe/1f4pb8zLj/oEzZRRWilhKhGkc=;
        b=mcSlj1xIeqOj4kl72Zi0G1CZppsKX6yiHB0AtvID1HiwfhUqfVldx0odg5EX2v6Iqt
         gG6ygkpm2DySDH0OixVapEoakt5c3X66r0u4NVlOXVuKMGzNTTrnWFsUeVulKRB4B7Q6
         bMicWB2/m6zoWYUBRToJyHTTFm/Uj3noIwkIQOsPRfgOndOfVnUKxDZ0FxaOEZ2MuP8I
         fJBl5EgpCqJDEEzT7fIENedG/N1eactru73HnUmMd7bBvKJfi2ul1QUVoLlrBVwF0hcV
         gV/1u/XIp5+dx2TtI1mZevkAEVCxwVKZD767cz8Jz68ONmag9xodaacq96wGJzLIYgXm
         hETA==
X-Gm-Message-State: ALoCoQnjjDeRBTCe0qFIiO0tvee4wqzO3tBvRuvHLEKyImGQJNOQ+3uvcRxWDw+5RdKGDXlooKct
X-Received: by 10.43.1.70 with SMTP id np6mr23226342icb.39.1416879103483;
        Mon, 24 Nov 2014 17:31:43 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:79de:6365:bed8:92ea])
        by mx.google.com with ESMTPSA id i126sm8399750ioe.28.2014.11.24.17.31.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 17:31:43 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3
In-Reply-To: <CAPc5daXuecn9bvuQ4qa6p5Ln-RqoUxkh=9nfOZCWAdwHZYJD5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260181>

Nobody is using this function any more, let's get rid of it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 string-list.c | 8 +-------
 string-list.h | 2 --
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/string-list.c b/string-list.c
index c5aa076..9584fa6 100644
--- a/string-list.c
+++ b/string-list.c
@@ -59,13 +59,7 @@ static int add_entry(int insert_at, struct string_list *list, const char *string
 
 struct string_list_item *string_list_insert(struct string_list *list, const char *string)
 {
-	return string_list_insert_at_index(list, -1, string);
-}
-
-struct string_list_item *string_list_insert_at_index(struct string_list *list,
-						     int insert_at, const char *string)
-{
-	int index = add_entry(insert_at, list, string);
+	int index = add_entry(-1, list, string);
 
 	if (index < 0)
 		index = -1 - index;
diff --git a/string-list.h b/string-list.h
index 40ffe0c..ee9b100 100644
--- a/string-list.h
+++ b/string-list.h
@@ -61,8 +61,6 @@ int string_list_find_insert_index(const struct string_list *list, const char *st
  * Returns the string_list_item, the string is part of.
  */
 struct string_list_item *string_list_insert(struct string_list *list, const char *string);
-struct string_list_item *string_list_insert_at_index(struct string_list *list,
-						     int insert_at, const char *string);
 
 /*
  * Checks if the given string is part of a sorted list. If it is part of the list,
-- 
2.2.0.rc3

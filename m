From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] string_list: document string_list_(insert,lookup)
Date: Mon, 24 Nov 2014 13:22:02 -0800
Message-ID: <1416864124-15231-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, marius@trolltech.com, julian@quantumfyre.co.uk,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 24 22:22:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt15P-0006ej-8s
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 22:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbaKXVWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 16:22:14 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:58984 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbaKXVWN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 16:22:13 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so3884059igb.11
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 13:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ATQnpbj1wj0RC4/YiVCH/+ADcvlwIvgBU1J2V7ZQvZU=;
        b=JTxdDmn2cjv4iXA3BjvbXDVGKXEdRTSOWW0VdqvtED/MVUf+3zt9HB6q2oOrF5PmGv
         6YRw5BC0JWopu+zWBmwklq4Cxm/vVrweRZgGzb9TAMjdO5jeivwOoT3Om6hRV3bIQmAl
         ckkGw0ZUFtYicGJb0VEQlJSRWsBCPoYy3KxI1zTJWObzjhysq7uljZnYe8ypqOehvtLC
         TjmliahFHT1CORdWknMN6uhdnOdpxvCZT8AzNiDJgJXI7456R2YxKSwOTa+q3vp0D1G5
         UFecwIk6sI0TGEtirh8sGaENKUskJMe7DHi6K3win7JWlo3uXvpEFW/CINkvdqSPcXix
         1aHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ATQnpbj1wj0RC4/YiVCH/+ADcvlwIvgBU1J2V7ZQvZU=;
        b=cxQgM+2TZfFQ0zvws9XINh6AVEKMkm/yuE7KNCbihFFKXvwEw8xHAg1DxDVbyWFsKS
         ys/t8pOQJVvut9P6Tvi1FQo/Eu2Dq0vK8RdT0aX0ZUBpcMFvuHYi8VynuCD5dUfut/QZ
         ZjMRFbt9c5BjNu0rVMInLjKeujAqKD2WIa57zgqMeeX/D/t6nkwkRNq0ENpRW2F2FKyE
         goRkPX1B7o7OPCimGKIGVSjH7doh9fEqMQdm+4qFFIu3i5v4cK8o4biLFCElUKTEYyCO
         x+TRZYGeMgJuWqUJRdNk6iTR06EVwKrWE0Ft2mdJf/23fGAYFWf6P9geH/l0D1qCv7tv
         xlug==
X-Gm-Message-State: ALoCoQmpiEdngDuDY5EB8OaoG80DcgZGT48/gP6HsBydi2SLiY8p+qq/EVut6DuaHvocqtPF/wgx
X-Received: by 10.43.79.7 with SMTP id zo7mr26345647icb.5.1416864132886;
        Mon, 24 Nov 2014 13:22:12 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:413f:9e9a:731:9749])
        by mx.google.com with ESMTPSA id nu1sm6732423igb.0.2014.11.24.13.22.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 13:22:12 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260147>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 string-list.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/string-list.h b/string-list.h
index 494eb5d..40ffe0c 100644
--- a/string-list.h
+++ b/string-list.h
@@ -55,9 +55,19 @@ void string_list_remove_empty_items(struct string_list *list, int free_util);
 int string_list_has_string(const struct string_list *list, const char *string);
 int string_list_find_insert_index(const struct string_list *list, const char *string,
 				  int negative_existing_index);
+/*
+ * Inserts the given string into the sorted list.
+ * If the string already exists, the list is not altered.
+ * Returns the string_list_item, the string is part of.
+ */
 struct string_list_item *string_list_insert(struct string_list *list, const char *string);
 struct string_list_item *string_list_insert_at_index(struct string_list *list,
 						     int insert_at, const char *string);
+
+/*
+ * Checks if the given string is part of a sorted list. If it is part of the list,
+ * return the coresponding string_list_item, NULL otherwise.
+ */
 struct string_list_item *string_list_lookup(struct string_list *list, const char *string);
 
 /*
-- 
2.2.0.rc3

From: Ori Avtalion <ori@avtalion.name>
Subject: [PATCH] Documentation: git diff --check detects conflict markers
Date: Tue, 29 Mar 2016 21:59:45 +0300
Message-ID: <1459277985-5776-1-git-send-email-ori@avtalion.name>
References: <xmqqd1qe1a2i.fsf@gitster.mtv.corp.google.com>
Cc: Ori Avtalion <ori@avtalion.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 21:02:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akyuO-0000zH-S3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 21:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356AbcC2TC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 15:02:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35607 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbcC2TC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 15:02:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id 139so8502264wmn.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 12:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NVbiK33PKEu+wqddX3dQoF4UpUvyXgb+JKWnFMCoQoM=;
        b=JugzZ1PKgSohnEp0cqlXpY2S/jr6aL3gcF2GvKM7rd2VLM4XPIxudps7QuFCy75Jg+
         OFpbChpFwOtD51qIe7Qg9AI/Ho0r96Lg6KPquiExXhlkadP1lCmNuru37sakjZrClm3o
         Rck1tRI2FxESEAZlJ2LecqJb4tLf0FhUdHAtdUMZxa4fU6yQ5zcCHm6MIufGhsquyoVz
         4DRdagyZ/yeUHsv9GjqU8i/JFCi+HDwzxvbvQMxWJzQqp1dRACGQTEcf2GxAE4umw8cl
         GlLY+nq2fMdLF20M/GTDAzjvwhTQvKWCp6X26QJXjRDMrTsh3qp/mN+l8JTXO2blqHiQ
         2IgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=NVbiK33PKEu+wqddX3dQoF4UpUvyXgb+JKWnFMCoQoM=;
        b=VeKTkU6oiUx3TyHHKi8U3AMfTp4u7ewGVzbvoUmBvxKko9zSo142e8nPkXnlvgIwD3
         p2cPQAEBRwf/88BQ7PsqoNPkgwaPv+/oagawDWIzKiXACOecmqAVNAwFRa6oy6wCt/6x
         T+XfXab5r8FWC5jdYYhnRDiPBayGs9A//900wA/kXvnmPwQTxrp/sGcJ4EVJr3ZZ+iUG
         efbsZV4u8kXUQ3ueZnNzph3Nl6j+Y+IP96hf9vFf/YY7OtwVTguYByA67bgprv6qHJ72
         Wv7lJBxgoUf2jLMWvXOIqfZsO/B/OmibN8iRE8gqV1W8RhzYgqXCxm9NUNOdCWqjkakE
         iv3Q==
X-Gm-Message-State: AD7BkJJlhg8BHfgs6i88rYyzDXprJNYtSVQlNN7jt5qb/4NYjhNnb7X4c3qoZpygTD0crg==
X-Received: by 10.194.201.196 with SMTP id kc4mr4413841wjc.144.1459278146884;
        Tue, 29 Mar 2016 12:02:26 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-180-3-19.red.bezeqint.net. [79.180.3.19])
        by smtp.gmail.com with ESMTPSA id ei9sm83269wjd.40.2016.03.29.12.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 12:02:26 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.dirty
In-Reply-To: <xmqqd1qe1a2i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290162>

Signed-off-by: Ori Avtalion <ori@avtalion.name>
---
 Documentation/diff-options.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 306b7e3..32f48ed 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -286,8 +286,8 @@ endif::git-format-patch[]
 
 ifndef::git-format-patch[]
 --check::
-	Warn if changes introduce whitespace errors.  What are
-	considered whitespace errors is controlled by `core.whitespace`
+	Warn if changes introduce conflict markers or whitespace errors.
+	What are considered whitespace errors is controlled by `core.whitespace`
 	configuration.  By default, trailing whitespaces (including
 	lines that solely consist of whitespaces) and a space character
 	that is immediately followed by a tab character inside the
-- 
2.5.0

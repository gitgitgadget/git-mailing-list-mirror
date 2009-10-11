From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/3] git config: clarify bool types
Date: Sun, 11 Oct 2009 23:46:12 +0300
Message-ID: <1255293973-17444-3-git-send-email-felipe.contreras@gmail.com>
References: <1255293973-17444-1-git-send-email-felipe.contreras@gmail.com>
 <1255293973-17444-2-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 22:49:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx5M0-0001qp-6n
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 22:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbZJKUsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 16:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbZJKUsI
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 16:48:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:37794 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbZJKUsH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 16:48:07 -0400
Received: by fg-out-1718.google.com with SMTP id 16so285617fgg.1
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 13:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bFxeoKkX2IKEQrANTEA5kAUR+EPIKMF+4/SvlviOL14=;
        b=PAn6ei9JypoeJjrJmqtKKiBIvckWp5hJxgCq4GtUSRih5VKxHiOeMnex4pxwCRw7cX
         Sq8waFXH4IiM/uoE4d0QnvalUSsJOQTDRYoxXeh/tD7K05mJOIDK1i0nmpTKEgyDe7mA
         5Qs/8CMX9ziKwgtcVsc4hWDn8gKEQNBU6nZwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SNST6tbJ9h3zCjH5OUUfApPiUfKPYtrxnyuGbWA1wS614UfrZLij3q97OKAbd7CFE1
         VonnW2go8XlYqPYjnzqAx7nErA5rQxfzBNdfn0/f7rgcJ5QjR/WFX5qHgfn2cgTXAzRB
         idF+/zkkrwX7OtgXFmEh5jgH4bQv8QE07Gpz0=
Received: by 10.86.103.26 with SMTP id a26mr542657fgc.40.1255293979379;
        Sun, 11 Oct 2009 13:46:19 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 4sm4541017fgg.23.2009.10.11.13.46.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 13:46:18 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.4.g31fc3
In-Reply-To: <1255293973-17444-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129951>

The value is what it is, the --bool and --bool-or-int options don't
specify the value type, just how it is interpreted. For example: a value
of '1' can be interpreted as 'true'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index a2d656e..29d7b75 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -66,9 +66,9 @@ static struct option builtin_config_options[] = {
 	OPT_STRING(0, "get-color", &get_color_slot, "slot", "find the color configured: [default]"),
 	OPT_STRING(0, "get-colorbool", &get_colorbool_slot, "slot", "find the color setting: [stdout-is-tty]"),
 	OPT_GROUP("Type"),
-	OPT_BIT(0, "bool", &types, "value is \"true\" or \"false\"", TYPE_BOOL),
+	OPT_BIT(0, "bool", &types, "value is intepreted as bool (\"true\" or \"false\")", TYPE_BOOL),
 	OPT_BIT(0, "int", &types, "value is decimal number", TYPE_INT),
-	OPT_BIT(0, "bool-or-int", &types, "value is --bool or --int", TYPE_BOOL_OR_INT),
+	OPT_BIT(0, "bool-or-int", &types, "value is interpreted either as bool or int", TYPE_BOOL_OR_INT),
 	OPT_GROUP("Other"),
 	OPT_BOOLEAN('z', "null", &end_null, "terminate values with NUL byte"),
 	OPT_END(),
-- 
1.6.5.4.g31fc3

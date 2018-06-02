Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BC3B1F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeFBEdi (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:33:38 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43291 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeFBEdP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:33:15 -0400
Received: by mail-lf0-f67.google.com with SMTP id n15-v6so302886lfn.10
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VToGPkRd2iEatmNHrZ9YTPNieBfQTW6eWi5gzpAohO0=;
        b=Y6bZaaIpdIIbihmXOF+w+8VIf3U4MDX8ns3jvjN7eN2HiztjBiGiZQjhJGnsKlWkRX
         K7r7OWDQ2xq2o+9NeYMkvGqdOHtfQgn2JUkRLShQTCdGeZVm0pCPWpJ4s79zqxJ67K+A
         OIS3A/D5Qdpg0AOTWxhPUKry/p5QZlvdl/xe6OfIEZ7Egr5kFoh5yEF7SDBy6K9dHh2r
         MAn6NA+Iel58ZtokW6dWAFs8rTgga03wwGXbsenQ5YMf/04+cABmETztiwqaJiBHvWWG
         nTBNLzj4qMa49mm/jw1XZf3u047T7u+3SuVAjnfSjLy+BiX9pVrxGpU8KzppmohI1nc/
         N1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VToGPkRd2iEatmNHrZ9YTPNieBfQTW6eWi5gzpAohO0=;
        b=qH4dTt/Ibwm1aMMkii5LGph8ia7B/1BHXHniYhCyWWxXhRRFVRQgDU9+kwaZKnN05H
         sWyhrrxAN2mNUbRoMZD4o2lUM3e+1fZzEysdxEJh/anesBY5QWWNBanJzHuQMj2kUzMj
         P6DjZryomroNVyRq9rntJn1Br4SctiXprvifr/Yvq9ObYeLrXZHBhuxzmgLG6Jl67dSU
         hLd7lIpioQG3jwzlXYnA4aTpQnolHpDlc3gMIiGZeOMAxQyeBha1bcyyEn6b20JDBRAL
         UAL0WTTMbeuMRVzQz2nVFgSNC5w/pQFwtcuO6UwHjczYKFkVyyi8LcLoRQ06lQxTbwJm
         evOQ==
X-Gm-Message-State: ALKqPwcHXpq2jiYJDRPeSXiZ+Cwvkr9xNnoNsJWX9HGpjmo1L/VXEXzD
        z9FWIaQbXeit7R/Wjlwm3RopdQ==
X-Google-Smtp-Source: ADUXVKLYRhy6zGhJHfxu/GqgjlO3eUSk2WkPxQH2+2P0yPuyZDuyybj5QYhPro6xOJ92JDOS3Hi8BQ==
X-Received: by 2002:a2e:4d0e:: with SMTP id a14-v6mr10292745ljb.106.1527913993180;
        Fri, 01 Jun 2018 21:33:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm644776lji.0.2018.06.01.21.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 21:33:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 21/22] transport.c: mark more strings for translation
Date:   Sat,  2 Jun 2018 06:32:40 +0200
Message-Id: <20180602043241.9941-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.309.g77c7720784
In-Reply-To: <20180602043241.9941-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 transport.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/transport.c b/transport.c
index a32da30dee..516a83b7f6 100644
--- a/transport.c
+++ b/transport.c
@@ -139,7 +139,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 		close(data->fd);
 	data->fd = read_bundle_header(transport->url, &data->header);
 	if (data->fd < 0)
-		die ("Could not read bundle '%s'.", transport->url);
+		die(_("could not read bundle '%s'"), transport->url);
 	for (i = 0; i < data->header.references.nr; i++) {
 		struct ref_list_entry *e = data->header.references.list + i;
 		struct ref *ref = alloc_ref(e->name);
@@ -654,7 +654,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 
 	switch (data->version) {
 	case protocol_v2:
-		die("support for protocol v2 not implemented yet");
+		die(_("support for protocol v2 not implemented yet"));
 		break;
 	case protocol_v1:
 	case protocol_v0:
@@ -780,7 +780,7 @@ static enum protocol_allow_config parse_protocol_config(const char *key,
 	else if (!strcasecmp(value, "user"))
 		return PROTOCOL_ALLOW_USER_ONLY;
 
-	die("unknown value for config '%s': %s", key, value);
+	die(_("unknown value for config '%s': %s"), key, value);
 }
 
 static enum protocol_allow_config get_protocol_config(const char *type)
@@ -846,7 +846,7 @@ int is_transport_allowed(const char *type, int from_user)
 void transport_check_allowed(const char *type)
 {
 	if (!is_transport_allowed(type, -1))
-		die("transport '%s' not allowed", type);
+		die(_("transport '%s' not allowed"), type);
 }
 
 static struct transport_vtable bundle_vtable = {
@@ -875,7 +875,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	ret->progress = isatty(2);
 
 	if (!remote)
-		die("No remote provided to transport_get()");
+		BUG("No remote provided to transport_get()");
 
 	ret->got_remote_refs = 0;
 	ret->remote = remote;
@@ -898,7 +898,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	if (helper) {
 		transport_helper_init(ret, helper);
 	} else if (starts_with(url, "rsync:")) {
-		die("git-over-rsync is no longer supported");
+		die(_("git-over-rsync is no longer supported"));
 	} else if (url_is_local_not_ssh(url) && is_file(url) && is_bundle(url, 1)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
 		transport_check_allowed("file");
@@ -1143,7 +1143,7 @@ int transport_push(struct transport *transport,
 						      transport->push_options,
 						      pretend)) {
 				oid_array_clear(&commits);
-				die("Failed to push all needed submodules!");
+				die(_("failed to push all needed submodules"));
 			}
 			oid_array_clear(&commits);
 		}
@@ -1265,7 +1265,7 @@ int transport_connect(struct transport *transport, const char *name,
 	if (transport->vtable->connect)
 		return transport->vtable->connect(transport, name, exec, fd);
 	else
-		die("Operation not supported by protocol");
+		die(_("operation not supported by protocol"));
 }
 
 int transport_disconnect(struct transport *transport)
@@ -1347,7 +1347,7 @@ static void read_alternate_refs(const char *path,
 
 		if (get_oid_hex(line.buf, &oid) ||
 		    line.buf[GIT_SHA1_HEXSZ] != ' ') {
-			warning("invalid line while parsing alternate refs: %s",
+			warning(_("invalid line while parsing alternate refs: %s"),
 				line.buf);
 			break;
 		}
-- 
2.18.0.rc0.309.g77c7720784


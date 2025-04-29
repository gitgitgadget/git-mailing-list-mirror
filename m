Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81DA21A44C
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938401; cv=none; b=noZoXkPOjUzxgVb5nPBN4ocJUONMFhso6CFyXIoHY2FDmXwNnmGPoD6fBhPay1/PJmJvWgpAuDKmfadJsyCVoZdqbjFFZt3tYdyfeL6MUndSL3mkHZ8xTpmBqTcLgM2JvsXcE8zPcWiq506T1GHut18Dmp0cWm7BxZAXhUXBjGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938401; c=relaxed/simple;
	bh=/o2K6JzyBn1fsOhGNi9LI8ikC7QRGEErkIqRsv+iFK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gl27jd5LezhhHvfXawXUo8TpyR+T2XXPXMAdU/yuRZwvPqmQRHX+Sh3wtukKfm9tr+mZKmPBhPaapf0KCK4JWe5NOLW7XaNACbvBoMJDtow88Ggh9pajs9FPAHS5gf+KFb/OUfXqu8Cp+PxNZJ6Er4qreocryh7MLYVKt0IKMuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdSPUbfH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdSPUbfH"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so1064942466b.3
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 07:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745938397; x=1746543197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36FoRCAL9tV9FscyjashjXA8SreuNlneT2T9mqDGVa0=;
        b=SdSPUbfHdQeyLzQdgiZGdu5kquCjft0GTWWhOZ4mG/Qr6L7VE5fD5nx/ZEMwQxVKYa
         xD1crser3/6OiMOGooQht9bv+QR2FhY7BHzZDjzVEdZ+CAvuK3C3SvMOR/X20fm4aSBR
         CXJ2LZ8aPu2yAYTjYnO+mQN8zAxKSN6m6Yd7jLxnSDU0oE7Jz/BO+s4yljq80d1Pn/Yv
         MszXAyh8leQ33DX2sNyuCIw2p0odaHGIhPjbL3GEdy9W7zJ5fkLy5HaTKRw0EOo3Ukvy
         VjA2cbNW5BuAp/K1ydUAZGnh38qbRYm7zznDxt0tGgafu2sHS+RVaRhLW9N+UYUC97fy
         By5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745938397; x=1746543197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36FoRCAL9tV9FscyjashjXA8SreuNlneT2T9mqDGVa0=;
        b=l0U2C+L4Q7lp2f52TARmncnxn7b9wOUtnmYQxZB7vQa4xnRsb2TOQxJ2t8m2/M06Bw
         35xhvqhGBeUDmJszue9OpilZFaih/Ga/dogdKhPIsuSEF0buoSAM4omzOLI706yVVfEX
         dZPLRkBptNHSSAAWoKhOwXDhPeDoGeYQhAChCjE0/f59tCXWHc/n3FBsu9WXtAZaJscg
         xAD9SR0Lp48sSBRzzNi8ls1sHXlWNSAkTM/2oaCOnwGFJEsF84KT3UhgVuk+YILF8sOf
         XcQ2Ig+shpFhI32mkX2nIdMsJHlhH3nrfwf7OS7W/oDw7kVOMy4xIQ/rJRHcK3wHErWO
         JZ5w==
X-Gm-Message-State: AOJu0YzmLjQyO/SoCDIWVj/u1DIBlrjgS5/AYoVV7K9MxuO2f/35nDx/
	NuL87nPo4hsnSOyxyiUaKmiC9dnMq8PjVjd1ov+Ma99rvjcSy6OQj0XsRA==
X-Gm-Gg: ASbGncv09IYXj92M+sY0+yEWXEjirc3QsXVv/yMHTIEJ+bFXfBaDkeky0zAe+hXnD13
	0DaPHZJyiMCDsDk4ZZVohkxQAWwwni/UkJl0kA81qEn3oA8I8/07KeEEGMW/Z2o5gFpg1HUBMVL
	NAYE/sk+Fx8EIEfFGD97ToyxbX8kRTIky57bJNAoVEQqCdfXQstNXbAKVyNlSfnIY0izpjN5QaR
	l03+UBtQ0hy1o2t3phCuc6DM2N2xBlFpdqvVIL6umv9Yt1e85r13u7QK+AaLQkCuVOGHQwx7cOc
	cDBw82ANtusGx/sGYnh1TUpyAiU66ivgnVROgypk+gvIn2kvcN59FPjD8r+iCs8N/PvIOBtIj37
	P
X-Google-Smtp-Source: AGHT+IF9/byp7S7LzPkQjI53JoUo6tXG9WRELYUvoH07+JV/40kYQ022XVyPAaNl/VBR3WMSUgTkow==
X-Received: by 2002:a17:907:97c7:b0:ace:4ed4:d428 with SMTP id a640c23a62f3a-ace84b3b270mr1370560666b.57.1745938396357;
        Tue, 29 Apr 2025 07:53:16 -0700 (PDT)
Received: from christian--20230123--2G7D3.lan ([2001:861:3f04:7ca0:9d50:3329:cd00:6e2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed6aed0sm791432666b.135.2025.04.29.07.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 07:53:15 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/3] promisor-remote: allow a client to check fields
Date: Tue, 29 Apr 2025 16:52:43 +0200
Message-ID: <20250429145243.992252-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.157.g09af0369a6
In-Reply-To: <20250429145243.992252-1-christian.couder@gmail.com>
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250429145243.992252-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit allowed a server to pass additional fields through
the "promisor-remote" protocol capability after the "name" and "url"
fields, specifically the "partialCloneFilter" and "token" fields.

Let's make it possible for a client to check if these fields match
what it expects before accepting a promisor remote.

We allow this by introducing a new "promisor.checkFields"
configuration variable. It should contain a comma or space separated
list of fields that will be checked.

By limiting the protocol to specific well-defined fields, we ensure
both server and client have a shared understanding of field
semantics and usage.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.adoc    |  25 ++++++
 promisor-remote.c                     | 105 +++++++++++++++++++++++---
 t/t5710-promisor-remote-capability.sh |  35 +++++++++
 3 files changed, 154 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index 71311b70c8..4147d2cf44 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -46,3 +46,28 @@ promisor.acceptFromServer::
 	lazily fetchable from this promisor remote from its responses
 	to "fetch" and "clone" requests from the client. Name and URL
 	comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
+
+promisor.checkFields::
+	A comma or space separated list of additional remote related
+	fields that a client will check before accepting a promisor
+	remote. Currently, only the "partialCloneFilter" and "token"
+	fields are supported.
++
+When a field is part of this list and a corresponding
+"remote.foo.<field>" config variable is set locally for remote "foo",
+then the value of this config variable will be checked against the
+value of the same field passed by the server for the remote "foo". The
+remote "foo" will be rejected if the values don't match.
++
+For the "partialCloneFilter" field, this allows the client to ensure
+that the server's filter matches what it expects locally, preventing
+inconsistencies in filtering behavior. For the "token" field, this can
+be used to verify that authentication credentials match expected
+values.
++
+The fields should be passed by the server through the
+"promisor-remote" capability by using the `promisor.sendFields` config
+variable. The fields will be checked only if the
+`promisor.acceptFromServer` config variable is not set to "None".  If
+set to "None", this config variable will have no effect.  See
+linkgit:gitprotocol-v2[5].
diff --git a/promisor-remote.c b/promisor-remote.c
index 70abec4c24..97f81a0e08 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -377,6 +377,20 @@ static struct string_list *fields_sent(void)
 	return &fields_list;
 }
 
+static struct string_list *fields_checked(void)
+{
+	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
+	static int initialized = 0;
+
+	if (!initialized) {
+		fields_list.cmp = strcasecmp;
+		fields_from_config(&fields_list, "promisor.checkFields");
+		initialized = 1;
+	}
+
+	return &fields_list;
+}
+
 static void append_fields(struct string_list *fields,
 			  struct string_list *field_names,
 			  const char *name)
@@ -533,15 +547,65 @@ enum accept_promisor {
 	ACCEPT_ALL
 };
 
+static int check_field_one(struct string_list_item *item_value,
+			   struct promisor_info *p)
+{
+	struct string_list_item *item;
+
+	item = unsorted_string_list_lookup(&p->fields, item_value->string);
+	if (!item)
+		return 0;
+
+	return !strcmp(item->util, item_value->util);
+}
+
+
+static int check_field(struct string_list_item *item_value,
+		       struct promisor_info *p, int in_list)
+{
+	if (!in_list)
+		return check_field_one(item_value, p);
+
+	for (; p; p = p->next)
+		if (check_field_one(item_value, p))
+			return 1;
+
+	return 0;
+}
+
+static int check_all_fields(struct string_list* values,
+			    struct promisor_info *p,
+			    int in_list)
+{
+	struct string_list* fields = fields_checked();
+	struct string_list_item *item_checked;
+
+	string_list_sort(values);
+
+	for_each_string_list_item(item_checked, fields) {
+		struct string_list_item *item_value;
+
+		item_value = string_list_lookup(values, item_checked->string);
+		if (!item_value)
+			return 0;
+		if (!check_field(item_value, p, in_list))
+			return 0;
+	}
+
+	return 1;
+}
+
 static int should_accept_remote(enum accept_promisor accept,
-				const char *remote_name, const char *remote_url,
+				const char *remote_name,
+				const char *remote_url,
+				struct string_list* values,
 				struct promisor_info *info_list)
 {
 	struct promisor_info *p;
 	const char *local_url;
 
 	if (accept == ACCEPT_ALL)
-		return 1;
+		return check_all_fields(values, info_list, 1);
 
 	p = remote_nick_find(info_list, remote_name);
 
@@ -550,7 +614,7 @@ static int should_accept_remote(enum accept_promisor accept,
 		return 0;
 
 	if (accept == ACCEPT_KNOWN_NAME)
-		return 1;
+		return check_all_fields(values, p, 0);
 
 	if (accept != ACCEPT_KNOWN_URL)
 		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
@@ -568,7 +632,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	local_url = p->fields.items[1].util;
 
 	if (!strcmp(local_url, remote_url))
-		return 1;
+		return check_all_fields(values, p, 0);
 
 	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
 		remote_name, local_url, remote_url);
@@ -602,9 +666,6 @@ static void filter_promisor_remote(struct repository *repo,
 	if (accept == ACCEPT_NONE)
 		return;
 
-	if (accept != ACCEPT_ALL)
-		info_list = promisor_info_list(repo, NULL);
-
 	/* Parse remote info received */
 
 	remotes = strbuf_split_str(info, ';', 0);
@@ -615,14 +676,29 @@ static void filter_promisor_remote(struct repository *repo,
 		const char *remote_url = NULL;
 		char *decoded_name = NULL;
 		char *decoded_url = NULL;
+		struct string_list field_values = STRING_LIST_INIT_NODUP;
+
+		field_values.cmp = strcasecmp;
 
 		strbuf_strip_suffix(remotes[i], ";");
 		elems = strbuf_split(remotes[i], ',');
 
 		for (size_t j = 0; elems[j]; j++) {
+			char *p;
+
 			strbuf_strip_suffix(elems[j], ",");
-			if (!skip_prefix(elems[j]->buf, "name=", &remote_name))
-				skip_prefix(elems[j]->buf, "url=", &remote_url);
+			if (skip_prefix(elems[j]->buf, "name=", &remote_name) ||
+			    skip_prefix(elems[j]->buf, "url=", &remote_url))
+				continue;
+
+			p = strchr(elems[j]->buf, '=');
+			if (p) {
+				*p = '\0';
+				string_list_append(&field_values, elems[j]->buf)->util = p + 1;
+			} else {
+				warning(_("invalid element '%s' from remote info"),
+					elems[j]->buf);
+			}
 		}
 
 		if (remote_name)
@@ -630,9 +706,16 @@ static void filter_promisor_remote(struct repository *repo,
 		if (remote_url)
 			decoded_url = url_percent_decode(remote_url);
 
-		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, info_list))
-			strvec_push(accepted, decoded_name);
+		if (decoded_name) {
+			if (!info_list)
+				info_list = promisor_info_list(repo, fields_checked());
+
+			if (should_accept_remote(accept, decoded_name, decoded_url,
+						 &field_values, info_list))
+				strvec_push(accepted, decoded_name);
+		}
 
+		string_list_clear(&field_values, 0);
 		strbuf_list_free(elems);
 		free(decoded_name);
 		free(decoded_url);
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 4038c076f1..2b54474ff8 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -321,6 +321,41 @@ test_expect_success "clone with promisor.sendFields" '
 	check_missing_objects server 1 "$oid"
 '
 
+test_expect_success "clone with promisor.checkFields" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	git -C server remote add otherLop "https://invalid.invalid"  &&
+	git -C server config remote.otherLop.token "fooBar" &&
+	git -C server config remote.otherLop.stuff "baz" &&
+	git -C server config remote.otherLop.partialCloneFilter "blob:limit=10k" &&
+	test_when_finished "git -C server remote remove otherLop" &&
+	git -C server config promisor.sendFields "token, partialCloneFilter" &&
+	test_when_finished "git -C server config unset promisor.sendFields" &&
+	test_when_finished "rm trace" &&
+
+	# Clone from server to create a client
+	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
+		-c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.partialCloneFilter="blob:none" \
+		-c promisor.acceptfromserver=All \
+		-c promisor.checkFields=partialcloneFilter \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that fields are properly transmitted
+	ENCODED_URL=$(echo "file://$(pwd)/lop" | sed -e "s/ /%20/g") &&
+	PR1="name=lop,url=$ENCODED_URL,partialCloneFilter=blob:none" &&
+	PR2="name=otherLop,url=https://invalid.invalid,token=fooBar,partialCloneFilter=blob:limit=10k" &&
+	test_grep "clone< promisor-remote=$PR1;$PR2" trace &&
+	test_grep "clone> promisor-remote=lop" trace &&
+	test_grep ! "clone> promisor-remote=lop;otherLop" trace &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
 test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
 	git -C server config promisor.advertise true &&
 
-- 
2.49.0.157.g09af0369a6


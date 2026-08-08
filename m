Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C9113C908
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 00:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147361; cv=none; b=XbrBdxjBa8Qy5JN4GuOzjeMunsTcQmw7NEf21vwZFFb+//F0jxrLMCElnnrb+TMpIwoOBKaQPI4cVUINbju7ONY6eprFVYvx2jTJBKoyabfxAbJ3CoLP//V2rGKv/JtIMPAM2wAQsXrxBX4uoEvbYrCefIY6Fi+f5fmOS4maq3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147361; c=relaxed/simple;
	bh=agUH9gahwLhT+X/qaaWBe/LpHXY6/1oaSOQ7j8A3tyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j24crYHceotu3vv8q3bBO2LtZ4BmKECX/9GgNkRn8uoGhC4E9I/4VR/Qx35sVq7XwX9nDDYAUGt9m5q0bHK+Gh8SAf9MW6jt8yIqEmc11TJQeMuEwPv8pI2/tepCK1h/DLPZaHddYTUjxaxeZTc3rX04uVCaQuIoz8KCwLu5EqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOohZwB8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOohZwB8"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49553515a8bso1428585e9.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 17:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786147358; x=1786752158; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D2dm1kfHdv+HjccmvDED6fAnJOsIiHpsJ5EF1M1dKew=;
        b=DOohZwB8TnTHnn0Pwe1DCZVNPsr+/KotwcxEOok5CvM/QrHrnyJtPjWrdEmmgBNrsl
         5lvsMNxyPZe3vYlJXrQww3bKyJbquadMPVM2G/OP023K9G5+48cTqGRnNGvDusiD+T1Y
         x69pfhUNin3S1NXb0sQbIAXhtXPnPWNLOguHWKV4gZFGdwmM3OXVJjELHEA+IKqX7eeO
         nVHIBEz+SB11tqXbzXrIDfcRx4mHOAtsxVYRC5OuNeHWe6DMaJcDh1u1S46KLajMWkyH
         jDmTrtylcXtKeCwbWBw7L0zd+sghY+K8QtlQcgkFKs43TAU7eMxJsuYKWImuompVHT+a
         OSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786147358; x=1786752158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D2dm1kfHdv+HjccmvDED6fAnJOsIiHpsJ5EF1M1dKew=;
        b=OjiQqyKuQjf4esAvqjJYIlijHauvDKLsuepb1HMi4zPGZ6TBpEKxOFKe+M7jhqcYNO
         RWr4URrcQrHzV1wXGm4QaBjPpk7H3Nla0t4sNODwqgEf/3eyTR9h/QtTY5nB/e2XS7Xp
         N7aS9zGj/0WVKIZEnwIj3H9SiUbgE1N0d7ng6S+2b/k8+auOWtMYSB6L4Vp8I3Ur2oJi
         hvSzbAp8QYLsaraS7nsU9hpbd0nPW5w+ssXaJ+BU2zPUSj/D6tOJnb0OWfiu54srdp/Z
         m3IIBH+Li3zrMCmjcVw3TXxbIBI6KVjrNbQBLp6WXV/lUeBXxh3bFGtMMMIkLWekHSmr
         b4Mg==
X-Gm-Message-State: AOJu0YwjUr5hvA0Cp07R36jnP13vu+PElfqvH+mcg8n4367SV5h3d3Mi
	LeLW9c8Ev16TrZbvRvK73jQGd/sgHjpI+ng8VFTvwr71ANhvC8Dp+AYk
X-Gm-Gg: AR+sD13m4wdR4kzWsPaducuCJsNZNFyaCcE2wDWLcr+wIU7QpyMCd31m2A7wuqZsGm7
	kJiIj3Zlq+YrgPE5HqYFZ/Ygla/pxj0Gt/QetI8WFP84lZ/koxtuJPCjnvbHB7VkampdKXS9ZZC
	xirEWyz9gZX/uzKpv2l88c4PhmZ1LG06ijp92fbJyQva/xUemBp0Dw6jXEmFA72ybaISwRAoYvU
	r0rB7IgqVIaP8lxh8oChXrImWMawGELDwCZW0QVT6eUaac3dcd7RGpYw4Tq/EHLXcb3rzN0Tg9P
	V+AiRk4w47bkLBkkDzRUJ/jEQwltnznJisQUS50/8DB729t4JX6aANJxd4IGjMWcK0s1YIkqPtI
	nQuogQmIV/JUasPCLnT9V0Z3Sqlna7NnWY/CESz1Mft9/GeNqVzk6QWWYrVYmTTBvXo+zRi4bzI
	xn4mgC89U3AyC2nNRxGzDQO9HNPOHNTS7F2ckIiywjVbhX8T6LViF8+RwM+IU9LUmjDFRMijQDl
	9R0JMmnYNK1q+BIpQC6zhwb9B6B/wWgOlCAkoOu69lFBoD/BR/xObHmVmuSTWMahYE29zY6S6bN
	Jo9X5phw7sVJk9PFllr1WIwwpuraHbHu1lIDNyQlRxTqm+2ajkliDTgQpbdEmPhXV+e1nt3r61e
	HGZNvs9mbDj9MGvpKnTxU/xdTT+30KLxNr5FPM0hZw45xgdEtwqBWdmJIMMJZeNjuqL+5
X-Received: by 2002:a05:600c:1d22:b0:493:c337:db0e with SMTP id 5b1f17b1804b1-49959e4263amr178774265e9.18.1786147357947;
        Fri, 07 Aug 2026 17:02:37 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c8ffsm72424525e9.2.2026.08.07.17.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:02:37 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 08 Aug 2026 02:02:25 +0200
Subject: [PATCH GSoC v6 10/10] cat-file: unify default format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-objecttype-support-v6-10-e5cdaf27a49c@gmail.com>
References: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
In-Reply-To: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

%(objecttype) is supported both by the client and by the server.
Change the temporary default format to the unified version that the
other commands use.

Update documentation to remove %(objecttype) from the caveats of
remote-object-info and show %(objecttype) support.

Now that type is supported and the default format unified, update the
tests to expect the new default format.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/git-cat-file.adoc        | 17 +++++------
 Documentation/gitprotocol-v2.adoc      | 18 +++++++++---
 builtin/cat-file.c                     |  7 -----
 t/t1017-cat-file-remote-object-info.sh | 52 +++++++++++++++++-----------------
 4 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index ac3b528c6f..514bfc0032 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -348,15 +348,12 @@ newline. The available atoms are:
 	after that first run of whitespace (i.e., the "rest" of the
 	line) are output in place of the `%(rest)` atom.
 
-The command `remote-object-info` only supports the `%(objectname)` and
-`%(objectsize)` placeholders. See `CAVEATS` below for more information.
+The command `remote-object-info` only supports the `%(objectname)`,
+`%(objectsize)` and `%(objecttype)` placeholders. See `CAVEATS` below for more
+information.
 
 If no format is specified, the default format is `%(objectname)
-%(objecttype) %(objectsize)`, except for `remote-object-info` commands which
-use `%(objectname) %(objectsize)` because `%(objecttype)` is not supported yet.
-
-WARNING: When "%(objecttype)" is supported, the default format WILL be unified,
-so DO NOT RELY on the current default format to stay the same!!!
+%(objecttype) %(objectsize)`.
 
 If `--batch` is specified, or if `--batch-command` is used with the `contents`
 command, the object information is followed by the object contents (consisting
@@ -453,9 +450,9 @@ scripting purposes.
 CAVEATS
 -------
 
-Note that only `%(objectname)` and `%(objectsize)` are currently
-supported by the `remote-object-info` command. Using any other placeholder in
-the format string will return an empty string in its position.
+Note that only `%(objectname)`, `%(objectsize)` and `%(objecttype)` are
+currently supported by the `remote-object-info` command. Using any other
+placeholder in the format string will return an empty string in its position.
 
 Note that the sizes of objects on disk are reported accurately, but care
 should be taken in drawing conclusions about which refs or objects are
diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index 7bf62014c3..dd52fd8110 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -558,14 +558,17 @@ object-info
 
 `object-info` is the command to retrieve information about one or more objects.
 Its main purpose is to allow a client to make decisions based on this
-information without having to fully fetch objects. Object size is the only
-information that is currently supported.
+information without having to fully fetch objects. Currently only object size
+and type are supported.
 
 An `object-info` request takes the following arguments:
 
 	size
 	Requests size information to be returned for each listed object id.
 
+	type
+	Requests type information to be returned for each listed object id.
+
 	oid <oid>
 	Indicates to the server an object which the client wants to obtain
 	information for. They must be full OIDs.
@@ -580,11 +583,18 @@ space.
 	info = *PKT-LINE(attr LF)
 	       *PKT-LINE(obj-info LF)
 
-	attr = "size"
+	attr = "size" | "type"
 
 	obj-size = 1*DIGIT
 
-	obj-info = obj-id [SP [obj-size]]
+	obj-type = "blob" | "tree" | "commit" | "tag"
+
+	obj-val = obj-size | obj-type
+
+	obj-info = obj-id [SP [obj-val *(SP obj-val)]]
+
+The values in `obj-info` appear in the same order as the corresponding `attr`
+lines, with exactly one value per requested attribute.
 
 If the server does not recognize the OID, the response will be `<oid> SP`
 regardless of the number of attributes requested.
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8502020083..011acdec09 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -821,15 +821,9 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	char *line_to_split;
 	struct fetch_object_info_results results = FETCH_OBJECT_INFO_RESULTS_INIT;
 	struct oid_array object_info_oids = OID_ARRAY_INIT;
-	const char *saved_format = opt->format;
 
 	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
 		die(_("remote-object-info command too long"));
-	/*
-	 * TODO: Use the default format once %(objecttype) is supported.
-	 */
-	if (!opt->format)
-		opt->format = "%(objectname) %(objectsize)";
 
 	line_to_split = xstrdup(line);
 	count = split_cmdline(line_to_split, &argv);
@@ -881,7 +875,6 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 		data->is_remote = 0;
 	}
 	data->skip_object_info = 0;
-	opt->format = saved_format;
 
 	free_fetch_object_info_results(&results);
 	free(line_to_split);
diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
index 190c45eefc..e2919aa061 100755
--- a/t/t1017-cat-file-remote-object-info.sh
+++ b/t/t1017-cat-file-remote-object-info.sh
@@ -139,10 +139,10 @@ test_expect_success 'batch-command remote-object-info git:// default filter' '
 		set_transport_variables "$daemon_parent" &&
 		cd "$daemon_parent/daemon_client_empty" &&
 
-		echo "$hello_oid $hello_size" >expect &&
-		echo "$tree_oid $tree_size" >>expect &&
-		echo "$commit_oid $commit_size" >>expect &&
-		echo "$tag_oid $tag_size" >>expect &&
+		echo "$hello_oid $hello_type $hello_size" >expect &&
+		echo "$tree_oid $tree_type $tree_size" >>expect &&
+		echo "$commit_oid $commit_type $commit_size" >>expect &&
+		echo "$tag_oid $tag_type $tag_size" >>expect &&
 
 		git cat-file --batch-command >actual <<-EOF &&
 		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid $tree_oid
@@ -152,7 +152,7 @@ test_expect_success 'batch-command remote-object-info git:// default filter' '
 	)
 '
 
-test_expect_success 'remote-object-info does not change the default format of info' '
+test_expect_success 'remote-object-info and info can be mixed using the unified default format' '
 	(
 		set_transport_variables "$daemon_parent" &&
 		cd "$daemon_parent/daemon_client_empty" &&
@@ -162,7 +162,7 @@ test_expect_success 'remote-object-info does not change the default format of in
 		local_size=$(strlen "$local_content") &&
 
 		echo "$local_oid blob $local_size" >expect &&
-		echo "$hello_oid $hello_size" >>expect &&
+		echo "$hello_oid blob $hello_size" >>expect &&
 		echo "$local_oid blob $local_size" >>expect &&
 
 		git cat-file --batch-command >actual <<-EOF &&
@@ -209,10 +209,10 @@ test_expect_success 'batch-command -Z remote-object-info git:// default filter'
 		set_transport_variables "$daemon_parent" &&
 		cd "$daemon_parent/daemon_client_empty" &&
 
-		printf "%s\0" "$hello_oid $hello_size" >expect &&
-		printf "%s\0" "$tree_oid $tree_size" >>expect &&
-		printf "%s\0" "$commit_oid $commit_size" >>expect &&
-		printf "%s\0" "$tag_oid $tag_size" >>expect &&
+		printf "%s\0" "$hello_oid $hello_type $hello_size" >expect &&
+		printf "%s\0" "$tree_oid $tree_type $tree_size" >>expect &&
+		printf "%s\0" "$commit_oid $commit_type $commit_size" >>expect &&
+		printf "%s\0" "$tag_oid $tag_type $tag_size" >>expect &&
 
 		printf "%s\0" "$hello_oid missing" >>expect &&
 		printf "%s\0" "$tree_oid missing" >>expect &&
@@ -448,10 +448,10 @@ test_expect_success 'batch-command remote-object-info file:// default filter' '
 		server_path="$(pwd)/server" &&
 		cd file_client_empty &&
 
-		echo "$hello_oid $hello_size" >expect &&
-		echo "$tree_oid $tree_size" >>expect &&
-		echo "$commit_oid $commit_size" >>expect &&
-		echo "$tag_oid $tag_size" >>expect &&
+		echo "$hello_oid $hello_type $hello_size" >expect &&
+		echo "$tree_oid $tree_type $tree_size" >>expect &&
+		echo "$commit_oid $commit_type $commit_size" >>expect &&
+		echo "$tag_oid $tag_type $tag_size" >>expect &&
 
 		git cat-file --batch-command >actual <<-EOF &&
 		remote-object-info "file://${server_path}" $hello_oid $tree_oid
@@ -467,10 +467,10 @@ test_expect_success 'batch-command -Z remote-object-info file:// default filter'
 		server_path="$(pwd)/server" &&
 		cd file_client_empty &&
 
-		printf "%s\0" "$hello_oid $hello_size" >expect &&
-		printf "%s\0" "$tree_oid $tree_size" >>expect &&
-		printf "%s\0" "$commit_oid $commit_size" >>expect &&
-		printf "%s\0" "$tag_oid $tag_size" >>expect &&
+		printf "%s\0" "$hello_oid $hello_type $hello_size" >expect &&
+		printf "%s\0" "$tree_oid $tree_type $tree_size" >>expect &&
+		printf "%s\0" "$commit_oid $commit_type $commit_size" >>expect &&
+		printf "%s\0" "$tag_oid $tag_type $tag_size" >>expect &&
 
 		printf "%s\0" "$hello_oid missing" >>expect &&
 		printf "%s\0" "$tree_oid missing" >>expect &&
@@ -618,10 +618,10 @@ test_expect_success 'batch-command remote-object-info http:// default filter' '
 		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
 
-		echo "$hello_oid $hello_size" >expect &&
-		echo "$tree_oid $tree_size" >>expect &&
-		echo "$commit_oid $commit_size" >>expect &&
-		echo "$tag_oid $tag_size" >>expect &&
+		echo "$hello_oid $hello_type $hello_size" >expect &&
+		echo "$tree_oid $tree_type $tree_size" >>expect &&
+		echo "$commit_oid $commit_type $commit_size" >>expect &&
+		echo "$tag_oid $tag_type $tag_size" >>expect &&
 
 		git cat-file --batch-command >actual <<-EOF &&
 		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid $tree_oid
@@ -636,10 +636,10 @@ test_expect_success 'batch-command -Z remote-object-info http:// default filter'
 		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
 
-		printf "%s\0" "$hello_oid $hello_size" >expect &&
-		printf "%s\0" "$tree_oid $tree_size" >>expect &&
-		printf "%s\0" "$commit_oid $commit_size" >>expect &&
-		printf "%s\0" "$tag_oid $tag_size" >>expect &&
+		printf "%s\0" "$hello_oid $hello_type $hello_size" >expect &&
+		printf "%s\0" "$tree_oid $tree_type $tree_size" >>expect &&
+		printf "%s\0" "$commit_oid $commit_type $commit_size" >>expect &&
+		printf "%s\0" "$tag_oid $tag_type $tag_size" >>expect &&
 
 		batch_input="remote-object-info $HTTPD_URL/smart/http_parent $hello_oid $tree_oid
 remote-object-info $HTTPD_URL/smart/http_parent $commit_oid $tag_oid

-- 
2.54.0


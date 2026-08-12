Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A1C43078B
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550161; cv=none; b=R5UlfNG6jt1aSebamHSK95S6QDgyILI7HbLTng/qwzQdTziGPvK60EeukvT2CwxjvL0SgDm9Y3Qc+/bHA2iYdd/vu50XaSNjVnXSk0BLmUdEDAkamTvB8SfJqYXt95ITb5xcWMGtPXfhJAlKeeO1RgVoE6uuWO5bJwBd8DVZWas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550161; c=relaxed/simple;
	bh=sc0+AXK5NbU53QDybQIbwCJwPWzMsyUAY94EOErvyPU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=fWZKEZniBjW6P2FVF7ejuNLlLsF1VkRSe+r3QfGDZKAHbPwj5B/JygjcZgdlCdtluUeUpMiKEWFuXEeGq2S1HUdQ0z7VuCSs/V+fqG3WkCa3d1X+zJZyWxyoJma8HzWYm1Mqw+coHptj5LnEEIZj0Ey0N/sxFHvzWXithOudKCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0Q5sQm5; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0Q5sQm5"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6aa9606ddadso871582eaf.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786550159; x=1787154959; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j4XEnlPGULEBjMHkX/mA9qMxToN2YnE3C8OICYtH3T8=;
        b=E0Q5sQm5YpIyxiEshQqqkc2pdOdHQzOaVjxJ1BirrTZfB4JgXNgrGNMNe95eBWs+c0
         LplB07TnvXdR/Qd9B/zWvHsymQakEJLj2xDBXrjI+VNvmfq/z4bxg+ecvRlV8Jb2mWT+
         4jbcJ2Tt3KVJiwXiXVdtMT97Om2hG33iSRnVLXzVfmrvuIi6vCPnIVyOl+hgUceVEL6c
         auIYJXA4p4Yun8GQXx6AcjCHJwV/aDB1OWXH/buxn1FrJCOAI1TAGdro0j5p/JKTJMCj
         /T1OtlpofOy4F4KrZ07+U7kNlgOU/44BSKddpqQ/jHUOjn7V5T4itJNF0ahmOmdat7Iq
         v36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786550159; x=1787154959;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j4XEnlPGULEBjMHkX/mA9qMxToN2YnE3C8OICYtH3T8=;
        b=HnDLXBuWrGcf/DBPw7/HIjiGD8RUWtNZIwop0c00mxLWg/h54C3GlEOQ5mh+bewhY5
         HV5fzLt58o8aZr6j4CoTC5+dSMO9UtTajfleIzWpBVfrPvMswR6M5WbxUG0bAm6klqei
         0OK8WLdBHc4Xig4V/nN3TWrRLUTV/mLt7bWHsbr3bDxTT41jc6sGQMYuAnZ6jrnZqsjt
         LVt0J42GhJzhkM70fu7jZuqqL3hNvbeXECrWpGwYiWFyzHYiCpBxB4VcKKDRT6SgjmXq
         bUl3LhVQr7Sj8mqf0QlxMRIUJGoubzXqVGnTMkPod9X+nMbi50LHe+r0dZFvvqmFKi2v
         Bggw==
X-Gm-Message-State: AOJu0YyufhXIgJo1KlehatxisMJgHKsIqko2/4fCh3HvIfrUBCBQJrem
	gGtNXUFHIzrwKiFEtzLvwNmUCc6oZAMV9zvfBD/4xsxUjmYuU2d5hIDrDYnSfw==
X-Gm-Gg: AR+sD137cPab6DNibXAYAkteoLm+9GZTRyKgIresvG1had0JHfMODK5FfMcarv3m3qs
	ILP9mKKEpAVpFDo8uuEBZBSzuBrvrsbl7VbMw/lIxzkr9cf3CdeQQNJsyl9+BdRTbtEICd+bbwp
	zRD/09RvvdiDDdgroWk6KksYffoGi/O4Jv39z6mKHZIxzVQ6omPNJiL9DaxvIglmOb2hClxSw+Z
	gtHIjPlj6DwTSVBUc/rizjWeRDaNVdaHVrQRhil7nTA1HVR8D1BXtgOdjA1RRcPEP4B93SH4jx7
	aGaIj6fH5CPS3e1G1KhSxF35g4/4CIOVON6bShPwvXd1Fh+xA55FbKhQY/s8sf6hptjAGZ3tT45
	ZH3+n/UBNR5tSy8LcKRlNaT+4D/yQ/QrULqXs0nJDCjJNIyQ5toSjOoeYpQzGPzczo3GGpQA4U0
	l2xpiwiAmXDgo+80YTB0t3p52+UqbaRMpMN2hxQLHiwLFVOcbmW8jto0RsK0L1IQ==
X-Received: by 2002:a05:6820:200d:b0:6a3:f522:7656 with SMTP id 006d021491bc7-6b0b2c34da6mr5312982eaf.20.1786550158729;
        Wed, 12 Aug 2026 08:55:58 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.18.40])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0ad6d3895sm3027134eaf.14.2026.08.12.08.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:55:58 -0700 (PDT)
Message-Id: <pull.2200.git.1786550157424.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 15:55:56 +0000
Subject: [PATCH] bundle-uri: refuse advertised URIs by protocol
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Servers may advertise bundle URIs that are not HTTP(S);
copy_uri_to_file() then opens it as a local path. On Windows that can be
a UNC path like `//attacker/share/x`, i.e. a clone can be manipulated
into making an outbound SMB connection that leaks NTLM credentials
(CVE-2026-62960).

Subject advertised URIs to the usual protocol allow-list
(`protocol.*.allow`), which drops "file" (and bare/UNC paths) by default
but keeps http/https/git/ssh. Do it in fetch_bundle_list(), the
clone/fetch consume path, so ls-remote still lists everything; each
skipped URI is reported. A user-supplied `--bundle-uri` is unaffected,
and `protocol.file.allow=always` re-enables an advertised file URI.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    bundle-uri: refuse advertised URIs by protocol
    
    This is the security fix released with Git for Windows v2.55.0(4). Due
    to the transparent NTLM authentication ("SSPI"), the vulnerability
    affects only Windows. The patch has been sent to the git-security list
    on June 26th, 2026, but only received reviews in the PR in
    https://github.com/git-for-windows/git/security/advisories/GHSA-xrpg-8j9v-v282's
    private fork (which had to be deleted so that the advisory could be
    published).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2200%2Fdscho%2Frespect-allowed-protocols-in-bundle-uris-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2200/dscho/respect-allowed-protocols-in-bundle-uris-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2200

 bundle-uri.c                 | 50 ++++++++++++++++++++++++++++++++
 t/lib-bundle-uri-protocol.sh | 56 ++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/bundle-uri.c b/bundle-uri.c
index 2bb2eb99e4..92a36ca0ab 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -15,6 +15,8 @@
 #include "remote.h"
 #include "trace2.h"
 #include "odb.h"
+#include "transport.h"
+#include "url.h"
 
 static struct {
 	enum bundle_list_heuristic heuristic;
@@ -890,11 +892,59 @@ cleanup:
 	return result;
 }
 
+/* protocol of 'uri', or "file" if it has none (bare/UNC/relative path) */
+static void bundle_uri_protocol(const char *uri, struct strbuf *out)
+{
+	const char *p = uri;
+
+	while (is_urlschemechar(p == uri, *p))
+		p++;
+	strbuf_reset(out);
+	if (p > uri && starts_with(p, "://"))
+		strbuf_add(out, uri, p - uri);
+	else
+		strbuf_addstr(out, "file");
+}
+
+/* Drop advertised URIs whose protocol is not allowed (see protocol.*.allow). */
+static void sanitize_bundle_list(struct bundle_list *list)
+{
+	struct remote_bundle_info **skipped;
+	size_t nr = 0, i;
+	struct remote_bundle_info *info;
+	struct hashmap_iter iter;
+	struct strbuf proto = STRBUF_INIT;
+
+	ALLOC_ARRAY(skipped, hashmap_get_size(&list->bundles));
+	hashmap_for_each_entry(&list->bundles, &iter, info, ent) {
+		if (!info->uri)
+			continue;
+		bundle_uri_protocol(info->uri, &proto);
+		/* advertised URIs are not user-provided */
+		if (!is_transport_allowed(proto.buf, 0)) {
+			warning(_("skipping bundle URI '%s': protocol '%s' "
+				  "is not allowed"), info->uri, proto.buf);
+			skipped[nr++] = info;
+		}
+	}
+	strbuf_release(&proto);
+
+	for (i = 0; i < nr; i++) {
+		hashmap_remove(&list->bundles, &skipped[i]->ent, NULL);
+		clear_remote_bundle_info(skipped[i], NULL);
+		free(skipped[i]);
+	}
+
+	free(skipped);
+}
+
 int fetch_bundle_list(struct repository *r, struct bundle_list *list)
 {
 	int result;
 	struct bundle_list global_list;
 
+	sanitize_bundle_list(list);
+
 	/*
 	 * If the creationToken heuristic is used, then the URIs
 	 * advertised by 'list' are not nested lists and instead
diff --git a/t/lib-bundle-uri-protocol.sh b/t/lib-bundle-uri-protocol.sh
index 794478ae19..889e673a44 100644
--- a/t/lib-bundle-uri-protocol.sh
+++ b/t/lib-bundle-uri-protocol.sh
@@ -237,3 +237,59 @@ test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol
 		>actual &&
 	test_cmp_config_output expect actual
 '
+
+# Advertised bundle URIs are subject to protocol.*.allow; "file" (and bare or
+# UNC paths) is denied by default, so such a URI must be skipped, not fetched.
+advertise_uri () {
+	test_config -C "$BUNDLE_URI_PARENT" bundle.version 1 &&
+	test_config -C "$BUNDLE_URI_PARENT" bundle.mode all &&
+	test_config -C "$BUNDLE_URI_PARENT" bundle.payload.uri "$1"
+}
+
+ignores_advertised_uri () {
+	rm -rf victim &&
+	advertise_uri "$1" &&
+	git -c transfer.bundleURI=true -c protocol.version=2 \
+		clone "$BUNDLE_URI_REPO_URI" victim &&
+	git -C victim for-each-ref refs/bundles/ >refs &&
+	test_must_be_empty refs
+}
+
+test_expect_success "create bundle to advertise" '
+	git -C "$BUNDLE_URI_PARENT" bundle create "$PWD/payload.bundle" main
+'
+
+test_expect_success "ignore non-HTTP(S) bundle URI with $BUNDLE_URI_PROTOCOL://" '
+	ignores_advertised_uri "$PWD/payload.bundle" &&
+	ignores_advertised_uri "file://$PWD/payload.bundle"
+'
+
+test_expect_success "protocol.file.allow=always honors file bundle URI with $BUNDLE_URI_PROTOCOL://" '
+	rm -rf victim &&
+	advertise_uri "$PWD/payload.bundle" &&
+	git -c transfer.bundleURI=true -c protocol.version=2 \
+		-c protocol.file.allow=always \
+		clone "$BUNDLE_URI_REPO_URI" victim &&
+	git -C victim rev-parse --verify refs/bundles/heads/main
+'
+
+# same path via a UNC administrative share (cf. t5580-unc-paths.sh)
+if test_have_prereq CYGWIN
+then
+	UNCPATH="$(cygpath -aw .)"
+elif test_have_prereq MINGW
+then
+	UNCPATH="$(pwd)"
+fi
+case "$UNCPATH" in
+[A-Za-z]:*)
+	WITHOUTDRIVE="${UNCPATH#?:}"
+	UNCPATH="//localhost/${UNCPATH%%:*}\$$WITHOUTDRIVE"
+	test -d "$UNCPATH" && test_set_prereq ADMIN_UNC
+	;;
+esac
+
+test_expect_success ADMIN_UNC "ignore UNC bundle URI with $BUNDLE_URI_PROTOCOL://" '
+	ignores_advertised_uri "$UNCPATH/payload.bundle" &&
+	ignores_advertised_uri "file://$UNCPATH/payload.bundle"
+'

base-commit: 11c6700f10234578d10523faf35656ca491425c9
-- 
gitgitgadget

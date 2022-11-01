Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCF4FA3740
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 01:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiKABHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 21:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKABHk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 21:07:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761031658D
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:07:38 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j15so18260626wrq.3
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNoP/XiagNYJqY1gtmMDna01LlRJft9mBpsTdeWfLTk=;
        b=bECG95dI6ZL3I2Sj62xHV2TSOrx1WEvmESXZ2rcosluHA+rJCGJ5ZK0s57lM/JgzW/
         gatknl0cXuITybqyfYxKNQaxygoNZJRBVjlrFUo0vaZXTsDDfl7Jx4Fh9Wpf3N/E+O1d
         VhbcMT6eMkywUf9n8ukHUGSpz8cjh+dl+AkFYHb3i4uFw96YL2Om0z3JN0dL8bVX0zZ6
         Io0zRwa8IZY+41t07hzY34iSANiqTbBQeunT7QRcAwWUFoyyaA/c2Md0vvH7p0PgmjZm
         gkTPfMeCMGThCHl7X/N4yicE6GlLRYGPg71u3A+8hcJxoQfDsW2s+LqAQm7NDwt/o0C9
         UMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNoP/XiagNYJqY1gtmMDna01LlRJft9mBpsTdeWfLTk=;
        b=Sxfnng4r5Wo7MJ4hVG/bhLjpyVlQVJ0K4mqKutg2g4+UGG28rQcgkzO+5IiONtiE+n
         mXvEMmS8R78QwXwPkl/k99SqWHZ0ENNV4xUUyQ7j14zE+Wjo4eReRaY8foXfcoQgSd6R
         RXSzjO4YzdhUXInApr2IwziDsBgekFSbfOmPtLCN8Iol2hUgR26HgHnKU8lIhvq/vYKO
         NCt+ebudXjLdqWUgiXwT7UDP/JCp5aj0ocQrxdIImDxZ6gsHKAoaN+b2PZULRYjoAxEx
         FkAalmx/pkfMPHlpMWSO0kReTEEWM4tkWBS/kkWCuURxw/N0SGvfnsL66GD3tHCjRH4Q
         t9PA==
X-Gm-Message-State: ACrzQf2AQoo/hlr/YHYzqRnwcgVm53r+LMXQFLH8nvDaapAGiBzQelsi
        ap7fNPH+k3le1HixZn2TA0ysjAeS9RQ=
X-Google-Smtp-Source: AMsMyM6yc5eijpgdCqqyNB1Sz+YKD5Z6KKvYOVzRg1XdWngVw2AUt7dq90CeiPhK0iaVR8frc4e54Q==
X-Received: by 2002:a5d:64e9:0:b0:22e:7631:bcab with SMTP id g9-20020a5d64e9000000b0022e7631bcabmr10207586wri.36.1667264856604;
        Mon, 31 Oct 2022 18:07:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ck7-20020a5d5e87000000b00235da296623sm8576383wrb.31.2022.10.31.18.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 18:07:36 -0700 (PDT)
Message-Id: <a02eee983185815d94ba1124b43eae43280aa963.1667264854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 01 Nov 2022 01:07:26 +0000
Subject: [PATCH 1/9] protocol v2: add server-side "bundle-uri" skeleton
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

Add a skeleton server-side implementation of a new "bundle-uri" command
to protocol v2. This will allow conforming clients to optionally seed
their initial clones or incremental fetches from URLs containing
"*.bundle" files created with "git bundle create".

This change only performs the basic boilerplate of advertising a new
protocol v2 capability. The new 'bundle-uri' capability allows a client
to request a list of bundles. Right now, the server only returns a flush
packet, which corresponds to an empty advertisement. The bundle.* config
namespace describes which key-value pairs will be communicated across
this interface in future updates.

The critical bit right now is that the new boolean
uploadPack.adverstiseBundleURIs config value signals whether or not this
capability should be advertised at all.

An earlier version of this patch [1] used a different transfer format
than the "key=value" pairs in the current implementation. The change was
made to unify the protocol v2 verb with the bundle lists provided by
independent bundle servers. Further, the standard allows for the server
to advertise a URI that contains a bundle list. This allows users
automatically discovering bundle providers that are loosely associated
with the origin server, but without the origin server knowing exactly
which bundles are currently available.

[1] https://lore.kernel.org/git/RFC-patch-v2-01.13-2fc87ce092b-20220311T155841Z-avarab@gmail.com/

The very-deep headings needed to be modified to stop at level 4 due to
documentation build issues. These were not recognized in earlier builds
since the file was previously in the Documentation/technical/ directory
and was built in a different way. With its current location, the
heavily-nested details were causing build issues and they are now
replaced with a bulletted list of details.

Co-authored-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/gitprotocol-v2.txt | 193 +++++++++++++++++++++++++++++++
 bundle-uri.c                     |  36 ++++++
 bundle-uri.h                     |   7 ++
 serve.c                          |   6 +
 t/t5701-git-serve.sh             |  40 ++++++-
 5 files changed, 281 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index 59bf41cefb9..57642b4a415 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -578,6 +578,199 @@ and associated requested information, each separated by a single space.
 
 	obj-info = obj-id SP obj-size
 
+bundle-uri
+~~~~~~~~~~
+
+If the 'bundle-uri' capability is advertised, the server supports the
+`bundle-uri' command.
+
+The capability is currently advertised with no value (i.e. not
+"bundle-uri=somevalue"), a value may be added in the future for
+supporting command-wide extensions. Clients MUST ignore any unknown
+capability values and proceed with the 'bundle-uri` dialog they
+support.
+
+The 'bundle-uri' command is intended to be issued before `fetch` to
+get URIs to bundle files (see linkgit:git-bundle[1]) to "seed" and
+inform the subsequent `fetch` command.
+
+The client CAN issue `bundle-uri` before or after any other valid
+command. To be useful to clients it's expected that it'll be issued
+after an `ls-refs` and before `fetch`, but CAN be issued at any time
+in the dialog.
+
+DISCUSSION of bundle-uri
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+The intent of the feature is optimize for server resource consumption
+in the common case by changing the common case of fetching a very
+large PACK during linkgit:git-clone[1] into a smaller incremental
+fetch.
+
+It also allows servers to achieve better caching in combination with
+an `uploadpack.packObjectsHook` (see linkgit:git-config[1]).
+
+By having new clones or fetches be a more predictable and common
+negotiation against the tips of recently produces *.bundle file(s).
+Servers might even pre-generate the results of such negotiations for
+the `uploadpack.packObjectsHook` as new pushes come in.
+
+One way that servers could take advantage of these bundles is that the
+server would anticipate that fresh clones will download a known bundle,
+followed by catching up to the current state of the repository using ref
+tips found in that bundle (or bundles).
+
+PROTOCOL for bundle-uri
+^^^^^^^^^^^^^^^^^^^^^^^
+
+A `bundle-uri` request takes no arguments, and as noted above does not
+currently advertise a capability value. Both may be added in the
+future.
+
+When the client issues a `command=bundle-uri` the response is a list of
+key-value pairs provided as packet lines with value `<key>=<value>`. The
+meaning of these key-value pairs are provided by the config keys in the
+`bundle.*` namespace (see linkgit:git-config[1]).
+
+Clients are still expected to fully parse the line according to the
+above format, lines that do not conform to the format SHOULD be
+discarded. The user MAY be warned in such a case.
+
+bundle-uri CLIENT AND SERVER EXPECTATIONS
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+URI CONTENTS::
+The advertised URIs MUST be in one of two possible formats.
++
+The first possible format is a bundle file that `git bundle verify`
+would accept. I.e. they MUST contain one or more reference tips for
+use by the client, MUST indicate prerequisites (in any) with standard
+"-" prefixes, and MUST indicate their "object-format", if
+applicable. Create "*.bundle" files with `git bundle create`.
++
+The second possible format is a plaintext file that `git config --list`
+would accept (with the `--file` option). The key-value pairs in this list
+are in the `bundle.*` namespace (see linkgit:git-config[1]).
+
+bundle-uri CLIENT ERROR RECOVERY::
+A client MUST above all gracefully degrade on errors, whether that
+error is because of bad missing/data in the bundle URI(s), because
+that client is too dumb to e.g. understand and fully parse out bundle
+headers and their prerequisite relationships, or something else.
++
+Server operators should feel confident in turning on "bundle-uri" and
+not worry if e.g. their CDN goes down that clones or fetches will run
+into hard failures. Even if the server bundle bundle(s) are
+incomplete, or bad in some way the client should still end up with a
+functioning repository, just as if it had chosen not to use this
+protocol extension.
++
+All subsequent discussion on client and server interaction MUST keep
+this in mind.
+
+bundle-uri SERVER TO CLIENT::
+The ordering of the returned bundle uris is not significant. Clients
+MUST parse their headers to discover their contained OIDS and
+prerequisites. A client MUST consider the content of the bundle(s)
+themselves and their header as the ultimate source of truth.
++
+A server MAY even return bundle(s) that don't have any direct
+relationship to the repository being cloned (either through accident,
+or intentional "clever" configuration), and expect a client to sort
+out what data they'd like from the bundle(s), if any.
+
+bundle-uri CLIENT TO SERVER::
+The client SHOULD provide reference tips found in the bundle header(s)
+as 'have' lines in any subsequent `fetch` request. A client MAY also
+ignore the bundle(s) entirely if doing so is deemed worse for some
+reason, e.g. if the bundles can't be downloaded, it doesn't like the
+tips it finds etc.
+
+WHEN ADVERTISED BUNDLE(S) REQUIRE NO FURTHER NEGOTIATION::
+If after issuing `bundle-uri` and `ls-refs`, and getting the header(s)
+of the bundle(s) the client finds that the ref tips it wants can be
+retrieved entirety from advertised bundle(s), it MAY disconnect. The
+results of such a 'clone' or 'fetch' should be indistinguishable from
+the state attained without using bundle-uri.
+
+EARLY CLIENT DISCONNECTIONS AND ERROR RECOVERY::
+A client MAY perform an early disconnect while still downloading the
+bundle(s) (having streamed and parsed their headers). In such a case
+the client MUST gracefully recover from any errors related to
+finishing the download and validation of the bundle(s).
++
+I.e. a client might need to re-connect and issue a 'fetch' command,
+and possibly fall back to not making use of 'bundle-uri' at all.
++
+This "MAY" behavior is specified as such (and not a "SHOULD") on the
+assumption that a server advertising bundle uris is more likely than
+not to be serving up a relatively large repository, and to be pointing
+to URIs that have a good chance of being in working order. A client
+MAY e.g. look at the payload size of the bundles as a heuristic to see
+if an early disconnect is worth it, should falling back on a full
+"fetch" dialog be necessary.
+
+WHEN ADVERTISED BUNDLE(S) REQUIRE FURTHER NEGOTIATION::
+A client SHOULD commence a negotiation of a PACK from the server via
+the "fetch" command using the OID tips found in advertised bundles,
+even if's still in the process of downloading those bundle(s).
++
+This allows for aggressive early disconnects from any interactive
+server dialog. The client blindly trusts that the advertised OID tips
+are relevant, and issues them as 'have' lines, it then requests any
+tips it would like (usually from the "ls-refs" advertisement) via
+'want' lines. The server will then compute a (hopefully small) PACK
+with the expected difference between the tips from the bundle(s) and
+the data requested.
++
+The only connection the client then needs to keep active is to the
+concurrently downloading static bundle(s), when those and the
+incremental PACK are retrieved they should be inflated and
+validated. Any errors at this point should be gracefully recovered
+from, see above.
+
+bundle-uri PROTOCOL FEATURES
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+As noted above the `<key>=<value>` definitions are documented by the
+`bundle.*` config namespace.
+
+In particular, the `bundle.version` key specifies an integer value. The
+only accepted value at the moment is `1`, but if the client sees an
+unexpected value here then the client MUST ignore the bundle list.
+
+As long as `bundle.version` is understood, all other unknown keys MAY be
+ignored by the client. The server will guarantee compatibility with older
+clients, though newer clients may be better able to use the extra keys to
+minimize downloads.
+
+Any backwards-incompatible addition of pre-URI key-value will be
+guarded by a new `bundle.version` value or values in 'bundle-uri'
+capability advertisement itself, and/or by new future `bundle-uri`
+request arguments.
+
+Some example key-value pairs that are not currently implemented but could
+be implemented in the future include:
+
+ * Add a "hash=<val>" or "size=<bytes>" advertise the expected hash or
+   size of the bundle file.
+
+ * Advertise that one or more bundle files are the same (to e.g. have
+   clients round-robin or otherwise choose one of N possible files).
+
+ * A "oid=<OID>" shortcut and "prerequisite=<OID>" shortcut. For
+   expressing the common case of a bundle with one tip and no
+   prerequisites, or one tip and one prerequisite.
++
+This would allow for optimizing the common case of servers who'd like
+to provide one "big bundle" containing only their "main" branch,
+and/or incremental updates thereof.
++
+A client receiving such a a response MAY assume that they can skip
+retrieving the header from a bundle at the indicated URI, and thus
+save themselves and the server(s) the request(s) needed to inspect the
+headers of that bundle or bundles.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/bundle-uri.c b/bundle-uri.c
index 79a914f961b..32022595964 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -563,6 +563,42 @@ cleanup:
 	return result;
 }
 
+/**
+ * API for serve.c.
+ */
+
+int bundle_uri_advertise(struct repository *r, struct strbuf *value)
+{
+	static int advertise_bundle_uri = -1;
+
+	if (advertise_bundle_uri != -1)
+		goto cached;
+
+	advertise_bundle_uri = 0;
+	git_config_get_maybe_bool("uploadpack.advertisebundleuris", &advertise_bundle_uri);
+
+cached:
+	return advertise_bundle_uri;
+}
+
+int bundle_uri_command(struct repository *r,
+		       struct packet_reader *request)
+{
+	struct packet_writer writer;
+	packet_writer_init(&writer, 1);
+
+	while (packet_reader_read(request) == PACKET_READ_NORMAL)
+		die(_("bundle-uri: unexpected argument: '%s'"), request->line);
+	if (request->status != PACKET_READ_FLUSH)
+		die(_("bundle-uri: expected flush after arguments"));
+
+	/* TODO: Implement the communication */
+
+	packet_writer_flush(&writer);
+
+	return 0;
+}
+
 /**
  * General API for {transport,connect}.c etc.
  */
diff --git a/bundle-uri.h b/bundle-uri.h
index 4dbc269823c..357111ecce8 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -4,6 +4,7 @@
 #include "hashmap.h"
 #include "strbuf.h"
 
+struct packet_reader;
 struct repository;
 struct string_list;
 
@@ -92,6 +93,12 @@ int bundle_uri_parse_config_format(const char *uri,
  */
 int fetch_bundle_uri(struct repository *r, const char *uri);
 
+/**
+ * API for serve.c.
+ */
+int bundle_uri_advertise(struct repository *r, struct strbuf *value);
+int bundle_uri_command(struct repository *r, struct packet_reader *request);
+
 /**
  * General API for {transport,connect}.c etc.
  */
diff --git a/serve.c b/serve.c
index 733347f602a..cbf4a143cfe 100644
--- a/serve.c
+++ b/serve.c
@@ -7,6 +7,7 @@
 #include "protocol-caps.h"
 #include "serve.h"
 #include "upload-pack.h"
+#include "bundle-uri.h"
 
 static int advertise_sid = -1;
 static int client_hash_algo = GIT_HASH_SHA1;
@@ -135,6 +136,11 @@ static struct protocol_capability capabilities[] = {
 		.advertise = always_advertise,
 		.command = cap_object_info,
 	},
+	{
+		.name = "bundle-uri",
+		.advertise = bundle_uri_advertise,
+		.command = bundle_uri_command,
+	},
 };
 
 void protocol_v2_advertise_capabilities(void)
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 1896f671cb3..f21e5e9d33d 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -13,7 +13,7 @@ test_expect_success 'test capability advertisement' '
 	wrong_algo sha1:sha256
 	wrong_algo sha256:sha1
 	EOF
-	cat >expect <<-EOF &&
+	cat >expect.base <<-EOF &&
 	version 2
 	agent=git/$(git version | cut -d" " -f3)
 	ls-refs=unborn
@@ -21,8 +21,11 @@ test_expect_success 'test capability advertisement' '
 	server-option
 	object-format=$(test_oid algo)
 	object-info
+	EOF
+	cat >expect.trailer <<-EOF &&
 	0000
 	EOF
+	cat expect.base expect.trailer >expect &&
 
 	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
 		--advertise-capabilities >out &&
@@ -342,4 +345,39 @@ test_expect_success 'basics of object-info' '
 	test_cmp expect actual
 '
 
+test_expect_success 'test capability advertisement with uploadpack.advertiseBundleURIs' '
+	test_config uploadpack.advertiseBundleURIs true &&
+
+	cat >expect.extra <<-EOF &&
+	bundle-uri
+	EOF
+	cat expect.base \
+	    expect.extra \
+	    expect.trailer >expect &&
+
+	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
+		--advertise-capabilities >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'basics of bundle-uri: dies if not enabled' '
+	test-tool pkt-line pack >in <<-EOF &&
+	command=bundle-uri
+	0000
+	EOF
+
+	cat >err.expect <<-\EOF &&
+	fatal: invalid command '"'"'bundle-uri'"'"'
+	EOF
+
+	cat >expect <<-\EOF &&
+	ERR serve: invalid command '"'"'bundle-uri'"'"'
+	EOF
+
+	test_must_fail test-tool serve-v2 --stateless-rpc <in >out 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out
+'
+
 test_done
-- 
gitgitgadget


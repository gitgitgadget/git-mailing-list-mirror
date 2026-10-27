Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071019;
	b=QdxT6AJOk5zzEs7pULXGr9Famq0xj5KrqHo6SZKna4iwF/h3069+NFikuKNJvALBOSCr
	 iQUaAJ6mnDoiBM7EAdn/jxFooWeCwqw/aH4wNL7cEtB7uleMM7GvITVznK1LojvBxX35v
	 0h4q4e+nM1kJc2kGkIK5TxTpxSIJChZxU1CPFrY7TUAqv1qcgI6Oem+hT4RHfW4EGT30Y
	 VqWbjiR4fschEo0xW52hbHzOxjhcTx8HyJSKydSviGJamZw+5t4K/27e5Zba5wpmfLWsc
	 SWIpbNnIbj4eXRGgjvQq2Ns8lhyzXpCLqgcwomodgTKP/o9k9GhhUkBfsRwjlaRJNZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=to505VgkrgPRikI4kOxkJiQZ07ILiscY2rjp3HnkQEI=;
	b=IgJCRiZgUAVrvarJk5rZD1Z3Q5OlHAKNbG8mh782qjy7f2aXZSbLG1/bUp9YDqC9DUVL
	 hY+3GeNMLEa7Z6pKCR0FVmCc1C604GeHNAd9WFue0XaBMAviKBtiKV9iHkcfyV2Cosh35
	 6pC8JIXeSsaVccWwLNqR0RNuDTDPYaZZvQ2hggwWB5DcEIF9RZsBf6Ky1va00zWuowSXY
	 k9+Y2LoeRJ1koOvtWeEv5Ns3F+R/P24jdltJeSeIgir4vWRUxIeZdCQxH5Tr6aQs9nPxI
	 AyJ9L0gEKVvgFCSUXnnwnJGCkxqFZA33iJzMX1LezfJgd+YI2ZQIhiZum7CnNvMk2mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=svln1UC8;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D3606A320
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 03:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C9D3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=svln1UC8
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a208d93758so42161235e9.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 20:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793071018; x=1793675818; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=to505VgkrgPRikI4kOxkJiQZ07ILiscY2rjp3HnkQEI=;
        b=svln1UC8BNlOgpfs0VtAtvDXZAJIwzjnQQdAV8UBiYmD17C3G9xYseZntnMT+iFeSv
         w4NEd39C5PuGapQUVlcj0pkg5O2D67ZJiOiXuF1Ge+nceTGG8FdSI+acbGL25wv7TinP
         dXUl0qzYUU0nqp5hqBv5coAT4aSyBUxex7lqz19adPRjmdJ8mneMl7ZCDGm8P3BJlg25
         VKSzMIqG2Kb2xvta63pyiSZVLOu0bgz55kBJARl/GhvW4x0jZPPmP+lqqy4y127xewLJ
         Cbdm58b9gPvncEQc2079YhagOrMOebBTdQfm+G5YKSOpIL24+YPVuR4H4GbSSofGQIAk
         4lUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793071018; x=1793675818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=to505VgkrgPRikI4kOxkJiQZ07ILiscY2rjp3HnkQEI=;
        b=goeiaCNvle7QOTZY7I4WS3l518KQBlv50QEY9XUTKg75AYFIgTVJaFEh5TvEer+zpf
         hIb1ng5LfBIlG8DwLoPWYqJ8UUrp1/lUcF+nthObv3y2qc9bN8uh2QFcly/vTg/bkcnI
         QvdFNl0VZx7E6paoU6qSvLxxIReQzUDe6I4O+AQZepQ16xl2KRtxY2BJw9VrGOc67Sf6
         wHtNOUqMR1H6M+vTMECgDMb68wRWMdSCVxIQXt4Xh+PFbifCB3FjX3V+N9aXKwqtSXbO
         qZshHsTxS0SFaa2J/mRtLMYE+iBNdlQ6w4133r8ITfc9m08+anSyvai7Wu5u2uGcvfDh
         anAA==
X-Gm-Message-State: AFq9FYKYalkOHtMEbZiAJfC95by0fsAo8cquR3eTqOxj0YdXTYOix4xP
	n+6pyRi6Yf1d0/GOy5bM/jcZMyquoxaKISg2goaXdipz2LKeK/yDbQ+xaJyBSOfp
X-Gm-Gg: AYBFou3/nUIabX9s9+5k2FxHshz47CGz8pgtFvZudco2em9COTVKUVdJGLJdS7z1rbs
	HelJ1maxAQGDQuNEAA1aLyM0SNRH85Ad2Y/hD0UWdcyn+n+yWwPlTyTbjyw/PV58dySVd6ZZVzt
	tPa7RK+t1MStDAXPUkdPMSC7OzVxqqYJlvDk91fw22QcIOwafFJlN/5Hp4gPzqjgRCmvJuuFFC1
	lsknyTi0KV8R+WQvmJpn3/oTRizvFkRc5SCrlFApHWAT0SLXqKTERZIrJLM4/tIdQcamJvV9mkl
	qc0SsijCj4pU89oBzNs9fqFSwVWVhmvqhTl1K21UokxhoPopF5wpTlzVPJIxJOyW+ZgqXeVinoB
	6mGqOys9NQ7gH6cnQR3twXjKluUq7dlsioICR/wnwhK8hLBQV5/gCj6FRZazvbAMFjhxgCuT301
	llGrswlZH0rHgTTQCdB194ZldbOxZzt2hFe2Qaya5hPBQ2MOXnAKNT21LO7QL9hfZ0xapu0akVM
	mUXOyoLQtP0gvvfYXTkvx1ROLtJ2BQ5uoHxZfx6C9r0iWVe1pdGVQXEkZJ9O4+S9rQudCvrkXB/
	n5ufpZg21amW7hX27PXsgORzOtV0PCYykgNp8vVV9W4o3Ba0mZfJNBJhDTUl9HJRCum/mU92wbb
	7v0MILldS082IWnEJh5QTTebVfb3hNPp3X4fnfLssnNYrJCEtcn8HKUao05XMSpE8SBxDfULjru
	noWA==
X-Received: by 2002:a05:600c:c056:b0:4a4:4d57:8462 with SMTP id 5b1f17b1804b1-4a44d578602mr107386095e9.24.1793071017590;
        Mon, 26 Oct 2026 20:16:57 -0700 (PDT)
Received: from mac.lan ([2001:818:c665:a700:9b4:dea8:96dd:9a68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm21777960f8f.32.2026.10.26.20.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:16:56 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 27 Oct 2026 03:16:52 +0000
Subject: [PATCH RFC 2/3] cat-file: make remote-object-info request in
 batches
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-remote-object-info-batch-v1-2-ea7a1f0b1df1@gmail.com>
References: <20261027-remote-object-info-batch-v1-0-ea7a1f0b1df1@gmail.com>
In-Reply-To: <20261027-remote-object-info-batch-v1-0-ea7a1f0b1df1@gmail.com>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

remote-object-info has a hard limit of a maximum of 10k OIDs per
command, this means that if someone wants to request the object-info
from +10k objects the user is the one who has to batch it.

Make it more comfortable by allowing a user to put all the OIDs in a
single remote-object-info command and then internally, let
parse_cmd_remote_object_info() handle the batching.

A default max batch size has been set to 50k OIDs. This number comes
from benchmarking with hyperfine against a local git daemon serving a
bare clone of git.git, requesting 100k and 400k OIDs taken from
`rev-list --objects --all` with "%(objectname) %(objectsize)". A 47ms
delay (roughly my connect time to github.com) was added to
client-to-server traffic on port 9418 with dummynet, giving an RTT of
about 47ms:

+------------+---------------------+
|            | objects requested   |
| batch size |   100k   |   400k   |
+------------+----------+----------+
| 10k        |  1.691s  |  5.862s  |
| 50k        |  0.981s  |  2.397s  |
| 100k       |  0.915s  |  2.058s  |
| 200k       |  0.924s  |  1.889s  |
| 400k       |  0.908s  |  1.820s  |
+------------+----------+----------+

To request all the batches over the same connection, it must stay open
between them. Currently, the connection to the remote is closed at two
places:
1. fetch_object_info_via_pack() at transport.c: finish_connect() is
   called after fetching the object-info data.
2. parse_cmd_remote_object_info() at cat-file.c: transport_disconnect()
   is called right after get_remote_info().

About 1, make fetch_object_info_via_pack() perform the handshake only
once and stop closing the connection, leaving that to
transport_disconnect() on its callers.

About 2, move transport_disconnect() after the batching loop, so it
only disconnects from the remote after all the batches have been
requested.

fetch_object_info() is void, so the only failure that
fetch_object_info_via_pack() could report came from finish_connect().
The exit status of the remote process is no longer checked. Any failure
while serving a batch is already caught by fetch_object_info(), either
through an ERR packet or an unexpected EOF, before any output for that
batch is written. This matches how ls-remote treats the connection
after ls-refs.

Make fetch_object_info_via_pack(), fetch_object_info_helper() and
transport_fetch_object_info() return void.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c   | 87 ++++++++++++++++++++++++++--------------------------
 transport-helper.c   | 13 ++++----
 transport-internal.h |  6 ++--
 transport.c          | 33 +++++++++-----------
 transport.h          |  6 ++--
 5 files changed, 69 insertions(+), 76 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f7d75a026b..4f78194bbd 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -39,12 +39,7 @@
  */
 #define MAX_REMOTE_URL_LEN (8 * 1024)
 
-/* Maximum number of objects allowed in a single remote-object-info request. */
-#define MAX_ALLOWED_OBJ_LIMIT 10000
-
-/* Maximum input size permitted for the remote-object-info command. */
-#define MAX_REMOTE_OBJ_INFO_LINE \
-	(MAX_REMOTE_URL_LEN + MAX_ALLOWED_OBJ_LIMIT * (GIT_MAX_HEXSZ + 1))
+#define DEFAULT_REMOTE_BATCH_SIZE 50000
 
 enum batch_mode {
 	BATCH_MODE_CONTENTS,
@@ -708,8 +703,7 @@ static void get_remote_info(struct transport *transport,
 		oid_array_append(object_info_oids, &oid);
 	}
 
-	if (transport_fetch_object_info(transport, object_info_oids, results))
-		die(_("failed to get object info from the remote"));
+	transport_fetch_object_info(transport, object_info_oids, results);
 }
 
 struct object_cb_data {
@@ -805,20 +799,15 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	char *line_to_split;
 	struct fetch_object_info_results results = FETCH_OBJECT_INFO_RESULTS_INIT;
 	struct oid_array object_info_oids = OID_ARRAY_INIT;
+	size_t batch_size = DEFAULT_REMOTE_BATCH_SIZE;
 	struct transport *transport;
 	struct remote *remote;
 
-	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
-		die(_("remote-object-info command too long"));
-
 	line_to_split = xstrdup(line);
 	count = split_cmdline(line_to_split, &argv);
 	if (count < 0)
 		die(_("remote-object-info: failed to parse command line: %s"),
 		    split_cmdline_strerror(count));
-	if (count - 1 > MAX_ALLOWED_OBJ_LIMIT)
-		die(_("remote-object-info supports at most %d objects"),
-		    MAX_ALLOWED_OBJ_LIMIT);
 
 	if (count < 2)
 		die(_("remote-object-info requires objects"));
@@ -836,48 +825,58 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 
 	if (!transport->smart_options)
 		die(_("smart options required"));
-	get_remote_info(transport, argv + 1, count - 1, &results, &object_info_oids);
 
-	string_list_clear(&data->remote_allowed_atoms, 0);
-	string_list_append(&data->remote_allowed_atoms, "objectname");
-	if (results.sizes)
-		string_list_append(&data->remote_allowed_atoms, "objectsize");
-	if (results.types)
-		string_list_append(&data->remote_allowed_atoms, "objecttype");
+	for (size_t j = 0; j < count - 1; j += batch_size) {
+		const char **objects = argv + 1 + j;
+		size_t remaining = count - 1 - j;
+		size_t objects_nr = batch_size < remaining ? batch_size : remaining;
 
-	transport_disconnect(transport);
+		get_remote_info(transport, objects, objects_nr, &results, &object_info_oids);
 
-	data->skip_object_info = 1;
-	for (size_t i = 0; i < results.nr; i++) {
-		data->oid = object_info_oids.oid[i];
+		string_list_clear(&data->remote_allowed_atoms, 0);
+		string_list_append(&data->remote_allowed_atoms, "objectname");
+		if (results.sizes)
+			string_list_append(&data->remote_allowed_atoms, "objectsize");
+		if (results.types)
+			string_list_append(&data->remote_allowed_atoms, "objecttype");
 
-		if (results.unrecognized[i]) {
-			report_object_status(opt, oid_to_hex(&data->oid),
-					     &data->oid, "missing");
-			continue;
-		}
+		data->skip_object_info = 1;
+		for (size_t i = 0; i < results.nr; i++) {
+			data->oid = object_info_oids.oid[i];
 
-		/*
-		 * When reaching here, it means remote-object-info can retrieve
-		 * information from server without downloading them.
-		 */
-		if (results.sizes)
-			data->size = results.sizes[i];
+			if (results.unrecognized[i]) {
+				report_object_status(opt, oid_to_hex(&data->oid),
+						     &data->oid, "missing");
+				continue;
+			}
 
-		if (results.types)
-			data->type = results.types[i];
+			/*
+			 * When reaching here, it means remote-object-info can retrieve
+			 * information from server without downloading them.
+			 */
+			if (results.sizes)
+				data->size = results.sizes[i];
 
-		opt->batch_mode = BATCH_MODE_INFO;
-		data->is_remote = 1;
-		batch_object_write(argv[i + 1], output, opt, data, NULL, 0);
-		data->is_remote = 0;
+			if (results.types)
+				data->type = results.types[i];
+
+			opt->batch_mode = BATCH_MODE_INFO;
+			data->is_remote = 1;
+			batch_object_write(objects[i], output, opt, data, NULL, 0);
+			data->is_remote = 0;
+		}
+		data->skip_object_info = 0;
+		FREE_AND_NULL(results.sizes);
+		FREE_AND_NULL(results.types);
+		FREE_AND_NULL(results.unrecognized);
+		results.nr = 0;
+		oid_array_clear(&object_info_oids);
 	}
-	data->skip_object_info = 0;
 
+	transport_disconnect(transport);
 	free_fetch_object_info_results(&results);
 	free(line_to_split);
 	free(argv);
-	oid_array_clear(&object_info_oids);
 }
 
 static void dispatch_calls(struct batch_options *opt,
diff --git a/transport-helper.c b/transport-helper.c
index d5a064d386..dafe829b50 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -786,16 +786,15 @@ static int fetch_refs(struct transport *transport,
 	return -1;
 }
 
-static int fetch_object_info_helper(struct transport *transport,
-				    const struct oid_array *oids,
-				    struct fetch_object_info_results *results)
+static void fetch_object_info_helper(struct transport *transport,
+				     const struct oid_array *oids,
+				     struct fetch_object_info_results *results)
 {
 	get_helper(transport);
 	if (process_connect(transport, 0))
-		return transport->vtable->fetch_object_info(transport, oids,
-							    results);
-
-	die(_("object-info requires protocol v2"));
+		transport->vtable->fetch_object_info(transport, oids, results);
+	else
+		die(_("object-info requires protocol v2"));
 }
 
 struct push_update_ref_state {
diff --git a/transport-internal.h b/transport-internal.h
index a10b27cc81..53ce86ed48 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -53,9 +53,9 @@ struct transport_vtable {
 	 *
 	 * Uses object-info capability of v2 protocol.
 	 */
-	int (*fetch_object_info)(struct transport *transport,
-				 const struct oid_array *oids,
-				 struct fetch_object_info_results *results);
+	void (*fetch_object_info)(struct transport *transport,
+				  const struct oid_array *oids,
+				  struct fetch_object_info_results *results);
 
 	/**
 	 * Push the objects and refs. Send the necessary objects, and
diff --git a/transport.c b/transport.c
index 25e2c14a7b..352540492c 100644
--- a/transport.c
+++ b/transport.c
@@ -433,11 +433,10 @@ static int get_bundle_uri(struct transport *transport)
 				     transport->bundles, stateless_rpc);
 }
 
-static int fetch_object_info_via_pack(struct transport *transport,
-				      const struct oid_array *oids,
-				      struct fetch_object_info_results *results)
+static void fetch_object_info_via_pack(struct transport *transport,
+				       const struct oid_array *oids,
+				       struct fetch_object_info_results *results)
 {
-	int ret = 0;
 	struct git_transport_data *data = transport->data;
 	struct packet_reader reader;
 
@@ -447,8 +446,13 @@ static int fetch_object_info_via_pack(struct transport *transport,
 			   PACKET_READ_GENTLE_ON_EOF |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
 
-	data->version = discover_version(&reader);
-	transport->hash_algo = reader.hash_algo;
+	if (!data->finished_handshake) {
+		data->version = discover_version(&reader);
+		transport->hash_algo = reader.hash_algo;
+		data->finished_handshake = 1;
+	} else {
+		reader.hash_algo = transport->hash_algo;
+	}
 
 	fetch_object_info(data->version,
 			  transport->server_options,
@@ -456,24 +460,15 @@ static int fetch_object_info_via_pack(struct transport *transport,
 			  &reader,
 			  results,
 			  transport->stateless_rpc, data->fd[1]);
-
-	close(data->fd[0]);
-	if (data->fd[1] >= 0)
-		close(data->fd[1]);
-	if (finish_connect(data->conn))
-		ret = -1;
-	data->conn = NULL;
-
-	return ret;
 }
 
-int transport_fetch_object_info(struct transport *transport,
-				const struct oid_array *oids,
-				struct fetch_object_info_results *results)
+void transport_fetch_object_info(struct transport *transport,
+				 const struct oid_array *oids,
+				 struct fetch_object_info_results *results)
 {
 	if (!transport->vtable->fetch_object_info)
 		die(_("remote does not support object-info"));
-	return transport->vtable->fetch_object_info(transport, oids, results);
+	transport->vtable->fetch_object_info(transport, oids, results);
 }
 
 static int fetch_refs_via_pack(struct transport *transport,
diff --git a/transport.h b/transport.h
index 39193d0077..c7f2b8b87f 100644
--- a/transport.h
+++ b/transport.h
@@ -314,9 +314,9 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs);
 /*
  * Fetch the object info from remote
  */
-int transport_fetch_object_info(struct transport *transport,
-				const struct oid_array *oids,
-				struct fetch_object_info_results *results);
+void transport_fetch_object_info(struct transport *transport,
+				 const struct oid_array *oids,
+				 struct fetch_object_info_results *results);
 
 /*
  * If this flag is set, unlocking will avoid to call non-async-signal-safe

-- 
2.56.0


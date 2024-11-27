Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26468836
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732669211; cv=none; b=N9UOsPVW2nM0Fl8RSoXC7oxK1Rc+soKtBybVQFuu3DTDaqAvxKpKXSC0F9Lns+BllzFglH82AxYOhUCtok1W9r1QejGbyMFIGgReW0l1+HNMsLfm5vrpWvPj4rEZejtX1Sf1EyVjES+m8HpaqWf/D0bZ8wevftUJ02HK3bQRJ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732669211; c=relaxed/simple;
	bh=xObzQfDoyEgRWr3dZn5y546B7zCUxVrFD81ljBrdn3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQQaUPT/BQy/6nu2Vpzxt123doaDe7DY17DBrSqJQCAwUk2DxyNMPwYilzGOV07cLJ2n/tTBV6brDehYG0giG4d8Ss4dW3ZEv5vsU/b18OQXHgKaHePK4MD35237EinWZVae6bf3sH9nPmOWyjcQihkQRpgLY7Ln6FC5LRyeyWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbIy/amE; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbIy/amE"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-29666708da7so3858188fac.0
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 17:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732669208; x=1733274008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHBTyPgDhTM/DitUp2D8gUcrwIPjvxWOgjSWHvi/NMo=;
        b=ZbIy/amEJ5qQOh3YsDsXA3mcZFE/7OvweeVCooCxaSNvLj43iPRu+JLkCUdUtnTzvM
         rK2L7k50QuNnNdsvzR3PVXbASVL+mY1iUAZrC2lC4uTHRk8QBl32UjPuPxXtdyut1YEO
         hosp/s7HntOo9Txrngvr8NzWgR7tE8QBuETOEzDA16go7uJC7rnwuqObbXKmeKdStg9V
         oBEeaBsQx34gTMCXZoDZlnDvMi+7Elev1752L7nr2hq9dIX+EQ8V4RQk0ywiJAQrKGTR
         z2eDSNoJMiIzttOe6eBZMCL3A9mjmPFNaOWmWxvWFeoP+EFtuXKAh/bDFDyCKd4Ja+U2
         CGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732669208; x=1733274008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHBTyPgDhTM/DitUp2D8gUcrwIPjvxWOgjSWHvi/NMo=;
        b=sOWfh1ch1cLePGNzIHhG8GovIlcH0Op3Qf+pn2sRu+mevkSvLtkUjYrYVM9uHy7bpy
         ReiaBn7a5dJCWxXdxQHtZaALTwF4lwDKIRscxDIOd4UH06/HKOjvb8oU/IRR0DMu/OnC
         +8GC4QjVTUuwyGgrauzeuwra3LbGby0nqXwAcffCTSOrFE/UQeVPvb28ZYAhrvTHNRfl
         lMh0MiAHMajx44tie/o/pe69SEtoL2Uvh8Br6QpsigJJY7nRsTGj/FG+5trJizDv03XN
         AvRO2CSD2ehn/1z4u7RZ/tICZkjlBLrwtKAhXukSARA92Pa03b8xmSzayWloPuQ0GZiI
         hHFA==
X-Gm-Message-State: AOJu0YxCTatGisdln8f4Q4gzKQ540omns2THxyQu+YvSr5YXlUpzVqY1
	SuX/2rrW0+fA44ySD7/Qi7hXEErCv38QWtc7yGVscvBx8zEd0BRRO08SoQ==
X-Gm-Gg: ASbGncseTeKIMUc3CCSaFJXQps1NBysaFB+sEY5R9PmFeoayYI6KEzWaUeiyNQHnxA1
	KpndHlqttI/u852PU847SdYQo1AIB0edz4lN7YrnwuJnXxlLqShhDLABscpK8AkpydMhKzbpnh6
	mypxcOvEdIuo4MiIJQGMj2Lp8hmpCmgdoz1OVBBmBlwd9GWM6zy3pAnSlIty3UbIOjlEBmcGyZ9
	HbgK9+Px8kjLw29XoPV949+PjlFyqcuy5+38Q9zTXNJurzgmrLt9i9ewA==
X-Google-Smtp-Source: AGHT+IENr3LRY3NEyt9703Z1h5tuE3Es9IfhCzwjVrZb4rWlrDVHmdBzXKbtMtckLvaRnFhT7WVYxQ==
X-Received: by 2002:a05:6870:eca4:b0:278:4f7:6058 with SMTP id 586e51a60fabf-29dc4303757mr565407fac.28.1732669208309;
        Tue, 26 Nov 2024 17:00:08 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71c0378d26esm3316643a34.31.2024.11.26.17.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 17:00:07 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 4/4] transport: propagate fsck configuration during bundle fetch
Date: Tue, 26 Nov 2024 18:57:07 -0600
Message-ID: <20241127005707.319881-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127005707.319881-1-jltobler@gmail.com>
References: <20241121204119.1440773-1-jltobler@gmail.com>
 <20241127005707.319881-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fetching directly from a bundle, fsck message severity
configuration is not propagated to the underlying git-index-pack(1). It
is only capable of enabling or disabling fsck checks entirely. This does
not align with the fsck behavior for fetches through git-fetch-pack(1).

Use the fsck config parsing from fetch-pack to populate fsck message
severity configuration and wire it through to `unbundle()` to enable the
same fsck verification as done through fetch-pack.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 t/t5607-clone-bundle.sh |  7 +++++++
 transport.c             | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 7ceaa8194d..c69aa88eae 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -171,6 +171,13 @@ test_expect_success 'clone bundle with different fsckObjects configurations' '
 
 	test_must_fail git -c transfer.fsckObjects=true \
 		clone bundle-fsck/bad.bundle bundle-transfer-fsck 2>err &&
+	test_grep "missingEmail" err &&
+
+	git -c fetch.fsckObjects=true -c fetch.fsck.missingEmail=ignore \
+		clone bundle-fsck/bad.bundle bundle-fsck-ignore &&
+
+	test_must_fail git -c fetch.fsckObjects=true -c fetch.fsck.missingEmail=error \
+		clone bundle-fsck/bad.bundle bundle-fsck-error 2>err &&
 	test_grep "missingEmail" err
 '
 
diff --git a/transport.c b/transport.c
index 8536b14181..0209cac5e2 100644
--- a/transport.c
+++ b/transport.c
@@ -19,6 +19,7 @@
 #include "branch.h"
 #include "url.h"
 #include "submodule.h"
+#include "strbuf.h"
 #include "string-list.h"
 #include "oid-array.h"
 #include "sigchain.h"
@@ -172,6 +173,19 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 	return result;
 }
 
+static int fetch_fsck_config_cb(const char *var, const char *value,
+				const struct config_context *ctx UNUSED, void *cb)
+{
+	struct strbuf *msg_types = cb;
+	int ret;
+
+	ret = fetch_pack_fsck_config(var, value, msg_types);
+	if (ret < 0)
+		return 0;
+
+	return ret;
+}
+
 static int fetch_refs_from_bundle(struct transport *transport,
 				  int nr_heads UNUSED,
 				  struct ref **to_fetch UNUSED)
@@ -181,6 +195,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	};
 	struct bundle_transport_data *data = transport->data;
 	struct strvec extra_index_pack_args = STRVEC_INIT;
+	struct strbuf msg_types = STRBUF_INIT;
 	int ret;
 
 	if (transport->progress)
@@ -188,11 +203,16 @@ static int fetch_refs_from_bundle(struct transport *transport,
 
 	if (!data->get_refs_from_bundle_called)
 		get_refs_from_bundle_inner(transport);
+
+	git_config(fetch_fsck_config_cb, &msg_types);
+	opts.fsck_msg_types = msg_types.buf;
+
 	ret = unbundle(the_repository, &data->header, data->fd,
 		       &extra_index_pack_args, &opts);
 	transport->hash_algo = data->header.hash_algo;
 
 	strvec_clear(&extra_index_pack_args);
+	strbuf_release(&msg_types);
 	return ret;
 }
 
-- 
2.47.0


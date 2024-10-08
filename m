Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4151A3EA6C
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 03:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358707; cv=none; b=FNBh3/5id9LKi1yX9viqStqrM6LhNM0b8SHEqgFPlXPVB9GIAcuC21y/Jun9Ngvc6MOx4+eI2pbEPpwFVjo65QachVVsxrQWPZnJk3gCkPFV/NQ1wVVGlehZl38f0Q7PVERHrf47eVqGJldKRIMUtmtR1rz24j/Ghh23EKsAUM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358707; c=relaxed/simple;
	bh=cGiORR69hHGT0c1b9tZjs8kDQ77GyoGfcdlq+8p6g1k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A1ldQFXvnK8fGv5hOhmCxU6otG2BPtDvtc6DU2ocooV4EdRN04RrcnYd+0oX+ICr5Px25dh/pzq4b/nTOWEErMlBiM2vm9y7u0PDJ+Is6n5wlX2RlH2t9DnPjOxLNh/AQQ35pkZrVgEeFbL+WB26tZFBSeQ+4RDSq31AjpiKm2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNW2NFrR; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNW2NFrR"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a993302fa02so334931266b.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 20:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728358703; x=1728963503; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMac6SI0Imrgv4YKKCPn0nb4NksKecWrQs4fnkC0zNI=;
        b=JNW2NFrRNZdtnqeXYYZWrQBZJEu8gl0xLeeXLvcVWhPfD4CxmG79U8hx5PdsiZNcCK
         B0Re7hYOvmoAqMCfVeT6DCsmUnHXmtTL6MO46+adGeJEQVUp8aU5bo6E1J/3YcgC4BnB
         LClJVdtlcY7TBWtj6/rEKtShoMlhyRmrIzALb2YEw66Cf35RizE6ZgQUu82m8rR/dbLq
         1VGXYs/JhVhCqOWuF6jPBn5XrLgcH0f2idCHSJQX/440LIC2VTfv9k6iVAci1t04CIOA
         PbQj7ruLV18u4aHMRQ48CyhYNPZCWg9fYOXQsjeGXMlJfGRsCVxhV07Nm6K9zh2fcY/m
         DgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728358703; x=1728963503;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMac6SI0Imrgv4YKKCPn0nb4NksKecWrQs4fnkC0zNI=;
        b=B4bb2u3Wng+VtJmEM7hvh+04H41If6eOqPQ/tdscOzTm0mPN+pCyZSGEmF2ZMPNW4F
         2bIG31GNKb44G9BV+pN9LdIeOettSUpcWL4+95CtKx/mIK7Jb5dZ+la86AksgAxU1pRA
         Kk6d0i9Xt5T57RHe1azHZ61FnnKM0A71CI47NLzKWepEWb+TWvhUgeeA/VkYA6+yTMFD
         LfSpRRd6CXA952kG7deV1Dcbg6/Wj0Icx5sT3b1W5dYJzzlvz+2NVXkcwa8s/KnQXqfR
         fHvNRhFRgcQtTnS5viSkqmF6jkDfl+uOBeHk6pltiME0lTzGDl3WZOXl6ZGdVPXqLJuB
         thNw==
X-Gm-Message-State: AOJu0Yx40SCY6zbbkxRxVoUw9xCIPkA2DiypGKlDSQaMwkzvswvCgNuN
	Skp7Rgp8smCU8/4X/SSRaRvsAnpOsoiWNlcDW0yT7D+nNEa48841adDXkA==
X-Google-Smtp-Source: AGHT+IF8cHtSTshuYEJrO2n9ErxUzGsOzvfFsIWLDVHSzNPI69LYAnj9lsJo88SLoWAkoUdN4MWbpQ==
X-Received: by 2002:a17:907:3daa:b0:a99:4654:caeb with SMTP id a640c23a62f3a-a994654ede6mr847248766b.35.1728358702718;
        Mon, 07 Oct 2024 20:38:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9963760779sm86712266b.204.2024.10.07.20.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 20:38:22 -0700 (PDT)
Message-Id: <3c6b129d3689f1920c4f06220c74820822537076.1728358699.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.v3.git.git.1728358699.gitgitgadget@gmail.com>
References: <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
	<pull.1776.v3.git.git.1728358699.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 03:38:16 +0000
Subject: [PATCH v3 2/5] remote: introduce remote.<name>.serverOption
 configuration
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
Cc: Brandon Williams <bmwill@google.com>,
    Jonathan Tan <jonathantanmy@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Liu Zhongbo <liuzhongbo.6666@bytedance.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

Currently, server options for Git protocol v2 can only be specified via
the command line option "--server-option" or "-o", which is inconvenient
when users want to specify a list of default options to send. Therefore,
we are introducing a new configuration to hold a list of default server
options, akin to the `push.pushOption` configuration for push options.

Initially, I named the new configuration `fetch.serverOption` to align
with `push.pushOption`. However, after discussing with Patrick, it was
renamed to `remote.<name>.serverOption` as suggested, because:

1. Server options are designed to be server-specific, making it more
   logical to use a per-remote configuration.
2. Using "fetch." prefixed configurations in git-clone or git-ls-remote
   seems out of place and inconsistent in design.

The parsing logic for `remote.<name>.serverOption` also relies on
`transport.c:parse_transport_option`, similar to `push.pushOption`, and
they follow the same priority design:

1. Server options set in lower-priority configuration files (e.g.,
   /etc/gitconfig or $HOME/.gitconfig) can be overridden or unset in
   more specific repository configurations using an empty string.
2. Command-line specified server options take precedence over those from
   the configuration.

Server options from configuration are stored to the corresponding
`remote.h:remote` as a new field `server_options`.  The field will be
utilized in the subsequent commit to help initialize the
`server_options` of `transport.h:transport`.

And documentation have been updated accordingly.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Junio C Hamano <gitster@pobox.com>
Reported-by: Liu Zhongbo <liuzhongbo.6666@bytedance.com>
Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 Documentation/config/remote.txt | 10 ++++++++++
 remote.c                        |  6 ++++++
 remote.h                        |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index 36e771556c6..b194dff07b9 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -96,3 +96,13 @@ remote.<name>.partialclonefilter::
 	Changing or clearing this value will only affect fetches for new commits.
 	To fetch associated objects for commits already present in the local object
 	database, use the `--refetch` option of linkgit:git-fetch[1].
+
+remote.<name>.serverOption::
+	The default set of server options used when fetching from this remote.
+	These server options can be overridden by the `--server-option=` command
+	line arguments.
++
+This is a multi-valued variable, and an empty value can be used in a higher
+priority configuration file (e.g. `.git/config` in a repository) to clear
+the values inherited from a lower priority configuration files (e.g.
+`$HOME/.gitconfig`).
diff --git a/remote.c b/remote.c
index 390a03c2643..fa65549aa44 100644
--- a/remote.c
+++ b/remote.c
@@ -24,6 +24,7 @@
 #include "advice.h"
 #include "connect.h"
 #include "parse-options.h"
+#include "transport.h"
 
 enum map_direction { FROM_SRC, FROM_DST };
 
@@ -143,6 +144,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	ret->name = xstrndup(name, len);
 	refspec_init(&ret->push, REFSPEC_PUSH);
 	refspec_init(&ret->fetch, REFSPEC_FETCH);
+	string_list_init_dup(&ret->server_options);
 
 	ALLOC_GROW(remote_state->remotes, remote_state->remotes_nr + 1,
 		   remote_state->remotes_alloc);
@@ -166,6 +168,7 @@ static void remote_clear(struct remote *remote)
 	free((char *)remote->uploadpack);
 	FREE_AND_NULL(remote->http_proxy);
 	FREE_AND_NULL(remote->http_proxy_authmethod);
+	string_list_clear(&remote->server_options, 0);
 }
 
 static void add_merge(struct branch *branch, const char *name)
@@ -508,6 +511,9 @@ static int handle_config(const char *key, const char *value,
 	} else if (!strcmp(subkey, "vcs")) {
 		FREE_AND_NULL(remote->foreign_vcs);
 		return git_config_string(&remote->foreign_vcs, key, value);
+	} else if (!strcmp(subkey, "serveroption")) {
+		return parse_transport_option(key, value,
+					      &remote->server_options);
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index a58713f20ad..e95d30946c0 100644
--- a/remote.h
+++ b/remote.h
@@ -4,6 +4,7 @@
 #include "hash.h"
 #include "hashmap.h"
 #include "refspec.h"
+#include "string-list.h"
 #include "strvec.h"
 
 struct option;
@@ -104,6 +105,8 @@ struct remote {
 
 	/* The method used for authenticating against `http_proxy`. */
 	char *http_proxy_authmethod;
+
+	struct string_list server_options;
 };
 
 /**
-- 
gitgitgadget


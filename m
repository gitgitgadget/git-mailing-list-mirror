Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90974D2EF3
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349439; cv=none; b=in44j08PJ3ZUk9FKKgeYDXUMf0xjdrWumpOsGaMumSw1yr1aDybkK7VSo9g/7+k1vA3rN43JZDNPS937Toi0WEXP7IOdZzMPDj+Mqog4GhDQFpyfg4VCWrNlChaQxM06vpVVHWFtXH5YzNSce2FJ62RpPBYSdu8eRwpTEPyCpkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349439; c=relaxed/simple;
	bh=T2dXglvsReHiKOXHLpGFdoDyaXRAkvBdCqHvJnClxUQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rKLt6/ZwLYBLdzgIAMjm/6gjC3WMaq19XOMWzSbbHjo5XqoEeemgSSsl9jKb4xxBaqcVZME7EiD5UeDNHQu6HqgAvpplVxQwcvRBCkYv9hoGKWv1lWUsOC7cqmEeydkotxQstJ1PzhxD9G2ZZH0TqA2G5zJqRzLUJfI2VDrWjmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39c9bb9d2fbso12008431fa.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 11:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785349428; x=1785954228;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IFo7Xw9p3Fg92nKzmk5vtbUQbA/8u/JvYM4T//lJBmc=;
        b=alUfTbaU/RXgnEyGdlU86nL7uxQXu7WoIgWtuAzjVfd/IeqdMFKQhiJDrUlIuU2IFT
         +jI/TUHp/s/SFLUu+VftBh+EhyFLMJg5AOJiEx5CWah7UTzyyErbEzeTVpwbGu8N9ccD
         +dgURmyYdfDCk/sLz1fCqM9tWczTm9qalIlFZAOEvlI1adM79p3cF78rmK6h9yo7cjSo
         zOUCb3Z8XmfHiBUrT2Fe4ShGBNrNg65IqN7vN7liirtv3QjbQfgWvCFrJYoYIBCBfYK3
         ekRBBUS3CKtma47evrPg9f9yZiIX4tnGEWLvh8J/aZz0SlZ0GYgoCRMJ9NAR12+hUuoi
         DRcw==
X-Gm-Message-State: AOJu0YxaPuAF+SiwQ1uT4BCOCN9xtNNKMOUJXFASVRtzKyf3Es2mEuYK
	LvTx7qLQcT7OU83E5KBqsqWHzGOZAV7mPZnKgshPbaUogWPMaIfBn9AKc0B22w==
X-Gm-Gg: AR+sD11/i27ZY1oIqOl/67TnAD2h13+sVL55eDAjf+J30B+6Fgb6awuISpcL892kt3H
	xX1mTqXqW1Glid0OIRaQQ0309ystjXhFOUVUmIZ2KDqfBsEUCRQdYw87xJJSlXTdFoo5M/3+k47
	ldBwJ822S1rC/jLPFysXQXqkQw3V8vUn3lpkK31GSXT3gsG9fEztSGrHMC+erYLLbfngtXm3M1M
	YH63rWCDKjj+yEaSPz6Fmd24QblhTwOYx6m2CAk1NdM5mk031FIXbo6vP4bFimYdIM5cu0viWnr
	bkuRDrId67JNrPc2it/vl2wgqgMPov5/z+K87xZgHVoA4/OIgaPRrfFkHC3NSZxsayL/JdFHAHd
	t58FcERDNrSNCXjsHkOpJj9jFOh7AmIE/zY0C/aDGILEflooxK3x1yJqx9ntCcU8obAZpWVrHLc
	lRu0rWbQ6w8YOYrhsjtYvFij0lYKhXiqklSVoDmzMWlq3oUD4Jq14hIdP3p2prjEzTfkU5tKtfq
	8skiGL4YZvBWx/Q/Mit1OFcmj+lixVkjopE3iagacDP+8R/Y8wH8bilvQHDbH4fuMD33naNkHhV
	iHywQojOVTrTPbpHyb4Eb2AJ0+QYQpyei2Vb/Uwmv2NYypmEO9GjY+8hAe3M2f8=
X-Received: by 2002:a05:6512:3d92:b0:5b2:aa5d:9d34 with SMTP id 2adb3069b0e04-5b2d02549demr1803763e87.32.1785349427577;
        Wed, 29 Jul 2026 11:23:47 -0700 (PDT)
Received: from t570.localdomain (84-231-41-81.elisa-mobile.fi. [84.231.41.81])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2d78ea9efsm538226e87.44.2026.07.29.11.23.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 11:23:45 -0700 (PDT)
From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To: git@vger.kernel.org
Subject: [PATCH] Documentation: a/an grammar fixes
Date: Wed, 29 Jul 2026 21:23:23 +0300
Message-ID: <20260729182323.1095474-1-ville.skytta@iki.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This takes the stance that `*` is an asterisk rather than a star.

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 Documentation/blame-options.adoc       | 2 +-
 Documentation/config/blame.adoc        | 2 +-
 Documentation/config/http.adoc         | 2 +-
 Documentation/config/promisor.adoc     | 2 +-
 Documentation/git-merge.adoc           | 2 +-
 Documentation/git-sparse-checkout.adoc | 2 +-
 Documentation/gitprotocol-v2.adoc      | 2 +-
 Documentation/pull-fetch-param.adoc    | 2 +-
 Documentation/rev-list-options.adoc    | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/blame-options.adoc b/Documentation/blame-options.adoc
index 1ae1222b6b..977d5f871f 100644
--- a/Documentation/blame-options.adoc
+++ b/Documentation/blame-options.adoc
@@ -126,7 +126,7 @@ take effect.
 	another commit will be marked with a `?` in the blame output.  If the
 	`blame.markUnblamableLines` config option is set, then those lines touched
 	by an ignored commit that we could not attribute to another revision are
-	marked with a `*`. In the porcelain modes, we print `ignored` and
+	marked with an `*`. In the porcelain modes, we print `ignored` and
 	`unblamable` on a newline respectively.
 
 `--ignore-revs-file <file>`::
diff --git a/Documentation/config/blame.adoc b/Documentation/config/blame.adoc
index 4d047c1790..5ac120d9da 100644
--- a/Documentation/config/blame.adoc
+++ b/Documentation/config/blame.adoc
@@ -29,7 +29,7 @@ blame.ignoreRevsFile::
 
 blame.markUnblamableLines::
 	Mark lines that were changed by an ignored revision that we could not
-	attribute to another commit with a '*' in the output of
+	attribute to another commit with an '*' in the output of
 	linkgit:git-blame[1].
 
 blame.markIgnoredLines::
diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 792a71b413..369ac2cd88 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -388,7 +388,7 @@ http.<url>.*::
 
 . Host/domain name (e.g., `example.com` in `https://example.com/`).
   This field must match between the config key and the URL. It is
-  possible to specify a `*` as part of the host name to match all subdomains
+  possible to specify an `*` as part of the host name to match all subdomains
   at this level. `https://*.example.com/` for example would match
   `https://foo.example.com/`, but not `https://foo.bar.example.com/`.
 
diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index c1f3d766a6..e80435f632 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -126,7 +126,7 @@ guidelines:
    the latter matches `https://cdn.your-org.com.hacker.net/repo`.
 +
 4. Be careful using globs at the beginning of domain names. While the
-   code ensures a `*` in the host cannot cross into the path, a
+   code ensures an `*` in the host cannot cross into the path, a
    pattern like `https://*.example.com/*` will still match any
    subdomain. This is extremely dangerous on shared hosting platforms
    (e.g., `https://*.github.io/*` trusts every user's site on the
diff --git a/Documentation/git-merge.adoc b/Documentation/git-merge.adoc
index a055384ad6..899330ff9f 100644
--- a/Documentation/git-merge.adoc
+++ b/Documentation/git-merge.adoc
@@ -329,7 +329,7 @@ After seeing a conflict, you can do two things:
    the working tree.  Edit the files into shape and
    `git add` them to the index.  Use `git commit` or
    `git merge --continue` to seal the deal. The latter command
-   checks whether there is a (interrupted) merge in progress
+   checks whether there is an (interrupted) merge in progress
    before calling `git commit`.
 
 You can work through the conflict with a number of tools:
diff --git a/Documentation/git-sparse-checkout.adoc b/Documentation/git-sparse-checkout.adoc
index e286584c67..d30168721a 100644
--- a/Documentation/git-sparse-checkout.adoc
+++ b/Documentation/git-sparse-checkout.adoc
@@ -331,7 +331,7 @@ wasn't transliterated.
 Second, what should bash-completion complete on for set/add commands
 for non-cone users?  If it suggests paths, is it exacerbating the
 problem above?  Also, if it suggests paths, what if the user has a
-file or directory that begins with either a '!' or '#' or has a '*',
+file or directory that begins with either a '!' or '#' or has an '*',
 '\', '?', '[', or ']' in its name?  And if it suggests paths, will
 it complete "/pro" to "/proc" (in the root filesystem) rather than to
 "/progress.txt" in the current directory?  (Note that users are
diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index 2beb70595f..16d60597f9 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -772,7 +772,7 @@ be implemented in the future include:
  * Advertise that one or more bundle files are the same (to e.g. have
    clients round-robin or otherwise choose one of N possible files).
 
- * A "oid=<OID>" shortcut and "prerequisite=<OID>" shortcut. For
+ * An "oid=<OID>" shortcut and "prerequisite=<OID>" shortcut. For
    expressing the common case of a bundle with one tip and no
    prerequisites, or one tip and one prerequisite.
 +
diff --git a/Documentation/pull-fetch-param.adoc b/Documentation/pull-fetch-param.adoc
index d903dc8900..401e6edcad 100644
--- a/Documentation/pull-fetch-param.adoc
+++ b/Documentation/pull-fetch-param.adoc
@@ -32,7 +32,7 @@ typically a ref, or a glob pattern with a single `*` that is used
 to match a set of refs, but it can also be a fully spelled hex object
 name.
 +
-A _<refspec>_ may contain a `*` in its _<src>_ to indicate a simple pattern
+A _<refspec>_ may contain an `*` in its _<src>_ to indicate a simple pattern
 match. Such a refspec functions like a glob that matches any ref with the
 pattern. A pattern _<refspec>_ must have one and only one `*` in both the _<src>_ and
 _<dst>_. It will map refs to the destination by replacing the `*` with the
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index fd831f0ec6..c856576f5b 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1139,7 +1139,7 @@ e.g. ``2 hours ago''. The `-local` option has no effect for
 
 `--date=local` is an alias for `--date=default-local`.
 
-`--date=iso` (or `--date=iso8601`) shows timestamps in a ISO 8601-like format.
+`--date=iso` (or `--date=iso8601`) shows timestamps in an ISO 8601-like format.
 The differences to the strict ISO 8601 format are:
 
 	- a space instead of the `T` date/time delimiter
-- 
2.53.0


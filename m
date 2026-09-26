Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B68346E51
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790423800; cv=none; b=fX5GNhUBXFzxdIgZC3xWFRVkhwlGXvoGD+/pQhZ6ROri3Iq/IrLmU6PDFVm1mb1JF2SKc96Enb40vPIhL8lICf7pbVQpFefEtdNCuyb/Hcuiim7UUxQEkq9Vk5iUcb4Ktmc05uiMMz4W7epw3OdLBIJ9oDWykTxvbdkNSjE5GJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790423800; c=relaxed/simple;
	bh=+RcY2eEcN/J2UbOsUBSF17951aXPOiig37m+LFqqJW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=bS35QG2bNuwhtv9GDQbBYbDeRYg10UXb5/1wk//vX9yHJWwcBgG55/f6OsfbKboszIWGgqVO60ax3tz6n8N/OQNlswybjnr27k3HCHIvf/DMMh4EOMrZ/HTCYnaNbu9QNIWYVd2hc+zW2VUumTOpbAQ+php5v2MALMV0/EHuMA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1WmsJ+U; arc=none smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1WmsJ+U"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-9143a7c85c5so17015726d6.1
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 04:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790423797; x=1791028597; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iv4uXx5H2yt4TsUrCIkJqgd+RaHB09fyMHXUiTXBOPA=;
        b=B1WmsJ+Use2jZbuOoCWAdUT7z04YQzrq/Ma82GUOdVQx2UnWVd45WUKCDbOSJ/KCzT
         9yaXd5AMhj2ThQIbyYwO/W2FUgLKZBAkZfezI7RgehoDpKXxUNtbYZgpukl9/6jjc1nQ
         2fXxZzotlQaQn5qFaRrbJ85Hj480y6HauVhqpJAZCyz8UrdPrixupxhbqd4wta0tw3mx
         msFB1FHuCiAaXuJ1XUVa0G8f71R5dbHNKrtHCEbvNyUqRqD0e01bg7V+uMiVi7+lLDtP
         vJvg04/aMTerK17l6PMJCnqf1IvHBWZG3RQGYUKqfmg6TdqsgWcW/4MX7N7JrklZ5Ti1
         P7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790423797; x=1791028597;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iv4uXx5H2yt4TsUrCIkJqgd+RaHB09fyMHXUiTXBOPA=;
        b=NwdHEUShXL+M1A3YSkZYhkvkNaW++XxXEGOABy6e9JhsQHbNSqXPrbA2zqyC2Lx+Gp
         /bwi3F/gtGgR+mbCEN7LOOxvccFtsuJIGL/auso4fKO1ICij1IMMFu3zrjHLz6WxNRVp
         DO7naOLeqqnV0hYj6Etd3MDfsmyNdvvMpVb778swg/w4Bh8LxTqwB4qiVy5/qGZGwe7X
         ykOf7FjSrO1GHD7lP194ndN+uURjS+N9vgT3pnJoMQCKDwACD+qKaRvz9rUvD/CcsW8I
         CDAWMnrLqUTLavjA9EiURk8J23aB1+O9CMs1IVhIZSZCS9AxHmu+ADaIHQjVrq0D14qH
         +SYw==
X-Gm-Message-State: AFq9FYJrxDfwaS+0byEy0b24Re5frij4wVSM9wZNrU/3OEH4h2AxtiwR
	v6+TzVtoHhKzO5R9FBE2Ju6XIhFEEuE3WZ8te6vmD8nlGxQaf5p//TrEmarGbSJC
X-Gm-Gg: AYBFou2yXq/qGpOrbltAgLBUxRz6EgoQNRpeg7nJNLSaUdt8x42DlBDaRqHSEDwyUeZ
	8d5IVhWeJpSd7GZdmKOuX6ijulNmxU3yi9S9o07Z8Xps2LhvKWxAEKh6luB5U9HAWfRlnIVLthV
	bK1VNqJZXYcjbBLA4w297rFSq1E/y4RiP/MzUQvSBfmu7KQzblyX82PkI+qMKncxZfZaOWMmasI
	D7NlBpKUvOoMcuzlSVYmCex85+tXtDMJnPSmr1Ol5CazO0CwuulUdAUiCyCzxzsMDmLNprrQ5xk
	r63/DrpLdzVCbuGl8oLbfxuY2pYCWCR76K3/KBfTvPxEZrbEObLR8f+q29DKawSns+uPUocow/h
	5+0zTNJz1PJMb/TpZgovJqPbv2F+xKvqWXW8+vM1heGdejFSlojBhFjVEYeQxzE6FMDQkl9tZaI
	l3k+lp/hElxEsbPFteNguXT6fqqjCScJCv/3MS2Wqy/xhDSrAi1gUHQUlSpYN/wr9mhKiu0WwFg
	S54vxW2LkG2Ol4rMmXGHUsa74t0XxmKBw6USi4oljKLnbZ+AbmwaAyM1hI22KezpeeaucvWeeNP
	lQvOp9bfkgILmbctXYggYJd69mBmazjSrxQfJTauxOOfyu+a0M9Y/RHKzN4qL+cvrQoCZu/rleB
	jtADD1SNbqfVDtRRyUCz03MkB+HA56tsarA+lV+OnUU9wu8T/d/qgOvpW
X-Received: by 2002:a05:6214:5b08:b0:912:4310:e5a6 with SMTP id 6a1803df08f44-9142f91b2ecmr96632886d6.35.1790423797396;
        Sat, 26 Sep 2026 04:56:37 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-eastus-03.tradc-corp.com. [40.76.104.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430df77adsm37890496d6.26.2026.09.26.04.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 04:56:36 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 26 Sep 2026 07:56:21 -0400
Subject: [PATCH v5] doc: clarify --follow's single-file limitation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-document-log-no-follow-v5-1-d04efeca7551@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OQW7CMBAF0Ksgr2tkjx0ndNV7VCwy40lwlcRVH
 EIrlLvjwIIWCbXLL/15f84i8Rg4idfNWYw8hxTikEPxshF0qIeWZfA5C1DgVKFK6SMdex4m2cV
 WDlE2seviSZZAxnjShdKlyMefIzfh6wq/7285HfGDaVq1tXEIaYrj93V51mvvz5FZSy2tI1Zgd
 4qxfmv7OnRbir1YR2b4HwOZYS6RENlpaB4Z84PR6iljMuOdN8ZV5CziI2PvjIPiKWMzs0MEY8B
 WWP36ZlmWC1HYqRejAQAA
X-Change-ID: 20260507-document-log-no-follow-72c33dc15017
In-Reply-To: <20260625-document-log-no-follow-v4-1-9bb233248b8f@gmail.com>
References: <20260625-document-log-no-follow-v4-1-9bb233248b8f@gmail.com>
To: git@vger.kernel.org
Cc: =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, 
 Junio C Hamano <gitster@pobox.com>, Miklos Vajna <vmiklos@collabora.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1790423791; l=4350;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=+RcY2eEcN/J2UbOsUBSF17951aXPOiig37m+LFqqJW8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBaRJHLv1P3uiNMYGjt2TMtFKZKpGXj0+Wxogs6r4yjudLCzgyLXTZYzAWsfEg6GRjKm4l2GabN
 He9eF/cBrDAU=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Saying that --follow works only for a single file leaves open whether
other inputs are rejected or ignored. In particular, log.follow enables
following for a directory argument, although that use is unsupported.

Distinguish errors for an explicit --follow with no paths or multiple
paths from the configured default, which has no effect in those cases.
State that results for directory arguments and accepted wildcard
patterns are unspecified, and document --no-follow to disable the mode.

Assisted-by: LLM
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v5:
- Distinguish explicit --follow errors from cases where log.follow
  leaves the command unchanged.
- State that results for directory arguments and accepted wildcard
  patterns are unspecified, and explain how to disable following.
- List --follow before --no-follow.
- Rebase onto current master, which includes mv/log-follow-mergy.
- Link to v4: https://patch.msgid.link/20260625-document-log-no-follow-v4-1-9bb233248b8f@gmail.com

Changes in v4:
- Limit the patch to `--no-follow` and its `log.follow` override; leave
  the existing `--follow` limitations unchanged.
- Link to v3: https://patch.msgid.link/20260510-document-log-no-follow-v3-1-d6d3368c64bb@gmail.com

Changes in v3:
- Retitle the patch to avoid the awkward `doc: git-log:` subject.
- List `--no-follow` before `--follow`.
- Clarify that `--follow` follows a single file across renames, even
  though the option is accepted with exactly one pathspec.
- Document the directory-pathspec case: directory renames are not
  followed, but `--follow` still uses file-follow traversal, disabling
  normal pathspec pruning and possibly changing which commits,
  especially merges, are shown.
- Link to v2: https://patch.msgid.link/20260507-document-log-no-follow-v2-1-ee7bcbbe612f@gmail.com

Changes in v2:
- Document --follow as limited to a single pathspec, not a single file.
- Adjust the log.follow documentation to use the same wording.
- Link to v1: https://patch.msgid.link/20260507-document-log-no-follow-v1-1-46ce02490eba@gmail.com
---
Range-diff versus v4:

1:  ee9e9a1817 < -:  ---------- doc: clarify --follow and log.follow for git log
-:  ---------- > 1:  993a2ed91c doc: clarify --follow's single-file limitation
---
 Documentation/config/log.adoc | 10 +++++++---
 Documentation/git-log.adoc    | 10 ++++++++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
index f7dfce69b5..4efdd4f61b 100644
--- a/Documentation/config/log.adoc
+++ b/Documentation/config/log.adoc
@@ -51,9 +51,13 @@ This is the same as the `--decorate` option of the `git log`.
 	details. Defaults to `separate`.
 
 `log.follow`::
-	If `true`, `git log` will act as if the `--follow` option was used when
-	a single <path> is given.  This has the same limitations as `--follow`,
-	i.e. it cannot be used to follow multiple files.
+	If `true`, `git log` enables `--follow` when a single <path> is
+	given. With no paths, multiple paths, or pathspec magic unsupported
+	by `--follow`, this setting has no effect.
++
+A single directory argument or an accepted wildcard pattern still
+enables `--follow`, with unspecified results. Use `--no-follow` to
+override this setting.
 
 `log.graphColors`::
 	A list of colors, separated by commas, that can be used to draw
diff --git a/Documentation/git-log.adoc b/Documentation/git-log.adoc
index fb3ac11283..a40b3d1c05 100644
--- a/Documentation/git-log.adoc
+++ b/Documentation/git-log.adoc
@@ -28,8 +28,14 @@ OPTIONS
 -------
 
 `--follow`::
-	Continue listing the history of a file beyond renames
-	(works only for a single file).
+`--no-follow`::
+	Continue listing the history of a single file beyond renames.
+	An explicit `--follow` requires exactly one path argument; Git
+	reports an error if none or more than one is given.
++
+A directory argument is accepted and enables `--follow`, but results
+for directories and accepted wildcard patterns are unspecified.
+Use `--no-follow` for directory history or wildcard matching.
 
 `--no-decorate`::
 `--decorate[=(short|full|auto|no)]`::

---
base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
change-id: 20260507-document-log-no-follow-72c33dc15017


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794876287;
	b=HOsGjCsWozVKxrBa602ObisDB7bwOg4/XHwPahly4YH3RTKIyLEWaM694FJ4RLDAcht9
	 4Hoe+QI8mlaxHcxW26gJ1+u4MnBxnUZ6g1itM+WeOcIb9/mDSPTWZM107iazep6OpYiaw
	 clMoQpCLNeR5qPVjvMxUrDGJuPiIHBbTatChbAzNhEwnonkJfnU+c2//vEdQMBfsi83tu
	 LoYQp+TOhv2vvT4alhhjcsHTrTHUb7Xm4ArrG68rgttuFuORQV/U5szcXwHmO1lx1J+Rf
	 qN2HEILaOnvPF66UT2899wMyjEx1hptQrFip3TtbODMkB+P04FUT5UAB2TBnU1O05Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794876287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BAcO31yYMbv8/tI7tmC5u+lt05XFpAWWgvNzAaKOvSs=;
	b=rnGsnSV6v0bgaZX/DHDu0Nux4U1cBh6L01SsA3OljRnFuMp0dIO+2QIWm8ykR3wvzrLS
	 AGK8B03WP7gRmuzcitI5tbLBpEeCKD6weQY1F0cdKTjnoORa+4NivyG9fg8V0OOwmWSWL
	 Cw5q8jz8yXc0fpoNtVd4jnQXJAVo4ElqvSKp6qXToWhOgKHGs8wCuYaejFuFOzN5DKZcw
	 CUtftz+c1FsgQS/lMeV0/nS6o05J8Mf17ogaFkzegCR+fsF1oamcOfEhB3wmMZfFRDt7l
	 7DW7jtqMaRJaE5aA++Mj0N0k77X7OoahB0PO+XhW35j7Erybe0NJ0Ki7UWavpyq5IvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ruL1CRzR;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD69606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 00:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DD69606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ruL1CRzR
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-490d59c3edaso250193f8f.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 16:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794876286; x=1795481086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BAcO31yYMbv8/tI7tmC5u+lt05XFpAWWgvNzAaKOvSs=;
        b=ruL1CRzRHMKlhJsLmx0WdzbO7WzQrGeao0zOH3SMugist+Z/+IIEouRdab9X3Qb3tW
         pcuUEO8NxTnVaHlhTB4OtcZJoJJ3Hn58ZdLQE4MGEwhHrojUHlZWk7J9JoBCFhQlwp2/
         q/XMWuEm31/9701VK8LmvzqQ/6yGL/N7NkXoCCPr/k7gaf4c1bdMdU82l5e6f+We+XjZ
         L/WDD8rF6pCn4j5AnyUJ2ygvatFbv8IrBR8NzApN+mHi8/Fv/5hWXjIJF3His9oZI/UZ
         y8zP7r+jU95X/dbz8Ld/Tdwad929nPr9axDObvVS3ftJFLa33HIjhp/SVlydEGdAs9ad
         //nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794876286; x=1795481086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BAcO31yYMbv8/tI7tmC5u+lt05XFpAWWgvNzAaKOvSs=;
        b=y/FWLTv2jwYZFWdk9AnYg31aXPIMdZMLf+Dql325ZaC3yIpMrVFsnO4HwcwugP2CQZ
         KrzDn0/UzdWOsaK2Nw5fNBx4Gu+3L/X7RLeJj/YO03SRLPIjLZF6eG0UwwULZf+HvU74
         s5CnszlgWT8ZT08pwE45jFFlYMGAi7wYlD74AlkhtJ45YeNG60wr36PM9EPJnSl/sYzT
         n6i3C/NpE8eT6p6XOD6s9K/XwenO/Dkla888zW6xtwUJQSyLBt2eQxm2v4Km6/Z0ZwOX
         5kMBMhHM+pB5PmtjW6ZJc2sLQmsZoWnkgvztiNLNIEPt3kjMBl6swLgLbqFvnJ6wKWNp
         9UPA==
X-Gm-Message-State: APuU4Z/AM2r41hdCDmuocxIxUOR7A7+EoD83PEY+BAtYkpmz+EHNOFMZ
	xEAMaNVRjAe8AmWnKh4etAJkRaCN+VFKLbY7XLXqQN8OesnnOOC6qQhBPjgS4U9hLv0=
X-Gm-Gg: AZFdTZcFTzUdFrIO2PiqEgZf746Ix5KgAJlKmRGbk26sFD/atiVHQY18X1NT3JpBxZZ
	OzDwVh1c/pzbPViqtPL0JUsTd+eL+2oDBLr5TglCuOpR9oHR4WYqjA0zIsS+gpUMVdaPOm9xr31
	KgusCHfhl3YZqcts3j38s+SX0uTLpn2vTdH6RYikOqz1P4MBo2hVRZGA+10at6M4rP2bNUoh34h
	8TPXx5HLoAVB30WA4ppdlAsSXEgE9I3XnS1ZVV1rBYL0StC+wSgNS7w3BoRYECAnRhpUJ9GICt4
	w0H4Ei1kCQK1VYq4zZ4OIUaXwUZlJ32Gajyye+pe7GL7RrSBmGJWMbETVosdLU+4oDMdmIuGRKx
	4tudVFROuQQbKSobkDMhKFqwGncvKhpK48uElVK8qzPDCX8mR4Bpzg7eDppBBZtMA8xPuX3odJf
	LVe+ZRN2FNMh02M3QOgyO/dEBJnWQafj7CPx5GOTB6ClpunLYb/OtLbmTThyeLmkfNg0xZjVonn
	9wODPnZ6E3xNQejw0j/XCb3tDOLYDuM61yuv5V8V+xAx7myhuYP7ugOJ+5ZMDT/G4GFOokZY0Qm
	6CQ6lefoPO0l4n9ye/Un7sRC1I7q2XHTjkIFZQSD/pot22k74/F6xhjsX/bQLsSxdN1TUcPzVpJ
	ihbrvXPsRTHmSmXQknfs1RqAMPElBbIBkNg==
X-Received: by 2002:a5d:6f17:0:b0:4a3:c963:c1c3 with SMTP id ffacd0b85a97d-4a3c963c1f3mr1230089f8f.15.1794876285646;
        Mon, 16 Nov 2026 16:44:45 -0800 (PST)
Received: from HP ([102.0.122.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a3d39b8a37sm953876f8f.46.2026.11.16.16.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 16:44:44 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: siddharthasthana31@gmail.com,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	jackrawlings2011@gmail.com,
	christian.couder@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH v3 3/3] apply: reject new and deleted files that have both names
Date: Tue, 17 Nov 2026 03:43:48 +0300
Message-ID: <20261117004348.806694-4-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.388.g09a996e1ff
In-Reply-To: <20261117004348.806694-1-tangajoris@gmail.com>
References: <20261114012055.127905-1-tangajoris@gmail.com>
 <20261117004348.806694-1-tangajoris@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git writes "new file mode" or "deleted file mode" before the "---"
and "+++" lines. The "new file mode" line sets is_new. Then
gitdiff_oldname() leaves old_name empty for "--- /dev/null".

When the "---" line comes first, is_new is still 0. So
gitdiff_verify_name() takes the name on that line as old_name. For
"--- /dev/null" this gives "dev/null", because one leading directory
is stripped. The "new file mode" line then sets is_new. The result is
a new file that also has an old name. "git apply --check" dies on it,
on the same assertion in check_preimage(). In the same way,
"+++ /dev/null" before "deleted file mode" gives a deleted file with
a new name. "git apply -R" dies on that one.

d70e9c5c8c (apply: check git diffs for mutually exclusive header
lines, 2017-06-27) made apply report other conflicting header lines,
instead of leaving them to an assertion. Do the same here. After the
header is read, reject a new file that has an old name. Reject a
deleted file that has a new name too. The error names the "---" or
"+++" line that came before the mode line. It does not print the
name, because for "/dev/null" that would be "dev/null".

Git always writes the mode line first, so patches made by Git are not
affected. A patch with "+++ /dev/null" before "deleted file mode" used
to apply without -R. It is now rejected too.

Helped-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Tanga Joris <tangajoris@gmail.com>
---
 apply.c                    | 18 ++++++++++++++++++
 t/t4133-apply-filenames.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/apply.c b/apply.c
index 77a665a71a..b920dbbbc7 100644
--- a/apply.c
+++ b/apply.c
@@ -1467,6 +1467,24 @@ int parse_git_diff_header(struct strbuf *root,
 			      *linenr);
 		return -128;
 	}
+	if (patch->is_new > 0 && patch->old_name) {
+		if (patch_input_file)
+			error(_("git diff header has \"---\" before \"new file mode\" at %s:%d"),
+			      patch_input_file, patch->extension_linenr);
+		else
+			error(_("git diff header has \"---\" before \"new file mode\" (line %d)"),
+			      patch->extension_linenr);
+		return -128;
+	}
+	if (patch->is_delete > 0 && patch->new_name) {
+		if (patch_input_file)
+			error(_("git diff header has \"+++\" before \"deleted file mode\" at %s:%d"),
+			      patch_input_file, patch->extension_linenr);
+		else
+			error(_("git diff header has \"+++\" before \"deleted file mode\" (line %d)"),
+			      patch->extension_linenr);
+		return -128;
+	}
 	patch->is_toplevel_relative = 1;
 	return offset;
 }
diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
index b6b9195924..b85dcb57bd 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -164,4 +164,35 @@ test_expect_success 'ignore an empty "diff --git" line before a git patch' '
 	test_cmp expect g
 '
 
+for old in /dev/null a/f
+do
+	test_expect_success "reject \"--- $old\" before \"new file mode\"" '
+		cat >old_before_new.diff <<-EOF &&
+		diff --git a/f b/f
+		--- $old
+		+++ b/f
+		new file mode 100644
+		@@ -0,0 +1 @@
+		+1
+		EOF
+		test_must_fail git apply --check old_before_new.diff 2>err &&
+		test_grep "has \"---\" before \"new file mode\" at old_before_new.diff:4" err
+	'
+done
+
+test_expect_success 'reject "+++ /dev/null" before "deleted file mode"' '
+	cat >new_before_delete.diff <<-\EOF &&
+	diff --git a/f b/f
+	--- a/f
+	+++ /dev/null
+	deleted file mode 100644
+	@@ -1 +0,0 @@
+	-1
+	EOF
+	test_must_fail git apply --check new_before_delete.diff 2>err &&
+	test_grep "has \"+++\" before \"deleted file mode\" at new_before_delete.diff:4" err &&
+	test_must_fail git apply --check -R new_before_delete.diff 2>err &&
+	test_grep "has \"+++\" before \"deleted file mode\" at new_before_delete.diff:4" err
+'
+
 test_done
-- 
2.43.0


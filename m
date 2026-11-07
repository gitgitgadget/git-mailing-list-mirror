Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081358;
	b=KhcQpv21/tgkNitmhbgoRNDDXyhEdLS8hClgKTX2gjUCmiquuIwLi7PfrnHpbL0BRQsQ
	 OQ0q+1IkKiGtCv2gt3Apxd96liYBjFxctqx3ojpAHap5S4mt9jlSEdDF6prBezhHFG2De
	 GmpVPTUyhMZz4M28lKwkv3K3Z5BdYwY3rw/tbQ7S4JsaDdtDrd2jLbSeTIMMczM8vgXA8
	 /NFTZsL4FQkrmDDJuRcADLhIWkZjEbefuCpKkUXL96cb8kjmUk5xDjjbhGfo0fHNtk+5I
	 cJY1iw73O9s7yTtozguaMyX0sXX+gs+0jfTdGY2+7lCNBhCaAd+JLrkHFK0Xz2m7PMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8l/PhSRNcA+MukN3MmIfMZfCAHp2cmBDP3qaKOswNYg=;
	b=2+Ho5UDcx1YAfPWK/0FRTFYnderZeZVQNiegPriNhwr017eL2ZMOBXDBiaXXWsHYQsYM
	 i1pzYEFxgm1RqNGXoVGSdAsCLL50tkD8U05nAfK/EDcyq7+pUDRep71x+1dc3tfU0XsE9
	 s+CfHxVu4LnOL5wtSZ9PisNQph+SQ02nlAKNzV86X5NkSTolZRZWZ6JwUHu9FZY6Z7oHf
	 56uxA3dMBvVu5NgLm7+dwOytk8jR64IGBjxEMdpj+45DVamuE75VBVPyDQ5hSitRxdk5O
	 XGixaYg0qzmDYpZxZhooqm8Axi6Jm2Tc7dRwUOnpV9SbmK4Y8zcUTxI3EMHhSZsl/ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GWHHSA1l;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9924606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 19:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9924606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GWHHSA1l
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-490585eddfcso28498f8f.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 11:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794081356; x=1794686156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8l/PhSRNcA+MukN3MmIfMZfCAHp2cmBDP3qaKOswNYg=;
        b=GWHHSA1lY5c1ENguqA/Dq0JEbcerv2fAk5L7PzL3ReHl7p8cjRFKOCUH2NuVEM3LJK
         smNrIQuhcOF9FolVhyJi0HX7wVQEklAcbmFPdU4IImtaeht3xweIxaElHsDpEHwNQLU9
         LM2FUs1Mh3uoxzoyMS28fE5bjPfiwFj1HlIna7EZOJPWP4rz4Db0q11C9WpKTkE6pju3
         0d8TvmkxAXw4QC0e5p9Npar88eVlnaeDMNeFeWCqV8Bwyi6R8uoeskgEuK/WdH/BxTDg
         N2R/oiq6F9unUg2bgcNI36aW7ioz4mv5eIMTTBVvWXa8xP9LwrKFAuWpGA9GRf3ccllC
         fdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794081356; x=1794686156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8l/PhSRNcA+MukN3MmIfMZfCAHp2cmBDP3qaKOswNYg=;
        b=1Y3PS6n8o66So/AJixawIiHVClwfIiWe+SRADLyRGbPFSdSldMrxuZ6kTLFSl4jrSf
         15xQY3GxGHdN9dHgJIUuAWPFLmJi9Gb4Ulmvm9qVe0gWSHDimK8ufy8Q6u6+esH7k0bY
         4JOTZTQdVlAmjawcLgcs296ZBGZZjRpyz/f0tDs4GFyq6YEIB/fhV3EHCJ5ieOsnZqZV
         fymci0UfyuaW1VhMmUOkjXFQQNjc5qwid/xFb2R39pKRx6EiJtmNoOyO5Dov+j2mYK/T
         tgUiWGJ+q47/3wIaw4dHihzu/d9pY+Uq9HC54pdJxlrtELAyqnyTINf5RjeotFqZKVTu
         TIMw==
X-Gm-Message-State: APuU4Z9x0Rrf6i/lL9L+mjB3g0HiBinVt/Nu/cn3Qv2ol2SUWe0agSQX
	ExMqOU9euxbVia1zC0/Xkf0BMIjJW+ivorw3HuncuGAB46zU3HlZ1hjQi8Tl7Hw2/hs=
X-Gm-Gg: AYBFou0TtnL137Ah4mWZEpcTB6D5wtgVzNy5wfjIjlg2Fj5MGFX36Ir5gwB+yUvUnFp
	/4IujNwKDP21JwVPTUneAah6vXuTykuiHrgDhCLFsQrR9JdW7z4RAscXnbACIeKZVQdi2+vnD2O
	oJEBLDT+1snZSSuhJxFEzFLnWEOMwMVMTIQOGldaYHTHjqBhI1tdcYwNiR2f8/B+gdYn4HmLNgY
	/iitAoHyPPA8T6nSB+Zu5SmV0wJhh6D8BKj5w4KoQKBWeJR6rpmwGcqrVIo967sFZlkVBnE4quF
	jiwwxDrohcoQddneqvb+9bMMEmd223II791prnV+ibRpjC7BHVPkBAYmJRr5lWTzfHpcMdd32ac
	6x33cQSbdxzgBBUWQ/T+AIDVaWIU+WeMmFy7FnZOydop9D8B8OI/HCSFC4w10k3NUR3Hepogpk9
	7E/+GPoHbjNlcc4q2wmx0VY+WWiG+CwaOklwX4rWsaJLtgwmL2oNN6dQIcJTcKHQUsT5IAvl6DZ
	nl01B+CouOe/ojZR8iHsgkZmwgi83jDQChPgdAVajeeajzmq/5foKSdAmKkylXKpX4SaOltoASe
	/eCPJahej9uOvfA2Ftwfet0VCd/ro8d/GgyavSdTdLoJyvlV5YcMBDVtq6YardTjyedizwOff+L
	SS4cXb3xmg2569Z67eail8rMsaC2szEn6rQ==
X-Received: by 2002:a5d:5d06:0:b0:48e:d88:55e2 with SMTP id ffacd0b85a97d-4958c779a6dmr8101f8f.42.1794081356079;
        Sat, 07 Nov 2026 11:55:56 -0800 (PST)
Received: from HP ([102.0.122.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d770248esm11585063f8f.42.2026.11.07.11.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 11:55:55 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	jackrawlings2011@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH 2/2] apply: reject new and deleted files that have both names
Date: Sat,  7 Nov 2026 22:54:29 +0300
Message-ID: <20261107195429.96842-2-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.388.g09a996e1ff
In-Reply-To: <20261107195429.96842-1-tangajoris@gmail.com>
References: <CALdwsC1cMKZgRPZA+pBaJe4PPs9q9W0K9CQLmM2bgUCyysTB-w@mail.gmail.com>
 <20261107195429.96842-1-tangajoris@gmail.com>
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
deleted file that has a new name too.

Patches made by Git are therefore not affected. A patch with
"+++ /dev/null" before "deleted file mode" used to apply without -R.
It is now rejected too.

Signed-off-by: Tanga Joris <tangajoris@gmail.com>
---
I chose to reject these headers, like d70e9c5c8c does for other
conflicting lines. Another option would be to accept "--- /dev/null"
before "new file mode" as a new file, since "/dev/null" means no file
there. I'm happy to change it if that is preferred.

 apply.c                    | 20 ++++++++++++++++++++
 t/t4133-apply-filenames.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/apply.c b/apply.c
index b56b363963..76cdacff33 100644
--- a/apply.c
+++ b/apply.c
@@ -1466,6 +1466,26 @@ int parse_git_diff_header(struct strbuf *root,
 			      *linenr);
 		return -128;
 	}
+	if (patch->is_new > 0 && patch->old_name) {
+		if (patch_input_file)
+			error(_("git diff header for new file %s names an old file %s at %s:%d"),
+			      patch->new_name, patch->old_name,
+			      patch_input_file, *linenr);
+		else
+			error(_("git diff header for new file %s names an old file %s (line %d)"),
+			      patch->new_name, patch->old_name, *linenr);
+		return -128;
+	}
+	if (patch->is_delete > 0 && patch->new_name) {
+		if (patch_input_file)
+			error(_("git diff header for deleted file %s names a new file %s at %s:%d"),
+			      patch->old_name, patch->new_name,
+			      patch_input_file, *linenr);
+		else
+			error(_("git diff header for deleted file %s names a new file %s (line %d)"),
+			      patch->old_name, patch->new_name, *linenr);
+		return -128;
+	}
 	patch->is_toplevel_relative = 1;
 	return offset;
 }
diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
index 727c36e7ea..ac9090d903 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -150,4 +150,35 @@ test_expect_success 'blank line after "diff --git" keeps paths relative to the t
 	test_path_is_missing f
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
+		test_grep "header for new file f names an old file" err
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
+	test_grep "header for deleted file f names a new file" err &&
+	test_must_fail git apply --check -R new_before_delete.diff 2>err &&
+	test_grep "header for deleted file f names a new file" err
+'
+
 test_done
-- 
2.43.0


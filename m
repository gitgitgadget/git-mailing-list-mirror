Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795569035;
	b=drg+Cx0d5ZQrFvQ5VaL9/Fj+I0V4NMMNdJ+HQLEBgpeNdBhLy2/aw318hgzJpl9iroXd
	 YeiiEHoUjv7O0JZWO57ghRH8vtO37n1S3F/kf0eTQg/soElmAYDHFoj2fNNA0p1g44lFP
	 ZoRbcvckaNN94JgdWfWpgTnPrCeq15Rcl8nrg4sv7Qb3wjCV727hDbgcamTdY/I+bRhdR
	 Fk/urDZC5e6/f2DUKINUOrL3pD7lZYh+cMlPNEYWb7bL6MCjqObO4JJ5PbeGddCx31yga
	 ZRd1RDtq5KoXy2P28uk8qff4rAA1CtsokT5ll4ej9VBlt0QZzLbV6ZxXXP7uqyS1STA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795569035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=88QRVxyEDfh9E3p7VDZi7885qfftpfUi6Gp4PVR2VmA=;
	b=YQpe2W2IvgVAUVzo7bTwscySrasnbkktobIN7TieVAleXg5CmJspRhsytwSm7be8GKEE
	 7xDcZill7HFlZiV5eyG30t8PHHomIR/ukXlG/Uqgu3N5vHST3b/vzq92sc2YdW/azgRiJ
	 /kdmIaWwG4Hl87LfpzI7rRmBp1mZMLOFI8di3hqBgLCvDzCFQwhncKgSLoC9smtJun0De
	 fXSdnobDMis0ywRDf6RyqHs4gbYWHP5oQPOPe32dVQsO71yljv+kWIHEnHzWYn3NMwwQ6
	 kOcaEmID+tEzLCI2puj/8SQEGpfRNq2UzvqXRyDz6YHm/G+S9FiiyTsfpeW2Kt+K7RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SaImAHTR;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8988B606A323
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 01:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8988B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SaImAHTR
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so55759255e9.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795569034; x=1796173834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=88QRVxyEDfh9E3p7VDZi7885qfftpfUi6Gp4PVR2VmA=;
        b=SaImAHTR2uTHtrC6iRmWGrbnyoQt+G2+891GPnVSkA6iDTjjrcXEwSvSeZ3x1itG8e
         SL2qVI/mvErfREHWFny7Qf6s+0ph0RhdmdMlwl9SrLTx6FTOpLEKWzcQEWBmhBZY40RM
         BC6LsFpcIfOROMLgiR3mbCMl9ITpZO3Ho0Wz6yvbpSdx0IpD0eMOWK/GWnpNhT0hF2g5
         bdMSkgr+8CEIOSgHYoQshoiqgqzP75dVb0mRXbLGCTSITHeSV50rjgol5hSQWavYpR2w
         pV9b5ZFiF7oN3H0acrNGyamcR3NqLlvrtYkhZKsXU6BZRhSmS9zRdK5y+tbFDKs3o1sW
         V06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795569034; x=1796173834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=88QRVxyEDfh9E3p7VDZi7885qfftpfUi6Gp4PVR2VmA=;
        b=QAHvhJiKxkbt3mvu2CLkxo8q5WWHyVReKNYtNhnGkiBPOrKM6TAW2ZFKqxsH2wdtfU
         w1Vp5LWDkcya4+K6Dn84OBEewfmlmW2tu1rneHXUyilN2UdgGUe34gxqJSrJy7drgDmz
         uGnEl83v2VYlDW5HSx5fcEPKLiXawp/DDtsvtjWHLyDaI+ktAhTgK7zCtS7PGGvmG1pI
         HxirRdSh104VYbKHFmV9KkD8bHGRouHfTZMRnyPtpyXTEt6ST88ZSnezRqn0afGUP4Ut
         0OtPuLAthX6ghhDRiPSU+qFXUVxF2XyoF8De4zktRJHsbjBmZ1tk/8l44PEB+91PdUDd
         vB1Q==
X-Gm-Message-State: APuU4Z8qcAswXATtjH4hL4/2j/e292b52/llJlZ39cmcYUyuWmkGJRUl
	WwjIo+8ylSa58n4eLC+LNXedLK04OXdUv6HWB/h0veW7K7ITm4/frhzPVmJxHSm958Q=
X-Gm-Gg: AZFdTZdwFRtK93LWFG40u2ILBvR2dUMRJxs4wKj97HXJo6/mCjWdhobyLyrdhqkEjfa
	ldhqFwTT6y94rUt7qFaxhkckdfuK25qed3JtkYpTvh06mkcHEb6tJUNI6OeSeCgx/Cn+NdV7Wlg
	mRs0mFnrR/MuBxjfeZ55YsySV8TIhHoG0CKJyK6KP3qMT9/HPFG9BhxgKFan2Co5yTSktrPbUT3
	PcZPueWi197I2JD+w/r2+HdL80keRcNZj581pandq5vhdJjDN4pAZMTHLfM3CrmB9STQdOHaxwg
	IkU+OW8dqpchomAz2GkM1jMEzCymG2geXOdAxiF7iRuTGrLiafEgQ2gB3KsLs85oypfRihU2v1F
	N+fto+AzluJqQQn6+Wwy1s9FmHjdgbRJRel6prAgyslWV3D9zRFTCiCV7SjjbRw+B1LsGhE1kcn
	Z2Jz061NHIngXVLSFX4Sfa5sUw8YAYs1PEnqBaMuDfLn7sAB7/4O65hqpP//Kkt/kAtBhASHwuS
	14JC37XGSDjGf5w7zud+NRIZU0Qdt7O8vg6B08AbZG7nU/p9owpCCCNsXfUGyBmmHvq3QcEVAB/
	bjtPiOk0/n6V3YoDnv3Q7c1PdVPcKSl8p5svln+f27HICZ8eaeuurzHBikSC8QpKbq/2Ctlv0Jc
	45eABTEqVmMG+onaL+QDYjupjoQnJufo=
X-Received: by 2002:a05:600c:3ba5:b0:4b0:a307:46f8 with SMTP id 5b1f17b1804b1-4bb8880f29bmr372532865e9.10.1795569033833;
        Tue, 24 Nov 2026 17:10:33 -0800 (PST)
Received: from HP ([102.0.122.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b39b6sm435336135e9.12.2026.11.24.17.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 17:10:33 -0800 (PST)
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
Subject: [Outreachy PATCH v4 2/2] apply: reject new and deleted files that have both names
Date: Wed, 25 Nov 2026 04:10:02 +0300
Message-ID: <20261125011002.589285-3-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.388.g09a996e1ff
In-Reply-To: <20261125011002.589285-1-tangajoris@gmail.com>
References: <20261117004348.806694-1-tangajoris@gmail.com>
 <20261125011002.589285-1-tangajoris@gmail.com>
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
index b28c1401f4..d09ae38dc9 100644
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
index 73d3bc4e08..953749734b 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -164,4 +164,35 @@ test_expect_success 'reject a "diff --git" line followed by another' '
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


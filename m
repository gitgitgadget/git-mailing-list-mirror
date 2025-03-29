Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA53D8F49
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743272484; cv=none; b=jMnwJXVl6Svffogvb5+Rh5LIhDF2RE8bYpdIrisj6Kho13Xn9A/dPxmpXXHLXhxMkRzXOzDX4aQ52MIEDg0lT37aO+OxNJla66TKbZDdd5N36bT3Ed2MUHp+KNqVmlbltOWknJ3cc9lk/eoekFXmgA1ecxZM34URLBgD+v5GSsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743272484; c=relaxed/simple;
	bh=Dmyn3xUi17ZnopWcXcd3UThRA/bzRTVrTO//tl5gY8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=En6c+XHz5Q8mmEhNWqIVyOPMTxP2IfkHLuYL8KGgeKYfECUExIgxsPjKTfEF95qGNeWwy5VzpSTJEIdnLUKYZhTXMAWczdnPscZHou1GQUQXsJjFbADxfTvRiPjDS8CfI27uqfXHqzi/rFJNdCib+hpQ+aqJnXTWWLLqjjzHDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3VMoKFj; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3VMoKFj"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abf3d64849dso493057666b.3
        for <git@vger.kernel.org>; Sat, 29 Mar 2025 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743272481; x=1743877281; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ll70Kqo0SOS36ZtjoupOR3b7AfI0EYPj0VqWxGPo7Vs=;
        b=d3VMoKFjc1eh9tpc3KNvDJKHHQ4f/YJXMAuu87au8LpIdCAXLxdq65DQNlINI88etS
         7l9nYEAqE7RTRn1aK78cyJyn3lpX6KhQT48qaz4ptN2LN2sT10idtH+LJxyp+aFTTW3W
         UkHEj0YDI+zrabyc99Ve3b1mudQgMBLJrTZWeila09MsYBLI1XB4BcNYiF2T3ToFfXx4
         zVxI8InJ2MCc5ELDGnDQ5UPpEspTb8MeqdY02Vs5MqMlQsIxuxC3FA5E+QriAQMH7oc1
         +/DH4FJZioPUKF59R5Wdy0kIxMb2Nx7Yd+70tC2yK9mbDuNVmOnLmznxnbrXYIRUGv9d
         J7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743272481; x=1743877281;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ll70Kqo0SOS36ZtjoupOR3b7AfI0EYPj0VqWxGPo7Vs=;
        b=C9u+EBGI4sQxdTQlllt+BXstYwORSc5iCtfZ0CIN1SD9gsZDQAwPi21n+9vXHreRI1
         KzsZ/Y/0YFpq9ut+TPgpUUqta76n+N8um05kJBugzAuMOf0XLatdytM8HuQNAvWqAeGJ
         nukesNcLYhUdSIyzRHmHh68Zk63EUTLYT+of27WqQV8icRdDeD1x28oNz/vTPX3NYXot
         zQLOcwqyE3+7wF0mSNNiQH+I5dW5TdcRDb3mduok7qL2fQLmOIwGCvWr2oaotgsJogN8
         YJ65LGKj0icWdSH/Y6LlJjSYawo0xqCrxFGACvXqgH5MvEqdILUxxnu6WCSVGNbdWjs8
         4wvw==
X-Gm-Message-State: AOJu0YzT9YBBdkQ8oru1ht0yzFEeyZsAV9qjy+Vo+L/X3QmqOIkx0UVy
	xVgLS/w4MQAUTowpeonWyGRK8/QhM2R5zuDDtH/NsBFlFMy3daqE
X-Gm-Gg: ASbGnctJmqlOoKHwkLtCvz9F9Ruo/cfZlNR0yAVV7lXYywPqukC5f2T09WJxNseRZvz
	eRyRKTTXPF2shLbz2WgCJrMa2DykzAyCRDs3xOuSdCzI7VEavUBt9ejeVBn/6V96i3UxnBXUE2/
	BABlRZPATEtsu3or9eZMGaTrPnZECemjaOmQPjjNlLpIdT5A82bJqI4439X+zrM2gvs7+gHL6Jm
	KzjhRNHCDYa3YR9plyRYxpTsjREhdCWfuJ6pjg0OKP2ymHQs/KXiLd8PYoazrdb2/0JYVZkQe6r
	jILTYelaSLj/LVKD3rdnJyhFHLE6V4xsK2JsO4wax0LgCJBpbg==
X-Google-Smtp-Source: AGHT+IGQT594/S5U9uyN2YzrwH+0pu6QivncIhsEzEDoqlvhSgrdYpNoWU5skK9c21BQP6bGDDU8jA==
X-Received: by 2002:a17:907:6092:b0:ac3:8aa5:53f6 with SMTP id a640c23a62f3a-ac738a0c683mr332027966b.24.1743272480705;
        Sat, 29 Mar 2025 11:21:20 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:c33:27ad:43f3:8b57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac719278674sm361436366b.40.2025.03.29.11.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 11:21:20 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sat, 29 Mar 2025 19:21:16 +0100
Subject: [PATCH v3] blame: print unblamable and ignored commits in
 porcelain mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250329-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v3-1-10f695ae519a@gmail.com>
X-B4-Tracking: v=1; b=H4sIABs66GcC/7WOQW7DIBBFrxKx7lQGY5N01XtUXQxm7IxqwAJsJ
 Yp89+KscoB2+b++/nsPkSkxZfFxeohEG2eOoYb27SSGK4aJgF3NQjWqa1oloZMaJi5gZ/QEEjI
 sMQ00IweIa1nWAi5ShhALkK/DNRxTtDMBBgc8hZjIgcf0QymDxlH3Y6PO2pCo1CXRyLen0dd3z
 VfOJab7U3CTR/t/LpusJ1rbrlfuYsmePyePPL8P0YvDZVOv/P7v+aqemEvTGpIGjbav/H3ffwH
 gLpqvrgEAAA==
X-Change-ID: 20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-4af46f02847e
In-Reply-To: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com, gitster@pobox.com, sunshine@sunshineco.com, 
 Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8909; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Dmyn3xUi17ZnopWcXcd3UThRA/bzRTVrTO//tl5gY8o=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfoOh66IpbdzcV22vOqbqHF/Ojvoq7oNuzo+
 DuHIthDC7ezkokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn6DoeAAoJED7VnySO
 Rox/XkEL/Rq4zmmyv+hoU2YXpZg4DNG6bC5qa8EzZRlnmUO/mAk5BtCwW5vrLQ6nCyLIiDsqlp4
 OrHaVR0Wppax4Q1k7uSm7Xs9dbFSOW9iq+rriXVhFL0HCWyXZpNH2vHoJTE48zIP7hR+2gVClep
 BHBkaclV5j8ABx847Ru+fd3alCbe7DcI1YPDHq+/i9qg+5hJ081kaayubomK1kyWbKSSTSWiHZJ
 /AxbwU5pqv4apY7cmP6qGlVKXXjZpP3m/1bH2bXZMMDB0GVZrSiLQnLw0hosMS7Yo3VpYCm8pMo
 oBly2XMAhicdiBoResc+LgttEE4G4JvrFliunJX2I44c2mMNX8VuNPfXOXFr79xmPr6KjkuWH3i
 bQUrvLujrz0iANqfS3vJoYchDsrRbOfNSVLcLVdQXiS9pP3dX63W8I/tDzYHT44tG78afUOeMND
 slDSeHooJG+4LmnP2t+8IXgOjkwoQ/Dill6Yz5GjKrPf+P5Q9380+fqRDO86BtvOxJEZXgrrhl8
 T0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'git-blame(1)' command allows users to ignore specific revisions via
the '--ignore-rev <rev>' and '--ignore-revs-file <file>' flags. These
flags are often combined with the 'blame.markIgnoredLines' and
'blame.markUnblamableLines' config options. These config options prefix
ignored and unblamable lines with a '?' and '*', respectively.

However, this option was never extended to the porcelain mode of
'git-blame(1)'. Since the documentation does not indicate this
exclusion, it is a bug.

Fix this by printing 'ignored' and 'unblamable' respectively for the
options when using the porcelain modes.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Toon Claes <toon@iotcl.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v3:
- Use double-qoutes in the test to ensure correct variable dereference.
- Fix incorrect test name. 
- Rename the function from 'emit_per_line_details()' to
  'emit_porcelain_per_line_details()' to be more descriptive.
- Ues 'puts()' instead of 'printf()'.
- Link to v2: https://lore.kernel.org/r/20250326-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v2-1-79037e17a74b@gmail.com

Changes in v2:
- Instead of printing the markers before the SHA in porcelain
  mode and breaking scripts and backward compatability, let's 
  instead add a newline printing 'unblamable' or 'ignored'.
  This is printed per line in both the porcelain modes. 
- Link to v1: https://lore.kernel.org/r/20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com
---
Range-diff versus v2:

1:  3a4012718b ! 1:  a80353ab00 blame: print unblamable and ignored commits in porcelain mode
    @@ builtin/blame.c: static void emit_porcelain_details(struct blame_origin *suspect
     + * information which can be clubbed on a commit/file level, should
     + * be printed via 'emit_one_suspect_detail()'.
     + */
    -+static void emit_per_line_details(struct blame_entry *ent)
    ++static void emit_porcelain_per_line_details(struct blame_entry *ent)
     +{
     +	if (mark_unblamable_lines && ent->unblamable)
    -+		printf("unblamable\n");
    ++		puts("unblamable\n");
     +	if (mark_ignored_lines && ent->ignored)
    -+		printf("ignored\n");
    ++		puts("ignored\n");
     +}
     +
      static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
    @@ builtin/blame.c: static void emit_porcelain(struct blame_scoreboard *sb, struct
      	       ent->lno + 1,
      	       ent->num_lines);
      	emit_porcelain_details(suspect, repeat);
    -+	emit_per_line_details(ent);
    ++	emit_porcelain_per_line_details(ent);
      
      	cp = blame_nth_line(sb, ent->lno);
      	for (cnt = 0; cnt < ent->num_lines; cnt++) {
    @@ builtin/blame.c: static void emit_porcelain(struct blame_scoreboard *sb, struct
      			       ent->lno + 1 + cnt);
      			if (repeat)
      				emit_porcelain_details(suspect, 1);
    -+			emit_per_line_details(ent);
    ++			emit_porcelain_per_line_details(ent);
      		}
      		putchar('\t');
      		do {
    @@ t/t8013-blame-ignore-revs.sh: test_expect_success mark_unblamable_lines '
      
     +for opt in --porcelain --line-porcelain
     +do
    -+	test_expect_success 'mark_unblamable_lines with $opt' '
    ++	test_expect_success "mark_unblamable_lines with $opt" '
     +		sha=$(git rev-parse Y) &&
     +
     +		git -c blame.markUnblamableLines=true blame $opt --ignore-rev Y file >actual &&
    @@ t/t8013-blame-ignore-revs.sh: test_expect_success mark_ignored_lines '
      
     +for opt in --porcelain --line-porcelain
     +do
    -+	test_expect_success 'mark_ignored_lines line_porcelain' '
    ++	test_expect_success "mark_ignored_lines with $opt" '
     +		sha=$(git rev-parse Y) &&
     +
     +		git -c blame.markIgnoredLines=true blame $opt --ignore-rev Z file >actual &&
---
 Documentation/blame-options.adoc |  3 ++-
 Documentation/git-blame.adoc     |  9 +++++----
 builtin/blame.c                  | 15 +++++++++++++++
 t/t8013-blame-ignore-revs.sh     | 20 ++++++++++++++++++++
 4 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/blame-options.adoc b/Documentation/blame-options.adoc
index aa77406d4e..19ea187238 100644
--- a/Documentation/blame-options.adoc
+++ b/Documentation/blame-options.adoc
@@ -125,7 +125,8 @@ take effect.
 	another commit will be marked with a `?` in the blame output.  If the
 	`blame.markUnblamableLines` config option is set, then those lines touched
 	by an ignored commit that we could not attribute to another revision are
-	marked with a '*'.
+	marked with a '*'. In the porcelain modes, we print 'ignored' and
+	'unblamable' on a newline respectively.
 
 --ignore-revs-file <file>::
 	Ignore revisions listed in `file`, which must be in the same format as an
diff --git a/Documentation/git-blame.adoc b/Documentation/git-blame.adoc
index f75ed44790..e438d28625 100644
--- a/Documentation/git-blame.adoc
+++ b/Documentation/git-blame.adoc
@@ -135,10 +135,11 @@ header elements later.
 The porcelain format generally suppresses commit information that has
 already been seen. For example, two lines that are blamed to the same
 commit will both be shown, but the details for that commit will be shown
-only once. This is more efficient, but may require more state be kept by
-the reader. The `--line-porcelain` option can be used to output full
-commit information for each line, allowing simpler (but less efficient)
-usage like:
+only once. Information which is specific to individual lines will not be
+grouped together, like revs to be marked 'ignored' or 'unblamable'. This
+is more efficient, but may require more state be kept by the reader. The
+`--line-porcelain` option can be used to output full commit information
+for each line, allowing simpler (but less efficient) usage like:
 
 	# count the number of lines attributed to each author
 	git blame --line-porcelain file |
diff --git a/builtin/blame.c b/builtin/blame.c
index c470654c7e..8a73b7be4a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -351,6 +351,19 @@ static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
 		write_filename_info(suspect);
 }
 
+/*
+ * Information which needs to be printed per-line goes here. Any
+ * information which can be clubbed on a commit/file level, should
+ * be printed via 'emit_one_suspect_detail()'.
+ */
+static void emit_porcelain_per_line_details(struct blame_entry *ent)
+{
+	if (mark_unblamable_lines && ent->unblamable)
+		puts("unblamable\n");
+	if (mark_ignored_lines && ent->ignored)
+		puts("ignored\n");
+}
+
 static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 			   int opt)
 {
@@ -367,6 +380,7 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 	       ent->lno + 1,
 	       ent->num_lines);
 	emit_porcelain_details(suspect, repeat);
+	emit_porcelain_per_line_details(ent);
 
 	cp = blame_nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
@@ -377,6 +391,7 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 			       ent->lno + 1 + cnt);
 			if (repeat)
 				emit_porcelain_details(suspect, 1);
+			emit_porcelain_per_line_details(ent);
 		}
 		putchar('\t');
 		do {
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index 370b768149..c5a7533232 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -158,6 +158,16 @@ test_expect_success mark_unblamable_lines '
 	test_cmp expect actual
 '
 
+for opt in --porcelain --line-porcelain
+do
+	test_expect_success "mark_unblamable_lines with $opt" '
+		sha=$(git rev-parse Y) &&
+
+		git -c blame.markUnblamableLines=true blame $opt --ignore-rev Y file >actual &&
+		test $(grep ^unblamable actual | wc -l) -eq 2
+	'
+done
+
 # Commit Z will touch the first two lines.  Y touched all four.
 # 	A--B--X--Y--Z
 # The blame output when ignoring Z should be:
@@ -191,6 +201,16 @@ test_expect_success mark_ignored_lines '
 	! test_cmp expect actual
 '
 
+for opt in --porcelain --line-porcelain
+do
+	test_expect_success "mark_ignored_lines with $opt" '
+		sha=$(git rev-parse Y) &&
+
+		git -c blame.markIgnoredLines=true blame $opt --ignore-rev Z file >actual &&
+		test $(grep ^ignored actual | wc -l) -eq 2
+	'
+done
+
 # For ignored revs that added 'unblamable' lines and more recent commits changed
 # the blamable lines, mark the unblamable lines with a
 # '*'

---

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
change-id: 20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-4af46f02847e

Thanks
- Karthik


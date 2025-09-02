Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE1E26E161
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 08:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802086; cv=none; b=gTw/phUsBPRgsQOL+yKKyYpwAkqBq98BkkwXJ5wDudlX647sMGkQFoUhekJswnHfMOeuVIjgyehDUyN0Y/hyed0Hkml/ie0xcpuo5DGR20U/YsXZ4V61QQWv2PJIcvyqP6XKY3xFKY696kZDxYGmIKCd45IhOeudcpje4ggOmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802086; c=relaxed/simple;
	bh=kctza1NTAmKNlc7ACpWs0gK/8BBLfkrqgzs6ZCzVtrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=amhQnf4yKWUJRiPDKfKwgp4I5acFuuZ2jekas0xkKaBVGK9Rj5shoGTFCV4mEBP8k8RW5gK6Zko2H3iruv8QCTqqn9nFP/+iXzXt7ANfVxm2NCOgAoHp3bugNlFUpCGpG3P1q0Z1E8mygzAJrfCftGyAg2MIDAmcSNAScRj0Yno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djzHlU2M; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djzHlU2M"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61ce4c32a36so8086843a12.3
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 01:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756802083; x=1757406883; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuMdIRAsNPcEKyCDmwcC8Hmvz5HD4rGoTRpyRFNJDk4=;
        b=djzHlU2Mhnt/aPGJGadjGWF1jaB5UioHlv4HBiGAv73l6rgVn/+Nxm18L61BnnGLbU
         ZZFZW5T0gO2AW3TVkbrRhbtiQhdXBwlyTaTrUHRk0WbnGY+DYLu/gin5gsqzlLT1vyxH
         CTRKvZi58UKOr9RfUSM8r3lX1738I+xBB8rm712aw9NOc8VM2iivIoYvBpxgE3xywAtx
         tUHSIvjsjiylTBHL5MYJ69w7pGCdjsvVPAawb4eXQu+iY41GLdWjckl08np7pjeb13XE
         k26qV5aFskgQnEL+AXOrZSLLw5X6B7XIgPg7D9ttMuBeNmqEyMMSlelVH1suUHHvSOef
         myqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802083; x=1757406883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuMdIRAsNPcEKyCDmwcC8Hmvz5HD4rGoTRpyRFNJDk4=;
        b=Nl94gRGbcyeuqY2MJuLttwPyO/hR6jnNZ7BUSgsgxWR20vC6yaqGTmV/WtAkx1/9Fc
         E/MZfIM8X1Rv10WgJuz2YO9URdw0nsLs71hPdBpV41nagj+6KuhezM+tEyaQcMMq+xtF
         yKD2r8RBVrU6dE++QQob03MxNK9gyFyUF4FNBs3Y3Rs+IVgRbPAk105epINKN3LTqeZx
         OEmoCJC5gV7sIXCBTlqwQjsfHsH/k0c1VsF0spZpgi1eViRJOKEvEaAU+sE/mi7I+57l
         tmHI2AGHrUFf+W2HEMNP0MeMYqjFbsgdcIyO3WJbNl77xIm5ENxybuehC6aL4OuoUJR9
         gKgg==
X-Gm-Message-State: AOJu0YzM9TJQ5G+PDj81r7LFx6axzdlb6d+IelVI0ouYiOoJKWZxE0Ze
	lppWE4DQZF189AFJSMQxtkJMR/L/6yB7txE8jn+VvJ0gyL8OgkBIXTeA
X-Gm-Gg: ASbGncuz7SSnX4b3NPfl5pIUMeGPTRLWnzn39ILp88ji2ESR3TYS5lGXPQJsWSKIh+m
	nH2FCSX/m9PF9aKNu+uUlORXPmvCVrQjZtSVFxZ7ejlrHbaG8cr0iyFnrqpR82qmGRwZcyJ2TEN
	sZ+fKMc1oB/5SegWoynPqgzCoLD/WtTizgnJum0hPHhgbqQl7au2ZehCc9RNGSwGcgRshDGI4SR
	HyUuFZaQVEtxMeowTjf934Ukj85B/aIFBrJGS/HUs/Yb8krImCfbSKm2HXoWGlXj2WHe6pNqNV/
	Q/dWPsaRCKedtyhNwCNIYhMoUdwLDEmEZn4z3YYV6QmT/JD/Ta8TBtPwjNw1XnqQdEklt/bjVIB
	2pY1Sdfw6wNOvC+oHWChxJ8Ky2ByNMW1xDuW4bIM=
X-Google-Smtp-Source: AGHT+IGJpgn5pVo33DFgjS+ENfAlaKz3RfTUPbmOsgEeYN41/WwqWUEn/l/YFxKmmUzitgB/+fHh3w==
X-Received: by 2002:a17:906:37ce:b0:b04:1e6d:63c9 with SMTP id a640c23a62f3a-b041e6d69a0mr685173066b.28.1756802082867;
        Tue, 02 Sep 2025 01:34:42 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:d13e:1f84:4afd:ec5e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b041800e89esm594785366b.30.2025.09.02.01.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 01:34:42 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 02 Sep 2025 10:34:25 +0200
Subject: [PATCH 1/2] refs/files: use correct error type when locking fails
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-1-35e69bbb507d@gmail.com>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
In-Reply-To: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, joe.drew@indexexchange.com, 
 peff@peff.net, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8359; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=kctza1NTAmKNlc7ACpWs0gK/8BBLfkrqgzs6ZCzVtrc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGi2rCBV/9AoBWEs5if+92/xi8nF94Scv8ji8
 poDtJGmMI7sbokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJotqwgAAoJED7VnySO
 Rox/X+oL/jPEOils0WRHQX1wDNvUnI5id9seBkY0NNHEozRAYI3MHBfWet0GsDsymPT3puRiWSe
 dl538zmtK17wfK/PJUiQquVwKC/q0nwzKwSXuDaD4uobOVqLSc8NNcJDXkFJnbculfK+EgFnJBQ
 rDAHt46XW4NET+UhGy+9YDGPZPuLxfb3MKeGY5ZKg0VanbqXBSOFf+kFGGv2ySoJNwhyVC9FoGJ
 edkSgvkl7zWHeNK1H3hQ1Nr3BS07RTediR6Nu0tCqXXBtmj1nRTyr1pg5wAbKcIG/utujfU8iF0
 hQNbx/zYrWMw5AEXFtw/I/mPcHR5+j5JAVvLN6gQqL5aa8f6v78X2lwA1hL76vHulUFp5uQMDeH
 ftNI3bSrsESRBSd8vwdWxyzFT0qn9A5vuVC2MCwHZUqD+vzZ1RA/fruIOtnummyxH0WaP/S/b/1
 mZdHBCNC5vbS3W2kzLFyg3bl5O5ldSD3oXIA0lIsWNX3KpUjaEnHeUWzcMdv4DMVE/3wAr6c6j6
 Q8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

During the 'prepare' phase of reference transaction in the files
backend, we create the lock files for references to be created. When
using batched updates on case-insensitive filesystems, the transactions
would be aborted if there are conflicting names such as:

  refs/heads/Foo
  refs/heads/foo

This affects all commands which were migrated to use batched updates in
Git 2.51, including 'git-fetch(1)' and 'git-receive-pack(1)'. Before
that, references updates would be applied serially with one transaction
used per update. When users fetched multiple references on
case-insensitive systems, subsequent references would simply overwrite
any earlier references. So when fetching:

  refs/heads/foo: 5f34ec0bfeac225b1c854340257a65b106f70ea6
  refs/heads/Foo: ec3053b0977e83d9b67fc32c4527a117953994f3
  refs/heads/sample: 2eefd1150e06d8fca1ddfa684dec016f36bf4e56

The user would simply end up with:

  refs/heads/foo: ec3053b0977e83d9b67fc32c4527a117953994f3
  refs/heads/sample: 2eefd1150e06d8fca1ddfa684dec016f36bf4e56

This is buggy behavior since the user is never intimated about the
overrides performed and missing references. Nevertheless, the user is
left with a working repository with a subset of the references. Since
Git 2.51, in such situations fetches would simply fail without applying
any references. Which is also buggy behavior and worse off since the
user is left without any references.

The error is triggered in `lock_raw_ref()` where the files backend
attempts to create a lock file. When a lock file already exists the
function returns a 'REF_TRANSACTION_ERROR_GENERIC'. Change this to return
'REF_TRANSACTION_ERROR_CREATE_EXISTS' instead to aid the batched update
mechanism to simply reject such errors.

This bubbles the error type up to `files_transaction_prepare()` which
tries to lock each reference update. So if the locking fails, we check
if the rejection type can be ignored, which is done by calling
`ref_transaction_maybe_set_rejected()`.

As the error type is now 'REF_TRANSACTION_ERROR_CREATE_EXISTS', the
specific reference update would simply be rejected, while other updates
in the transaction would continue to be applied. This allows partial
application of references in case-insensitive filesystems when fetching
colliding references.

While the earlier implementation allowed the last reference to be
applied overriding the initial references, this change would allow the
first reference to be applied while rejecting consequent collisions.
This should be an OKAY compromise since with the files backend, there is
no scenario possible where we would retain all colliding references.

The change only affects batched updates since batched updates will
reject individual updates with non-generic errors. So specifically this
would only affect:

    1. git fetch
    2. git receive-pack
    3. git update-ref --batch-updates

Let's also be more pro-active and notify users on case-insensitive
filesystems about such problems by providing a brief about the issue
while also recommending using the reftable backend, which doesn't have
the same issue.

Reported-by: Joe Drew <joe.drew@indexexchange.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c       | 21 ++++++++++++++++++---
 refs/files-backend.c  |  2 ++
 t/t1400-update-ref.sh | 24 ++++++++++++++++++++++++
 t/t5510-fetch.sh      | 22 +++++++++++++++++++++-
 4 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 24645c4653..9563abbe12 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1643,7 +1643,8 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
 
 struct ref_rejection_data {
 	int *retcode;
-	int conflict_msg_shown;
+	bool conflict_msg_shown;
+	bool case_sensitive_msg_shown;
 	const char *remote_name;
 };
 
@@ -1657,11 +1658,25 @@ static void ref_transaction_rejection_handler(const char *refname,
 {
 	struct ref_rejection_data *data = cb_data;
 
-	if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_msg_shown) {
+	if (err == REF_TRANSACTION_ERROR_CREATE_EXISTS && ignore_case &&
+	    !data->case_sensitive_msg_shown) {
+		error(_("You're on a case-insensitive filesystem, and the remote you are\n"
+			"trying to fetch from has references that only differ in casing. It\n"
+			"is impossible to store such references with the 'files' backend. You\n"
+			"can either accept this as-is, in which case you won't be able to\n"
+			"store all remote references on disk. Or you can alternatively\n"
+			"migrate your repository to use the 'reftable' backend with the\n"
+			"following command:\n\n    git refs migrate --ref-format=reftable\n\n"
+			"Please keep in mind that not all implementations of Git support this\n"
+			"new format yet. So if you use tools other than Git to access this\n"
+			"repository it may not be an option to migrate to reftables.\n"));
+		data->case_sensitive_msg_shown = true;
+	} else if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT &&
+		   !data->conflict_msg_shown) {
 		error(_("some local refs could not be updated; try running\n"
 			" 'git remote prune %s' to remove any old, conflicting "
 			"branches"), data->remote_name);
-		data->conflict_msg_shown = 1;
+		data->conflict_msg_shown = true;
 	} else {
 		const char *reason = ref_transaction_error_msg(err);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 088b52c740..9f58ea4858 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -776,6 +776,8 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 			goto retry;
 		} else {
 			unable_to_lock_message(ref_file.buf, myerr, err);
+			if (myerr == EEXIST)
+				ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
 			goto error_return;
 		}
 	}
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 96648a6e5d..e37a5d83e8 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2294,6 +2294,30 @@ do
 		)
 	'
 
+	test_expect_success CASE_INSENSITIVE_FS,REFFILES "stdin $type batch-updates existing reference" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+
+			format_command $type "create refs/heads/foo" "$head" >stdin &&
+			format_command $type "create refs/heads/ref" "$old_head" >>stdin &&
+			format_command $type "create refs/heads/Foo" "$old_head" >>stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+
+			echo $head >expect &&
+			git rev-parse refs/heads/foo >actual &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref >actual &&
+			test_cmp expect actual &&
+			test_grep -q "reference already exists" stdout
+		)
+	'
+
 	test_expect_success "stdin $type batch-updates delete incorrect symbolic ref" '
 		git init repo &&
 		test_when_finished "rm -fr repo" &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ebc696546b..57f60da81b 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -47,7 +47,13 @@ test_expect_success "clone and setup child repos" '
 		git config set branch.main.merge refs/heads/one
 	) &&
 	git clone . bundle &&
-	git clone . seven
+	git clone . seven &&
+	git clone --ref-format=reftable . case_sensitive &&
+	(
+		cd case_sensitive &&
+		git branch branch1 &&
+		git branch bRanch1
+	)
 '
 
 test_expect_success "fetch test" '
@@ -1526,6 +1532,20 @@ test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
 	test_path_is_missing whoops
 '
 
+test_expect_success CASE_INSENSITIVE_FS,REFFILES 'existing references in a case insensitive filesystem' '
+	test_when_finished rm -rf case_insensitive &&
+	(
+		git init --bare case_insensitive &&
+		cd case_insensitive &&
+		git remote add origin -- ../case_sensitive &&
+		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
+		test_grep "You${SQ}re on a case-insensitive filesystem" err &&
+		git rev-parse refs/heads/main >expect &&
+		git rev-parse refs/heads/branch1 >actual &&
+		test_cmp expect actual
+	)
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.50.1


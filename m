Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EB3193426
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734279961; cv=none; b=u3V9WzTZU/l/YDkfKk83NCWj/VR+5MI4iWPTOI+URwCNV3L6JMdXXX3/lMi4CZqUG3YfDViGF/IqVoNUPAhunlCGwFHmazg65gS0IszaugucjuBdzhMGi4a9P1COevPfZ8BSPCevMSm+IcHe3mrDCDvLnTnuj8ptXFQp5WkTo+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734279961; c=relaxed/simple;
	bh=KzZfc3eupGdaCgu8IhgU0wTKwFN0zZpW2VhtYjGjgj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YX/kdakQ5ZW3I2BS/KPng6dG3OzjY7I7IcsJSjsnS7WiW5RQqrejinGKosXu7ogho+p6+HNk0Ba2++JgAlgLA6u2xW8T6iynmo6vR76H3DmSOP+Jl313rQ58Dmrdw7qXnw8NwlmuCLX/C7OIDarGP94qloa0XqYPowSOsjWjju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clvCVcdP; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clvCVcdP"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa662795ca3so850511366b.1
        for <git@vger.kernel.org>; Sun, 15 Dec 2024 08:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734279957; x=1734884757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbLgtM6fZRugS/23dnDGKiBeriksEAzT/0GxzT9Q5yo=;
        b=clvCVcdPatptCljTqGPcyNhkvfDSnPb5cROvLmFpEn0GR0voROjoRMcEpHKDgNvSQ1
         kLEXDJcPkGQl5O1ppS+b7H/cdHj9ncmy29CQy0oz8dxbN+FSI/v043rCbkK6XZQLs0NV
         /6yL96uyLwHQOACjuy7PYiWIYl167KQSTzR35e9erzqYZ0T8lGS3EbDfnH2nKWyyz60Y
         tChTW4+08CbfZCYu4fCBT5O7DwTcmQDGl/4QoiYSo/PnmLXNJdf/v2gt2xqfKR4i1Ta1
         MSmp8W5win+a+9TrrR0VZhcL4tNiGwevCL3yPPm4ic0i+AJHMXt2+V0TZeRf7T+XZ52C
         LkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734279957; x=1734884757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbLgtM6fZRugS/23dnDGKiBeriksEAzT/0GxzT9Q5yo=;
        b=hX3fkXN3iWFZ0T6P3kNSzqEJEY1nvm59IOhBrKuZZxbbigY7XHM7uwfqnhXFL+svIq
         t+3ZsVp3ryyK56bysYzmzFtTB/7bOYH/CB+QNoJ2HaH7BQb40LGSquYERba4pB/OLEBv
         +oBZe+fi5oEG4CZ+w9RVPlLPwFTtpFhXlRExsKGMOhZZx8LBDTMVxnDMp7B0wh7IaGr5
         RUnh3pTavn15CZrBn4HnhmFJehqpVgmCG3BRBeZI3dM7SWcqt+Hffh9UvKm0ffu189NA
         yn8ExdjxqSu8cqjx6Z13+rqT6QIHE0TZKqt3DybFH+szZpwVSLTQqF1aNpbXsGVWqBSN
         lmsA==
X-Gm-Message-State: AOJu0YzpasAbWIFj2W7fQW+UusZFC5+3LTPM+KlUmClkAJCQuCGxS+nC
	LfJRcOZF8JyVIfJVf/MGQZrGUM1o8I3yQEg5jzCKWkiR9S2Q6ivN
X-Gm-Gg: ASbGncs6/AoBLY8+4FD7/LcsRU6MZfPbq5RF1z6BYscDNePvRdzHLkI1aOAFG9pSwaV
	qkryfN4Ybr2BuMACy83Y9GPNvTguUC5GvpI7zmZr7zQSwUhocFnd89vZthO2DFAJEdo9r6SGH2k
	3GXoBFlWdjKbCfatk0C+u7duO5LCSxIIZTY/4WH2U2IFbEyhLtrgp7tVcqjKjdp7m9SEa1JliD2
	d0Err00CPEypDcXTAgtwKRN+lke3eOAhBsEtN/52m9TR87zSaq9l22/5MT3sgKF7Ex3qw==
X-Google-Smtp-Source: AGHT+IFU75ruSZpv/8WxWSQJDO9VJ/dqcDlz6/0q9LM0vRcCnMI0QWD2DoG3FAa/fKAG9f56Wx7PiA==
X-Received: by 2002:a17:907:1c9e:b0:aa6:489e:5848 with SMTP id a640c23a62f3a-aab7b8485admr849445266b.25.1734279957297;
        Sun, 15 Dec 2024 08:25:57 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ad1asm224887866b.139.2024.12.15.08.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 08:25:56 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 15 Dec 2024 17:25:43 +0100
Subject: [PATCH v3 6/8] refs: introduce the `ref_transaction_update_reflog`
 function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-320-git-refs-migrate-reflogs-v3-6-4127fe707b98@gmail.com>
References: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
In-Reply-To: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6145; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=KzZfc3eupGdaCgu8IhgU0wTKwFN0zZpW2VhtYjGjgj0=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnXwMOgPn2PqpXM7/2RLuD6z7dlzrfvePMx7Fu2
 l8rZbpUjd2JAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ18DDgAKCRA+1Z8kjkaM
 f7QfDACe1yHb05TYla5iJel8LrcjvpXfhMOdJ5h2iZA++ai1uqAFlUWxAn3xmOPkUjIDLgAc1UL
 xsvO6wkeTRfYEI/g4dFzzLOtUzExThjdgMo3DdvgLMWqUg+Xhfn+58ZmGmUpRupDGdPGwhs0QlT
 bt/Xii5Bxt0Di4Koj78wXuNgVSf4d9xBUstj58yh22LVNchWenE5/gP8B6kcs9zwCLiK8B9Z58S
 puE/TRqDRKzMNf8k/m2Qz7M4yJ742IPXB5hq9pbEaSS6CP205K0GyALjY3gqPpWUjpuiyCeBGPY
 mEbqOb6Imypo1Je3pcRGM6TRpyHNVBqTjzbpELT7DQRizVbZwqqeZqt6SsztJiZ45wMNDVcIhqJ
 acuYIXzhES8QcfJ5rgngdP4J8/gWf+IS65kvIAne0Edo7doBEyQJUijyog1onwV/YtI2q9Hae9V
 MeXBcIbFC8OMzxWwwj7+8YSgj2Yc82k0zcbMKNZ37mgGXOEjwqNVMwDhsF1M3yE7oPyTY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Introduce a new function `ref_transaction_update_reflog`, for clients to
add a reflog update to a transaction. While the existing function
`ref_transaction_update` also allows clients to add a reflog entry, this
function does a few things more, It:
  - Enforces that only a reflog entry is added and does not update the
  ref itself.
  - Allows the users to also provide the committer information. This
  means clients can add reflog entries with custom committer
  information.

The `transaction_refname_valid()` function also modifies the error
message selectively based on the type of the update. This change also
affects reflog updates which go through `ref_transaction_update()`.

A follow up commit will utilize this function to add reflog support to
`git refs migrate`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               | 39 +++++++++++++++++++++++++++++++++++----
 refs.h               | 14 ++++++++++++++
 refs/files-backend.c | 24 ++++++++++++++++--------
 3 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 782bf1090af65196263a3c35ed18d878bb4f2967..8b3882cff17e5e3b0376f75654e32f81a23e5cb2 100644
--- a/refs.c
+++ b/refs.c
@@ -1207,14 +1207,14 @@ static int transaction_refname_valid(const char *refname,
 		return 1;
 
 	if (is_pseudo_ref(refname)) {
-		strbuf_addf(err, _("refusing to update pseudoref '%s'"),
-			    refname);
+		const char *what = flags & REF_LOG_ONLY ? "reflog for pseudoref" : "pseudoref";
+		strbuf_addf(err, _("refusing to update %s '%s'"), what, refname);
 		return 0;
 	} else if ((new_oid && !is_null_oid(new_oid)) ?
 		 check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
 		 !refname_is_safe(refname)) {
-		strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
-			    refname);
+		const char *what = flags & REF_LOG_ONLY ? "reflog with bad name" : "ref with bad name";
+		strbuf_addf(err, _("refusing to update %s '%s'"), what, refname);
 		return 0;
 	}
 
@@ -1257,6 +1257,37 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	ref_transaction_add_update(transaction, refname, flags,
 				   new_oid, old_oid, new_target,
 				   old_target, NULL, msg);
+
+	return 0;
+}
+
+int ref_transaction_update_reflog(struct ref_transaction *transaction,
+				  const char *refname,
+				  const struct object_id *new_oid,
+				  const struct object_id *old_oid,
+				  const char *committer_info, unsigned int flags,
+				  const char *msg, unsigned int index,
+				  struct strbuf *err)
+{
+	struct ref_update *update;
+
+	assert(err);
+
+	flags |= REF_LOG_ONLY | REF_NO_DEREF;
+
+	if (!transaction_refname_valid(refname, new_oid, flags, err))
+		return -1;
+
+	update = ref_transaction_add_update(transaction, refname, flags,
+					    new_oid, old_oid, NULL, NULL,
+					    committer_info, msg);
+	/*
+	 * While we do set the old_oid value, we unset the flag to skip
+	 * old_oid verification which only makes sense for refs.
+	 */
+	update->flags &= ~REF_HAVE_OLD;
+	update->index = index;
+
 	return 0;
 }
 
diff --git a/refs.h b/refs.h
index a5bedf48cf6de91005a7e8d0bf58ca98350397a6..b0dfc65ed2e59c4b66967840339f81e7746a96d3 100644
--- a/refs.h
+++ b/refs.h
@@ -727,6 +727,20 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
+/*
+ * Similar to`ref_transaction_update`, but this function is only for adding
+ * a reflog update. Supports providing custom committer information. The index
+ * field can be utiltized to order updates as desired. When not used, the
+ * updates default to being ordered by refname.
+ */
+int ref_transaction_update_reflog(struct ref_transaction *transaction,
+				  const char *refname,
+				  const struct object_id *new_oid,
+				  const struct object_id *old_oid,
+				  const char *committer_info, unsigned int flags,
+				  const char *msg, unsigned int index,
+				  struct strbuf *err);
+
 /*
  * Add a reference creation to transaction. new_oid is the value that
  * the reference should have after the update; it must not be
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 255fed8354cae982f785b1b85340e2a1eeecf2a6..c11213f52065bcf2fa7612df8f9500692ee2d02c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3080,10 +3080,12 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 		}
 
 		/*
-		 * packed-refs don't support symbolic refs and root refs, so we
-		 * have to queue these references via the loose transaction.
+		 * packed-refs don't support symbolic refs, root refs and reflogs,
+		 * so we have to queue these references via the loose transaction.
 		 */
-		if (update->new_target || is_root_ref(update->refname)) {
+		if (update->new_target ||
+		    is_root_ref(update->refname) ||
+		    (update->flags & REF_LOG_ONLY)) {
 			if (!loose_transaction) {
 				loose_transaction = ref_store_transaction_begin(&refs->base, 0, err);
 				if (!loose_transaction) {
@@ -3092,11 +3094,17 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 				}
 			}
 
-			ref_transaction_add_update(loose_transaction, update->refname,
-						   update->flags & ~REF_HAVE_OLD,
-						   update->new_target ? NULL : &update->new_oid, NULL,
-						   update->new_target, NULL, update->committer_info,
-						   NULL);
+			if (update->flags & REF_LOG_ONLY)
+				ref_transaction_add_update(loose_transaction, update->refname,
+							   update->flags, &update->new_oid,
+							   &update->old_oid, NULL, NULL,
+							   update->committer_info, update->msg);
+			else
+				ref_transaction_add_update(loose_transaction, update->refname,
+							   update->flags & ~REF_HAVE_OLD,
+							   update->new_target ? NULL : &update->new_oid, NULL,
+							   update->new_target, NULL, update->committer_info,
+							   NULL);
 		} else {
 			ref_transaction_add_update(packed_transaction, update->refname,
 						   update->flags & ~REF_HAVE_OLD,

-- 
2.47.1


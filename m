Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C99207E10
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367482; cv=none; b=Bdd/FAXC0N5uXnd5U7yZNNDzoNFr7jqWJxvc0ICFcsQu1+PYYSd1XnWzVvJsrExtjh4E/xpUl89V+Mpo9NGN6uhZycNceE0iMyiJlrXXT8I91xXQo4EY/KlquAnF6yscVIBJVnAvH1NQqokLdpgzXB49qXbRHOXPzi7NSd8eUjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367482; c=relaxed/simple;
	bh=NoEckIGxQa5jQrZ0dQ7BHqCovFckF/qXPjbGFqkkuA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j2tCBssErGpU7ve+qJ9oZDy0wgZFUdTntSp5q0UYkw8Eei+GOswv1jXKo7YBbX5HYuVVmGeOZBC5fBzlrLjG0M38wYRDVfwcydEX0ToupG9FtiRhUGJ3jF8Cy5mPv0bUi6wNh7nGs8R+ZYlG7GQ8yFw8aBkeRwd+n9uYvrvtobw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHmB17yl; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHmB17yl"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so6789151a12.0
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 08:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734367479; x=1734972279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Io5XE6RXiBUov+SaLOGtphgg3UciL24hpxxR053Wce4=;
        b=OHmB17ylqWMRL6cebjsvpiiei4Cot4AK3BGPzk+aCLqBVhaOaNDQ84dSlcf+PsvDeh
         JSpRCAQ/yI+QzEPukXXiYY4pHZlPuaC3HFOMKnfyw8pr46Fo57K86k43X4SrxM8RIOGg
         8XSrdbcBaWBrtcqA4puR66A7YeuOjNJY5prz+MOEdDzdt2m65w9Wj+jCUEZ+92WYnliW
         OhPtTa8nr03qa+dNKMQShhkmi7Y0OxLt1+ILbhyU8LQXKsScemYQDKcGZpJzycEZ/9S2
         JJI9lKOmYSvt92PPR93Cm9938Is0zOnsGJM7KavAwRp7AnkZ/owPPOZRrhrz4cI42eyd
         lzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367479; x=1734972279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Io5XE6RXiBUov+SaLOGtphgg3UciL24hpxxR053Wce4=;
        b=Ze/0V4tsMDkf3o3jxWNpA5lcKfBXFwEmpWNdaHJjDtep8+PDTHKBrnh/EoAfbF7GYP
         gBnn3uh/C6ObU6dOnVDcLYZZyHf67blJn+i77UEfkadG/BW9iOGSm1IQtAbxySDSOA3P
         qzv10unY1d0K+QFN96W6d36R2coI56+C6HcSSUk0gK1oArCWRCnOTq+bwgPdPzK2rVBw
         jwszvU/RWl6GaOBU43VNO6NNYFowgrpIeRueRzFIKbjOQF5MX/XDke78dM//I044wtNx
         rX2mx20AHIOkQjfRo2HZK6Cego9tjgtSC0doHtF/k0wjv1w4vmUnOdxwidve8L28jVTY
         xPYw==
X-Gm-Message-State: AOJu0YyLtF+L+EftmjQvNgovJ4WhZEefZI8yoYv/sAsNK0Ia+1d0IWkg
	kkO2laoYeyZjCz4Tageg03/8jPfEInGMnwPpMJlKnqLobcFQNbNYT6+q7eP0
X-Gm-Gg: ASbGncs4KaOy1dj05c4eqYZYgicDIysAuoBUASl/IxY2RPnbkdeoosDzLnsOOG/39c3
	AABVLaPsZ/ZweqG9DbZa8RU7qopyH5MtVpoiXQjPNKnpsnkvC7i7q12iYXfEFIhXn6x1wI4FC5Z
	O43+Dl114/QjlYf1CDnf6TmpzhLKRm3Nm587ER/tXixzNqZ4H6dl5Nq7JmLzrHEP6E1CivDF6PO
	+76QluadbiOcIxU9jIQRX1JGiSwTZPNV8d2bTP7DN/E5tW3Jm0BRdJrFYE=
X-Google-Smtp-Source: AGHT+IGh441fcBJLOZfFrBFkLq4gFExfBfGvlvC2+poduJ13VjRaldXRpFKKcicperdFwwvot2TlJQ==
X-Received: by 2002:a17:907:96a5:b0:aa6:9c08:cd3 with SMTP id a640c23a62f3a-aab77ec88d2mr1399568366b.48.1734367478515;
        Mon, 16 Dec 2024 08:44:38 -0800 (PST)
Received: from [10.82.4.202] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9635957fsm354834366b.109.2024.12.16.08.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:44:38 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 16 Dec 2024 17:44:29 +0100
Subject: [PATCH v4 4/8] refs: extract out refname verification in
 transactions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-320-git-refs-migrate-reflogs-v4-4-d7cd3f197453@gmail.com>
References: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
In-Reply-To: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2366; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=NoEckIGxQa5jQrZ0dQ7BHqCovFckF/qXPjbGFqkkuA0=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnYFjw+SGjp1K4d5N+wtGwzw9/efOnPIR38CPVg
 EJqyO3E0lGJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ2BY8AAKCRA+1Z8kjkaM
 fx/tC/46joNxf+uCLIaOD42QrR/kFu4frBNf1Ok81GWavb0gxAuuCNDNmYCeh1Ld0N6xbuVPQ6q
 BDWXvjfVTsKKZBVZLEhIwDfuaOdVezoXO7PRCwSWgXapK7ZKf8mBAZn8hSzsv0P6kUyxSnI3rpN
 CrCCumR3mXp8ubI7/xpP2eKBcTMcLtODsMisGIz+UQ8nj3uCgUnDLQjSCczud0mailjzMIy0uK2
 IGerDwQIk864at1jF7QPj7ZBg9Hkqusyy7thInfqRYYCEHACFAc/7x0rLjhLvWUuvgPDtn1nY9v
 /mmAZqmHZEM81utMSnkPVeglB7QdFwBO/jQBXjup7lRGVv3BtCMlssC10bj/q/munA4Sv3xgLKZ
 hnz2BtljIiBedTxw65OvDg5F3d4+XnxbTrp277E6dlSC8FBMbL9jMGITZhMcB7oUr7a5sbHdcx3
 nrbWIGb2XwgErYRDiusCRE9V+Wpx/guYKlteUqdJKvTmR/feXfUNMTyOwm7UyBU/1DeEY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Unless the `REF_SKIP_REFNAME_VERIFICATION` flag is set for an update,
the refname of the update is verified for:

  - Ensuring it is not a pseudoref.
  - Checking the refname format.

These checks will also be needed in a following commit where the
function to add reflog updates to the transaction is introduced. Extract
the code out into a new static function.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index f003e51c6bf5229bfbce8ce61ffad7cdba0572e0..9c9f4940c60d3cdd34ce8f1e668d17b9da3cd801 100644
--- a/refs.c
+++ b/refs.c
@@ -1196,6 +1196,28 @@ struct ref_update *ref_transaction_add_update(
 	return update;
 }
 
+static int transaction_refname_valid(const char *refname,
+				     const struct object_id *new_oid,
+				     unsigned int flags, struct strbuf *err)
+{
+	if (flags & REF_SKIP_REFNAME_VERIFICATION)
+		return 1;
+
+	if (is_pseudo_ref(refname)) {
+		strbuf_addf(err, _("refusing to update pseudoref '%s'"),
+			    refname);
+		return 0;
+	} else if ((new_oid && !is_null_oid(new_oid)) ?
+		 check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
+		 !refname_is_safe(refname)) {
+		strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
+			    refname);
+		return 0;
+	}
+
+	return 1;
+}
+
 int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *new_oid,
@@ -1213,21 +1235,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 		return -1;
 	}
 
-	if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
-	    ((new_oid && !is_null_oid(new_oid)) ?
-		     check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
-			   !refname_is_safe(refname))) {
-		strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
-			    refname);
+	if (!transaction_refname_valid(refname, new_oid, flags, err))
 		return -1;
-	}
-
-	if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
-	    is_pseudo_ref(refname)) {
-		strbuf_addf(err, _("refusing to update pseudoref '%s'"),
-			    refname);
-		return -1;
-	}
 
 	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
 		BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);

-- 
2.47.1


Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAED0192593
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734279959; cv=none; b=KCX7WwfeENK+y3smO7+s87yG/Ngl7tFWVR1wjk7Kyt0rB0gQfYqnuXN+qTQkWKUgdV8Uqvn1tnNDwlK5um53+cSAee7x57hlPpbKb6CckwXYh780Z3UonIYO1t+eEldQ/TeLumlR0DHPS86tzBZK0cnk/es0bmTNxvH5HaYaeXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734279959; c=relaxed/simple;
	bh=NoEckIGxQa5jQrZ0dQ7BHqCovFckF/qXPjbGFqkkuA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mPpOemIDDsEMTHYd06KDDWyhNK+/oH9LKpiEK88flt5RgS6jlfzOUSkJb+wuyBQ34uexQa6rLEBAEz4dFF6a2xiKtehHU2IkZXtrOx64ReZu1zRNcd5U+maMBBOGihUj+PasLW8FAJrrCz15F7GIK5d3SXPNgWXB748USxGrPbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ol/Nv/zo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ol/Nv/zo"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa662795ca3so850509766b.1
        for <git@vger.kernel.org>; Sun, 15 Dec 2024 08:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734279956; x=1734884756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Io5XE6RXiBUov+SaLOGtphgg3UciL24hpxxR053Wce4=;
        b=Ol/Nv/zoJTIaF7TIxjkUobZVJ72qdVAzE3knI268Otl+C92k0ko1XhCI9Y5FWlzuZx
         q7tykWY6oOoDHq3wvqARpCziRiI+GPebqd7Y5JJbGx5ldqXcYjHWxNGlw8FSaHYcbZ/a
         RO5K75CaGvt8+pwZjcP12srpTgh0zAd3bqxeE3GH8huucUxI1jL4tkIdObFB3pT0f11D
         EBIzBWf+YImL438SXmsbmtm4MzVN/zZmdBS/k0QOaDZTXUM/OrYrXAg/YOBSSitTwt8J
         7pItz3wWSEW3xCn1sYiiT2H+EcctcgUx9vdbSbUIbr3lnUkVqKdso227222IpAjtJQux
         HhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734279956; x=1734884756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Io5XE6RXiBUov+SaLOGtphgg3UciL24hpxxR053Wce4=;
        b=EbxeDneB54qP3MTe9w9kb72axxQOO1aHuEO2Bq9fsM3T0pQDfsOJHHa5OICj2nGo3M
         cukNrBtHXH5+P7NISPLqogKnusHvUa3Wb0K8bKdjZeeUBMXzg9En562nb4jHmU7kL2ud
         XD1eLouqTg6AWo5cI5OIxjClx+rgCizjHWbnbPy1H3cJYJHuhb4Uac2XaA6AEFMIbOFn
         JlR32IEHqBADrYXnPheU1xY3LqvLBCDUrAiG7fiBPddOgkQiEuLVLrHw5Fq5m8G92BzJ
         H3QZzMLb1kwcCoEzhi4+5Cb3fyemv6fDFTqIlvvYQY77MtMf422XhQG5QjhTdDNutfix
         fePA==
X-Gm-Message-State: AOJu0YxSMbwevdyuqYgqUWZ0WM3Eix09T+cOlhoVtwDaMLw4i+XnDS9c
	zhqCsqQSzNMAGoVBttpe+LtvAA9cCONYKFezE9sqhK0jdVM+RY0W
X-Gm-Gg: ASbGncshujoqYYJuP2Jkr8JZoily9prMROKriNqjaUmA73GPcwg/ZSPBYtnlAoKzfVC
	yg8ccD0sAqLyTcctB0HK1+KFcX/le0zM8Dlkul3jo5ltApWRFunuhCDL78cKvW0sDllELcJs8OX
	gOPSADAbQp2rHxrb8uGiKgKGz/QiuudU5kA3P83Qzjn2QY+TxKzDMk0H1/oUqegtLXWaIxXZc87
	8ozLVhOksXmpRMMjCHaamyi38xmBUoKDTSmrQlEK9Spv6rhf86UmdkF8ih5Xbtaw6vhAg==
X-Google-Smtp-Source: AGHT+IHX4TVNU4s9QWZP0OvrrdjTEBrkhVdocyz+5grGI/M+nUl+ozWx1yXvtwFU7G7Xj8+DHDGxuw==
X-Received: by 2002:a17:907:1c07:b0:aa6:7c36:3428 with SMTP id a640c23a62f3a-aab7ad158b3mr916404566b.0.1734279955843;
        Sun, 15 Dec 2024 08:25:55 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ad1asm224887866b.139.2024.12.15.08.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 08:25:55 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 15 Dec 2024 17:25:41 +0100
Subject: [PATCH v3 4/8] refs: extract out refname verification in
 transactions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-320-git-refs-migrate-reflogs-v3-4-4127fe707b98@gmail.com>
References: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
In-Reply-To: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2366; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=NoEckIGxQa5jQrZ0dQ7BHqCovFckF/qXPjbGFqkkuA0=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnXwMOpgREDkZXHPSB4e0LhKgyiQHnfmGTqIAjq
 33AKX+3snaJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ18DDgAKCRA+1Z8kjkaM
 f/yeC/90ICif0WavWU0cffLuAWqZ//1TAutknYYOxAb6uDAPB1d/FfeTmNbYvC67sFUwDPFriHf
 4OohTEZ3x5v+ozR2QiX69z50iVZSFr1yK8mn3foTJjHjSQ+JRFgKowRNBeQDBGFW55QZjOpOOgL
 cYmfAq1DcdB9V+UBc0gJxABZFVH+l/CSchPVV78+2Sef1bSZ3C/vX3dxNK6e8NafvqSY583QxP+
 kWTJu2cRhCjJYSoywiMvISg39b0iYoaUEX5dWsOV1baQ/xljNnfABeuP8N/DgRBG+Ist0aqIjPd
 Kj2+7GZXiH5awX9LtykeJ5hCOyjDdEWwEX5/HJ3LDT7fDvTXC1JuR9ptUKKGFAOrq5YRdu77OyW
 uuMUdJce7qrmmhBIBDeB9TZTcitiZ19il1L5zstqddWO4lmbxEEXrOK8/7n5i0J/Xp4vqDaB5qP
 3Ey8oO+0ScEHtKD+I2M5SpgPfMMaWCMswdYZiSlvKY2x9dWYygh6cC9d9+lRTr9HRuFLE=
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


Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D13E51D6
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916659; cv=none; b=Hy04HP4iLDgR2P3UHiNpioqLBpPB7x1LG9XNb9JmfdgcUyPUg6g0LS8N/heqf1n9y1R/Gzh/vIz0oiXEvFJCuavplAgY5eXQJuHESevbqZB21pgCb9dt7dyt8CVqRgnNhajlkjXsgn4qCOKdqoKbw4PEwHStgGfkylKiWVpB008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916659; c=relaxed/simple;
	bh=9hmCFKoKScRjhfqO/sM+O28CtMU/EzaD+pSewKN1a58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=URRvJDs0ODaT6KaEm14ERp/B2ku+UdrMsP6HYS7s15Yx35iYyB48yZ4saz5Eg24XbDGVGpoUoQw1K1L9hqFOT3skUu6ft6yHEvP5znS4GfmS6gifoSXIqvOftc8HUdTHMcJ7UmPzz3+QBGctd9OqMRE1okvCcuxI+df2V1DbuQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+eIEpVS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+eIEpVS"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so27180925e9.3
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777916657; x=1778521457; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPlWDpTehSrUWXOWCJ9JidhgaGbaVdI3x5TMBlSYF/w=;
        b=f+eIEpVSkDGFZIIFye+HteiT1WKV7ClzFd5mZ+MIBikde94LzpQrfQxDQVvS/pAxwy
         43VViyUHp4pnG8+vkdAVvWGUF86cnzUHMfMQS56rGTWsjP67AiO9BcT1KsRhTO3Fxi2n
         JElfzNGC8QPl95X6YIkH2h9i56X7aL/ZzYlqb+c4u82Jh2hKMzceXDeLH82Rnm2tf3Cz
         wRGa9OzxI2EPZ+Bv+cNhLPvxTFeo9UyGZe+/WpxfEZg/xMNfhJqkWCjmlfBw9iVAzIQR
         0zop6S/M4Ud78EOI7jrcNNKxkAvM+BkSE1golGdszlco0FvdSBcGdnfTA+4eavNHztDw
         d/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777916657; x=1778521457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KPlWDpTehSrUWXOWCJ9JidhgaGbaVdI3x5TMBlSYF/w=;
        b=YW2GSsXvv1AgOPPvE8YhPMxZVc2pRjPrk8maeexJTr5F0QnGXgNMJh5PuX7JTOY9fl
         JHvzzQWYl14Q6eDO+qB5BsBXLadKbUOfJReENAHA0eR6iXhCdfmLMFP6CI0sGsxGlThG
         zl+AZ/oNUgcB001ZWVF7mXlms8lmGoX4bUpN9QMJ/fXv+MoVhjamH9Nau0CyJ8MA8uX7
         VjPPO0aE4l5mUNiJioOtU0kcMZqJCSr80rNkHM7D9nsTSNLCDKnGpqwY8UEpFcrmmY4N
         /ElDEZsltEeqrxNL+bbEtYxhsoF60efwl2Rpfb5neRpLk5RNZDFQ4D9rO1RgAKZAOWz1
         4qAg==
X-Gm-Message-State: AOJu0YzDcZkVEgsrEPZfElduqTlZqwYQw36wFxDqw2wGoVdLnVuxJt5x
	AHr9uqNq/+omq28FpjxqQaM8+xxAXA1l8OqyrrwtU+Vd2zrLBwdqGR8N
X-Gm-Gg: AeBDiesXiUNfo/HYg7pYdHHFmgky0430/VJ7B9ensetFtgUqYVGmYyyVe6BWDMY21QJ
	XJnKFaJffeYqUA3/3UUAjUjh6JkZ476AUc+/srKQGjrblGMNb+TcxaFLokN42vOqbbE6Yaza02R
	bXJc7oKwwjmv5XEJOYRWGK17e0Zkrq14qmq2dEWTwyCAFm50bnVA/MP9xOs2A0GFvsulp2r/pEQ
	yIo9hF2gNAFiTcVTJx5h1XlOiNvR6LoekccYawiWmj5O4ysBYlg+/OQkTEZcsbv08NCX6PU8WLU
	N5ltyI3F64zJIjoSY24LBsdgjpjRjfFfrtnacsnbO+LmT29/1Uhs16r85+9nGC+HHpcq/KJczgT
	Nt1ingO4jvCumUNHncYdkzfxEYfa67QyGBJvh+1P+gdTc4oeRsLUURdNcO4SAZksST/2iiUpZq5
	kyeXQ8VOYBaPCFOd/GCEr0tHl1jOe/UXboTb6O+bjF
X-Received: by 2002:a05:600c:821b:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-48a9852f366mr171051475e9.1.1777916656377;
        Mon, 04 May 2026 10:44:16 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1f8b:93fc:106a:20a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fc1sm299297675e9.7.2026.05.04.10.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:44:16 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 04 May 2026 19:44:08 +0200
Subject: [PATCH v4 4/9] refs: return `ref_transaction_error` from
 `ref_transaction_update()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-refs-move-to-generic-layer-v4-4-936ac2f0b1a3@gmail.com>
References: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
In-Reply-To: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3225; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=9hmCFKoKScRjhfqO/sM+O28CtMU/EzaD+pSewKN1a58=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGn42ukxTz7M8OI7kwjTZctNJTJ4+jgSg8KHc
 i0FvjbFGNSn04kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp+NrpAAoJED7VnySO
 Rox/5nUL/3FMPA8lLGeLZPWEkmez+9w7BS4KNsbdvLwCHWOEIiAp/0QFAoUlGXxQeWViTJFuAnz
 TV2BvrxwpPigRvMf7zaq7LtMJRnXVjSFaSxIyZyP/tlSaSeYncBS1tNx6cI0gvo7MAN8s+4UEBV
 1vXx6RerZru3kETHQXbDb4HDHnBydW1Zgg9i1uK1aDQY3dU8oBXDNDTpUEDVTSARuVvLSjie6T+
 FihHNN69ulw0oUetWeVz/L3/Z8L1y9pygiHRTtC5KVo9kGDE6vmLxu0uuojPhliCfCNg7KWxYY2
 RUGsFqBXXuWeoT5nvYAoxNGSELX6h0YGuojxuNvGSvHAUaJK33zolMX05GmpSKLSJfyNSdSyj0v
 BD0PaIRuTUb0i18+hJiUF0g/RVx1MWksYtgv9sliwjxlvzsGnNBgYRSEBgGyGrVWh7bl6jsMxg7
 P1tQet1cSAovBxUG5G6PRYcFelyqwr7cXhG5HPCMBLbYj0SQ6XTOOAxiaRTlXcOF20FlwLTlDQ4
 vU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `ref_transaction_update()` function is used to add updates to a
given reference transactions. In the following commit, we'll add more
validation to this function. As such, it would be beneficial if the
function returns specific error types, so callers can differentiate
between different errors.

To facilitate this, return `enum ref_transaction_error` from the
function and covert the existing '-1' returns to
'REF_TRANSACTION_ERROR_GENERIC'. Since this retains the existing
behavior, no changes are made to any of the callers but this sets the
necessary infrastructure for introduction of other errors.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 20 ++++++++++----------
 refs.h | 16 ++++++++--------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 6b506aeea3..efa16b739d 100644
--- a/refs.c
+++ b/refs.c
@@ -1383,25 +1383,25 @@ static int transaction_refname_valid(const char *refname,
 	return 1;
 }
 
-int ref_transaction_update(struct ref_transaction *transaction,
-			   const char *refname,
-			   const struct object_id *new_oid,
-			   const struct object_id *old_oid,
-			   const char *new_target,
-			   const char *old_target,
-			   unsigned int flags, const char *msg,
-			   struct strbuf *err)
+enum ref_transaction_error ref_transaction_update(struct ref_transaction *transaction,
+						  const char *refname,
+						  const struct object_id *new_oid,
+						  const struct object_id *old_oid,
+						  const char *new_target,
+						  const char *old_target,
+						  unsigned int flags, const char *msg,
+						  struct strbuf *err)
 {
 	assert(err);
 
 	if ((flags & REF_FORCE_CREATE_REFLOG) &&
 	    (flags & REF_SKIP_CREATE_REFLOG)) {
 		strbuf_addstr(err, _("refusing to force and skip creation of reflog"));
-		return -1;
+		return REF_TRANSACTION_ERROR_GENERIC;
 	}
 
 	if (!transaction_refname_valid(refname, new_oid, flags, err))
-		return -1;
+		return REF_TRANSACTION_ERROR_GENERIC;
 
 	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
 		BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);
diff --git a/refs.h b/refs.h
index d65de6ab5f..71d5c186d0 100644
--- a/refs.h
+++ b/refs.h
@@ -905,14 +905,14 @@ struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
  * See the above comment "Reference transaction updates" for more
  * information.
  */
-int ref_transaction_update(struct ref_transaction *transaction,
-			   const char *refname,
-			   const struct object_id *new_oid,
-			   const struct object_id *old_oid,
-			   const char *new_target,
-			   const char *old_target,
-			   unsigned int flags, const char *msg,
-			   struct strbuf *err);
+enum ref_transaction_error ref_transaction_update(struct ref_transaction *transaction,
+						  const char *refname,
+						  const struct object_id *new_oid,
+						  const struct object_id *old_oid,
+						  const char *new_target,
+						  const char *old_target,
+						  unsigned int flags, const char *msg,
+						  struct strbuf *err);
 
 /*
  * Similar to `ref_transaction_update`, but this function is only for adding

-- 
2.53.GIT


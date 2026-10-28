Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180888;
	b=jm8oH2H0FptQw6+sgAh/4e+t02K4HJCFyVUSBn+cGRDMbFZZd9drOM/b5vs5f/jSTHke
	 t3lu61sNCEzVKmUNVnuWnXMg8ta9YtYbLMpzBFJR3jcru/dqoLQM2hWUyyRSdXtTxgT8V
	 Z6kLKqaHAttvCdiLEha5TmcOG9u9wKW0kCUQvMhQea12BDU65QtJpfir/IRF9tnNaDxPN
	 bcJetTRmEjXLMUB9tp7MKlmaDcVNkxS1JJ3Epxj41KMZY2uWAhZ28HH+SbTEZ+Kl+jUn6
	 aQeWgXLVMK9yw/IgeiyRlMZ308d/E9X/xbMcRSE7Zg7e32NojxH9LNp7e7npWZHjbNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=dYW6gQmsJQzZTizI9JOazrwxLYzXfEbKoyMsyD5hGhM=;
	b=NLxMSIuiFb0QkO8QoXb8hwUcbsPQRtjBAf3ajbyv6GKj7ICCKZ4+8DBZgHJHy0ZGp+kp
	 IWukM43jE0pM0kM3zT/P5W+fmhuzyTNvwY9kFafqG607sAbPdZ3eKHPes/NDr5tFYreNn
	 mr9VWHGhIP9eR9YCJI6I411A8VtiuuLKjJfJLfcYoHs4rM0NvxD8Jc10voWzDRrZ6ecuN
	 CIJ6XRJv/4tAyO4bzgkJBTq+9y+hEzWFsGrskAkmbVUFnw9BY2I8dTKnb+gkqvFMUz7Rp
	 /82441uf66aqovjzi8qEshzu7239cH8fxsG3w4ECNuSKyRAIhA0K+zL7Uu3YSSOqncA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jMrYIGY7;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82260606A337
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 09:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82260606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jMrYIGY7
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a208d93758so7513605e9.3
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 02:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180887; x=1793785687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dYW6gQmsJQzZTizI9JOazrwxLYzXfEbKoyMsyD5hGhM=;
        b=jMrYIGY7MdF5lnX+8APjobV7ksWRGEIxXXobc6pKXHMi9CG0JYvreGAye1h+xJb9Kf
         PmMjNRtPnvFH/0a51OYr4exT+6azutd8escEjH1hvmGpg0YxCikq5AT/qFBapI2GdKrQ
         5r4JywKrEs4fvpEqtngs6AOgaHYRV0SIbieeS7rHdZMz+d98bTJtbbFcrYVZ8DcxleTh
         MzH7QHwyI1TBInscCD1wzu5vubh/BjRg3ZtQ1BwA5QC0h7iqm0ond9mf7n5+YBb1c0I/
         VnSAd2oYkHGDN7J2JioGtXuot3CPMivHxrxQ7jmDaV1UXsdEYxToDgpDr8vFOS8i7Iw2
         4svA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180887; x=1793785687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dYW6gQmsJQzZTizI9JOazrwxLYzXfEbKoyMsyD5hGhM=;
        b=mHyYz6syWrvAFwm36pQkK3PAhjzIw/KUPwSu2nb3BdpfBCXhCmoN6bpfl8XoviWx8/
         NDNA8XT5eyfUbbJEnPZA7K91FURSmAJuoaZZPhbynq9y8ygOzmbXYNuBJx2ZDvnD4NT/
         rTiOxCgAuVzgxXznyk0kqRGXzWhssswjsbjXCCZXXDpiab7s7qu8Ndl6Dbizpb9ihMfd
         spL/ylNN+O8EKW3oDt/gNcd9sADRpLoRMm9o2svOvjfYqbVOaVGiR5ZjJWkqnJvRrqv1
         BMqhEFS8R0eevefJIuc9YycvMxaDhLV9bLDKV+YsBu4kt/tw587wkB85RE45nsMpvptJ
         nUzQ==
X-Gm-Message-State: AFq9FYKFHjPmw6RLHxz2rKE1oyi/XOABw/IIeGcHqoR+V2Sg4j/+NFiQ
	l6xv+hmbKBQQHu/vveypgTw08GSuLaRLk6f98TYzA1ctXoqkp7NKz7iL
X-Gm-Gg: AYBFou0tdjDaJH8lT9MBHgqRYlzOkf/BQRA828xS6pCKSSj4sL9CTJ64/dtTw40x3SI
	FVDx++2Gb69lHNt0cmK8GF2pb9Ir3T9Bxe8DxX5mDpitZi4Yr/MRP2y+X6YZM1UOdCJF0KMiVmn
	fz2osAxzH2rLz9hnmAG/ZLPXgrxGC+GnSl9Rp1rSDpt3N3ZCT8445MaA8/dKe5Qoiga4/qk1aWK
	jjOdK5UPibu7zcZcXgkCXujbtd9Bxc07KEScjjERVeBBiM5YYvzloi1CYF6wwR+kYQ49R45ob2X
	yRnsyzrQmurZPKlLz6l9HbT4udm94egZsdUIVRgZQ6d9UzoqWtcvDhGDlsUCse1ynCx0FkZWaG7
	zRMxMt11Ex6/F21IPhG1rat2AO6HVlR2eWKx6WjozPAkiEHIKmDL4687wd0BcryRBseNBOGeFNH
	a6tJS0jW+gREh/COfAVKQHBEIhzXI5K9kA2MsNOK9+CdR170aX9w+GaMf3aYea7A3wwXNpAuGtR
	I8AZMw5FTVTwulT9+yJtiJMPZ9+MnCDDaImLGgdPag8vMx9XUPuY46qJz37IPxwkQUQylXLNiiO
	8cvOyGGnM/VIhLAcx5kqIlOvwGd8/uUnDlPzNTM/Kho6i6ptqEGedOWip34Gpzahnl1mSQcqBuU
	4j0mRZDGd+NZ4dQ==
X-Received: by 2002:a05:600c:1f94:b0:49f:fdca:c361 with SMTP id 5b1f17b1804b1-4a9663995a8mr36929385e9.12.1793180886603;
        Wed, 28 Oct 2026 02:48:06 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:13d:528:68fc:144d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94fce50a8sm26496985e9.4.2026.10.28.02.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:48:06 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 28 Oct 2026 10:47:59 +0100
Subject: [PATCH v5 1/3] transport: add `transport_options_release()`
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-799-shallow-fetch-with-tags-v5-1-7c43cc9ae810@gmail.com>
References: <20261028-799-shallow-fetch-with-tags-v5-0-7c43cc9ae810@gmail.com>
In-Reply-To: <20261028-799-shallow-fetch-with-tags-v5-0-7c43cc9ae810@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Justin Tobler <jltobler@gmail.com>, 
 =?utf-8?q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>, 
 gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2961; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=uH5WpN8NcJbb8WZVru196ipoltgj733Eo/zmEt1P8KA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrhxNTfUJ3hBGHtJwozvXZMTbKfgZkek0/SD
 /HovgvMfwj8c4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq4cTUAAoJED7VnySO
 Rox/UncL/2fO4QkjztCqBT5TIcZHQQyyc7tfOGtoK7VzpTnzvaynHDzqfFFaunEeux0y5kbrTEV
 CB/jEiQGxadX9PgJeJ+8li1tVngOLQhqcv0/OGYIkSJvZpABPQffy8DzZYnD9eqMSTdn0dnBDtE
 DkwpB8iSwZ5htosnCsBGV8L9nXIN6cU1tjG+FdvKaidLRBol43tn1OtAUrSMnux0WmcjnOv2ore
 +F7f2m7q2x2NxoeZB0APhBU+t+GvHW0o+ZKEnILschqLf1B7aSyXaSOYFheYVQkI10evBDBnNUo
 2eLPenhYTjPbTAYwAol5zKbzwzJ+v6LTsfxh3T7H+kboEg3/wFU/WXFecQeXPZF0rsTlGPq0e0P
 VuJolWRx4nxki/e+z0V0I3mQsXOU+UNWGxgkscISFf5+agHiq7mp0qV0gXSFqOOf1Lbt7vlG017
 Z/kJS9yC81mTNISZV//ZjwjyP2GKR9SJBHahoDngqcfKKyhAJZwFRj7SIirfW3xq8ru9ILOY+U5
 pw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `git_transport_options` structure is used both in 'transport.c' and
'transport-helper.c'. But while the former specifically clears any
associated data in the structure during the cleanup of the transport,
the latter misses this.

This means when using remote-helpers, data allocated for the structure
leaks. Introduce a new `transport_options_release()`, which acts as a
common path to release memory allocated with the structure and use it in
both files.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 transport-helper.c |  1 +
 transport.c        | 24 ++++++++++++++----------
 transport.h        |  2 ++
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index d5a064d386..14d179e0f6 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -401,6 +401,7 @@ static int release_helper(struct transport *transport)
 	refspec_clear(&data->rs);
 	free(data->import_marks);
 	free(data->export_marks);
+	transport_options_release(&data->transport_options);
 	res = disconnect_helper(transport);
 	free(transport->data);
 	return res;
diff --git a/transport.c b/transport.c
index 25e2c14a7b..4491443b28 100644
--- a/transport.c
+++ b/transport.c
@@ -1017,6 +1017,19 @@ static int connect_git(struct transport *transport,
 	return 0;
 }
 
+void transport_options_release(struct git_transport_options *options)
+{
+	if (options->negotiation_restrict_tips) {
+		oid_array_clear(options->negotiation_restrict_tips);
+		free(options->negotiation_restrict_tips);
+	}
+	if (options->negotiation_include_tips) {
+		oid_array_clear(options->negotiation_include_tips);
+		free(options->negotiation_include_tips);
+	}
+	list_objects_filter_release(&options->filter_options);
+}
+
 static int disconnect_git(struct transport *transport)
 {
 	struct git_transport_data *data = transport->data;
@@ -1028,16 +1041,7 @@ static int disconnect_git(struct transport *transport)
 			close(data->fd[1]);
 		finish_connect(data->conn);
 	}
-
-	if (data->options.negotiation_restrict_tips) {
-		oid_array_clear(data->options.negotiation_restrict_tips);
-		free(data->options.negotiation_restrict_tips);
-	}
-	if (data->options.negotiation_include_tips) {
-		oid_array_clear(data->options.negotiation_include_tips);
-		free(data->options.negotiation_include_tips);
-	}
-	list_objects_filter_release(&data->options.filter_options);
+	transport_options_release(&data->options);
 	oid_array_clear(&data->extra_have);
 	oid_array_clear(&data->shallow);
 	free(data);
diff --git a/transport.h b/transport.h
index 39193d0077..cb262ee3da 100644
--- a/transport.h
+++ b/transport.h
@@ -59,6 +59,8 @@ struct git_transport_options {
 	struct oidset *acked_commits;
 };
 
+void transport_options_release(struct git_transport_options *options);
+
 enum transport_family {
 	TRANSPORT_FAMILY_ALL = 0,
 	TRANSPORT_FAMILY_IPV4,

-- 
2.56.GIT


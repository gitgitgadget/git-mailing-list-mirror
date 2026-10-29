Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793277955;
	b=nVg21i0+Zv9w3roBm5pJvO3RXDdKuZ8C6MdZNXXkyzZi2BrG+2gKJx62w5gEq6inVoo5
	 ZJ3YzrF2k/XXv8s3cb63ia34yqy7mdARdtp2nWo2bpdJ7c6c13o8hWXBKjnxGZUlafrHe
	 X3NjzRqgX8Mhf7BfhyrNAOI05Lr+Rg8AAIV9LGA9+dBOLnhPVVs/JDufOKaNwLgq0V6OO
	 uulSHbuKMu8SU2Gr+0IZr+m1lmGMLz4WEX2wRuSQ2FJhb4wkgDEbQSIESxwKMVkPhGX/D
	 r488qmi5BJXQoGPkvKV4E3Ln/6kvXrGn7fd4IftENoA65D5AHrEAEaU7UFv3ZSyNkog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=x2/3gWv80JY25P050R7gkkYuOKyq0BXDjcSuoYiCj/w=;
	b=zLQMhrdJ0knn8z6FyU2pltmANL6tZKDnYulhsy2z1kApulyJaGsThrpIpUcp2o01gFqY
	 xm0qWtM0Px0aTXywNyB68L0haBZcc94vaPeEQlWM11KV0+mcKJnVTSJFlkfLiolkIqL8+
	 TeGOMVYD3s0mg3KuB84nAHNFvNxLqk8bBtfnmvXasb+vgvUX5QPuCLJ9ik4TAC9vUBbTY
	 Zn+wNKdi2uupZ1maUtPQg+mrvA0t8T3E5E+TCPlCTxKapmDuP0z0vULbW02HIBMNotkA9
	 vOJ20DtDiyRox6G8tfI30c0K97s9jmPCBvwuhu6YROXRKyVxHm9eRO4jq2+mHfvnPow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="jE/jLL+N";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AF4606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 12:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55AF4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jE/jLL+N
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so17586835e9.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793277954; x=1793882754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x2/3gWv80JY25P050R7gkkYuOKyq0BXDjcSuoYiCj/w=;
        b=jE/jLL+NYZCxngi6EVugj/ut/T6ujRdMeUavVKs5hrORqZoPT9CBTcXPxb/vVrkzAD
         LjY+QvzlUV/ohD7VdZUclKwZHIZC48CPl0omcRH64VG2fm0Bp/RZTU9gSubCgBocSWSi
         cHYLDxppqgX7um+L2FKxKOBQ/x2ttuaom7XIWL7u7gd6qkBXti/zdMXGvPUj+wkka/Jt
         O+58mUnA8PUYmMnFqKSmh1u+OkTyt0N/+CBcVTb+HoBKw1SGnwas2tgORDlo8y4a7uZW
         +h4u0n0ruOjn9GlEsqr+lxkIGpJXayZbhPLK1u8J9pgwk7S/8mYLbWVoHOwrFwKXVLyv
         8Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793277954; x=1793882754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x2/3gWv80JY25P050R7gkkYuOKyq0BXDjcSuoYiCj/w=;
        b=jeA20jsizZ8JjoZBRi3YM8z2EkPTGBjvMaYateI8GLHJadcx063g+KvAlXX5i7FT0i
         Nsksc0vYZ3wEIeUiR9SkUAVm6AeHhBlQM+onvlIht1isyKnP9Y3yEdQApZjhOuc3zKlX
         Ltv8Sj635GQ6spNKAFEErcL1CIaFaS/D4KK/Ir2e/kH1p7gdW5ChX+FpvugcjNRKMTZo
         //Enx2BKYM0U9PJjQgjI0J0GQPMJfQY2EpZQ2zXwqpC0BhwoAIKLGVsYX6wihyQBjDhO
         fcNKVGDD+GW3r53hQEiviTaVMamZndRSOZTayFHyH2rWEiZPrvkwHYXhLOywR4+A2/ta
         7IUA==
X-Gm-Message-State: AFq9FYKnPn5QnUzeWMvmUiHi06YoNxK3wEe2DIdX83G8BxsrZWVDfEHN
	d5dKRKtmNnLroIUXd2spmE2HVtfFWRbRcuOCzHflekJ4YZxapyy8m/72
X-Gm-Gg: AYBFou24MqWk8y8dP/p+KuX7ACuQ52dWqQRsrZiFWHRYdhn1Vx0JV+LywN4Jn1ufile
	cJdV/g50u+19m9znpVByZeSLQjvKWNPU09ICwkYm6FL4Y/GABYZipOR9Nkl2wHZR1Hvf1chAnpi
	C5Snl+YRarKzvR8/tykDjLOc5ecMF94pL4/PuNvTvwEY2ZlmSdecaPrQABUM4Yk4LHqid3MufHu
	10/0cCMHZcf1OMW8NJG1vLtdvG2iT9m04Bm6Lf74RWMgCJyuRJqXJnYr16cm/lj+tp/oOSbWEwM
	G7khs2N/ManPBfeq1f3ZjXFImxHAcvpY++gop8BcEXS3M467wnbwYO7J5jVDOcZg7i4fNrUe3T/
	lHdpRV6Y30fkIUNp8ot7i4DOnWU7j4JeiU2jZkUpSKazvuSe+6jwGmb+CXuNfQ6H8yXgFE1VRVi
	klWpHvo9vOmAGWaIsFmZrn8Vl2YGqgffJbaO1yJUYAaO+PLonr7ZdQ22ZfmeKUX+S6pMaKW3lUW
	+6Qq5x1CZBP1wKfd1QIGsRO1K7L7ntTUrKehy8DyBXfB5xRD5IKqqTuv7USYlxkKLhP9bkP1Co4
	UrxUDxrZLDXi27E4Y89++25aS1Felv+opDgrP+OdDEqBP7SZry8cZtp8Bmz9Zk3b4tgWXSov6za
	Vcce/j6MLrpIFXJk=
X-Received: by 2002:a05:600c:4e90:b0:4a7:7f3f:6f8e with SMTP id 5b1f17b1804b1-4a96179c513mr119605755e9.0.1793277953600;
        Thu, 29 Oct 2026 05:45:53 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:7938:fafa:2306:bf7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a930a63eb3sm106593635e9.1.2026.10.29.05.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 05:45:51 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 29 Oct 2026 13:45:38 +0100
Subject: [PATCH v6 2/3] transport: add `transport_options_release()`
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
Message-Id: <20261029-799-shallow-fetch-with-tags-v6-2-e6ddd5201def@gmail.com>
References: <20261029-799-shallow-fetch-with-tags-v6-0-e6ddd5201def@gmail.com>
In-Reply-To: <20261029-799-shallow-fetch-with-tags-v6-0-e6ddd5201def@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Justin Tobler <jltobler@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3067; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=MOPI8Qynnan0UGaoFOcRr08Yxu+RCgoQh8mgJOz1pnU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrjP/ewHItGZmycPs6ovvUu3+4j54LCNlJoF
 24QUe+SzBUZ04kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq4z/3AAoJED7VnySO
 Rox/Q5kMAJeQtGZQb6iqEGELfDLOkNFCRYP5Kfm5prEcFFqP8u5IjrjrUX4xVmouy/rr5UbSfx3
 AlTgOMUmkotNKpFT+0ISU+Y+ndTg3AzF9FeWk9EVnY+gVySXZsqiAX7gMrG9BhKJmpWudgz8DN5
 JnZQ96H5z1Q4o47x7QLsBp0BdctbpRlxIQ+GQyzqP2ksMhraV0DmeizctiNMjF8+aQVU2Gfr4xa
 Y4ZmQ9k3dcqCz54VT+j/jMyTBJlwmgPdwYPAPQP1zCVtZneyXwmtExe/XuA+88Cd43vMK6Q/Jle
 M7oUhP88qliRR+O9S3tD/iq5xDiblvE+R6DMMpkCzMQ0c8Zqg5Y9wuAfSQSAIqWqCoixuIMrHZx
 oU3k2pE1Av63t9igRgz86UK677grMl0cnFGNJPKAvYq3KPjxmAUC7412WwZzd2hsIkCQQOtwU8I
 iezmIbogLMk4ifYOJTG3t1SO6OELqx0Djvj5rLuBPOeezs9mccHpwA+VKGFJ2WycuAOatpU21f5
 iI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `git_transport_options` structure is used both in 'transport.c' and
'transport-helper.c'. But while the former specifically clears any
associated data in the structure during the cleanup of the transport,
the latter misses this.

This means when using remote-helpers, data allocated for the structure
leaks. None of the existing tests capture this leak, but the tests
introduced in the next patch do. Fix the leak by introducing
`transport_options_release()`, which acts as a common path to release
memory allocated with the structure and use it in both files.

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


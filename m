Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180890;
	b=NeL2foAvLbZk7WZ9I4xK3qTHNujHIH5qx0vD88eluaBj9NZP1yuo0f/06jOiHWaVBn07
	 5kZaD7M9q2HhW2okBj4WYVYYGq74S/gdE13XEkQGTLGucMdUjSSIfrIVuEQWIbQeRPRL4
	 4T8hBljv7nv//peJYNtb+AVOmHacPQBbb7tYBEIX6yM6MBO4Zoayc4c5QL5SRUxcWQORV
	 phh2+wfDGEy1tEAjEiGwYAGP5UXxgY+GVZdfXQXYHigtgkIqh1YrsucvNIovfghmdo4Tt
	 FJX7uwPlcGQI9JTS+qkudWbfvpk9ut0QWpCqnFp0apK8EYADMbTwbSCwezDITQ8xtng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=zkCKVQFy/+kjPeWH+8MTNbYacx3QbALeP3v2s1X+6HU=;
	b=WNpz+J18dnQR0rue7WcXT4dxMZLanhn92ZrSpUwk5WJcvdGf1QtF5XKp1NWxeuHogjjZ
	 nk4MyawiXfULikz0lc/Zjuvpslcka6bKGuaYrtrJvQkvQlxFFKTYPa8kewo90zNVeXLk5
	 SzI6Y5PCFD7CoGLz23l5sKoTfA6XuIscwf7sT5BQXWmNcvJnTtHZYEfQMcga5DutQlAUU
	 FtgfSQ4FJM8ajQl51ZjJzWD83ciuXj2D9v/SqcOmCcvxv8K3st0Z9pSUcD47V98jQlTuW
	 ikXplrxH5RJCinQ3fM/wC1/VOu/l8RUjwmCzv4QCklj+e7R3Dm/9XnBq6MrbQy5k2dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ktoXw5ei;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4CA60A260B
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 09:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E4CA60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ktoXw5ei
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso5609235e9.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180889; x=1793785689; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkCKVQFy/+kjPeWH+8MTNbYacx3QbALeP3v2s1X+6HU=;
        b=ktoXw5eiZSY42oA89X+Ulz5EzFwEDKgP5kyxwVVZz5MThVeSyWv5ycfj+TaV/2+oja
         W5cMWj0vpQgqyZPLH2MT35S4kCjuPPlJP0oDljyFGCVeNcWEESXe4y6hYHvE5Gy7OwYk
         NWZ2n/e4RERpgdrmpXf9UAtsRy0BmqItSeim0VFr8cNfYuPmwmj3lfhBY0CIrUDdJbrp
         y5ghhIDJrlFczklXdQafAJXxmti5cj8dqACmIuoWOMI64EHtqkSCVg8Tb7zjCVPflrIr
         G/5ddN/F8ABaHv1DBXT6+A/uBoAKifARXRdh3ern1zoJNpnYXnrK6w4l+DnkqeL7oQwN
         xxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180889; x=1793785689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zkCKVQFy/+kjPeWH+8MTNbYacx3QbALeP3v2s1X+6HU=;
        b=XdE1mAiL9kpq5NZk8ZNJP072RN1TTH/bD/EW8hxY5LPL3JujDdN+g5TBmXdLNqJd1t
         mUqLdLQcGICsE4Gi3XJ4ZW2rkf0+pL1aHQ29yf2eV8NlfE7Uk9shUhnh6EccdmOwNjYA
         ceDOzGzg8yvs7pmfAmePFumsfEwkBAd5GbyZ3nhjM83S+UhwaccAo2blOPbAnmtzytpr
         5zeruDplrVle6sEFMVL5iF1f5gl5yU+V8Utvbu0EkN/m92n0uNyZrnpEfrgqQJapKfDB
         2cp0PTKLf7FBin+b0bVgHFAsWsoGhDRwnFLw/PG18X0MqLpwjyhXxRH0jSlX+pAyQbFp
         PUyA==
X-Gm-Message-State: AFq9FYJwvQyjzLX5k/SCPjWuozdIfr+UV2WvZm7939NIpJ2AJxb2naN/
	FfK+oVT/0dgNDNMGAX5cF7Er0844y88QptvY9JhPzGwgObk8cGPUpAE2
X-Gm-Gg: AYBFou3Q9XVT6IbhGoVXC8UrFbTnryBTFj/E+alYjev8IrR3RJd+GJfAM3kJUYuDxpa
	pmy1PxLqGVKUwmE2dI0ZG2KDfV3S1MZJIbySMocbghl11gdffOw3zXS/V1OdQPHKkQ9eY3dv8qn
	nKm39G0qW4kBJnv/BSYy8T+KZUOT1OhnGcQHKznnCNx3L3DGJh6sK8Mjljqq3685sGHynjMLzNx
	Ikz+4DVP7B3mMNT6IwYbo0VPpvg+X6bBWfFKK8LC/fxToM7YEfImhJ53Y11tlkLljkNBVnnmn80
	7dzaL6n2GJXBJ6XIKukaR3QODWW+rkh/IiHukFs6AhptdsmHq9TnVDWO+4yGITjbgzyq+3HgmlK
	jsDxX74B+NeOv77LOP8crs5NfMHg0bgXVAqEfiVyB0T+CWh/Hbsc45t2vO4yU0E2mucYh82BLzB
	2db8TfRpt5+C1rVgxy9fiI7JWdeLlJICFH1l31/aAsTNK+uCcAUz3k7PhXhqQOR5MlybbkIRB9/
	GtVazvFxOGhB+lrefuM2BMKfnjC0tcjFEJY1BW1BJkATB+LdQBD64/0hh926liw90hGhv4I/zlu
	ru7ixTJt12bJchp8y3wwg7d+A9KSSycAytEGIZHoolEN/CWJCpLYjYulfk2hGxx/mRw=
X-Received: by 2002:a05:600c:3541:b0:4a5:a5ca:de1d with SMTP id 5b1f17b1804b1-4a9675dc907mr37104165e9.30.1793180888631;
        Wed, 28 Oct 2026 02:48:08 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:13d:528:68fc:144d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94fce50a8sm26496985e9.4.2026.10.28.02.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:48:08 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 28 Oct 2026 10:48:01 +0100
Subject: [PATCH v5 3/3] t5510: cover upstream info update on fetch failure
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
Message-Id: <20261028-799-shallow-fetch-with-tags-v5-3-7c43cc9ae810@gmail.com>
References: <20261028-799-shallow-fetch-with-tags-v5-0-7c43cc9ae810@gmail.com>
In-Reply-To: <20261028-799-shallow-fetch-with-tags-v5-0-7c43cc9ae810@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Justin Tobler <jltobler@gmail.com>, 
 =?utf-8?q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>, 
 gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ApGjIQTPJl39n4oFcIYOaLDn0t8VDWHRxrhTefXB+Fw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrhxNSJTNVRLXw9FvvxSr782qGX/pBJnNBUS
 mA35RaQVUzasIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq4cTUAAoJED7VnySO
 Rox/CqEL/1qVGN64V5OoXoHoIt9OldYC1DQ4mWTTXo0h7A1KljIvt0vIA7T5W5p5LdWsojxEj/y
 BhQDHsgkZIX4fvxvwbhDLy89354p42BmyPzwGYTFBUlq2wjUkYWLlxeMJpWKnCI23ZJPos0FwQS
 VJvxT3PH0NesZbg48mYkXdo/X1SS/XTjaekSJ8bhuQZqDt3wKdL8pRdRapz1xXsbqFaAuRY/mnC
 ifzZciGHLPYgbq0fzXxNahMKUKUWfDWAIEEJp5ZvGb4PzCF2Qz3odp04IgbTGOlJjzFWRza8NaA
 jEBQIm2u0FXgDvv7opQFRmoXWYF7w87SeqTQFIIrBfSzKrk5LmVY7G8xsdBDoZ2pXkhiKjFDP5i
 1DGJugmzOhNn0y2g61+SOPh9HSnY3rl84Bs/7g1QMLZm113woJhCWGMsiYWvtrk4fkTm+v+m4kl
 nyhlddtfN0CZ5giwGaHrjFaYNc0eC6bCHnMxfoZisOvgCxh8ilTSvRhDJiWzI9zJGBZyksFcaE5
 As=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

git-fetch(1) performs reference updates in a single batched transaction,
so individual updates can be rejected while the rest succeed. Even in
that partial-failure case the command still performs the remainder of
its work, such as writing the upstream tracking configuration and
backfilling tags.

We have no test asserting that the upstream tracking information is
written when one of the reference updates is rejected. Add one.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t5510-fetch.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 7c1f8405df..ca5f9642fc 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -2039,6 +2039,31 @@ test_expect_success REFFILES "upstream tracking info is added even with conflict
 	)
 '
 
+test_expect_success REFFILES "upstream tracking info is added with conflicts and backfilled tags" '
+	test_when_finished rm -rf base repo &&
+
+	git init --initial-branch=main base &&
+	test_commit -C base one &&
+	test_commit -C base two &&
+	git -C base branch foo &&
+	# Backfilling only takes place for tags which are not pointing at tips.
+	git -C base tag -a annotated -m annotated HEAD~1 &&
+
+	git init --bare --initial-branch=main repo &&
+	(
+		cd repo &&
+		git remote add origin ../base &&
+		mkdir -p refs/remotes/origin &&
+		>refs/remotes/origin/foo.lock &&
+		test_must_fail git fetch origin --set-upstream main \
+			"+refs/heads/*:refs/remotes/origin/*" &&
+		git config get branch.main.remote >actual &&
+		echo "origin" >expect &&
+		test_cmp expect actual &&
+		git rev-parse --verify refs/tags/annotated
+	)
+'
+
 test_expect_success REFFILES "HEAD is updated even with conflicts" '
 	test_when_finished rm -rf base repo &&
 

-- 
2.56.GIT


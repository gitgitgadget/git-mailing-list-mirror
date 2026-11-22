Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795361791;
	b=ArF+Wa40J3jdBPNJcN+WLK6KLYnyyLOvOJHHxXpO6lfxkSC2k+mmrUSJNluk7jm/k2sk
	 YN56RqbH4yQpJSU/7tctwjjZLa1LjTlGp+R/5Myo27vwa5QGPeABGC6CGGWFuxzNfxUjT
	 nWt62KEgm7/0q/oddv93jOpUDl/GJXHbmqStFMbz9kWA7grWb3B+2Vbj9iZSJrz0gO2O8
	 Em9oVsfGfBCnbMtq3j72Vi8SChv8r57ai7Fh6YBVukJWMptjeCPuUuNeayK6G/n1/ePBt
	 6FcbHi5lzfY7MEejdiB7BFzaz/JU8s3LtDUP3kRJr8yyMesckf58GEJhWfZTbB/x84A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795361791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jU2YFwjvT7yD+Lv9DHlYxCDT3BY4fzqytSkt/yb5eUk=;
	b=Lbt2BB9wDFOTgNbiFduF7dlOUtN+/HYWRhdPu9rFo4HOLcoipR9LeSFic6hOOgF4yOAZ
	 ZnRrI4BHrycWljegjKo+cJ6Az0KNAJz0Axo/LnvSSLD3yd3MfEKkC21Be88UZkHabEo32
	 W/zRSa8k7zOb6BQ6h+f37zA6oXANRgLfwE8IpMrnaQTKrAWv6OETjWONJfJVhNP4MPjKT
	 i0Bi9oHbD+93dlF5EUDEbmburUgZQIGo1svcEo7Iir6pSPmnvyRnK/xGxcaEkGwpLaQNC
	 kNUCYjWk9zBv2ws4YI4xwQ1oeLqEYFRgS/7nesCf821Oi3/inpsPGllCY+eelmaMIbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnDkL3HX;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AB4606A32C
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 15:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98AB4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnDkL3HX
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4d28f75d62so414908666b.0
        for <git@vger.kernel.org>; Sun, 22 Nov 2026 07:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795361789; x=1795966589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jU2YFwjvT7yD+Lv9DHlYxCDT3BY4fzqytSkt/yb5eUk=;
        b=hnDkL3HXD5flumF3/t9e2PN941pIWyMnXNac52oll7iAb/sDags2OtmfgAUf2U0vIv
         qVbBpurDATSvCxRsPVYMWo7VoQUlIaAe4V8VumDHDC3ceBcgkROUXlpk0JqFfBhQzcyY
         SBtn4R7k5prd2CRl3mGulrBExDzL2LnjZKCXLcpiD7/4LcoJPb/3nwp1Y+tRdCRT+iv/
         QT2T586fQ+AfOO8P7aElwHFEbnunYf5jlh3SvQzfXzGUIaxARjZy1L9ltn76Ke3ICrj1
         x7orIEql5uoyt6fx27gpQRuB1KAK0gHbpYJKxcn5h/3PZn2vvsi0l9tEx03RGUiBddo7
         0JsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795361789; x=1795966589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jU2YFwjvT7yD+Lv9DHlYxCDT3BY4fzqytSkt/yb5eUk=;
        b=g27Ii5+hx8IQyLL7NnETPNpaLJJ5ZTIa2lGsYSm9/vpUvq3h8lm6jSdpQSjjlMspCd
         45SWY16THXiZ4PWCJlI4vlHNQd787p07fcR3hsWbyMvG5VHAnxlfEPpOW7i7b1tYIs1H
         PlbfppEre0zwviv5oNIMfwRPcbEPn+FZHsMjvr2Mpy9TRNWZw4fDadW/MyqzP5J+9dNZ
         oNBo2NinlNa7M1IjD5zo0fxOAsjO4ntFohKXFmOW9ft8NZgMHJTp/DH6dIenk+OA7pUb
         RIkuzVM2JtGV0OFSfX7leUOSQtxy+fFbdHrTbiSmXJNHy4sc5zXd6nO4ocURXkKMHsle
         1qhg==
X-Gm-Message-State: APuU4Z8FbZhLnGPay5K/y+FFHsb5wfshc5pWcgIJ5mV8rLMonWo5+YEI
	KTKMy4r20u4LGZDXTbyGvXy+Mgw8rIEtPTXwSjKiLEg9tSKuC3K4grMKvzWniA==
X-Gm-Gg: AZFdTZd4tLzpO+JPiw068Il5/vCo8XaVnaugPTKyiXAHJWlx6uJ/wDlxiKrDUcqeD9+
	lFEd+n6GQdXE9a+JuK+8cXNsS240NxW/HiafPHD2b0tfIEwDhjVzDTD7CF51bhv7z7HBKO+ajzj
	pfzIdQAPZjQ8IjuQpgbR/dEQoG3+O/olzLRQyogrVaM10o8udA9mZ0KbsWCKc/h7OBYaNqGKznD
	+ya+2sH1c4kUOb1N/fksSMZNB7IJqW4Zkvnvi7zYk8KAfTvdL78bVK6xcyY2qJ4mLz4XOcKl0vp
	EgjGvul2zK16YG2FxKyq4j+ZO90l/A6T+A6JNLGSHoaWIuvnyvSfBC88H6L3L2q6SspfkKRxiiJ
	Juk6jQ3N2ZDMw2d2ndXussMMdA5xqmQ+lfacdPKNAeW9F+FIyf3/jd08sk4taT8DLPobmUMqvcf
	tdPffmyBc9lBBzy5JwFwkC5606JVuBm84TQOgQyAWWJQTgbl+bIrm8bpOm+SmhSsN7fhQOhTFIc
	wPDVLR1kmbuDXxjqBDlQocqbxwc9eRUOS74Knj/jSc7cAd2sySsP3ZKighWHE0wTV0FJJSJcE6c
	o4tap1znHDtcu+KuoGFKOboJRWxjZkwK43LiRg0yi2GvLs8onsM=
X-Received: by 2002:a17:906:f8cf:b0:c50:bf14:8ec1 with SMTP id a640c23a62f3a-c513ab4d93emr531709666b.33.1795361788721;
        Sun, 22 Nov 2026 07:36:28 -0800 (PST)
Received: from omris-tuxedo ([217.71.1.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afec177sm319118666b.72.2026.11.22.07.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:36:27 -0800 (PST)
From: Omri Sarig <omri.sarig13@gmail.com>
To: git@vger.kernel.org
Cc: Omri Sarig <omri.sarig13@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] doc: update-index: format options correctly
Date: Sun, 22 Nov 2026 16:36:01 +0100
Message-ID: <20261122153601.110226-1-omri.sarig13@gmail.com>
X-Mailer: git-send-email 2.56.1.dirty
In-Reply-To: <20261122152538.107580-1-omri.sarig13@gmail.com>
References: <20261122152538.107580-1-omri.sarig13@gmail.com>
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

The update-index man page had references to several options, which were
missing the relevant markers, causing them to be formatted as text
instead of as references.

Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
---

After sending the patch, I noticed that the commit message was wrongly
capitalized, sorry about that.
Fixed in V2 now.

 Documentation/git-update-index.adoc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-update-index.adoc b/Documentation/git-update-index.adoc
index 9bea9fab9a..9b956216d2 100644
--- a/Documentation/git-update-index.adoc
+++ b/Documentation/git-update-index.adoc
@@ -57,21 +57,21 @@ OPTIONS
 	updates are needed by checking stat() information.
 
 -q::
-        Quiet.  If --refresh finds that the index needs an update, the
+        Quiet.  If `--refresh` finds that the index needs an update, the
         default behavior is to error out.  This option makes
 	'git update-index' continue anyway.
 
 --ignore-submodules::
 	Do not try to update submodules.  This option is only respected
-	when passed before --refresh.
+	when passed before `--refresh`.
 
 --unmerged::
-        If --refresh finds unmerged changes in the index, the default
+        If `--refresh` finds unmerged changes in the index, the default
 	behavior is to error out.  This option makes 'git update-index'
         continue anyway.
 
 --ignore-missing::
-	Ignores missing files during a --refresh
+	Ignores missing files during a `--refresh`
 
 --cacheinfo <mode>,<object>,<path>::
 --cacheinfo <mode> <object> <path>::
@@ -145,7 +145,7 @@ you will need to handle the situation manually.
 
 --force-remove::
 	Remove the file from the index even when the working directory
-	still has such a file. (Implies --remove.)
+	still has such a file. (Implies `--remove`.)
 
 --replace::
 	By default, when a file `path` exists in the index,

Range-diff against v1:
1:  ec32a90695 ! 1:  07112e8191 doc: update-index: Format options correctly
    @@ Metadata
     Author: Omri Sarig <omri.sarig13@gmail.com>
     
      ## Commit message ##
    -    doc: update-index: Format options correctly
    +    doc: update-index: format options correctly
     
         The update-index man page had references to several options, which were
         missing the relevant markers, causing them to be formatted as text

base-commit: 03b41523c576f26ad34085378717a0c1b287470f

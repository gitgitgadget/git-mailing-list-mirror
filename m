Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4071EA3AC
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232491; cv=none; b=FEcaQy5BkQXIWfhtZ+w7ssXWAl7HkFYkal3i1X20s9pDloRd3eRUrHDbomkij8vdzckgzGfM4m/hkSBPYzkDPAlN5UQcLeYY0Xs38pWWQqrYf5pJKhJ3s8MnLpY3TgkTddd5Wj2cz9BLtYQG2oymvc1kL4d+98dLnkhXEmnqxEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232491; c=relaxed/simple;
	bh=HM+MeXmlvuTjdsxOWprs+RfBnFhn5pTRGKQKwfu3Ezk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=gOA0vHt+vFNyXWlGeP5TU0J2UQ8V8CEax906rnySOmtEZhzK1hiidPedNDcL+bMLRYTe7dwxX9RC0UAxP+dbBSU+8wiEcO8OAjvxO+uo7uVF03fpfiJ40+03lZFOE2C3YMUWKn5aX6BfQRzSwpiF7j3QID3s9gME0e/W1OGbVk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyrhbOoO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyrhbOoO"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a83597ce5beso94882066b.1
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 02:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724232487; x=1724837287; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2F0eU0jJQS5b2rKfYRVx1JZtI3zdSl7LxZeSKl3gNFY=;
        b=kyrhbOoOcmGcWn7MAYaPlnvQHCHAQsfAem09/X5nzVDvpMEjoW2iQQ/FYm4wBA+ilW
         he1APyrBq7L8Vnd9vRqev+3JPydRegVDX21EnlC5iNreors8LxkZs7dNBQiONMXkQW6T
         j9xN9icG5efN7j2+wDmuIdWhnlKUXSYxFHnDNuCKbWPomcDJJpFJbNnX9NsXvkz1pgMr
         YNJCFVEra7CFJJwVESISM60I063iBioLIBYoZvJjYg0ixzmgHycj5EdxCjC7FydfE1Ym
         GlJByhGsgznYo8eOVtT9Ppr+PJqBKIcLJqB6YEot1KI9iq0qBOewaD9xu7VyAJnF//yd
         wlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724232487; x=1724837287;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2F0eU0jJQS5b2rKfYRVx1JZtI3zdSl7LxZeSKl3gNFY=;
        b=TWIzBCOjtIPZUQutZQCLXZzcIQWAicuCzAgRuG4nYvehioQuD6kZx1XnXWDl6XPVL+
         QwWNc+t60AXxyl+USpnX59ydt82/4NoAd1qnKF1EBNo0D5GC23UeZrhV/VwP0hqOdQz9
         BDv8Eb4pkICVA05CNXyRO2FRROf20nX7UFSrsM/KwEwLNWosxWrEJ31blyEVLFhlWMun
         eMwJYyDWIGAuY1H/ny+HYTitre1TH5VVQ/RDJ73bRHK0dF0rBrjAqACt8QTocmLNvPUD
         W+Iem+9LPxMlXQyrRp8JfVX4yzziqxOVWl9dtaFrd7lg0PsqONGs3Z2HHcUi2XCVyx7h
         +MKw==
X-Gm-Message-State: AOJu0YzIdTJ7+YECyx3oD42oj7EwOVoHBD1W0qtaAybt/o8F5J+RAQAw
	9CMKqzQNHuXp0zkiS8n2S4Y+4s4LflII/Yk/k6sIvqraJJkx/CK3KmIkBQ==
X-Google-Smtp-Source: AGHT+IFNNjE1Vrv8NugLdh8kI/P8CcMimxs/ZIEIYywTeKKCEIxXsBlkUzRPkuZ7Fz2MVjQn2EbNHA==
X-Received: by 2002:a17:907:944f:b0:a72:5f3f:27a2 with SMTP id a640c23a62f3a-a867014256dmr135073466b.26.1724232486897;
        Wed, 21 Aug 2024 02:28:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383745e66sm871671466b.0.2024.08.21.02.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 02:28:06 -0700 (PDT)
Message-Id: <pull.1768.git.git.1724232485264.gitgitgadget@gmail.com>
From: "ahmed akef via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Aug 2024 09:28:05 +0000
Subject: [PATCH] docs: explain the order of output in the batched mode of
 git-cat-file(1)
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "Patrick Steinhardt [ ]" <ps@pks.im>,
    ahmed akef <aemed.akef.1@gmail.com>,
    ahmed akef <aemed.akef.1@gmail.com>

From: ahmed akef <aemed.akef.1@gmail.com>

The batched mode of git-cat-file(1) reads multiple objects from stdin
and prints their respective contents to stdout.
The order in which those objects are printed is not documented
and may not be immediately obvious to the user.
Document it.

Signed-off-by: ahmed akef <aemed.akef.1@gmail.com>
---
    docs: explain the order of output in The batched mode of git-cat-file(1)
    
    The batched mode of git-cat-file(1) reads multiple objects from stdin
    and prints their respective contents to stdout. The order in which those
    objects are printed is not documented and may not be immediately obvious
    to the user. Document it.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1768%2Fahmedakef%2Fexplain-the-order-of-output-in-cat-file-batch-operations-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1768/ahmedakef/explain-the-order-of-output-in-cat-file-batch-operations-v1
Pull-Request: https://github.com/git/git/pull/1768

 Documentation/git-cat-file.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index bd95a6c10a7..f1e0b4a7219 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -270,8 +270,8 @@ BATCH OUTPUT
 ------------
 
 If `--batch` or `--batch-check` is given, `cat-file` will read objects
-from stdin, one per line, and print information about them. By default,
-the whole line is considered as an object, as if it were fed to
+from stdin, one per line, and print information about them sequentially in the same order.
+By default, the whole line is considered as an object, as if it were fed to
 linkgit:git-rev-parse[1].
 
 When `--batch-command` is given, `cat-file` will read commands from stdin,

base-commit: 80ccd8a2602820fdf896a8e8894305225f86f61d
-- 
gitgitgadget

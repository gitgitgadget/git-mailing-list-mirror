Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F71440C
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712017211; cv=none; b=s/mYDbyYfRHVuduzp8WkD66Efy901S1sDn4ZgJG47L6Mb15PafXAb9F+abEvW1cbDVXHSMg3P/8z4uh5gJ+ZQqXFA3gAzKQmVJDIjvEmm5pyWCCsQ03BlI2/JjTJC7VWTsYUNzAnr2jqfYXpWjwqBf8Y/+tHQR0q4IieJZ8QjGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712017211; c=relaxed/simple;
	bh=WhDToBpmrXDtrl/F+j0CXm1ViWhhkDskm7tDG5MN6tg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=cEa6e+xE+RZ/kO80E6RurM5/TMPtzgQc0awTCr0CMQn3B4/zNY/RrJLAy8ej2FSObD16GSMsMMH78J/xUT2Fj6GoNHlUBx0Z5bBGObusmTgqUkI01VNeStplSZCJeiaakY8dhBFPvbi59Zf6T23CA0zUsakniSaVsa3ShkKBhvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZP3qCAA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZP3qCAA"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-415694c83b7so7313855e9.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 17:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712017207; x=1712622007; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HMT+E6/5rHvyxeVnSFdJuIvUtVI03R1+AFkEc7bwOY8=;
        b=iZP3qCAAhfujrlq2wX1DwbPGakzCDkelhhJuwu7p2TSkiIjFYK8vRHkD97YN4lODP1
         pLzqUmydii2sqd/bntxw0mdbmqU5U7dQWqOjKF+OGnDww5ho23uHQF+ANIBQzoGZwSgK
         Hxfu9oH+5SvW8IpnlC6tec6SRggPCQcmtgKn3UhDoRWic4C1HrJpUURY03rp//jnYvlz
         PWGscTz9Iufpt0+rfIYyfteXO+EDe+vRZyyu/5dk5HU+PqmewhDIgzyyJRHdT6vIVF0q
         XKpbGRttxWMqQMTZJGoEw8G8gN6KAZSes06E+/G1aXvuT+jeIxc8HHDQPZEw3+jMOcCF
         FVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712017207; x=1712622007;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMT+E6/5rHvyxeVnSFdJuIvUtVI03R1+AFkEc7bwOY8=;
        b=oTQq7O3QilAs+t0Pf1QOugXqk2CFAyPv20yVxhdUODzCUpjX1isTYg/HotZfUAqnvt
         Rspy8zEtHzz9SBpIx+iUrnumuIT4v3sgB/4g2WGnBmZ0Ury4eIlklVcqWXOjGvhYOMYV
         fIOq+SHCstWs1LMT0jlTPXFtfhcb6ldJ5qYj6IyQGkhQjMPuatEm6TbDdSZetWsFGEqX
         K/320eXahrpa5Xh4wS71amkzDPvC56CUykJXpCzCLBPvMCNdLtBGMxi1IdvfQHwgriyK
         Ma0X1NHla4NKzcwPYvWfMfM0dEVYPyP9NT7jgfjRNIlXZirB6kTn5SHL5g8UxS78uy2v
         wGGw==
X-Gm-Message-State: AOJu0YyND51wXqJ4jSqbX9gAGVqM5RTV7vHvv5fKsA6p2AJLcG4TjvFX
	K8NwSpoA/oD/NTQ34HaOipkz7ppT6sy3h6x4yk5Q7w42INsw0GaofFGPD+ih
X-Google-Smtp-Source: AGHT+IH2YZUBy7d2WROS7j5z2/MNRTptu5ixSjg0Pida9jNh+axLKHgkRljr9oMbmklNiRrkDosqbA==
X-Received: by 2002:a05:600c:1c97:b0:414:759a:71d5 with SMTP id k23-20020a05600c1c9700b00414759a71d5mr7022409wms.34.1712017206820;
        Mon, 01 Apr 2024 17:20:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c35cb00b004149530aa97sm16194522wmq.10.2024.04.01.17.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 17:20:06 -0700 (PDT)
Message-Id: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 02 Apr 2024 00:20:05 +0000
Subject: [PATCH] docs: recommend using contrib/contacts/git-contacts
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Pablo CHABANNE <pablo.chabanne@etu.univ-lyon1.fr>,
    Nathan BERBEZIER <nathan.berbezier@etu.univ-lyon1.fr>,
    Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>,
    Matthieu MOY <matthieu.moy@univ-lyon1.fr>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Although we've had this script since 4d06402b1b (contrib: add
git-contacts helper, 2013-07-21), we don't mention it in our
introductory docs. Do so now.

Signed-off-by: Linus Arver <linusa@google.com>
---
    docs: recommend using contrib/contacts/git-contacts

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1704%2Flistx%2Freviewers-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1704/listx/reviewers-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1704

 Documentation/MyFirstContribution.txt | 3 +++
 Documentation/SubmittingPatches       | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index f06563e9817..eb1e27a82df 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1116,6 +1116,9 @@ $ git send-email --to=target@example.com psuh/*.patch
 NOTE: Check `git help send-email` for some other options which you may find
 valuable, such as changing the Reply-to address or adding more CC and BCC lines.
 
+NOTE: Use `contrib/contacts/git-contacts` to get a list of reviewers you should
+include in the CC list.
+
 NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
 please don't send your patchset from the tutorial to the real mailing list! For
 now, you can send it to yourself, to make sure you understand how it will look.
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index e734a3f0f17..52d11ff510b 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -459,6 +459,10 @@ an explanation of changes between each iteration can be kept in
 Git-notes and inserted automatically following the three-dash
 line via `git format-patch --notes`.
 
+[[suggested-reviewers]]
+Use `contrib/contacts/git-contacts` to get a list of reviewers you should
+include in the CC list.
+
 [[attachment]]
 Do not attach the patch as a MIME attachment, compressed or not.
 Do not let your e-mail client send quoted-printable.  Do not let

base-commit: c2cbfbd2e28cbe27c194d62183b42f27a6a5bb87
-- 
gitgitgadget

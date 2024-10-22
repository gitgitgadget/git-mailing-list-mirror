Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAF818BBA9
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595260; cv=none; b=Rx3LtW+7lIk9lSd9/VjtH8tMkkrHdNK7YwggxdYivr0GHAeqH03VsHj2+3bzx0ttlpnwJ/S1Kn9Brv7QutbuHYx+P0ouIuEEKkrrVEBhXZG1Sbg4l2fa85RubN5azBgh27y1SjwbG4xv1LDS9zEboUfHZVcHZaaSeil4f6CHaiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595260; c=relaxed/simple;
	bh=ATtey7BT5paV7mep2VoZDTDTEl305xq2KYN0wBJLhXE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HvF6+I8kO6ala+OuN8jjngnLnvv6ogTtGUoX0z8KqToyj8xuUUryGUjffi5XMYq9c9ouAc4oAiEkyAGXE7WShTt9zlj+CsesHvR5yVKAVvAnjFHkM5VyQtRJ99bUInxjkggPgwk2ga08Y5qd1ypquA80BN1u8+tDTs9siupOWgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y77bUuI5; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y77bUuI5"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso75590591fa.1
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 04:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729595256; x=1730200056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xQxnzzC3AWnQzhnSWozOB2FQUyXa2p1YgWIBhNr2UWM=;
        b=Y77bUuI5MRptlUhb0KcVuQXuAHj4c4BdW7Q91tgDTdz8EjmiEcI+6T6CA8CrMoW7J0
         hiKxxSmgyNQrl8gu+7Rlc9R1KEDTGXtxA/0GrKXsxTtLqACaY4NuF3cQdcMUxo4wYwvo
         TvCVeyhJGP6u9AB8lJruwoyCvLmA00AAGmENOAfMrmyD8AVH6ekCE/jSiXpf3HE0Yi2x
         rXO0l2l79X8hUa89NZwZaTeqYL8S+wLXaF8q5hkRo6lS0AYy9+lfvI+zz/8H4RdH6x6j
         lCYYmU1Z81ZbSPPLVTGa3JRT040UeKsgmq9g8w6jGh/Ts24mCOx5svbpZ6RjxYpb/QtD
         poQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729595256; x=1730200056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQxnzzC3AWnQzhnSWozOB2FQUyXa2p1YgWIBhNr2UWM=;
        b=MBVrQxOgHhjsELRskLwrhCx5UVuurf1VqY1j0qbJ1jyNpoof+fhcwvgIn2T6GBx9i4
         +ODjQUbP46GhZxBSeefM9LmUqstxxgdDLNSVGcvlclV0CQYMzpEGqz207R9KA0GSDmmo
         oELTcM6SribXT+FimaKMKJwlMiYs35JjZW7Wl3nPyrh5qbNe054cwQU8nwmm/skLnbyh
         cZF221QO2CpFku0UeeTzuieWb/Zp9J7u0Rjdwev3AGuy7oO0M8ovc8wh2093tMfzIJRU
         RybwzkN2EH9tRB15ezT7Q66wKhe/mD7e0Z91coiY6wPVn21fASbnthrTrTTHfoXG8ZbI
         JPbw==
X-Gm-Message-State: AOJu0Yznematk9Hwiam1ziccG5N2YUj9FaKHiN8wnNl9JF+dqUi76uiO
	NLoy0TukwTtOcLlQx22S41wxtAM4wFNzr2hmCoN3XwdFD4nGWwMw5J/kVJZ6
X-Google-Smtp-Source: AGHT+IFRnlF9/VVjKQy6NnPSbuAJungzuzb0ym+FXuN8qMlqlFwCj+lnYQUGrrfbcRb4Xmz77PWrEg==
X-Received: by 2002:a2e:bea1:0:b0:2fb:61c0:137 with SMTP id 38308e7fff4ca-2fb8320f0f6mr98937941fa.40.1729595255662;
        Tue, 22 Oct 2024 04:07:35 -0700 (PDT)
Received: from void.void ([141.226.13.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a913076f5sm327145566b.95.2024.10.22.04.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 04:07:35 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2] t1016: clean up style
Date: Tue, 22 Oct 2024 14:07:30 +0300
Message-Id: <20241022110730.7655-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use `test_config`.

Remove whitespace after redirect operator.

Reported-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
v1:
  - https://lore.kernel.org/all/20241020121729.27032-1-algonell@gmail.com/

v2:
  - Base on "ak/typofix":
    - https://lore.kernel.org/all/20241017112835.10100-1-algonell@gmail.com/
  - Tested:
    - ubuntu-latest, GitHub Actions.

 t/t1016-compatObjectFormat.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index 92024fe51d..8341a2fe83 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -116,8 +116,8 @@ do
 		git config core.repositoryformatversion 1 &&
 		git config extensions.objectformat $hash &&
 		git config extensions.compatobjectformat $(compat_hash $hash) &&
-		git config gpg.program $TEST_DIRECTORY/t1016/gpg &&
-		echo "Hello World!" > hello &&
+		test_config gpg.program $TEST_DIRECTORY/t1016/gpg &&
+		echo "Hello World!" >hello &&
 		eval hello_${hash}_oid=$(git hash-object hello) &&
 		git update-index --add hello &&
 		git commit -m "Initial commit" &&
-- 
2.39.5


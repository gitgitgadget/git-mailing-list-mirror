Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706135956
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763090; cv=none; b=j7x9F1VfeQvLUwKrCwu7yrzApu8N3OuLCnXjm5jXKOKyIXTqTbWIOY9afq0dNi1Jlp/h3UVJwvEY7vNZz7oGAqqhiLa4yaeDJVgj3ImE6kowDbLLCRB3skEt61GDNL2YuvhdrXpPMvubdzED8o1aBRJ0/6tY4AzJnvgsvm+SEFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763090; c=relaxed/simple;
	bh=dr5hzo4uhrBb5fw5tCnGbT5/3fbYYeixJtJl/nSoiqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ri+3TxYSTsQTcXRJkvq6UHBg1Us66/A2GXUQDoAwn+wsMxSHdWPema/P2qd2++E3PVq8FLcSrVSjzbzLg+kT3CsDBglvEvQe8WIQbZuDR0fOQI4z8vFNF0AiqRZYTKawN5tKD6OtPAsANDiLrvxsiLc11VrPSeYoBRS7BQs635s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfDtzQUY; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfDtzQUY"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa67ceb4e31so32633666b.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 08:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733763086; x=1734367886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNLTh9hIxfWy/0RaTJBZ35tOHi2vi2KxzyTBi3DGvL0=;
        b=KfDtzQUYRrgiE5jYNVW96ozw2ekuu0B1zSOjhka1JRAiswLfr+fC5nHfse+t4545Sx
         YC6kOdvDo//bFsyFI0FFy0joL1exJp5D35PgoghHldEPtH+m42TX02adwgiBDrLbc+X9
         LcgGrlfr79RIzG8BOWVyStu3C02EAyIDuMWlFNbgwyh2TSSuEm/a2+nuAEBZY2Q6Mp6t
         +n3WcE5ulrg/ZJkY/EDr0hiNqxSzkyusuDbQ3qRgszB5T1nhTP8MgoDBbSfSekidNdqG
         1lof9BWTXhINv0Nhbb3fBxewdBrVxud1G5YyqUGnWpxlQm2+GQSgFhbtbhOwu27VlRQ9
         G48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763086; x=1734367886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNLTh9hIxfWy/0RaTJBZ35tOHi2vi2KxzyTBi3DGvL0=;
        b=IdI6QdiEXnIsXP07He8tJM+AqMm8Td+lUHgJSCeAZHyfOGaubxa6PFrOJpe4te16kC
         4av52LW9y/a3PJo2a43d9f1T4lEFVJAVD4gEQWtvVHsr+6pI+SGy9YHbPAoWTbR6F1mN
         KZzmnpxp7+HjKiyHh2UeO8fkNVy+08BMx8hhUIaxisD0NEPN0G9LvnlvBr11TRbvqy6y
         8Er6nmuKelpO04jZ6IEApNSAp+nrOYLjdKFrY4cQISfkhMJXXDY7P/xtZox+c6SWHxJ/
         RTemXYTlCIJWmHnxK/bZrawuuHLLF3TRsXwb5RhmsRz/WLQVL6C+AIBgWjGkUlEJ+6Fy
         YVyw==
X-Gm-Message-State: AOJu0Yw3D4mF6fE5KCfV/usNylguXlz3Zaaw2QhAgAP01wEnfvqkd5Ro
	OhUuhyyj6fFNRbQWNbumY28M9y0LvId85RrS8JGVPCmw+pgp6OKTYpQdvo5d
X-Gm-Gg: ASbGnctVM84MRKwYJg+6MALoSMwChRHMXzZoPZbkiA50Ae0bkhMNkYErtO1qhnes0An
	ebmxRPHFDqpjRn0NoFKuVnzC1QaB2q8RpHBUnL4BbGEGgUSCGAXXDyNGMmccN/LixnxjXwKTf0p
	iwuMq+zcSSi+bxr+dZhEGMk8LqafQoVTzh9rCVmBva8/z5TAwgAsACcUl6V0spNOvs+gZTXykI0
	+YVpC5W7j/ycV13Tc23Tbared0kzMnLJAYnzL8ThhD95zQ0ZamzYh883qU=
X-Google-Smtp-Source: AGHT+IEZneTg3T4nujZfxs4qbeTsLdqUAbAd5xjEMSBKGcmPtjz19ws/VHQtFjwn//xz3NU13h/7TA==
X-Received: by 2002:a17:906:c105:b0:aa6:2eb3:40ea with SMTP id a640c23a62f3a-aa69f2556aemr14188266b.11.1733763085779;
        Mon, 09 Dec 2024 08:51:25 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa673474e27sm300539766b.102.2024.12.09.08.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:51:25 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v2 4/8] git-submodule.sh: get rid of isnumber
Date: Mon,  9 Dec 2024 18:50:05 +0200
Message-Id: <20241209165009.40653-5-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241209165009.40653-1-royeldar0@gmail.com>
References: <20241207135201.2536-1-royeldar0@gmail.com>
 <20241209165009.40653-1-royeldar0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's entirely unnecessary to check whether the argument given to an
option (i.e. --summary-limit) is valid in the shell wrapper, since it's
already done when parsing the various options in git-submodule--helper.

Remove this check from the script; this both improves consistency
throughout the script, and the error message shown to the user in case
some invalid non-numeric argument was passed to "--summary-limit" is
more informative as well.

Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 git-submodule.sh | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index fc85458fb1..833ac8362b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -53,11 +53,6 @@ jobs=
 recommend_shallow=
 filter=
 
-isnumber()
-{
-	n=$(($1 + 0)) 2>/dev/null && test "$n" = "$1"
-}
-
 #
 # Add a new submodule to the working tree, .gitmodules and the index
 #
@@ -524,17 +519,15 @@ cmd_summary() {
 			for_status=1
 			;;
 		-n|--summary-limit)
+			case "$2" in '') usage ;; esac
 			summary_limit="$2"
-			isnumber "$summary_limit" || usage
 			shift
 			;;
 		-n*)
 			summary_limit="${1#-n}"
-			isnumber "$summary_limit" || usage
 			;;
 		--summary-limit=*)
 			summary_limit="${1#--summary-limit=}"
-			isnumber "$summary_limit" || usage
 			;;
 		--)
 			shift
@@ -554,7 +547,7 @@ cmd_summary() {
 		${files:+--files} \
 		${cached:+--cached} \
 		${for_status:+--for-status} \
-		${summary_limit:+-n $summary_limit} \
+		${summary_limit:+-n "$summary_limit"} \
 		-- \
 		"$@"
 }
-- 
2.30.2


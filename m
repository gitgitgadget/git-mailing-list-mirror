Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA7B21420F
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856346; cv=none; b=akQz06OCfNeJ8VBLNSd9mS/R1+d+weKqr5RTzv63evi5XV/2P9UGG1y7Tq3j5U6R1Z6gd2Oa2NwD4OD5PYAbIn7Jnr3NsZuAA/bjUNhncOYHZYzjqL2x8rLD2R4gR4HvMhebYOt1sghCsuEJBm7ky7NCjz/bzAAWW5rY4QKv9TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856346; c=relaxed/simple;
	bh=s+FdjAYhpdB1k4KIYUhTwSQn3ybiSNrVZ6lw5awsLrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c4UJaN6qMea3UJKK9CVWkYsvOXK99QhI4uZ4GYgFbXeS3qleqbLAxcrxa45ZY/AKxNuPgKSajRwtt3zSxbo3Lh+DoIYWsnSWT7JUr7uXawXiHStHL5KpPYBgQtXJBZlm2+4+q0wtIhIWMmEnHDUdXukTWauvqORUwlWLmbPI+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCYWOHep; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCYWOHep"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3ce64e7e5so552495a12.0
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 10:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733856343; x=1734461143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuXCx1rN4/hrvtLTL6QZ9QDEFcnUddFGKuajpTRwkVk=;
        b=UCYWOHep7FkCEpDV4tIJ9gNY0mla4yx9TX7Z7gT7dCMB+/IXsC3rlAMJjpSkkMMVpn
         hY3sTO2JwnfZZcy/kwqSTc3tHpezCRgPHWEmkygkXBTQo/hHfEtYqF88kulnEY0m+Rrx
         hLnllNrD2FHLf6XZ12ahqlnorog7xnztP4cXlXfZGDIScrdsBdy1Jek1G//X0YK7pwr0
         s0IEY6SvR40+ISMAvn4YPhYVWdflu5GJub52Cqvo6BWYzgnVR9U7ZkYleCzViMqHcX+o
         tZT7lhs8v+N4X0yLWLnnC6GBga3LEYlS8f7BMvV5d9Kns56VpTVWX6Pvf1WO/eWWPfvF
         vAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733856343; x=1734461143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuXCx1rN4/hrvtLTL6QZ9QDEFcnUddFGKuajpTRwkVk=;
        b=DHq/2269sbHDLkQ149boV8HtJMuKrrrVPs/MMR6Y8zDn0aEV/uuNS2WWSjWfG/ci5g
         0vacqepzs2/sMRsgHeyjaySylYtvERc3ChsXdYvYq4t+NvH5tnqabSxo/x4Nas2Hq6en
         1xQ8180Ez0nd5HLx4LAgMZ9B3a043qg7BjzzzCEsvxCkMAibn9NIaDKCFcF/93xhw5rV
         tpb/m8L4I606/zjV3bCKMzNyIiv5O/CDP2jk/Kdv2k3laJ1uuaQVm2teOeSE7ENkpkbp
         VJ5xYnwXr4dZzlPxwhxrWfXeoLvyqffPoNTMGzzdWKe7HBpi6vV2aSbt5mMYizugXWXp
         hqeg==
X-Gm-Message-State: AOJu0Yy5+TDzlr/z9WloOWZdpFdikaQwQuSO1GIgt2WlIxFs+CxBeOHh
	B4IBjkFl5aePhpO7J1F9ZzN7US/cb9WLBfudrfX9ArDzahzJueLpH/uhm78H
X-Gm-Gg: ASbGncuBmjo961EGPiUET0eryoUD7lDh32j43r+PisbU8KCbSwWCMREE+f6aOoOnBXD
	q94Aqioqen7XxPky3NOBTV0MVF4ZosvhaB9qCusAtQvV6dqoDAKEfalP0PqIhql6ImzKxLIdEfU
	DfI5FDj0GfJU7vniAIQSuZMhmmlbF9DUQ3loBWc3hx0XhJ1XyUO+BJgoWu+zygD+zBFF7ZCZGKl
	6fO/cLxyZk72GRn5A562TVbzKoSOa5/CA3kxeZMf1+5FbfIoUNA/xzVMKfomko=
X-Google-Smtp-Source: AGHT+IHsmAzm6fw+pCXLxeIDPzEFkax3AnvykRV36499JQ2E/8lHc7BUxXJjnO6zGLL2Q/fVxUNa8w==
X-Received: by 2002:a05:6402:2681:b0:5d0:8111:e946 with SMTP id 4fb4d7f45d1cf-5d3be6fc185mr6171765a12.5.1733856342521;
        Tue, 10 Dec 2024 10:45:42 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48882sm7895896a12.24.2024.12.10.10.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 10:45:42 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v3 4/7] git-submodule.sh: get rid of unused variable
Date: Tue, 10 Dec 2024 20:44:39 +0200
Message-Id: <20241210184442.10723-5-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241210184442.10723-1-royeldar0@gmail.com>
References: <20241209165009.40653-1-royeldar0@gmail.com>
 <20241210184442.10723-1-royeldar0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the variable "$diff_cmd" which is no longer used.

Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 git-submodule.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3adaa8d9a3..ba3bef8821 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -503,7 +503,6 @@ cmd_set_url() {
 cmd_summary() {
 	summary_limit=-1
 	for_status=
-	diff_cmd=diff-index
 
 	# parse $args after "submodule ... summary".
 	while test $# -ne 0
-- 
2.30.2


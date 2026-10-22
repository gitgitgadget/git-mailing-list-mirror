Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792704568;
	b=BC/aXSnmTr+O+PSUcpEtrajzmVPQH+XaB0mgWfzJ/d7ORT1QBOdX4QNLMFY1kn9Ql5uH
	 P9R4a3/OPXlXG+cPcRwZj5GOJQpiLihGWERBjGlZoEKjI5E5A76D0Byau5ddx8YAXMEDK
	 z2HYVnQfO6DLlR1p/j8BJaxoQYtqfznNB3UEv3QW+3UPjmyJvq6pEDhvOh6Kuy7zGyekK
	 1J4ArSP7acyVYrr0fE8nhUY8YRycv+0mJJNv/viMYNIrioWy5rs2DTLgNBrv17Sj2DAt7
	 VZ1XDPAI9JJTSPpX/T9f5rf3zKuWByhIUyOzn3yMiXCyKLwlh/vPgK12xfxNHYavUqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792704568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+qCA2i1TyIxb6gwFj3rxqTvI5F0K3vwRkqxc8/PHTQ4=;
	b=KRXuTb1wZeaMZ6U27ywvwf2TJexQwyjLca2f3UoXLnMqk1B1SeBIM7sT5ZEe2VcLqtIt
	 uEs6VQ8w0rsCzzqCfvJzpbjN9GC25RqJKbhJwC0QJEN4ihLhzpRP9MeiOkOqMTwemtSgt
	 hH6nXgVrrjS/ZTS0SW8YODxkwe8QzICWodJoxqEjoonSoY/HUHb5tn032Ap5qBStWll2G
	 y0zNGy6fIadKsggcRp6PiYxApLP5p0ttbxbi/PjaFpMBPMEQpXDum+oWZZICIIEvlnzLc
	 pivdx+zzHM3F0HnCzA1qBSOpZjz6gOosMKaGr0ACVwVigUJwBRj0HEdmW+k0XaGqEBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PYdLEDuv;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9450606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 21:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9450606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PYdLEDuv
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e00eee27dso152972f8f.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 14:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792704566; x=1793309366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+qCA2i1TyIxb6gwFj3rxqTvI5F0K3vwRkqxc8/PHTQ4=;
        b=PYdLEDuvCZRwC8Xs4KD/KcH2vkhQR7NiSrKysBbeUybwN0XYrPsc9v//5UQS/QgchU
         rvd66qrsSaknD8zQceKHb0wuIcmLRMlTF17hAXrE9TKwV+IRCCa0uTZgZaeHJjEfz4zT
         MZIof51iVYWtqxgtYB1cOSPehvr/sTTO7XW7v41chYF2EP7DNuiRnVZmwVGYMZUwcZ1A
         7ZMi86Bygqpc5FvZ0r0YOVBZleKBNm8Vkd6F4LX4hl7lVRckWH1MZarVoVH+/HqQO3om
         bG08rIpQXxiDgKmdmBY7T0hCkzM+JC3cdkW/WLtfxD111VWPQ7vItsFy9PhleWNjK0Qc
         jt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792704566; x=1793309366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+qCA2i1TyIxb6gwFj3rxqTvI5F0K3vwRkqxc8/PHTQ4=;
        b=gw9lPIon1LumKUNuRcgFxmY5FReQtvq/JePIWU4pxxs0mbUDddsYW3U5yGmBvjQ8jd
         Us1+ZAT7fNTWOxN12f6NfvC9GlzkfKfiSgeTV5gzQfteDqxWqgQ/fcx8HNgsPu1eymR2
         Ct+WBq6u+1VHzdoMFgKwzSptrmWI4bVTBK9SzFqzHMT1ekLsXD+Xt9kODSIb2hOHHjED
         k+7SALK/8SuXoZY8UDtMh5GA5sPXQvNzSaN6iaFNYgDJ3S837poalbUs0Q4oLTNUVig1
         JetD+RyPqYpwzvK0knW1OZ+gSEvhLjgLEgQHWuCSGP3Qt/0mCEFMmQDoiftx4o/6uwJp
         jiag==
X-Gm-Message-State: AFq9FYLzKXXa3SPx8+MO1p03n+u7avePm5QnrsO2P7TckVeZuJMoQwNp
	tUOLklOH5oBehHUmUZ651UZa25b0MW/8osF73UX6SLZCY2/iwJuJcYOoWZTklcXQ
X-Gm-Gg: AYBFou1ZK2H50F3SFLC2ulEvOCRT8BoBCPxrTHSdK1bIszGXsu/A6ClZcqXs2yiYSdQ
	NTZtPnRHZsEOSiJdBhxa9w7AdYtFjtocKrLSohegXOzzdOLQqQOBQbNKZcZTSedDarzx/ql1Ybc
	5nqugASyfFuHLcxw/2VJqrfr7CrUSF10P4ymDuBt3cDl0SkXWy1kL6e1ZyHrrMi1SrX7Qp78+pZ
	SEGDY00JM0Cd23KR+J7UF0KntAWwzTm8sKAFxYzDoLH6kYpj9Ot7XW2oUwtT8VYJazjcPY95+gZ
	jIytkIfw01mce56PhpvtHBjEaQK2xThKj0JDbJdFszchb888F8fWRtnDSfN5gCHjT/pEuoqVgTk
	5c4OekBpdYXvNSOQ4AEOb6WhuDm+2Lewl4wSC/N5T0/ghM3Ser6NctDH7TeBZlPB+Ay0Oa1ENl5
	L3DLda9pQd6K1LNVWxZs3k8ZIn+M3ayONM1TALAA+ipMw1FiOeRNEJsJFTJpk44Iy1XILR+CC34
	mnNW8UOj+A9oI3xqXegJ2YGpr7wSkgPWX67LwoRYNnpFs9YsvQLPyKz+Xa/mKTGprv/MFiyZPQv
	mu8S6sJXgQnF30qBbQZcHKRUNKrBUA160vk6yOs8wT7+rLvtjg==
X-Received: by 2002:a05:6000:1623:b0:48a:fba3:d5b1 with SMTP id ffacd0b85a97d-48e385bebddmr80662f8f.55.1792704565901;
        Thu, 22 Oct 2026 14:29:25 -0700 (PDT)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38044e8fsm739355f8f.31.2026.10.22.14.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 14:29:25 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH 0/5] root refs vs pseudorefs
Date: Thu, 22 Oct 2026 22:28:48 +0100
Message-ID: <20261022212903.177261-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Since 993d57eded (refs: pseudorefs are no refs, 2024-05-15), the term
"pseudoref" has been restricted to FETCH_HEAD and MERGE_HEAD, which are
not stored in the ref backends, while other refs outside of "refs/",
such as HEAD and ORIG_HEAD, are called root refs. However, a fair number
of docs, comments, messages and tests still use "pseudoref" in its old
sense. And while the glossary describes the rules for refs in the root
of the hierarchy, it does not explicitly define the term, even though
"git for-each-ref --include-root-refs" uses it.

This series adds a "root ref" entry to the glossary and clarifies the
"pseudoref" entry, and then replaces the outdated uses of "pseudoref" in
docs, code and tests. While at it, it also updates the long outdated
glossary entry for per-worktree refs, and fixes a few inaccuracies
found along the way, for example about which refs get a reflog in
git-update-ref(1) and core.logAllRefUpdates.

I've left __git_pseudoref_exists() in the completion script alone apart
from its comment, even though it's used for both pseudorefs and root
refs. It could be renamed, keeping the old name as a deprecated wrapper
like elsewhere in the script, but it's not obvious what to, because
there is no term covering both.

Andy Koppe (5):
  doc: glossary: add root ref and clarify pseudorefs
  doc: glossary: update per-worktree refs
  doc: stop calling root refs pseudorefs
  refs: stop calling root refs pseudorefs
  t: stop calling root refs pseudorefs

 Documentation/config/core.adoc                |  2 +-
 Documentation/for-each-ref-options.adoc       |  2 +-
 Documentation/git-ls-remote.adoc              |  4 +-
 Documentation/git-update-ref.adoc             | 13 ++-
 Documentation/git-worktree.adoc               |  9 +-
 Documentation/glossary-content.adoc           | 86 ++++++++++++-------
 Documentation/rev-list-options.adoc           |  4 +-
 builtin/for-each-ref.c                        |  2 +-
 contrib/completion/git-completion.bash        |  7 +-
 refs.h                                        | 13 ++-
 revision.c                                    |  2 +-
 t/show-ref-exists-tests.sh                    |  4 +-
 t/t0600-reffiles-backend.sh                   |  2 +-
 t/t0610-reftable-basics.sh                    |  2 +-
 t/t1400-update-ref.sh                         | 66 +++++++-------
 t/t1403-show-ref.sh                           |  2 +-
 t/t1460-refs-migrate.sh                       |  4 +-
 t/t4013-diff-various.sh                       |  6 +-
 ...iff.diff-tree_--cc_--summary_REVERSE_HEAD} |  2 +-
 t/t6302-for-each-ref-filter.sh                |  4 +-
 t/t9902-completion.sh                         |  4 +-
 21 files changed, 129 insertions(+), 111 deletions(-)
 rename t/t4013/{diff.diff-tree_--cc_--summary_REVERSE => diff.diff-tree_--cc_--summary_REVERSE_HEAD} (73%)


base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
2.56.0


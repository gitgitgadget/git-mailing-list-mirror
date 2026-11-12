Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521205;
	b=Vq/zcystOBcAS7KDYP3mOR0sFA4IR6oj9Zv2YwnJFdztGHoc9nfyDUozA6BwYKlJ5ini
	 iKVPyuZV9Gj1vgEkOKQu73KOlTlQXOl3qK3a9wkIqLkZNpd5qYPclVm/ALmvzqTd0tYjm
	 j6twaMUJFn8lkELz97LGYeXTErnLSsXOFybNZ49tj1m7BrU3HYqwG5dSAMnVdLEFN0D6L
	 EvK+ffngXcLy9fp8ghZmAaQPAY+rSronrLBh5zbcJtOm1jhxljP8gdu8XPSqFbs4AaVr3
	 x58qpK3en0YvYgksjqxSvUbIg8XKq0cotLz/Qqfnp0jA1+2l8qF3rOA1IZNE/+bHSFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hJCT6UCOX5eH7P2fQhxI2yQKg/6roJJqcsT0KCux3yo=;
	b=pILvdWq9WAMi5UDwPpM19B8+UZWn9cQN3ivKGUE9S+B0r5iahngPwMZgg490xsSynsKH
	 Jyx3oG00A+G1SdMnEyCaU6oXMGdBzICelB8dFRPKINX7bquRH09KjMCweU6oSn2616WvI
	 9TPZU3/nYpFiMd/J7+hZXrzYFb7QYSisP73o6DZod4zc96UTeTLkjRm162ThAnQIguzM/
	 zr0OWFdGrLPxABK59PYFIRoknKbQBxtBnt+Jls+B1GeagDYkHMoKBQmGcj2vPyM0v24QE
	 SmamuvuayI/U+9iCdLHPlEgq83SVdM5fVfhr2YBhimbx1tc0qEPZZr2s2HSWK/5q8Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U23HQz4i;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0CB606A33B
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 22:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE0CB606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U23HQz4i
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so1587825e9.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 14:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794521203; x=1795126003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hJCT6UCOX5eH7P2fQhxI2yQKg/6roJJqcsT0KCux3yo=;
        b=U23HQz4iGriMQyHI07s/MR9Uq+Xq/sfSv8HO9a4h3ST6PqJsNS9OrZvClP9qg/vjxD
         cR7PHqo8kYL2MJO/93nrYr/R6dxWUWErs/ZciSxR6CVRyOwSht18P4xNSTSSzJTNCPH3
         W0I2vS3QExtjGuSaXx9v5AmYit9rDdjyhPqhF6ZvwIqElu3tugNAmuCuurNJXgxXTzvH
         jwH/SGgPx4ZvqTVXMUeNuGXfk2NFqYStdrD4EaNNtQHRrXstYiUom2Y2bReAs+mCDZOA
         d0impfboyU5uadTTR18FRZzEm7Qbw0NlblBIdQBHUdWePYaq8vzAvP6WnA6VhCXw2mO0
         6i+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794521203; x=1795126003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hJCT6UCOX5eH7P2fQhxI2yQKg/6roJJqcsT0KCux3yo=;
        b=QCpZCwewE0hfCx5M/lTdwl/h8+P7BiaJKZsy9x179zER7WTykq6yDdE/zJgGHJtIUt
         7KRowx7qbLZXY3pRn6UNMI0ev5SMmJFa+Zd7OrHdHXHzx4kViXyxfVKgAvKuKSjsCFAY
         cTQOqBQg/xt1gX7FXIfCGkJrtY8uiZpsyZMsBIr94uo5fWxKq26DK4lxV5FOTqnwaxlK
         APsIhtt2utVz/as+oJikXy4FvAk4E6VTpX6d2vCoqdRE/1IhrBEhttDcWaUpCAFaY8qR
         J+Uq60btmB9adfTNRVAeRu731/0bBlm3r2NYb5C0pwru7MvXh2296TMljUvZWYxwZ03R
         4W6g==
X-Gm-Message-State: APuU4Z+0ORenWbB0WoymWFIg60fq4F3pgaofzCf2xXFhQymfYUuWb2XM
	9oUDo54Vf/kL33edVdpWV80RBLwxPbqYZ082A9SCfjqR90ZgIY/H504tDxmJrZwI
X-Gm-Gg: AYBFou2wz4zaG2YKkfwwTPj0F6+nFHCxckiqyIOUvP9BXSHfjKLjTDPd98JsesRrirI
	noiwRafo6wo0NTq4hMz9KgbHEWoygnJ42CJjxD2EnHkh6NY5CQrxMKNFOU8APPjHD+M1aZtwqEr
	1TlUeaOjuGj1SHhnwrxR4QIU104QLXRdd/mbPa8G5HsjzEVj0TdsZehnIT1e3RoRC8+MZd5/ha9
	23cVjqZkSHTlhxoNY3kJ4PWaXNriBIwh4WsSiBQAgAZoW8rcUfXgiaM/jL0lVheARFM7Bq0PESS
	YHPgW1UaipE+9sAConjMtqa8tWh9v2oPYMQcstbLIgTSzTqjzrPksjKW0fM9C2x7mrWthouHI7f
	DMiU0V643Razf4YrDfBkixdoQ/qE/kCxYbFhyfYt9MWb+Xf4QzXlDYPqoz5FfUhzPxiBhnsvtu2
	Rbdg+Azyut5bJnzfFiUA2Mn1dINqYDo3WKlt7pZbCeq2lRakzQkEpchRGu7mnQn0TCOqyI3qPIF
	tchG4oPMmrb5XCpDBtd+i3zss3oZME2hsYwaFVQ0BAkBOWeEtdQLjWWv8SQIUFsngSEv2/aKstr
	DHD+C8ww51tZOTQXY64b1CsQh0mlLPnDsKhpa0JPPxX/NyMHc5fG9gjtDZp+hjR8r6e8/NbbStI
	paiZlQwd1v4lSEX4VCXxMZg==
X-Received: by 2002:a05:600c:83ca:b0:4bb:53e4:a7cc with SMTP id 5b1f17b1804b1-4bb55a74c2emr11748395e9.30.1794521203067;
        Thu, 12 Nov 2026 14:06:43 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e29daa5sm106098995e9.12.2026.11.12.14.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:06:42 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v4 2/5] doc: glossary: update per-worktree refs
Date: Thu, 12 Nov 2026 22:05:38 +0000
Message-ID: <ccc3554410199a06f784e3761832e4c910b65415.1794520948.git.andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794520948.git.andy.koppe@gmail.com>
References: <cover.1794000450.git.andy.koppe@gmail.com> <cover.1794520948.git.andy.koppe@gmail.com>
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

The "per-worktree ref" entry says that only HEAD and refs under
"refs/bisect/" are per-worktree, but that has been out of date since
a9be29c981 (sequencer: make refs generated by the `label` command
worktree-local, 2018-04-25). All root refs are per-worktree, as are refs
under "refs/worktree/" and "refs/rewritten/". Pseudorefs are specific to
each worktree too.

Bring the list up to date, and state that it will not be extended, as
new per-worktree refs are meant to go under "refs/worktree/" since
8aff1a9ca5 (Add a place for (not) sharing stuff between worktrees,
2018-09-29).

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/glossary-content.adoc | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
index 1d737cae1d..0ce1701937 100644
--- a/Documentation/glossary-content.adoc
+++ b/Documentation/glossary-content.adoc
@@ -494,10 +494,27 @@ exclude;;
 	interface than the <<def_plumbing,plumbing>>.
 
 [[def_per_worktree_ref]]per-worktree ref::
-	Refs that are per-<<def_worktree,worktree>>, rather than
-	global.  This is presently only <<def_HEAD,HEAD>> and any refs
-	that start with `refs/bisect/`, but might later include other
-	unusual refs.
+	A <<def_ref,ref>> that is specific to a <<def_worktree,worktree>>,
+	rather than shared between all worktrees. All <<def_root_ref,root refs>>,
+	for example <<def_HEAD,HEAD>> and `ORIG_HEAD`, are per-worktree, as are
+	refs with the following prefixes:
++
+--
+ - `refs/bisect/`
+
+ - `refs/rewritten/`
+
+ - `refs/worktree/`
+--
++
+This list will not be extended in future. Any new per-worktree refs shall be
+created under `refs/worktree/`.
++
+Even though they are not refs, <<def_pseudoref,pseudorefs>> are also
+specific to each worktree.
++
+See "REFS" in linkgit:git-worktree[1] for how to access the
+per-worktree refs of other worktrees.
 
 [[def_pseudoref]]pseudoref::
 	A name that can be used like a <<def_ref,ref>> to refer to an
@@ -787,5 +804,5 @@ See linkgit:gitrevisions[7] for descriptions of commonly used root refs.
 	"working tree" and repository metadata, most of which are
 	shared among other worktrees of a single repository, and
 	some of which are maintained separately per worktree
-	(e.g. the index, HEAD and pseudorefs like MERGE_HEAD,
-	per-worktree refs and per-worktree configuration file).
+	(e.g. the index, <<def_per_worktree_ref,per-worktree refs>>, and the
+	per-worktree configuration file).
-- 
2.56.0


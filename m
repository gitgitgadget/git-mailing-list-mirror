Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B440870
	for <git@vger.kernel.org>; Fri, 17 May 2024 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715948851; cv=none; b=PaYJv+AVTl9eRGpCqVA90chUgN1dsWeIBKQgAlqYWrH2GtG1zm9GGfqx+IAr3B5f4V6r76fUirurpNVKlFX6UaAzJ7SJd+h0xwPY8AzEVMsfpcQTUX6gD1r2z5SUKfoFIOrI8q4VMmVnjMzQddN/AFFG7tLAfcMr98knmc/dzyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715948851; c=relaxed/simple;
	bh=A6WKjWsCVCEHEuc52onexQOMFOqqU6MebytgyENT664=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXhgbB3CW7ZvpwBiZ9aRi47VU1RX420OWimwZzh+KstCS6bB3niG6zXug1lBtpq/fUVWvIDa6gJjEJdcxEF8FSVsxhmG861Xf8kYbdcw1XS8rokS11vmURBzBhAbJhgFDdyq5e8AWp6LRO5k97/MnNFw5G/xsFx/LdllTkW4HnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fisus8nA; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fisus8nA"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5a4bc9578cso416762766b.2
        for <git@vger.kernel.org>; Fri, 17 May 2024 05:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715948848; x=1716553648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fua9hjDBoa+3DsYaA468ipQsFTEOg8JIp4iobXh6rE0=;
        b=fisus8nAv6iWAj04ecoYcIjQ0yUcbSdFMeJRckXHFroKOQanveTjgg5gnXZs9GEH+T
         pgti4Symu2Ll9KlL916TqRkpOR97ObTlXieFUyTOOWLLRR6lqh+LkshM0OFhhuvNhHnW
         mqzaM5ZWUxwxTmI9q2mE4yNzjRqarrvJDW5oVveVN227zMYQLdEGa1Ln3v+mVkzINYVU
         mO7PZgeRPWBmnx991LDJqdpNKSVDd1IBPhK14lvVjXPnd6QU3MlvBTAbTJwMMhVJlHp7
         PJRec+4Kofiu+fYAtO1pzSVal6PX4eFo9O1f5I84i3OyJEHKB/LOs1ARHInQxKWdCER1
         b+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715948848; x=1716553648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fua9hjDBoa+3DsYaA468ipQsFTEOg8JIp4iobXh6rE0=;
        b=TcPDC7VBcgV5drSnrRov+FBDyJqhgpO52E6pRz01dcXpOjjTZoLEJREb6iXy9kidMs
         wLiuO+Ac4dfFrCBQHAJTxMR3s+HTWqzPk8nDWOct2tbzZIeN+GoTEqZwHbyzGmt4AXTU
         wM0O1xM+irkJBVe/wHKdC5Mz+H1DGzNcQZqALTT+wwDbvZtBmr/xahFdMwmVS38fISMY
         +E6L3UNlitCggieisw23kY6C9lbaDbrVzFopSQ3GGck/bDyaFZYXDm9h16hyVBKuf1oe
         ckgp4WdyvJkG1fAdClBmMK+aWXUTx/y4m7Ik8gCSZl6Te8+yvb3JtxLJrRSLdXgZpcl+
         edIQ==
X-Gm-Message-State: AOJu0Yx1lxcrpFp6tuZvFw0IMSyQ1VqC85f4kpSllXskotwZLjekDqdd
	ggzKLzzM0vzKMccwyT8LOYrc+2k+u9XwSfChVF2PGkQFxmUvh4T1
X-Google-Smtp-Source: AGHT+IGabPPkvrLU7kr7lDQwRVq5gPVLjkN1QR5MlHWJsVh4P9FfHAThf6JI8cG92K2YlwDLomwwCw==
X-Received: by 2002:a17:906:4882:b0:a59:a727:1e81 with SMTP id a640c23a62f3a-a5a2d57a381mr2139265766b.20.1715948847389;
        Fri, 17 May 2024 05:27:27 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:4a60:5c46:7b75:202b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a178a9d9csm1111636466b.74.2024.05.17.05.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 05:27:26 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v2] SubmittingPatches: add section for iterating patches
Date: Fri, 17 May 2024 14:27:24 +0200
Message-ID: <20240517122724.270706-1-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240514123039.1029081-1-knayak@gitlab.com>
References: <20240514123039.1029081-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

Add a section to explain how to work around other in-flight patches and
how to navigate conflicts which arise as a series is being iterated.
This provides the necessary steps that users can follow to reduce
friction with other ongoing topics and also provides guidelines on how
the users can also communicate this to the list efficiently.

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

Changes from v1 include:
1. Removed ampersands in the example commands.
2. Fixed grammar in commit message and text. 

Range diff against v1:

1:  ae52d39e2a ! 1:  ea37ff3eb6 SubmittingPatches: add section for iterating patches
    @@ Commit message
     
         Add a section to explain how to work around other in-flight patches and
         how to navigate conflicts which arise as a series is being iterated.
    -    This will provide the necessary steps that users can follow to reduce
    +    This provides the necessary steps that users can follow to reduce
         friction with other ongoing topics and also provides guidelines on how
         the users can also communicate this to the list efficiently.
     
    @@ Documentation/SubmittingPatches: patch, format it as "multipart/signed", not a t
     +
     +. Make a trial merge of your topic into 'next' and 'seen', e.g.
     ++
    -+    $ git checkout --detach 'origin/seen' &&
    -+    $ git revert -m 1 <the merge of the previous iteration into seen> &&
    ++    $ git checkout --detach 'origin/seen'
    ++    $ git revert -m 1 <the merge of the previous iteration into seen>
     +    $ git merge kn/ref-transaction-symref
     ++
     +The "revert" is needed if the previous iteration of your topic is
    @@ Documentation/SubmittingPatches: patch, format it as "multipart/signed", not a t
     ++
     +This trial merge may conflict.  It is primarily to see what conflicts
     +_other_ topics may have with your topic.  In other words, you do not
    -+have to depend on to make your topic work on 'master'.  It may become
    -+the job of the other topic owners to resolve conflicts if your topic
    -+goes to 'next' before theirs.
    ++have to depend on it to make your topic work on 'master'.  It may
    ++become the job of the other topic owners to resolve conflicts if your
    ++topic goes to 'next' before theirs.
     ++
     +Make a note on what conflict you saw in the cover letter.  You do not
     +necessarily have to resolve them, but it would be a good opportunity to
    -+learn what others are doing in an related area.
    ++learn what others are doing in related areas.
     ++
    -+    $ git checkout --detach 'origin/next' &&
    ++    $ git checkout --detach 'origin/next'
     +    $ git merge kn/ref-transaction-symref
     ++
     +This is to see what conflicts your topic has with other topics that are


 Documentation/SubmittingPatches | 79 +++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 8332073e27..3c85ae4344 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -608,6 +608,85 @@ patch, format it as "multipart/signed", not a text/plain message
 that starts with `-----BEGIN PGP SIGNED MESSAGE-----`.  That is
 not a text/plain, it's something else.
 
+=== Handling Conflicts and Iterating Patches
+
+When revising changes made to your patches, it's important to
+acknowledge the possibility of conflicts with other ongoing topics. To
+navigate these potential conflicts effectively, follow the recommended
+steps outlined below:
+
+. Build on a suitable base branch, see the <<choose-starting-point, section above>>,
+and format-patch the series. If you are doing "rebase -i" in-place to
+update from the previous round, this will reuse the previous base so
+(2) and (3) may become trivial.
+
+. Find the base of where the last round was queued
++
+    $ mine='kn/ref-transaction-symref'
+    $ git checkout "origin/seen^{/^Merge branch '$mine'}...master"
+
+. Apply your format-patch result.  There are two cases
+.. Things apply cleanly and tests fine.  Go to (4).
+.. Things apply cleanly but does not build or test fails, or things do
+not apply cleanly.
++
+In the latter case, you have textual or semantic conflicts coming from
+the difference between the old base and the base you used to build in
+(1).  Identify what caused the breakages (e.g., a topic or two may have
+merged since the base used by (2) until the base used by (1)).
++
+Check out the latest 'origin/master' (which may be newer than the base
+used by (2)), "merge --no-ff" the topics you newly depend on in there,
+and use the result of the merge(s) as the base, rebuild the series and
+test again.  Run format-patch from the last such merges to the tip of
+your topic.  If you did
++
+    $ git checkout origin/master
+    $ git merge --no-ff --into-name kn/ref-transaction-symref fo/obar
+    $ git merge --no-ff --into-name kn/ref-transaction-symref ba/zqux
+    ... rebuild the topic ...
++
+Then you'd just format your topic above these "preparing the ground"
+merges, e.g.
++
+    $ git format-patch "HEAD^{/^Merge branch 'ba/zqux'}"..HEAD
++
+Do not forget to write in the cover letter you did this, including the
+topics you have in your base on top of 'master'.  Then go to (4).
+
+. Make a trial merge of your topic into 'next' and 'seen', e.g.
++
+    $ git checkout --detach 'origin/seen'
+    $ git revert -m 1 <the merge of the previous iteration into seen>
+    $ git merge kn/ref-transaction-symref
++
+The "revert" is needed if the previous iteration of your topic is
+already in 'seen' (like in this case).  You could choose to rebuild
+master..origin/seen from scratch while excluding your previous
+iteration, which may emulate what happens on the maintainers end more
+closely.
++
+This trial merge may conflict.  It is primarily to see what conflicts
+_other_ topics may have with your topic.  In other words, you do not
+have to depend on it to make your topic work on 'master'.  It may
+become the job of the other topic owners to resolve conflicts if your
+topic goes to 'next' before theirs.
++
+Make a note on what conflict you saw in the cover letter.  You do not
+necessarily have to resolve them, but it would be a good opportunity to
+learn what others are doing in related areas.
++
+    $ git checkout --detach 'origin/next'
+    $ git merge kn/ref-transaction-symref
++
+This is to see what conflicts your topic has with other topics that are
+already cooking.  This should not conflict if (3)-2 prepared a base on
+top of updated master plus dependent topics taken from 'next'.  Unless
+the context is severe (one way to tell is try the same trial merge with
+your old iteration, which may conflict in a similar way), expect that it
+will be handled on maintainers end (if it gets unmanageable, I'll ask to
+rebase when I receive your patches).
+
 == Subsystems with dedicated maintainers
 
 Some parts of the system have dedicated maintainers with their own
-- 
2.43.GIT


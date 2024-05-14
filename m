Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1C3219E8
	for <git@vger.kernel.org>; Tue, 14 May 2024 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715689848; cv=none; b=uNKWQy16LP6zDO5A3RI2DEFfHUwuvcK9oNfsqNZueh/MV2zlwCkyl8cNKSk48M/0g1QquuTrmvXjKunMUZ8u/mtQSa89mTtgneVGBRI1ZTD3xzLx34Hs33eRMYDz4VP3ZINT+CgjO71/yn8EEVx37QIj/e+mgHl7jarDTyLPSic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715689848; c=relaxed/simple;
	bh=X0xWq4yxjOZR3mBwhIbYFVU5IVPJV4YmJ7IfNrFxP74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mBrebbMoqcn5uOw50JokjVinX9CkRY1L8pQmxDuslROpX70oN6Ch4iZqNVUS5pWszV/LDHJF5h8lLIa4v1erDUtagZl8gsyt7/z2CpKdu0KUz5StceqOvq5suEnkleAvYjSkFOfcFp2zGSL6+yJAzgNYVpt9wNa+o4CQSqd8esU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su/uLu/s; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su/uLu/s"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f40b5e059so6483733e87.0
        for <git@vger.kernel.org>; Tue, 14 May 2024 05:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715689845; x=1716294645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=07dwgWL80h3ybHEwShiqjRRhohdpjKkp0jEghxc3NGI=;
        b=Su/uLu/sLUtb2gK4e2eQu5Mt9Z884GQnoZfZM8yTSv8LHyn4y+W6NtfztR/F/Aj7Cu
         DwQRJFeLOKgJM1PHjwVa44qfaFBslOOXiCupMMVsSDvJa9VdEZCikF3wzAwxGBZJwqCn
         BG/8e5BBFI0D75fD/L6cKpuxqZ//T2GhpzharAmOORVqy3/oeJqnDR8+ylGSYjrRR3Dl
         h0scVPl81ghHgliJ5k+5YNljUfbU3u1PVhdCiOy3U/wAwWRp9kqW5qHC2SJbj794tfg6
         TqxL9odx/jT75VPmfJ0dXdlp+g+/KoArGsiocia+n74nYfjduYGZlEc1BwL9DwJWFT6N
         7yZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715689845; x=1716294645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07dwgWL80h3ybHEwShiqjRRhohdpjKkp0jEghxc3NGI=;
        b=nhBG53Pk8y0UFmwiPYIEqGHvVplnybykahUqA+Po+pmxtEyvdlAKs102OPsh2+YnIm
         lplZHASlZGL55QQMuhjxTB8qcsTj9Ug1DIOholo82XIaGpy84ziwYUrb6CMuH7gpvDA2
         /j1HsY1SPljGCF7IciKthOeqJ7+qMgbG+Ewf3YrM1iMl+cVlvHmL8Tf6XE/I4Bz99v99
         I9l41KwnIYHNPNfAw+4XE9NE+D7ZyDjhCaJIRyqbd+7KShmxGzIUVDAnqOUev2qytttu
         72+Weg66eqIIzfAL/1SuO39sAi2Y6xaEcaBi6pRevxMLWXy7zCatxPohMniM+Y5T6NHD
         QqAQ==
X-Gm-Message-State: AOJu0Yx+zb6ExJx9LKlLGsZDX7NFDC7SL2K9GGhtUogwLGmkBNyKTp/j
	aLgAL8ytLwb9h75eoi/UjtMdsb3e3txZyBrvfgCnGOZNZpbMRftS
X-Google-Smtp-Source: AGHT+IE/6j2It8TSmj57PfkR1Qxo9yPfSEIbH3IWV/jxyHbfakto5jJp4a5QHMfPid3yIdrSuMnJHQ==
X-Received: by 2002:a05:6512:1105:b0:51c:dc6:a1cf with SMTP id 2adb3069b0e04-5220fc734ecmr9548368e87.34.1715689844274;
        Tue, 14 May 2024 05:30:44 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574ec273185sm155346a12.42.2024.05.14.05.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:30:43 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH] SubmittingPatches: add section for iterating patches
Date: Tue, 14 May 2024 14:30:39 +0200
Message-ID: <20240514123039.1029081-1-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
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
This will provide the necessary steps that users can follow to reduce
friction with other ongoing topics and also provides guidelines on how
the users can also communicate this to the list efficiently.

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

This came off a discussion wherein I sent a series based on `next`
instead of merging in conflicts [1]. This is mostly worded by Junio and
I've just put it together into a patch.

This is based off master, with 'jc/patch-flow-updates' merged in.

[1]: https://lore.kernel.org/git/xmqqy18lpoqg.fsf@gitster.g/

 Documentation/SubmittingPatches | 79 +++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 8332073e27..2fd94dc8de 100644
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
+    $ git checkout --detach 'origin/seen' &&
+    $ git revert -m 1 <the merge of the previous iteration into seen> &&
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
+have to depend on to make your topic work on 'master'.  It may become
+the job of the other topic owners to resolve conflicts if your topic
+goes to 'next' before theirs.
++
+Make a note on what conflict you saw in the cover letter.  You do not
+necessarily have to resolve them, but it would be a good opportunity to
+learn what others are doing in an related area.
++
+    $ git checkout --detach 'origin/next' &&
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


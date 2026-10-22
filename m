Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792704584;
	b=HscWJYWWg/CA9o596ZQjyW96Bt3seaLzVIWPgRhXRUGWz6Mb+R+n6dOrnqdM7lUtBFPs
	 lfsBxH4o0hNKDB3T4sM78S0GYZtFkXTOoUPm0UlV7v2+y0Fxq62/fs3lLiIjQuRE7AvS6
	 9ptVqtGIyt16tN41PGMvHZGeDlKVBdCjxnLLF/QFP1JkGF96eqeUXQlziVDis6GV0zjA9
	 kQHAhALrwRKjRHY3umT5uPHrf1WaRsFE+jq5esJKwbqHZYLwNaYHMqD/pDD915RWM1ErM
	 /BezUaz6JpNlvQKo+GkqoPuHb4bppj+jwjfAPuDTA1c2xr8s1c+CnIz14kmg811leKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792704584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4jZ4GbEHN3vG7cBJ6o7vqqdGq81aDlL4sieOfv4h+TA=;
	b=mQY3OLvu/skKeKbfu4v3+vCuVU+BIdHwFfvKIKE3R8QworxdlOEfg7CCiVj2BZ4BtTJh
	 1KO1z0UPVlWE9Cfiuorv4SICD88LOWSOUAkuKup6BsRb1hELPwRKCNoM5tNgWIqlw5QgI
	 ADQSvhXkyUIr9cwSnz6V2BUUZvKvH7NkjrTfrCOH2EjF3pmykVipckG/bYnET8CAVPsjJ
	 5C3oN3fb0S/1JSPrsKFaRGNP/rgMC8uIGscXEnKTh5Z4cn3VB4zO7yCgjkTfpQgq+UpDd
	 X5tCRfvL1SBueDwL3A1jeFoZBIeZ3N9SYTfzjiQo4zzBIw+gpHuUJ+HZIvZRGVvykeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XAl5jBxk;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66251606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 21:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66251606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XAl5jBxk
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48c4be28b82so179873f8f.2
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 14:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792704583; x=1793309383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4jZ4GbEHN3vG7cBJ6o7vqqdGq81aDlL4sieOfv4h+TA=;
        b=XAl5jBxktRQu8LwTr+ezL9XLhGMJi0FpfyzMXYQGnWzLsjJjqC6u7kSri9oKsiGdMG
         OJD6SqYKJK+4rcZ/boEGe1gjPJRcSQq2DzfLf4p0u9WWOuHpoaiItG2jpP3/G9nFRozH
         Nc2g9RCwnYXxs6P3xRvhzsbZZrvtbYvGcwM6iuSGa7dy90YGy6CiihtCQI0sEdAgnScd
         bSpS8mY2N0TYKxhWoK+jVdDENPwicGUvW2uYXkLpZdWheS6/qw/hln5PYoCmIto+T1/b
         G+vACuY/08UpqmVKSj37/hABOpLhMQ4LXEXTSZ2oA9jQQ2L4dhskDU/N1S61pJuyH2Bf
         GvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792704583; x=1793309383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4jZ4GbEHN3vG7cBJ6o7vqqdGq81aDlL4sieOfv4h+TA=;
        b=zD9kZx8dwJN0lLcwsu1J9V5WzY/CYMVS4RfmHfw+HM3IEc2n7ROoeyAd8SrsDMHPk5
         1L8Xf/scSbqJSCe9D0jk7Jlh1EgcgzI5s0QgGM3Xi0zNQb5xv9pwkco2nGVSq6hgWvPK
         pEGOz0F8XgVjSJqzLlbyvhZ+7jB+xw9n3H8BSgvYe728qIdtuFguuTqBkdRVy5qdK184
         o0ss5GtzZqNpD+St+vmROWNs7pKkAUcAaZJDYv+jrpaf9RVP6yiP0hxM3gQaqqYvsOr0
         ZBqQnEfAd3BP2x/XIAD2b181gXctjeJrV9jizvXqnXm30f+aO5oUUfQ3FuKibl9roAkM
         dtMg==
X-Gm-Message-State: AFq9FYK8SI1MTMn9vGDA/L7AEYPMDvQggnmXlNK+LMeOPoW9RmD4QgKT
	+pF8Zwv2Z6TiEijww7svae402ghIxesDWn6XGChvPmTYwk9hglDDBDRyluFL+RmD
X-Gm-Gg: AYBFou1pv5FI8yec2aFXsK8quOy/eqKOBBOArkc4R7lEcCd2Apy1cP4W8hnZ9qc+7+C
	G58jPzMMrd2T5aNi++nxjZ9hy1HNqOdXKtP6ffyXpsN29alpBBOgaCDEkkgk0YJg85goedaY5QZ
	26bSj/W8rRfEyz9kZ+L9ew4xQ4R9PwkOblw6Ek9yu/YuWmf6NCgbg9hFS3LpKsnnX48rAxM3PXJ
	guB4T1gj3ryW2D9Dk8MRkcYe9G5kH/r3s954/txG/3F/nMx49SkZIedCeuX0myurCLOUySN45xP
	sfp4J2LHhFGee2n6ycwOVfiwAqPxXOh79zBVN9xX8v5zkibH/JfojrHw5LCFSTf1PssoeGsFEBd
	6bEU2+nLw51J3b3Ava6yT1KJctws2tfwkUMwp7OduN6pU/tjl5ngn5Ja6axzNWeRD3jhNoORefH
	VleVH1XHfJGNve0Xv3VjZBqPeOD4Ff9Viekm+BwYV+ochn2hJ2GDj3+L6w315MSJRr9SDDI4LDu
	RvgAtJ+x0DRrmSb6Mzq+KzloaTGiaLV68ZDyn5xz2fSzkEQUKwF3poLgK1oc0AmmJECmPFPTk/3
	zaeLMXBSlkox9KAGhiIXwo0UPU25SOgfeHdW2ihRFQcApIVJ
X-Received: by 2002:a05:6000:29d4:b0:48e:2f7e:bdbb with SMTP id ffacd0b85a97d-48e385ab359mr79575f8f.50.1792704582727;
        Thu, 22 Oct 2026 14:29:42 -0700 (PDT)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38044e8fsm739355f8f.31.2026.10.22.14.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 14:29:42 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH 2/5] doc: glossary: update per-worktree refs
Date: Thu, 22 Oct 2026 22:28:50 +0100
Message-ID: <20261022212903.177261-3-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022212903.177261-1-andy.koppe@gmail.com>
References: <20261022212903.177261-1-andy.koppe@gmail.com>
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

The "per-worktree ref" entry says that these are only HEAD and refs
under "refs/bisect/", but that has been out of date since a9be29c981
(sequencer: make refs generated by the `label` command worktree-local,
2018-04-25). All root refs are per-worktree, as are refs under
"refs/worktree/" and "refs/rewritten/". Pseudorefs are specific to each
worktree too.

Bring the list up to date, and refer to git-worktree(1) for how to
access per-worktree refs of other worktrees. In the "worktree" entry,
describe HEAD as a per-worktree ref and MERGE_HEAD as a pseudoref,
rather than listing them separately from per-worktree refs.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/glossary-content.adoc | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
index b2c582254b..eff6d23215 100644
--- a/Documentation/glossary-content.adoc
+++ b/Documentation/glossary-content.adoc
@@ -494,10 +494,16 @@ exclude;;
 	interface than the <<def_plumbing,plumbing>>.
 
 [[def_per_worktree_ref]]per-worktree ref::
-	Refs that are per-<<def_worktree,worktree>>, rather than
-	global.  This is presently only <<def_HEAD,HEAD>> and any refs
-	that start with `refs/bisect/`, but might later include other
-	unusual refs.
+	A <<def_ref,ref>> that is specific to a <<def_worktree,worktree>>,
+	rather than shared between all worktrees. All
+	<<def_root_ref,root refs>>, such as <<def_HEAD,HEAD>>, are
+	per-worktree, as are refs that start with `refs/bisect/`,
+	`refs/worktree/` or `refs/rewritten/`.
++
+<<def_pseudoref,Pseudorefs>> are also specific to each worktree.
++
+See "REFS" in linkgit:git-worktree[1] for how to access the
+per-worktree refs of other worktrees.
 
 [[def_pseudoref]]pseudoref::
 	A name that can be used like a <<def_ref,ref>> to refer to
@@ -788,5 +794,5 @@ and pseudorefs.
 	"working tree" and repository metadata, most of which are
 	shared among other worktrees of a single repository, and
 	some of which are maintained separately per worktree
-	(e.g. the index, HEAD and pseudorefs like MERGE_HEAD,
-	per-worktree refs and per-worktree configuration file).
+	(e.g. the index, per-worktree refs such as HEAD, pseudorefs
+	such as MERGE_HEAD, and the per-worktree configuration file).
-- 
2.56.0


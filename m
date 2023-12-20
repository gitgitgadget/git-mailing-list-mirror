Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308D148CE5
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 21:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKtEtJCl"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d13e4f7abso1050045e9.2
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 13:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703108158; x=1703712958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdIbyUT6G2/F7V4pEus0UOl12Fh3W+haGC+N1kgZjRs=;
        b=OKtEtJCl2v4AiPXt7q18rpslTc7j0hDDF50hj649t+xFEXOnsm1DwweABtBewvoNbk
         vSnj3sfp2u3+NH4e1G0aHOeWBOzWPd+rwN1bmGYQJlha3Ldu3cgPj8oi+0SSphYSDBgi
         xKK4IJd/VYxF9x+Mrt6rnBdN6QORTLWb4zmyD/5ZWsiUlh+hiBZcjSHOGJGTbXK388+L
         CTQOctVjawBW3zCmcp5Hg9fWCp3uFtiIr+4DHBVciGoNAq0ZytWY84OnQ8qdfnUZ0fwz
         /5NR3Ukj4HDx6WGOJE15b1QB4oHwYgT6UUm/+ffhbZwx64pQ82PjCPtHZBOyE3eyXuQQ
         I4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108158; x=1703712958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdIbyUT6G2/F7V4pEus0UOl12Fh3W+haGC+N1kgZjRs=;
        b=OFE5sRn2yBQpY/+/20Z5IPhfmXsNBVFqm+RVr7gs0aVBcC/WDAe3m5kcmvVNPwZI8t
         R71LIPhY60rdIDrowJ8vxGkAq/Jkglsr4LVpvJr6T1jRFKyM8oYpyjn1LZ8ei2vZbJPJ
         OU0XzRN8WpoTDzGixpQ2+tAqZ3ORwQwfdj6HC81prTibDSoHL1ipM3H3M16ISx9zsce/
         uVtuhNtyE0T3o1EYionwbCjq8TPEB0SDRMnJtKyheRPBYa+sCzC7UNsUq0Tw3ecbluDT
         PevXYleJjY/LESNSaaXcxp7wLW/QPI6ECMUNSBdQqnrKbtKyYrI3H2IxoRBBQOChNRRk
         jd0A==
X-Gm-Message-State: AOJu0YwhzaF2MADpp7m9lJ4Vwk3PX9ClhX74/8RMxaXC2FQ6jVYz8Fv2
	tfJxsjqeRn0e8i465BUYj2c=
X-Google-Smtp-Source: AGHT+IFyPPi0HjKAESbK7QjIfkGR6XTSPzl1+011bn8P/NZBCbyWJgFPRdCelKfMcD4qsDpmYghcQg==
X-Received: by 2002:a05:600c:a018:b0:40c:78c:f2b0 with SMTP id jg24-20020a05600ca01800b0040c078cf2b0mr198731wmb.2.1703108158161;
        Wed, 20 Dec 2023 13:35:58 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd7-e0bf-0-e5b0-3039-5d18-ec57.ipv6dyn.netcologne.de. [2001:4dd7:e0bf:0:e5b0:3039:5d18:ec57])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b0040c411da99csm8757315wmq.48.2023.12.20.13.35.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Dec 2023 13:35:57 -0800 (PST)
From: Michael Lohmann <mial.lohmann@gmail.com>
X-Google-Original-From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: gitster@pobox.com
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>,
	git@vger.kernel.org,
	l.s.r@web.de,
	mial.lohmann@gmail.com,
	newren@gmail.com
Subject: [PATCH v3 1/2] Documentation/git-merge.txt: fix reference to synopsis
Date: Wed, 20 Dec 2023 22:35:34 +0100
Message-Id: <20231220213534.18947-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <xmqqy1dor3t5.fsf@gitster.g>
References: <xmqqy1dor3t5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

437591a9d738 combined the synopsis of "The second syntax" (meaning `git
merge --abort`) and "The third syntax" (for `git merge --continue`) into
this single line:

       git merge (--continue | --abort | --quit)

but it was still referred to when describing the preconditions that have
to be fulfilled to run the respective actions. In other words:
References by number are no longer valid after a merge of some of the
synopses.

Also the previous version of the documentation did not acknowledge that
`--no-commit` would result in the precondition being fulfilled (thanks
to Elijah Newren and Junio C Hamano for pointing that out).

This change also groups `--abort` and `--continue` together when
explaining the prerequisites in order to avoid duplication.

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
---

@Junio My sentence was ambiguous. I wanted to refer to the upstream
version of the docs, since that also has the faulty prerequisites, so I
changed it to "the previous version of the documentation" for
clarification. If you think that this paragraph is not needed
nevertheless I am perfectly happy to remove it.

@Elijah Thanks!

 Documentation/git-merge.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index e8ab340319..33ec5c6b19 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -46,21 +46,21 @@ a log message from the user describing the changes. Before the operation,
     D---E---F---G---H master
 ------------
 
-The second syntax ("`git merge --abort`") can only be run after the
-merge has resulted in conflicts. 'git merge --abort' will abort the
-merge process and try to reconstruct the pre-merge state. However,
-if there were uncommitted changes when the merge started (and
-especially if those changes were further modified after the merge
-was started), 'git merge --abort' will in some cases be unable to
-reconstruct the original (pre-merge) changes. Therefore:
+A merge stops if there's a conflict that cannot be resolved
+automatically or if `--no-commit` was provided when initiating the
+merge. At that point you can run `git merge --abort` or `git merge
+--continue`.
+
+`git merge --abort` will abort the merge process and try to reconstruct
+the pre-merge state. However, if there were uncommitted changes when the
+merge started (and especially if those changes were further modified
+after the merge was started), `git merge --abort` will in some cases be
+unable to reconstruct the original (pre-merge) changes. Therefore:
 
 *Warning*: Running 'git merge' with non-trivial uncommitted changes is
 discouraged: while possible, it may leave you in a state that is hard to
 back out of in the case of a conflict.
 
-The third syntax ("`git merge --continue`") can only be run after the
-merge has resulted in conflicts.
-
 OPTIONS
 -------
 :git-merge: 1
-- 
2.39.3 (Apple Git-145)


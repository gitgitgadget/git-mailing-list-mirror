Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790AB37F736
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552463; cv=none; b=NPeGkX5IhJ05rC1Un2NZhDgtjeeqMko6pjsL/zEa+tML9+yBRWa7lKPuk6qRAEkhLt6M1vQd55DWK+hIm+aeLmjgJ5kCBWFaniXVVjcDkckPvKk261ITkmluE4d/G2Nz/y7hDSrgFDkdkvESFnOMCqsBbsicPQG7KzJPZnrtTic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552463; c=relaxed/simple;
	bh=YYFbLEm9ODhAHmi4F+WW2l/u9I1yoJ4Hgi/CmMvYGaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duMPVP7SWPUcLCJa6wCNZiLIpelcIlHMYXNYlRl90maH0kQg8Vu2TGmH7UOJpYV7+u007aLFI2bUA3jJ8tl1BW/6VGOZQT4PzMKgmuAHLM/LpOfHQlo+bEJcOG4lbMnkYM4m4lMcUN+xogt524wupNGa0rr0rlJ5e2RipozyrTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kidzZTBZ; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kidzZTBZ"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d7fdb922a5so1101088a34.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774552461; x=1775157261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKC5YPWs45YI8+sLBPnMx3bmHx7yl7jQzJkZ3t5TciE=;
        b=kidzZTBZwKBkYF2Dkne7nzdPcgDyoMxh7A5MV7jouJ1XsESatLGq0L9x5ZzZ5zBMzn
         cCIpIoDl57glFYEZdHlLoY6FPtQAK+yHg6wex2s7/LNgFsBWuE0UK9UXI6RcfNU/Q9J1
         s5/uOwdXbgwEN1D98AEnXr0iJmNuFeN8d4y+EpwWkWoVQ8B299oPLFmzMv96TFxKsVT3
         LW9YONyevoLJej/NAGp/xka/g9ExmtuXbJujOpONcyUNm/3f+YlbjPrH1TAfkxGNkL7a
         d6o4HQCtxrW+g9rVgDEg+tQOaDmq4wkY4OlO/rUy7NyxtgATU2zKIRzMzcBbdN+Bk0/f
         gvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774552461; x=1775157261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QKC5YPWs45YI8+sLBPnMx3bmHx7yl7jQzJkZ3t5TciE=;
        b=aKXUncMfPsD10mMSY+ZBTGdBItvCru470kin/DEm+KrCr+biu5CBFI6mSFRPhwJKi8
         PpcJLK3bNF93sOtUyiAFTScEixD1bo1HgNwxrxXb9+DfCZk5rNvksrgwnM5HAqJBYQO6
         rxFLhQGmJGm9oq5rTPZ0lnAZghGa+NN/l5Kv9q9cBUh4/emOQ1MlNDnIBCv8b5q9CKi8
         0UefL7s70lAwzj2ic66u98CDvUCtjRYxGiPhuuddnB17pM6JRqDYU1g4J8qDGerXXaoK
         eZvdKtLiweD2EgnXm83j08aflKs/+A6Ux8Zcdv2hQf6Q3m7r9qUxX84R7X0W0ZbweBu1
         6QrA==
X-Gm-Message-State: AOJu0YzVidsJN+rOJ8Xo6h888Xq1AiKRtNUKqDka9cdNF2Ok8MdwJ8DE
	mIwO1w7CHLEBLo75D0FDlFZynCyuY83KUhwBMe+X3eNq+W0FvhB6dSorEDgsLQ==
X-Gm-Gg: ATEYQzzpKUzVggvekLGtzPiuDjGiEiFpnev5HAuCLjqvmg3JARj7HS+9zH2TGjHPtcY
	B+lpOm7LcrKwAPyGoXcSaUkvzQJ9rL3ik/7qPcYqwMsew1cw3+6mUrkpgHPhsBGu6CQ/ndIwQgV
	Rqcl12TqDmhFiOLJkg6TD1wlHsnPxt5tC3G6naa0WAWoCSdmP3ZO1BW/0091e40DG6KpGEU1lv2
	+wegBLbysZbtoyOfO3/6vG8om8/cRp7u1h+6hFL9kjJHblst3DChTOra/Nh4yTZyNssuCMGVUnf
	pS4LJsczcUM8NMTlM3QNXVTNTsWDXueivOdiSq2jYfyzHFyFXn3OE23O4zHFBjIc7KErOI4EGnN
	pQpS1zKLTc+2A6NAvZCJsQ1yiyi9bmhWHFtRJg6ZieXvyWSrlBSXpFhrB42b+JA8K43FvzeSRBD
	bSHRSdYW26WgIMgneTvyACW+wjB0HKbfQ=
X-Received: by 2002:a05:6830:82b4:b0:7d9:b46f:ee21 with SMTP id 46e09a7af769-7d9d69cdf4bmr4833600a34.16.1774552461188;
        Thu, 26 Mar 2026 12:14:21 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d9e71f5ab2sm2946689a34.18.2026.03.26.12.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 12:14:20 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/5] fast-export: check for unsupported signing modes earlier
Date: Thu, 26 Mar 2026 14:14:10 -0500
Message-ID: <20260326191414.3783974-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260326191414.3783974-1-jltobler@gmail.com>
References: <20260326191414.3783974-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The '--signed-{commits,tags}' options for git-fast-export(1) support
only a subset of the modes accepted by git-fast-import(1). Unsupported
modes such as 'strip-if-invalid' and 'sign-if-invalid' are accepted
during option parsing, but cause the command to die later when a signed
object is encountered.

Instead, reject unsupported signing modes immediately after parsing the
option. This treats them the same as other unknown modes and avoids
deferring the error until object processing. This also removes
duplicated checks in commit/tag handling code.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/fast-export.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 13621b0d6a..a30fb90b6e 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -64,7 +64,8 @@ static int parse_opt_sign_mode(const struct option *opt,
 	if (unset)
 		return 0;
 
-	if (parse_sign_mode(arg, val, NULL))
+	if (parse_sign_mode(arg, val, NULL) || (*val == SIGN_STRIP_IF_INVALID) ||
+	    (*val == SIGN_SIGN_IF_INVALID))
 		return error(_("unknown %s mode: %s"), opt->long_name, arg);
 
 	return 0;
@@ -822,12 +823,6 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 			die(_("encountered signed commit %s; use "
 			      "--signed-commits=<mode> to handle it"),
 			    oid_to_hex(&commit->object.oid));
-		case SIGN_STRIP_IF_INVALID:
-			die(_("'strip-if-invalid' is not a valid mode for "
-			      "git fast-export with --signed-commits=<mode>"));
-		case SIGN_SIGN_IF_INVALID:
-			die(_("'sign-if-invalid' is not a valid mode for "
-			      "git fast-export with --signed-commits=<mode>"));
 		default:
 			BUG("invalid signed_commit_mode value %d", signed_commit_mode);
 		}
@@ -970,12 +965,6 @@ static void handle_tag(const char *name, struct tag *tag)
 				die(_("encountered signed tag %s; use "
 				      "--signed-tags=<mode> to handle it"),
 				    oid_to_hex(&tag->object.oid));
-			case SIGN_STRIP_IF_INVALID:
-				die(_("'strip-if-invalid' is not a valid mode for "
-				      "git fast-export with --signed-tags=<mode>"));
-			case SIGN_SIGN_IF_INVALID:
-				die(_("'sign-if-invalid' is not a valid mode for "
-				      "git fast-export with --signed-tags=<mode>"));
 			default:
 				BUG("invalid signed_commit_mode value %d", signed_commit_mode);
 			}
-- 
2.53.0.381.g628a66ccf6


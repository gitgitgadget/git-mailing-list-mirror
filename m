Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2EF20967B
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409477; cv=none; b=styUGlssAvoNNpnFe+wSo3yFOPOhbN8WOr3hQpB6uAkvalgbxJsEjrXLxvvlhnMaMNUVRbj7YQmoFJ0ao5YqUrMBPTC29qVu1HWh//xG3yQvIpivB0GRiXfSQsukcuD4junsgt05tx026T7s+gD8Z/mrFCGN8OH+5orh1I96j0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409477; c=relaxed/simple;
	bh=opPvqbuSojM7C18Au7j9w0k+hzvHe5F6EHrCLfwU8KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvatnlHpVW58C6UYqiWVby1qKIwyBiNiD3PDOoskHCoZTQoG59DU6zFGSqVvsQEUNhB81krgFVgR2OsFiblR6ry8GpHJuvbSM0eLt24qnADZ4vOL1BzQXAU9E2LW4zIu9v+Ajxx+enJeLVZt3yCSUzYs+hrX7T6PtrVjmUqEdjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgEca7dg; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgEca7dg"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72bd5f25ea6so3149a34.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742409474; x=1743014274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFid9FOUBgE6oHvchTwDzqtDPMt9SuyhXyG5MJ9m4c4=;
        b=TgEca7dghiN30tVbCxrBVtewxoTmRUAZdRwGhDtTr5pb6/xs6/dSCyIXtGabNYku11
         xQE2eMdhebH0lSWEU3Cu1SAUjvCZi3+20fRcFYLp7vOr7pSEUMNjYUzC2Cf5/JizUdKj
         HSOAdUOwulaXGzYE904/xv/PaojflPy6x1bdJ7Kw6J1lfpRGTFrnQ2kx9KR1jxp9zX8g
         Y9gPSD9lb0ERvhcIqSCamev2Ofx9On8fio+ojkptLnmNQi9AjBsdX8QTd1z4VrYnw4q7
         0aw3sFLfqGtlz+wqxdg+zhFt99PxzGoiCk5kjJVTF40CAxVzS9ulyWJ2h5Vnh3nWdgN/
         7YqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742409474; x=1743014274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFid9FOUBgE6oHvchTwDzqtDPMt9SuyhXyG5MJ9m4c4=;
        b=P20bpLHLQdNN4pM/J6SPwOi0NdyT8yBJGwp1oWk8e+xN7IsTWdlIYumbAQ/R5xMD3X
         3K2OZE3SlICVcVPeWQVudk8M7huQgA+TaL83c7PtzFOuWE0RDhggiWkVK7JIhMRGAWsZ
         2TuxFCcWuuQB0cFeF34Gwe44e/IJbLY7WGl/Yqf90bneI2qrL9qtqnllB18tUlb/zsJu
         G5zEUPGalR1+vvNKB8tUbb//UUGYeNZcVgTTC430UMfVKYf34grBfoQlsQ/iTJ59ZWbh
         k+sEWTH16ViWLnUdFE+w8lOufvmgJhBtj7z9Pw1Wk33PhlP+9yjSuplvw33S92lYiixp
         WNkw==
X-Gm-Message-State: AOJu0YwjkjdmdVsRD6vwKWjcDZsw9StAtLpDxVmMrmPYvWblJwrwOCIx
	x/wdz3BxngDsVNJdugOX25JWTjyPP3plxt+xYV7NcisEBaH1Ii/DAtSNsw==
X-Gm-Gg: ASbGncvgCbivwGQB5/TaqNh+Hc71nw9XJhEzjCHbE2m+3t0wrhBidwwaM2QpGm/PYFK
	WvOC4OYFo4HhyWC/i05eFvUm+Ijt+5tGZTKZml1jh6brmwfLROblT/oQMfzxwpi+JkVGji1joSF
	1sVILf15PkGmMiYmJQGYzkynoc7bE0p+TxNstXVQpN1IoqRKwpoN3IZHxCI8HGlBQq5AnFMxBTI
	jLyEtoibBqR08OjaE/R2TD/zDo+6rm0Ij8bQLHj6+9+PUVvZboH0DWjusiMl217l//LFIRQtuEf
	DcIkwv+pO9Pcyfrfqfkui7corHSFcHacMp7+t6x4Lf2XtGLVnEW/vxPywdob2pA=
X-Google-Smtp-Source: AGHT+IGSE7m07a51szMZXJCXx5qvnPWbdsjz5jPL6RXFyj3umaVSECETcYhuwIzMRfuN944x10HZRw==
X-Received: by 2002:a05:6830:6d84:b0:72b:95e5:edab with SMTP id 46e09a7af769-72bfbdbec9fmr3377369a34.1.1742409474646;
        Wed, 19 Mar 2025 11:37:54 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e796sm2561943a34.48.2025.03.19.11.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 11:37:54 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 2/5] rev-list: refactor early option parsing
Date: Wed, 19 Mar 2025 13:34:07 -0500
Message-ID: <20250319183410.1225428-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250319183410.1225428-1-jltobler@gmail.com>
References: <20250313235747.9583-1-jltobler@gmail.com>
 <20250319183410.1225428-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before invoking `setup_revisions()`, the `--missing` and
`--exclude-promisor-objects` options are parsed early. In a subsequent
commit, another option is added that must be parsed early.

Refactor the code to parse both options in a single early pass.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/rev-list.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index dcd079c16c..04d9c893b5 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -16,6 +16,7 @@
 #include "object-file.h"
 #include "object-store-ll.h"
 #include "pack-bitmap.h"
+#include "parse-options.h"
 #include "log-tree.h"
 #include "graph.h"
 #include "bisect.h"
@@ -639,19 +640,15 @@ int cmd_rev_list(int argc,
 		if (!strcmp(arg, "--exclude-promisor-objects")) {
 			fetch_if_missing = 0;
 			revs.exclude_promisor_objects = 1;
-			break;
-		}
-	}
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (skip_prefix(arg, "--missing=", &arg)) {
-			if (revs.exclude_promisor_objects)
-				die(_("options '%s' and '%s' cannot be used together"), "--exclude-promisor-objects", "--missing");
-			if (parse_missing_action_value(arg))
-				break;
+		} else if (skip_prefix(arg, "--missing=", &arg)) {
+			parse_missing_action_value(arg);
 		}
 	}
 
+	die_for_incompatible_opt2(revs.exclude_promisor_objects,
+				  "--exclude_promisor_objects",
+				  arg_missing_action, "--missing");
+
 	if (arg_missing_action)
 		revs.do_not_die_on_missing_objects = 1;
 
-- 
2.49.0.rc2


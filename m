Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470C4DDA9
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776472354; cv=none; b=JofHw4ayhuHbzVIRpcUmgdnf8850RoSkTsHM1s7R30MFBv8dAym5eq+zApEdxIzFf6NFaz1Fw6yAAxFTLrUHSg5qSttoHArejYS9jRPkATWoNj2sLlELEA9UHBEDys3dn0SiZ7tZ0WX/3jn17eQm2fC5lZBEwuybQiEc8/asxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776472354; c=relaxed/simple;
	bh=lGmaA7HQpL4fc921lV+KimhO650Cr4sQocwTfRp2N1A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kznS+pC9B7atObOjUweu3/+3h2Xv5CxiHMSB1JZ6PFxxXx60N3z638W0fRmurQzt+8FzYtTuANG/7cSzMwMTMWcqZinEdRwRAV3YIYdpVWM0+AH00vITtopNHpKZOTcoHsxuWPmFZhuugrmGkjEB4Lwd1y8YJyx84rL3zLjstN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asVhUAwl; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asVhUAwl"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d87c138e1so13407081cf.1
        for <git@vger.kernel.org>; Fri, 17 Apr 2026 17:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776472352; x=1777077152; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwAcFLxBMUqEyAsFL9q41zuA9nhWvwzTk+WOQ6O1RbI=;
        b=asVhUAwlQNMElm/LxOKejpszAw0eQlSM4PGqelptEufYj0rLgcDHak7H6YhqKJtUn8
         q67ZVBRm8U7jmUfdNEiawsC/YsfhX64Ey+8HSoqxcP5pi+dY6+9x+SnsxZh/iDcA2r9s
         BAIZEND0ZIdpCOJDRg4bTWkEW65ONFV+rjBoTQVuvQuINAb4DnAnNkIbO/TFPK2uO8H/
         IH7WUASBhnIeBw8eP19KgKEvyhj8uByhwqr3q5SneKI7SsMJP+mE09yX3KAcADxV5rEP
         MgMpyfeFwg4Qu3+94XzX5LmzroUyMHnfcA/bMgosSW86jMcu/NKNY9TY3DMa/npCKD6d
         xowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776472352; x=1777077152;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TwAcFLxBMUqEyAsFL9q41zuA9nhWvwzTk+WOQ6O1RbI=;
        b=Hdo0P4AkrqTsveoVoVrEUTKW4xSyx91QfybmgfhiGppmEPZcp105xZE9/TVWWFweq+
         QNDvaH+PzVvoIbQkqSHGhy1wSx0+TAmdQSqZqJt0HCyj/aAsIv/TAT4iIbZvYgLMjSVg
         n2L5aSP9ERfmPxBV5zkeKzRGvJkc7ud1rCM2ZclB1t6rjKI51tKunbE2gTqvm1e6j3ay
         lTu5djQq9oOrHnsyObIIQLbrLEf+pwIEnydgZitLPY0TmiPpbJXGj7MNKGsEL1DQSHD4
         EwddUKdGzbpA8aEgTaDw35uFTqcDekxLa3fzGMX85Ot25Uo4+EofNp0zAhp0uNcTwAQP
         7lYw==
X-Gm-Message-State: AOJu0YzVNVWWpfcktdVGNfy9vCCrFE/7qPxj49nfOPqjTRGidudrS2kI
	bjDISDooYKOeXTOzeNsuNwBW/OpWoCcJLCosFvMmMKKp9QxM/tjhl+n4zhFRCQ==
X-Gm-Gg: AeBDievZpQtboUwgLH0Mz/loqcrMetrMi5yPpg/rx5Z+owsnmW8SCDLe8P/GX1odt2S
	sdbSZeGNmt+kGWkllUSdSG1S4VyezjbLvruLfYQQ9d3QdkO0BMZnA9l5El2Ehu19kNbvroBhLdd
	Es3cFW1wub/TGOEJvIMgnPq82ZY7RiOdmOVYZvTw58tbMTbSb6/NGzjwa9awVYUWpppnTx2qzj9
	FesKBsCVlCbRtK7TFTS7ELJ7QlWxK3Bs8smzS9o6fJtLor2brvRsaByHiBIfAlA+nplxZcAUP3h
	19+SKn/uXM1huF2aQeOZvAliYxGozI9x+zpLjsYGBIiXvqedzns0DAO4/TeSjfa62Chso0beTvO
	bbotVz+VwrL4yDWAOJqvY9Ip9JVZNen1x+b0pdSAm8sZmOkOE8OkoZ8ngiKHB9os3rZZqgI1WAg
	HTcEnVj1KFHIxlGcySCMJVnqMHGH1HFZDQC0yyhLI=
X-Received: by 2002:a05:622a:65c1:b0:50e:42bf:70fc with SMTP id d75a77b69052e-50e42bf7bcemr14602771cf.50.1776472351807;
        Fri, 17 Apr 2026 17:32:31 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.177.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e394addfcsm29411511cf.29.2026.04.17.17.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 17:32:30 -0700 (PDT)
Message-Id: <663816a34496e4d6bb43b815e8a59bf1934efe62.1776472347.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
References: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
	<pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 18 Apr 2026 00:32:25 +0000
Subject: [PATCH v2 1/3] patch-ids.h: add missing trailing parenthesis in
 documentation comment
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 patch-ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/patch-ids.h b/patch-ids.h
index 490d739371..57534ee722 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -37,7 +37,7 @@ int has_commit_patch_id(struct commit *commit, struct patch_ids *);
  *   struct patch_id *cur;
  *   for (cur = patch_id_iter_first(commit, ids);
  *        cur;
- *        cur = patch_id_iter_next(cur, ids) {
+ *        cur = patch_id_iter_next(cur, ids)) {
  *           ... look at cur->commit
  *   }
  */
-- 
gitgitgadget


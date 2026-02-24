Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D823EBF17
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 03:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771903954; cv=none; b=jqWT2/i+I03XT8L6XeR0IFU+pOy/h+EQiz4gFRrzfVfF3DnXWfetN5pKFa2INa6zEEEThImFPss6dj9z2bjrLt5czZT0ZK/GAit7lW9kNLL2xb+SxE8jx/+Wc4BGttSJa5CHRG26NqQxXWz4IPl+2zr+vwKoBocAIKZf1DgeDps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771903954; c=relaxed/simple;
	bh=DbBtxKh45HOIPrQNnKF7iqwRzEjbB+zCEVIH7Rh9It8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Yz/XnXU71L2wvtJM228QjT0P2LIaegnBAaY49N84felNHpRX+QjPK0hJ8hOMHe5go163gq1YgCWpqdh+s3jaPmy9e0XhGWjBAoe7hoRkI0LY0eyp+X3NTRYiE4AUxKqlZhtK2IeAbtYkVkZmnP/6f1wA90OB54gN2rKhgR1jWpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFhpwSZ7; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFhpwSZ7"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-899a98c2421so2315646d6.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 19:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771903952; x=1772508752; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/chvvTWGwht57g82JtwCzb4MI3beCAZc8XyFx21ZOo8=;
        b=mFhpwSZ78ZvInHfnJ7DREZ087ajwAiuCTbuTiyLThVtY2u8xh3U84obONR53qjAb2h
         FEInFiiTg8zjYzlYm2ib2xxAHHqvt3PQh/BwVYPrOaEc1uWzcc7WKYn9uKm98JQU5/Em
         eN7tW5zIGt/up9hhfZYjKVkpHbVv9RT34D0op2abQnlMjx2hrq+hQWudLaP9qbV1imyP
         UlQqu2uISeIpCLxI0R8kug7L97vAF7VSz3m2teYvYzQU49Hwfy1FOtSIcWsyipQ8y0ly
         vL5gFp00Fpr+16eePrQ6bD74LdH4HINs02JQ5Jw4hEAbPW8gbNOVy2RJNcbl8AYTnkW6
         ttMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771903952; x=1772508752;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/chvvTWGwht57g82JtwCzb4MI3beCAZc8XyFx21ZOo8=;
        b=li5V/EiZtqdZwx2jjnmOea/UHQPchGZRxb6llMs85HqpKlI8BSPAoDjJMQbFZ82yiC
         94Gs2pO/CNUhrVZrWs59DwQy4JSFNKGhKZvBRYKUDYxaN1IoMJtNWDpnfsw6gnjQ3elI
         DnecWGLA3oZqM7zddFyNA53f/AubZtYycGCZ23ivef9nNz52RwQ5FkoGBJlmycsnJQfp
         9p0Dw66KxT1PPndOYoAJMmllMknvR/evdwwkKFXcLSy0+Oik9aqtrTmFIrOolR/SYQd5
         UKs4+hjKvmLVKOnwGRL5AZLRvljo+24vmzehcnRCI0Q0h2JwS2rRy8/oGOAPQvFXiavv
         DK4g==
X-Gm-Message-State: AOJu0Yw14o8xFStgkc0JIpMgWh5TVyAMsss8n5itpVdgFnWuAtB5ni/a
	Npo6Ctc6s9IeCovUvmDE27ksFGDFx+ohba6j9Ivz022vzVA19BPMZQcx+IrKvQ==
X-Gm-Gg: ATEYQzyC5JUqajMpQDsFOZNASnMgHLjhzzmkzegK/zP++jVdUYiRRSuZWY9Y3yh6MQW
	iMoe23vQzk0i6vj+eUwU8R1QojtY2AaLd2tLufnLc2F20BmP6nUEzVSkn+1fcSKN1KlaLajVa4S
	0+A0MISKmG0FmKYIsgi76jr3dfW/PTGpez/julvdzgE5Q/zQCDVhwkLXNbdI/kzXMkKjcCgq4k8
	l1hu9IIj/7NCnE5RjS/1lInvTvK4qYgne0DD3kgVnKstB07HWw2QxwsQlvuDtlaWUeVp/KF6xKi
	53fkgSaP9rn72EsPgKBwsUyqc7Enu2UtOwdrYw3qBCaJ5MxjUmUTH8bC9zkDc+V0G19EaQvoW27
	0+2wjzBYz9b2u4xmCWA445Z+xbr/SrRiVyKrS/CTLYk9kZVcatOg2V7ix3KULAItEcMpPJhKOn/
	LfLtNmv+E1/m34MzwB4Ha7Iy6z
X-Received: by 2002:a05:6214:f05:b0:895:c06:8cbf with SMTP id 6a1803df08f44-89979db8304mr172570836d6.62.1771903951783;
        Mon, 23 Feb 2026 19:32:31 -0800 (PST)
Received: from [127.0.0.1] ([20.97.198.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e6341c4sm86136096d6.35.2026.02.23.19.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 19:32:31 -0800 (PST)
Message-Id: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Feb 2026 03:32:28 +0000
Subject: [PATCH 0/2] for-each-repo: work correctly in a worktree
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
Cc: gitster@pobox.com,
    fastcat@gmail.com,
    Derrick Stolee <stolee@gmail.com>

This was reported by Matthew [1] and is a quick fix.

[1]
https://lore.kernel.org/git/CABpCjbY=wpStuhxqRJ5TSNV3A-CmN-g-xZGJOQGSSv3GYhs2fQ@mail.gmail.com/

I also took the liberty of removing the_repository as I wanted to make sure
that wasn't involved here.

Thanks, -Stolee

Derrick Stolee (2):
  for-each-repo: stop using the_repository
  for-each-repo: work correctly in a worktree

 builtin/for-each-repo.c  | 10 ++++++----
 t/t0068-for-each-repo.sh | 22 +++++++++++++++++-----
 2 files changed, 23 insertions(+), 9 deletions(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2056%2Fderrickstolee%2Ffor-each-repo-in-gitdir-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2056/derrickstolee/for-each-repo-in-gitdir-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2056
-- 
gitgitgadget

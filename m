Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473D93EBF24
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 05:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771046196; cv=none; b=eWNuV5vJiPW8R4bVNqSDJw2ZXVLx3JjFTdsO41i+RcAm5NtAs3BAxKFQAZbdVY0BACoYN6Szcrx0KNnNyBPEP+ucKEkRrHrNHbzgqqCBnJ2dKOHJa2TdFLIn7LWWczHcp9KQeikRlv+pJkW54/iTFyCM3A736WqAnJCdlAtVmU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771046196; c=relaxed/simple;
	bh=Hk5gGZ4F+1ohQ6bp3YM2aY1VfWviIF2z27XHH44DAhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OU0amzcl9/OzSX7vK9PzoUQqgE9EHEfoCDF3wEhCEtUYCPq4Arp84oSy3g9a5bsWGjrhnYsMBjdH84Oyzh0zTHBs1qESqWg3jwPwy38NbD6JtHpWPFzX5iwS5M7L1BkHbjHZSY29JneKXDXukFeTNJYcbMnrjmYxBI4orMp/4Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSSNN7pf; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSSNN7pf"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ba94dbf739so1746562eec.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 21:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771046194; x=1771650994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I6o+5Qm/wMRaSrARHbKm6a9P+b3RD8CvW7sRngxj16k=;
        b=LSSNN7pfkfXHmXds1mUY9S5AUi5eBOS/wdgUybaZKCREXa64ezt82fTVD2rpRhr7/H
         qdFssI5liOHSQbYaJAK7QArmXZw7QRf42OqjNFmaaDAUqoyvFeBTdSuVkmr4awAB+xxP
         V59kMsDyGafClOf0gN99zK1Qr/riswC2LfqlARMiKzuzr65NsjkxewOFsE/IUQuPeF34
         sl4Zgnbub1Ov4sb6flas6PRXr5geWLqusJ1Xg25rFce7tKZt3aaN12ON02ovSjBsR7hC
         5QWxzdYgrpjcUvGblmXw7OIMHr6w3mAG6F8FZyH7J3ZnB5YTpJ41/agczORk+k01IGZ5
         0GXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771046194; x=1771650994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6o+5Qm/wMRaSrARHbKm6a9P+b3RD8CvW7sRngxj16k=;
        b=DVWET8ZAPC6Miw2QEfcD8VVH0KuEoVnWWJkD8tJBjmkNjl6lYOz+niBhN+zM/sG73O
         sTleQ8IjJbLubI9pb6wtq9Ft+mGcflt1jrthSah6nriQ/83+pf7x6wi1i2tVKqeCFcal
         0hgvB3scqHjV3go2vvO7oU9Rg0U8ZspyBkzV4Qmj7byGnBqXycY+mp6rVy0hmJ2/4+Xn
         zHzZ5SfnjXuDGjjzxIpDXeM6EFNzdaC6O4HP/1GZpg/OXSUGw36I5Ywt5qpMFoyHoTCy
         KeMB61hmgBAXjB8aR8duV0ijf7kGgUs18sOr7D9z2NZHdH48TVNFS3oQw78fHyMl3kSN
         NS7Q==
X-Gm-Message-State: AOJu0YzXyFAIurZs8uIM0U4CgeqLC2AMQBJU0Is+fKSrSB5eRVyD9q0G
	1gTwxRKdz9VV3K0usjj14MLjfGtZ3lt5tvkX2x7Ok3Q9i2xTggm5d49NrZYKbw==
X-Gm-Gg: AZuq6aIb6Flh6skulSm5ESS7waqt7u2KgAPBhP4h7CyzBcZbYln/6Xo4KnKHXgB6UH9
	Yt11deYXVI7uykcZgQNkv3oMMOsWmpe6XjD7I8YI4QvTXhxjrfz89G7EZfPvj23qlWhsVQ481zX
	UiV2k6n9CJAAYqEVmTTRO+i/+HbRU0J6Ok1dX1mM5GBFDJ6V6kZ/bWfsay6IcsPj6pAfAkrFBpw
	oP2M30nWvxW01AmmS36Gy7GF401VuVQk9p+ssJhs4FsPGRql8R3BDVzFVGuPF39BcSbWYono3FA
	/2KHZePM4E4aZDA3bQOFbmoSnI0vKp+C+WUGCOFRd3X2BykkzxZwUFu+dwLVHrT6OH0XQm+cfPR
	4oEfqbcfanwJnRPO+aN/MN2k66lpB8SLKhW06+K/dwVUDunkftYWmHI9cANE4jAsUhiPburlGjj
	4uiGeDe+Jt+OwWJ7zTbnWdvokTZ7bcydtzpqs=
X-Received: by 2002:a05:7300:dc86:b0:2ba:6854:8d43 with SMTP id 5a478bee46e88-2babc455a47mr1543631eec.23.1771046194334;
        Fri, 13 Feb 2026 21:16:34 -0800 (PST)
Received: from localhost.localdomain ([2601:646:8081:3770::996e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb415dddsm1104325eec.0.2026.02.13.21.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 21:16:33 -0800 (PST)
From: Collin Funk <collin.funk1@gmail.com>
To: git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] ref-filter: don't declare a strdup'd variable const before writing to it
Date: Fri, 13 Feb 2026 21:15:57 -0800
Message-ID: <c752a4a6c750bc485804b43d7b525754e39e5fe0.1771046151.git.collin.funk1@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I generally don't like the casts like in rstrip_ref_components and
rstrip_ref_components because they force you to write this:

    free((char *)free_ptr);

And the const doesn't really benefit readability, in my opinion.

That is a bit of a seperate topic than fixing the warning, though, so
I left them as-is.

-- 8< --

With glibc-2.43 there is the following warning:

    ../ref-filter.c: In function ‘rstrip_ref_components’:
    ../ref-filter.c:2237:27: warning: initialization discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
     2237 |                 char *p = strrchr(start, '/');
          |

We can remove the const from "start" since it is the result of strdup
and we end up writing to it through "p".

Signed-off-by: Collin Funk <collin.funk1@gmail.com>
---
 ref-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3917c4ccd9..183cb6bbd7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2214,7 +2214,7 @@ static const char *lstrip_ref_components(const char *refname, int len)
 static const char *rstrip_ref_components(const char *refname, int len)
 {
 	long remaining = len;
-	const char *start = xstrdup(refname);
+	char *start = xstrdup(refname);
 	const char *to_free = start;
 
 	if (len < 0) {
-- 
2.53.0


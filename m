Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7199A37F74B
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 04:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781323589; cv=none; b=A7h+xnhRyPKzVVAz5DVgi4Q6zpE11Rw4tvMPauklp3c9oxvLRAt3wXDkz0cayqAW89l/h0WG3DTcwS3mT887x/HOQxSDZIv83LcKca+ZxWGZMxyl4Spfizba/5wrZX8lDHXdgxkorvSDiYJGR/1whVVIj7+6Zzl4ZbhSJUXgplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781323589; c=relaxed/simple;
	bh=ykxJUnrh+c0/8at5XLmQ951zKevR+SiIldniQ6uOMco=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A9mSQROJCFjmHyNjtQs9zkWKfTbcgmCsZDTEmCKXN6jDeX5Xt0SmaqBvUjIZLHo4pwrfPuqeu0nvYtK2+efJE/OHG75eJUMyJz6zcuthAKi+iGVsc5abhDMBcey1QrcKEzGvl83kgnZT+XHVLfqimqg2hcBwUrUgTN3IxaeT460=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rDUJaAtL; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDUJaAtL"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-306f36df4feso1225982eec.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 21:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781323588; x=1781928388; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qPS/vAQr3uX9zCOah4thP39LBa0s8D9VyUYAqq+pa4=;
        b=rDUJaAtL9t3WniChs/aultDzn9v29cdEP/sEvOYYPH4YeatyDjUhRoLzkAT3fUc9xx
         M3fYER0W9pqvzzNiPn5AkrLQK21Ck99ep4VYROLKd/yl69ikMD+5/0B+bDT14fmCsPUp
         p1IIOEfTEovcT/Z1JsTpdF0yh4HxTlqc4EMTkoYlU39ojwzB5eT9ZMm/sJDUnhF4s6k7
         cEJQNZwuQQiwb11RXHgRjHSqGOetrJ/W0f0wPSZWhLqDcsRBAYMXgQ1o2/v7Z0Adhdip
         rFBq15ycX07bWgZY8gWvGs8mWRHAXq//Mw+CeE4ICJwhWDRr0EUXiJmE2DICIocxCRtl
         u7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781323588; x=1781928388;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+qPS/vAQr3uX9zCOah4thP39LBa0s8D9VyUYAqq+pa4=;
        b=dhrM6X0EjU+jxBF0i2/kF28xDhzMC/MvGMvzFQGyotjKsADVgdaC0TQEjAyPOR86N2
         9nn5llFcY7R+5Z/4INwV92b/f9ozZ43ooe0Nzu/8N1OVcv8GR4+6Cfj0LepjJyiF3eVk
         2/Xv+YauII9abPU33DNp0F07I1TdfwxLjwhy//qAEeXg3h9YMkWCVWZszNo7emTRrx0I
         Gw8aFwn0RqE9hXDZYx/KtF6ABZoLBxQoMToA/3OQGN6iLUSaQ+CGqhldUrq2c6KITDsv
         h4n6aVLx0BWzlW+Jv8gxjxauC5wzcqw/d9DhLSXZwA64z6AteGxYYFgNVeLV9t186c1B
         bvGQ==
X-Gm-Message-State: AOJu0Yx4cTc7yH0399wtMd6P9gQFmgvjd3aHigcPGCW34AWW7E+ib0HD
	JAmXyzUJhPRXreCP4vJ1TBTdQ0o2LaXWRVhSST8szB+lG/mD3E2EnT62tHfaGA==
X-Gm-Gg: Acq92OHv6zOJ4n0SPbvVL815CvnEuvvihyyg6lJ08jWwhW5y8ENXBv1BBVN8nCiE1C7
	ErIN5DBnbgoZ5q8lgIZoB+nM6wXYwBXfgu64JfkgQb/O5CAEhKu2JSayjVgM0RJ4rtebv2caeff
	/ioOgoo6p4GQm09W19RvwYc6PpPvia5mFC+IOoApI/yis+OaMIePP3EaIpMxLSfREl/CrJLoeOS
	rKAn2n98e27eFIddFQwjQjxw6h+fM7EKMghIVXaU7+fjJgDF0usxjOjbNxU7mUHtU13qXkGKr4S
	rgj3L0VifmRUaue1eO7ZY4CVJZZzqhI4OK+LXS0+/VxLF0+yBXd3ZOjuA+XdmRc/WVvQ3P5dECc
	FusT5U7maSub5ftB3kE0qLqdECSr4pE/5/qTSYpakQ/ajzhSCmuIx24OItIOhZsa3iMdZEtS0um
	1PXEAEwj4MeuexRdnoU91JUVvZ
X-Received: by 2002:a05:7301:4b18:b0:304:6822:2cb2 with SMTP id 5a478bee46e88-30820cc3819mr2487107eec.11.1781323587510;
        Fri, 12 Jun 2026 21:06:27 -0700 (PDT)
Received: from [127.0.0.1] ([40.65.56.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0357sm5751766eec.11.2026.06.12.21.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 21:06:26 -0700 (PDT)
Message-Id: <c1b86748d1798db3f85f25654bdec34f36e7b591.1781323575.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
	<pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jun 2026 04:06:13 +0000
Subject: [PATCH v2 4/6] t: fix Lexer line count for $() inside double-quoted
 strings
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

scan_dqstring's post-loop newline counter re-counts newlines that
were already counted during recursive parsing of $() bodies.  This
happens because scan_dollar returns text containing newlines (from
multi-line command substitutions), and the catch-all counter at the
end of scan_dqstring counts all of them again.

Fix this by counting newlines inline as non-special characters are
consumed, and removing the post-loop catch-all.  Each newline is
now counted exactly once: literal newlines at the inline match,
line splices at the backslash handler, and $() newlines by
scan_token during the recursive parse.

This is a latent bug: any consumer that relies on token line
numbers rather than byte offsets would get incorrect results for
tokens following a multi-line $() inside a double-quoted string.
chainlint is not affected because it annotates the original body
text using byte offsets, not token line numbers.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/lib-shell-parser.pl | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/lib-shell-parser.pl b/t/lib-shell-parser.pl
index edbfee0839..c91289dfd6 100644
--- a/t/lib-shell-parser.pl
+++ b/t/lib-shell-parser.pl
@@ -93,8 +93,12 @@ sub scan_dqstring {
 	my $b = $self->{buff};
 	my $s = '"';
 	while (1) {
-		# slurp up non-special characters
-		$s .= $1 if $$b =~ /\G([^"\$\\]+)/gc;
+		# Slurp non-special characters; count newlines here because
+		# newlines inside $() are already counted by the recursive parse.
+		if ($$b =~ /\G([^"\$\\]+)/gc) {
+			$s .= $1;
+			$self->{lineno} += $1 =~ tr/\n//;
+		}
 		# handle special characters
 		last unless $$b =~ /\G(.)/sgc;
 		my $c = $1;
@@ -111,7 +115,6 @@ sub scan_dqstring {
 		}
 		die("internal error scanning dq-string '$c'\n");
 	}
-	$self->{lineno} += () = $s =~ /\n/sg;
 	return $s;
 }
 
-- 
gitgitgadget


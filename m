Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F8349E5E5
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062055; cv=none; b=tBJogU8IV8odwIHvhz7J29fcD3hy63qeL1755O0xh3GkqwKpVmvN+Yvzd2WChv7dXHmihlbY1JZ5yjC3Rkqrjo1olYemWHlUUIAKsqN4h2EWZTIv308NFlGIE9zHakmB4x8NLQ0j7gTRK1FRODnw97EGGDnmqRK9hnbuAS/Kmpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062055; c=relaxed/simple;
	bh=mFZPxUBdK3VLybwLSQfUvJJh4q5ZMTX2ciSsAv0dqpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiqnMLOSSiHfwBx3ajgVARWxlkzn+4wpbKEpOIPO4nJj7V1u0zZQ+MHJeOI9nofri7GDXg1v87y1Cbnj+iam8JdfJDR07UzUqcv1lB0mzalgFqTIr+UV/i3KjQ1YbmGlpTQxmjAGYNgFjincu2l0ccxV0DkgFZ+SqhLXdrfGAzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nakyX0nB; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nakyX0nB"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-988ccb8da15so943624241.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 04:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792062050; x=1792666850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5/4VpmSfXWie6beYUPbW/cyH9wmD1ce32/Qr18x5iJI=;
        b=nakyX0nBh7aVjn+YWcJZWdIZ+CDpNJqAiNf7gztdaOvULgjwPzBk4laEn5lYD1YNB8
         QAHd2A70++7P8jZdNi2JJJYkLGz0wLBTDAp8yaZ5GDtDdfRxDtemrjNBrIbs+sg7T76y
         27++5Xpuud64RtPRguWc1RuaYrhTzw9qonVTTI78yukGgW0HE7T+aAchgL+kBPHdPTaq
         +JERLyLd/CH6AczR1yd3klpbxaI46p8rIMyO1QI7QvVieuj8tPW2EPvnIBsQJbfPOg60
         yrmv0ij8FnfjjvpMsqBHthxkFPkzcEaKAyNpho7foA0eerFvHtzFpV4gaP1PK5evaxpX
         mpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792062050; x=1792666850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5/4VpmSfXWie6beYUPbW/cyH9wmD1ce32/Qr18x5iJI=;
        b=rSY9VLCSCZs8hWgwNSkLYPgimYRYkpKZEoAfGWO1nNTWzuEhqEEn5CTvEPmvLdpKo3
         OP0rnsA7LYYLe+75aTITfumft/L3Hgh7a0w93LTtI5YTOlFWnkUch+3Kl7j8ipdi48pf
         A7AkZYuE8tM17XfbPjOzJsLTLP7LLHo/2YltpcOMEfBdEl5ukwoSBpLVf9hzbUae8h0z
         adSkHddedAnl79jm4M/yY+HE/e6mVls7Si2JiwpUREFDe2UMqQID0gRLOXlugxqfeD9J
         l8aw1Svyl6Q7LMAVSvutv2Ci7slhXslEc6UFNNRj0CavJTxIHCSy3YvnXLB+D1rDkq/k
         UxqA==
X-Gm-Message-State: AFq9FYJLpwSoTb1X+a28jA+qe6RgDx5isDqq4l0fuATmxuRj/drtMwCN
	GgX2pmTc6Rma36woeRxfzo2q6VKNDSyM+FNmzEPJ5FWzxIM6ncSNrI+/EiZNRziK0ls=
X-Gm-Gg: AYBFou2KhQI7hmC6O4pHgONH52BR2yaY0H1/6HcPqe8ZjTnY4Sp3OKZBBl69RPkcfDp
	h09gJ0SnJS+xbJtXoqdQ+BkuDiQs3GB1QwYLDhDozwK+VM89cdCb4srZwJdc5vKO+5cC7T3y3+F
	oAqILX4Z7aAfWGDjNx1Ack/OqO5zU9MYYLSZZQTmoRdnGxerfPT/6vg0+SvmoTKoxQCqtJuMM5s
	p8tJKB+YYlDBJmRCPF30ox0qWeJT0nB6C3ZfRE6Od/rWJCd+LHIO1+Q4yHURGqkhO7VCXLJDJY0
	Tmd1P18lkAzamGHwRdoVAduFayQxmf4MGm42huS7vIdQ3GbWuYTm2iiWAzfOWieGvJpoVK5MrCo
	5b280+bY9Eq2/cSSzJg7FBMjMH7XIheWlPRU154MVIStXyLnyY5Vk6gSu/LcYNaVlDto7rplOD4
	g6AuJhaIk8NcDaaNtkV8qlWNAhbsRlV43KuMVXG4SQbk6xLG6N1nOgESmsm5j6Bmm6QnCLf75Kl
	gDEhf96b/1pp9KA+JlsKrnLtEDvj8hQ4e8pJhdS8rym
X-Received: by 2002:a05:6102:5cca:b0:7c3:881f:b620 with SMTP id ada2fe7eead31-7cb373134afmr4082629137.21.1792062050162;
        Thu, 15 Oct 2026 04:00:50 -0700 (PDT)
Received: from isabella-caselli-linux.. ([2804:388:d001:9f94:7eb9:62e0:e1e9:151e])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb35471536sm13099381137.11.2026.10.15.04.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:00:47 -0700 (PDT)
From: Isabella Caselli <bellacaselli20@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ignacio Encinas <ignacio@iencinas.com>,
	Isabella Caselli <bellacaselli20@gmail.com>
Subject: [PATCH v2 0/3] Add hostname condition to includeIf
Date: Thu, 15 Oct 2026 07:58:56 -0300
Message-ID: <20261015105859.3184108-1-bellacaselli20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012015846.2649843-1-bellacaselli20@gmail.com>
References: <20261012015846.2649843-1-bellacaselli20@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a "hostname:" condition to includeIf, allowing a
configuration file to be included only on machines whose hostname
matches a pattern. It also adds GIT_HOSTNAME to "git var", so users
can see which hostname Git uses for matching.

Changes since v1 [1]:

 - Rewrite the commit message of patch 2 to explain what the test
   no longer verifies when the hostnames differ, as Junio asked.

[1] https://lore.kernel.org/git/20261012015846.2649843-1-bellacaselli20@gmail.com/

Isabella Caselli (3):
  var: add GIT_HOSTNAME
  t6500: get hostname from "git var"
  config: learn the "hostname:" includeIf condition

 Documentation/config.adoc  | 14 ++++++++++++
 Documentation/git-var.adoc |  5 +++++
 builtin/var.c              | 13 +++++++++++
 config.c                   | 17 +++++++++++++++
 t/t0007-git-var.sh         |  5 +++++
 t/t1305-config-include.sh  | 44 ++++++++++++++++++++++++++++++++++++++
 t/t6500-gc.sh              |  2 +-
 7 files changed, 99 insertions(+), 1 deletion(-)

Range-diff against v1:
1:  a34e1eb36f = 1:  7609601553 var: add GIT_HOSTNAME
2:  c341ae75c0 ! 2:  cb1599c7ce t6500: get hostname from "git var"
    @@ Commit message
         It gets the hostname from the "hostname" command, falling back to
         "unknown" if the command fails.
     
    -    "git gc" gets its hostname from the system and only checks whether the
    -    pid is alive if the two hostnames match. Otherwise, it assumes the
    -    lock belongs to a gc running on another machine. Since the test passes
    -    in either case, a missing "hostname" command or a mismatch between
    -    its output and the system hostname can cause the test to silently
    -    exercise the wrong case.
    +    "git gc" only checks whether the pid in "gc.pid" is alive if the
    +    recorded hostname matches its own. If the hostnames differ, it assumes
    +    the lock belongs to a gc running on another machine and skips the pid
    +    check. Since the test passes in either case, it may pass without
    +    checking whether "git gc" detects a running process on the same
    +    machine.
     
         Use "git var GIT_HOSTNAME" to get the same hostname as "git gc".
    -    Keep the "unknown" fallback, which is also used by "git gc" when it
    -    cannot determine the hostname.
    +    Keep the "unknown" fallback, which "git gc" also uses when it cannot
    +    determine the hostname.
     
         Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Isabella Caselli <bellacaselli20@gmail.com>
3:  a1e4fc5ba3 = 3:  5a2bb2172a config: learn the "hostname:" includeIf condition

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
2.43.0


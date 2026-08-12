Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470F73ACF1E
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521196; cv=none; b=Uxq9mO1NLOkdUHOo7vAq/uoUsaFYx9gyWBkTUlVVXhVpB+dH3MsyPjx73PHcn6rQJJ30qst02DJ4I/0xF1vZRu65yXB/04WsW/i7kgLnBzd5D0jf6NVsXNijkii+FhiUtjS+lGK9i728FoIpSpJrje4IKqPMt4sYoJXiPToi8lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521196; c=relaxed/simple;
	bh=H0PizsPPV+MUAUIJw03y2J4nzFYS8HH7EkBFpHktLpc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G8DSvgtJd8bKDd9xS2NqjSLrVUFo0cRN+n1gkurVnB0i71rDVdkhKgC8BdbiNumX2fPLpWd0UXObWM/vhyLylqmbK92MFbWbZl993yEeOm2XjUsZQph6W5ADsroO9u8HrCGV49bAvWO0eks/S9a6LfNPL+/bSy7G7qfv/+ZgKyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcsOsb7o; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcsOsb7o"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d02b4c3601so4236835ad.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 00:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521195; x=1787125995; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BU7QYyd1JGW8st5nbHVrxZlsyyeMc3aYDaoFk0R7Cks=;
        b=CcsOsb7oNzZC7BM4mvJav6V7y/3bQ8r9ka+iHDw15S8Ouj56df//XmEuNgZMuC1+I0
         47MR1ntNk+l9kJdyEn1jbl8pthKPxDmRp1Hl/B0RTcMpyI4mQKKXJuqlhxN7LdXbZ+Py
         it85PAhAVlLBOVl8fehYwK4GnLp4ehWPCp3HLpgqO5yu2MvGq+6dnSXr3QNPHJ5vL4K0
         knckNL8mXeVdYO2IyATZWRnhTyN3wB4C6n8Pu8M75L+w35GYRJFHNve7X0ZGIj8MFaSB
         uzwp56tSanUvuiXj//sdkFdTn834KwtUZ7KxKe4zBNM50kjY76hh0CMeg8phWtESW+8o
         F7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521195; x=1787125995;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BU7QYyd1JGW8st5nbHVrxZlsyyeMc3aYDaoFk0R7Cks=;
        b=U22UmfLDwr5I3ZLJvrIuqCP01XcgGiy+PJXk2irDNV2tmfquIpRKTEymzPpdsIUImt
         zv2EhE+Wb83XVZZ47ehORX7nW0+97q6dKHnrSVR+EeEL3YNXcoa8hfjP2tV7JVat3KVg
         RpNmB+5wmdMlR9VmBrroQsGZp61pM3jR6X5hI8Z4lstm4+Djn5sU+gnnKtTeoLCoGGVx
         /rezqTXUe1UZRDsgmiL/jJepfrVs13ZJjdl0sqamXCbYgmYDdaj3+gQJMo52SdNicQQ0
         S6xETvgYsyyGcnbKGgwrEWF0kMFDrlmlqr9ObCh0BrzvdBomrxkJj3bk2uvG2voVQx6w
         haxg==
X-Gm-Message-State: AOJu0YxV0ekbyM60SZ/1P+HfgrtC00e1cErR9j41xlJwElhSr4J9nCmo
	Oo3Psd864Bt8ajgnkewgRJvp6qcfWUOauE5ZRIkhY7UWEzGkFmygMA9f19HZCw==
X-Gm-Gg: AR+sD123yPzxvBjz6lx2kXe+s8hNzIN8PPWA797dTWWLLHW3ILOdEM7PRXFPjHOMmXP
	xHjLfh1WxZwgXB1SeTzMhXGXRUs+kD7v4TSiV6jG8xiWygWcBd2WDVoLiBd0XH9M+hbzJvCn2Bq
	PK+B/nY4K/1b7AYWpGFC0Ts1y63kKyZq7tK0YblNlhwAiM469BAnloYj/i9MFQ4uX9gQvS0KZBx
	C3eoScc7uDhz9AEfjTrc4QZ00Ur4WFvkESDrQuAKl3qjnBIKzStoVP6vICYLSJCTmfNe53FgZ4/
	BOx99L8B8l0uKQ4f7s+cXjfFqx42NRM8/B88mKpA+lS24oQYKio08rpcPE4PDFWfAM3pEoOxAEs
	/5abWbgtVpZDmeuswkjqiPi9HNNAWVpxG4gST3wnjEl8iLtxRRPhKOP0+8A9vVaFLdnV/WIoU4v
	KRMlYxP3n2kz/tc4ijX9+xG2Kr09zbrzyxMh1uhAbtq2zc28qBoztS58fHT8P7GF09
X-Received: by 2002:a17:902:e746:b0:2ca:d151:383a with SMTP id d9443c01a7336-2d345746899mr34130515ad.20.1786521194549;
        Wed, 12 Aug 2026 00:53:14 -0700 (PDT)
Received: from [127.0.0.1] ([20.184.150.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d350feb6e2sm2759495ad.20.2026.08.12.00.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 00:53:13 -0700 (PDT)
Message-Id: <d44d05c897006b96a2b897acb030a4331170caad.1786521173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 07:52:51 +0000
Subject: [PATCH v2 11/12] mingw: ensure valid CTYPE
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A change between versions 2.4.1 and 2.6.0 of the MSYS2 runtime modified
how Cygwin's runtime (and hence Git for Windows' MSYS2 runtime
derivative) handles locales: d16a56306d (Consolidate wctomb/mbtowc calls
for POSIX-1.2008, 2016-07-20).

An unintended side-effect is that "cold-calling" into the POSIX
emulation will start with a locale based on the current code page,
something that Git for Windows is very ill-prepared for, as it expects
to be able to pass a command-line containing non-ASCII characters to the
shell without having those characters munged.

One symptom of this behavior: when `git clone` or `git fetch` shell out
to call `git-upload-pack` with a path that contains non-ASCII
characters, the shell tried to interpret the entire command-line
(including command-line parameters) as executable path, which obviously
must fail.

This fixes https://github.com/git-for-windows/git/issues/1036

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index e0fbd2c66d..afdc1ef2db 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3185,6 +3185,9 @@ static void setup_windows_environment(void)
 		if (!tmp && (tmp = getenv("USERPROFILE")))
 			setenv("HOME", tmp, 1);
 	}
+
+	if (!getenv("LC_ALL") && !getenv("LC_CTYPE") && !getenv("LANG"))
+		setenv("LC_CTYPE", "C.UTF-8", 1);
 }
 
 int mingw_platform_has_symlinks(void)
-- 
gitgitgadget


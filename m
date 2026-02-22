Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8C43EBF1E
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771769276; cv=none; b=WWQYStZRSi78GiB50Bo8Pl5jQs9Sbi/o3L4hQmDpKb/OOra4hkpRQEGtpmzskFaUmtMjxvP7HIqXb4sQPfti00sMm0+uJwq14s1qydwcjJMffdAhiFzhjs+TF46uaTwJ2SR7VCm8X7ujKhns75yaTOFPCfpS/kihkpbGnEtogAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771769276; c=relaxed/simple;
	bh=xoZz4RsKiEwfKYvJxO0Ua0eFzANqKvazXCNuLfUkJuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AdzeqV1dP/51D4cJw4fDx38hHNR8rvff6LDCTfs8ZfVkKu0u8g+15xwQb8/aXad6CQKvanbTIMLiORpvuNtZ8sR/6vp/MjavDdSb6UKg6JqVvcoWLlAJu4jtabKHeNnWsxKOBDK9aRqVgZtXMQ5zBibouQH9v2lSzZqWEx0yMHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AU+biZD9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AU+biZD9"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82310b74496so1810173b3a.3
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 06:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771769274; x=1772374074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jrJ+hxxGXyNty3BEXupWBIna8+GgVNdcNdBQ8JzEMg=;
        b=AU+biZD9mQx2+LLfrxLK6xn/AKREprv2Gc4ZWvt/2ba+9vdTFTzuWsocWN3SSrNqZ0
         QcBXtAW2yCMjPFmQQbHzv8vLvmGbdznvVZdMuO2ZiBasIYStfndqrQkenhzdIh7KpYAj
         UI4xzGhQmp1Fdq7yONpBedM85xu0JSMKLHbUH21u2PYavTTBaO+VQf4fSbCOOwfTap5W
         enBQ6hFCEwgJsdPW21M1U8GUqSCWCcyRiDhFd9i6TbnanBeGHzwzpzWRY0otBh5Vkzh3
         sZaeRbVTp5JCEWfE666OAEYhxhlArN1gh7tVPNxGUsTEJu5YZ/OgiNFUDTIwtrmRQUjS
         mYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771769274; x=1772374074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4jrJ+hxxGXyNty3BEXupWBIna8+GgVNdcNdBQ8JzEMg=;
        b=Xkav1W2VDR9ooiRS0A5egMbANvM3LtRT7EDXwS8QyDo3wGRNBUc1D7angwe2hKtx4v
         9HtFnm8Uqsq2Ew0oE++yuq+B6+3Un7DKUmg8QNQX2jLppF0cKboUAR9dpEsjvhs/NheV
         07mGmz0Npj5bciN6Cci3hURcx+KEp2oASTQe/7WoHa4GD2zeIm4oVgGnFZgWTZuNX16l
         Jl2wUPmgU5KQi5QPHw8ej5Da87vDi1sfmH98ukkYPTYfCjlIi+73t36zIyfjJi9g0fNl
         oqbajQRjJdU9O8uUEmq9Gx1FSmA9vY8R07G4zt+2d7OCg9vhhgRW2HZbCn2G6gChP4P/
         MvVw==
X-Gm-Message-State: AOJu0YyGdSJAhSIzbxDBEy3XETRoBPEXYbVRexy0VdaS+Qq0Ck0nc0vn
	ykr9fzS761kLn2TPcPSaqNqMWwnKH7fj8LG5D5fVJbdhrgTYYmkHYmRChxPgXw==
X-Gm-Gg: AZuq6aKlBi/2vI3BeJIA9va5QxHoptL7owY1S0AxN2QNQcnHLWYuNhyV3lei7ZCbPA2
	e71kNT6nO5GyoCF0AzypRvmHzBG8DiFsByev/BiP6NdHf04d/OvXgmEwGv3LqoLKPJZdQIAJhM/
	UtriMZXuv3eCZomhxWLSwy9Ux/2xk+/WbEuaaA/TBP+fKOKBK+tioEjjC+SLZquvQVlCltm2zHI
	N1Y2+eNo/wVL3v/Y37VNHQBC1kAChlBezFruCpaADLG/ajs+bGIgeSk/fwI4avzX4LKEyBY3EmI
	oMqIR1WKAB4yFGrWrBxGlA4oNLE9XyV+Sun6ui4OEaUOaS2He8Jea5notZUZQNS4fhV5H2DRzQa
	YVO/QrpmlKkKh7Nb1PqPGmpegxIe6aBuy5yjl4/JbJaelgDKyYkIHgauZpvHGlL9PYjOu8Q1qBK
	QjCRQT8k7DK0l433rMJWIfS89k/dhwBcGB45/43923s3Q4IcKoAa1rKcx7QE8=
X-Received: by 2002:a05:6a00:2e19:b0:7e8:4398:b360 with SMTP id d2e1a72fcca58-826daa25790mr5521019b3a.51.1771769274306;
        Sun, 22 Feb 2026 06:07:54 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:9188:668a:fc76:50af])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ee179sm4624001b3a.61.2026.02.22.06.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 06:07:53 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	gitster@pobox.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: Re: [RFC] send-email: UTF-8 encoding in subject line
Date: Sun, 22 Feb 2026 19:33:52 +0530
Message-ID: <20260222140737.1760413-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqldgmrom9.fsf@gitster.g>
References: <xmqqldgmrom9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> > That makes sense, I tried it below.
> > I also wondered whether, in addition to this, it might be helpful to warn on
> > an invalid charset, and/or possibly fall back to UTF-8.
>
> Agreed on the first half of the statement, if we have an easy and
> portable way to tell if a given random string names a valid charset.
> I do not recommend to "fall back" to anything, if we are asking an
> input from the user.

Following up on this, I tried adding a warning when the provided charset
does not appear to be valid. Current flow is,

  Which 8bit encoding should I declare [UTF-8]? y
  Are you sure you want to use <y> [y/N]? y

With the additional check, it becomes,

  Which 8bit encoding should I declare [default: UTF-8]? y
  warning: 'y' does not appear to be a valid charset name.
  Are you sure you want to use <y> [y/N]?

This uses find_encoding() from Perl’s Encode module to detect any
unrecognized charset names.

Let me know what you think.
Also, is there any new test that should be added for this change?

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 git-send-email.perl | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index cd4b316ddc..e62fa259ba 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -23,6 +23,7 @@
 use Git::LoadCPAN::Error qw(:try);
 use Git;
 use Git::I18N;
+use Encode qw(find_encoding);
 
 Getopt::Long::Configure qw/ pass_through /;
 
@@ -1044,9 +1045,25 @@ sub file_declares_8bit_cte {
 	foreach my $f (sort keys %broken_encoding) {
 		print "    $f\n";
 	}
-	$auto_8bit_encoding = ask(__("Which 8bit encoding should I declare [UTF-8]? "),
-				  valid_re => qr/.{4}/, confirm_only => 1,
-				  default => "UTF-8");
+	while (1) {
+		my $encoding = ask(__("Which 8bit encoding should I declare [default: UTF-8]? "),
+			valid_re => qr/^\S+$/,
+			default  => "UTF-8");
+		next unless defined $encoding;
+		if (find_encoding($encoding)) {
+			$auto_8bit_encoding = $encoding;
+			last;
+		}
+		printf STDERR __("warning: '%s' does not appear to be a valid charset name.\n"), $encoding;
+		my $yesno = ask(
+			sprintf(__("Are you sure you want to use <%s> [y/N]? "), $encoding),
+			valid_re => qr/^(?:y|n)/i,
+			default  => 'n');
+		if (defined $yesno && $yesno =~ /^y/i) {
+			$auto_8bit_encoding = $encoding;
+			last;
+		}
+	}
 }
 
 if (!$force) {
-- 
2.53.0

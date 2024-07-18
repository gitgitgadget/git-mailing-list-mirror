Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADCA145B23
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721335665; cv=none; b=CVwSm0D5XkWJ5YdkKgpx7uTkbzJDeG/8Nn6jCM4RbnObQ/53Yjtoxa5an7b6ffIxeXeOXmnQEHcDoXO5iJBzpsz2cwpLpNMCmEQQJ3kCY3lmsw7iAnBw3z9ueIm6aqCJ9Aw/UTyQgEAt983+F/FoDx9LXEHYCEhkk+ooN4dPAwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721335665; c=relaxed/simple;
	bh=X8PlQH51CUNSBUn18mYQWo5vOapRlvy3QxNZylIBUP4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ns+46LNu08A/efIxJDV4Mbm4I4xJaDbeKX0ie07RnbHuAIDMiLL2btpXJf2azQmSzH+f7Df//grN8d9zWLX6aVu2BZDExkMS7le4YYrooIjOO8f9wDWLBxnZz1euNHw7MtPEPq71QURC9irnMTDlv09vECpfObU8+HpzrqYZDHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSK/beVX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSK/beVX"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-36798ea618bso186469f8f.0
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 13:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721335661; x=1721940461; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9pB+QVMAAEuBBMangAPii+XS71mbisuR4fxXFJpA6Q=;
        b=eSK/beVXje0xMyEWFK9ofrmTIS+3j8GuYiB3c0/cerB8ecBzM7F4BQMbPdk2QyU5aU
         9G9oIN4k8iIKxsTrQEfypNVU3LR7PhQkGDEGdaqWd40kxTFih9MYuE95VkdY+fQu+pwS
         hbMGUcoVeHeiZ6Jrb8yDVuL3TtlGrA0EcQCXZi61ikElMVLmQDUEEPKRpw7IHjWb3ubo
         WV7pqoCfckWKRax9bU1+AqYvWrchbdvWdKpMBhQXyRjVu+UoRDxyrA4mUjrqDjsHGN9a
         QPkAmuqf/EUGWtC6TJ2H1rPkbh/TC7L5e6JkkyDZ10Ud2JG3Q8yZSuz5jxMUkFBy5ydw
         srdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721335661; x=1721940461;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9pB+QVMAAEuBBMangAPii+XS71mbisuR4fxXFJpA6Q=;
        b=eA/dyO/NVxFgkopclid44n+PjxjcilwwiMCdA+SB8Y+PRRDIyv6oGWPvcRVNBUo4it
         9WvY8+zNmWofhvq2N2LxeJpe8YthbPx2aV8WaaPqZFVWUZumI/sfzJARn/Aye7OtlcbD
         KQKp/alyqIRvVg/BJu7oDlFsSvtgsKxVtfHBcDsZ6lJesPq1AolCQVwnY+KcpnuDPK8v
         bM+OFCE/nk2BvAaWt9qKX7xNVlwEQJDF61VSwxNJGXGDLsgduP+DwqvheX7oDRL0Fv1S
         p4+h6SJ5Jo49mHo5K7oUk8CR+AGev1wPJ+JxLl/+dGVd7xnfS+LMMO9WaPS7c9uia+YO
         LCtw==
X-Gm-Message-State: AOJu0Yy3IpQwbzLXLsbURsOeqjAyilkg16kjRw7LtZfM9kIXunBvXIMI
	DhmqudIhvAgzyELRlW+GS3eDSSKMqny2nlmFbS52jLwbY3o+Y8SrS4Ej7A==
X-Google-Smtp-Source: AGHT+IF0j6K+AkrLfd8hoMICIWP7yiU4iJdYIjmBz0eL9QE5XCeMszrWCrGckcRe55XUaHc+GfJTSA==
X-Received: by 2002:adf:9b9e:0:b0:366:e9f9:99c1 with SMTP id ffacd0b85a97d-3683171dc1bmr3127150f8f.53.1721335660882;
        Thu, 18 Jul 2024 13:47:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36872b512b4sm487587f8f.114.2024.07.18.13.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:47:39 -0700 (PDT)
Message-Id: <7735afb32afd601e8306635e1cb3767f3f923f43.1721335657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1747.v2.git.git.1721335657.gitgitgadget@gmail.com>
References: <pull.1747.git.git.1721246266.gitgitgadget@gmail.com>
	<pull.1747.v2.git.git.1721335657.gitgitgadget@gmail.com>
From: "Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jul 2024 20:47:37 +0000
Subject: [PATCH v2 2/2] git-svn: use `svn:global-ignores` to create .gitignore
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
Cc: Alex Galvin <agalvin@comqi.com>,
    Alex Galvin <agalvin@comqi.com>

From: Alex Galvin <agalvin@comqi.com>

`svn:global-ignores` contains a list of file patterns that should
not be tracked in version control. The syntax of these patterns is
the same as `svn:ignore`. Their semantics differ: patterns in
`svn:global-ignores` apply to all paths under the directory where
they apply, while `svn:ignore` only applies to the directory's
immediate children.

Signed-off-by: Alex Galvin <agalvin@comqi.com>
---
 git-svn.perl | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b0d0a50984b..a2a46608c9b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1279,12 +1279,20 @@ sub cmd_show_ignore {
 	$gs->prop_walk($gs->path, $r, sub {
 		my ($gs, $path, $props) = @_;
 		print STDOUT "\n# $path\n";
-		my $s = $props->{'svn:ignore'} or return;
-		$s =~ s/[\r\n]+/\n/g;
-		$s =~ s/^\n+//;
-		chomp $s;
-		$s =~ s#^#$path#gm;
-		print STDOUT "$s\n";
+		if (my $s = $props->{'svn:ignore'}) {
+			$s =~ s/[\r\n]+/\n/g;
+			$s =~ s/^\n+//;
+			chomp $s;
+			$s =~ s#^#$path#gm;
+			print STDOUT "$s\n";
+		}
+		if (my $s = $props->{'svn:global-ignores'}) {
+			$s =~ s/[\r\n]+/\n/g;
+			$s =~ s/^\n+//;
+			chomp $s;
+			$s =~ s#^#$path**/#gm;
+			print STDOUT "$s\n";
+		}
 	});
 }
 
@@ -1315,16 +1323,25 @@ sub cmd_create_ignore {
 		# which git won't track
 		mkpath([$path]) unless -d $path;
 		my $ignore = $path . '.gitignore';
-		my $s = $props->{'svn:ignore'} or return;
 		open(GITIGNORE, '>', $ignore)
 		  or fatal("Failed to open `$ignore' for writing: $!");
-		$s =~ s/[\r\n]+/\n/g;
-		$s =~ s/^\n+//;
-		chomp $s;
-		# Prefix all patterns so that the ignore doesn't apply
-		# to sub-directories.
-		$s =~ s#^#/#gm;
-		print GITIGNORE "$s\n";
+		if (my $s = $props->{'svn:ignore'}) {
+			$s =~ s/[\r\n]+/\n/g;
+			$s =~ s/^\n+//;
+			chomp $s;
+			# Prefix all patterns so that the ignore doesn't apply
+			# to sub-directories.
+			$s =~ s#^#/#gm;
+			print GITIGNORE "$s\n";
+		}
+		if (my $s = $props->{'svn:global-ignores'}) {
+			$s =~ s/[\r\n]+/\n/g;
+			$s =~ s/^\n+//;
+			chomp $s;
+			# Global ignores apply to sub-directories, so they are
+			# not prefixed.
+			print GITIGNORE "$s\n";
+		}
 		close(GITIGNORE)
 		  or fatal("Failed to close `$ignore': $!");
 		command_noisy('add', '-f', $ignore);
-- 
gitgitgadget

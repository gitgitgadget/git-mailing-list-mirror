Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8151836D8
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246272; cv=none; b=Sj74Y997y3M8kRSRL9+Iyc1WO82vhQTUoMQTLRTK5oN9k2/Tka96TCZaFxGG5m461DQs/xJIE2+Pf571I57hRxz7l5Q/5L9EnLfuPM64CsVLv+y1QbanDYfH926pN2yElTqjTyarS36d906kKeXxsWA9R3SoNUNENPOTC7VrGp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246272; c=relaxed/simple;
	bh=A9zTyEn1z8U/y4m6EUFixEY3YlRMFDegWDsv0N9HLEY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iOugT5dECrV8bn0anmLvvECmlhRuBrd6RgUUVCFNkb2AOL1XdyNvRvSYgbuqoX13s162RbA4fKbsDkPHhYa8quBc3Qf8matjX/EoRvC2EABfEr40FYW36loaxKhhzhbiz9j27TL2/ZjE+B/Aupy/q98DLcOIU2Id0OhJukMjqB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZPtRNlB; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZPtRNlB"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36796a9b636so48234f8f.2
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 12:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721246269; x=1721851069; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjZVSqo752Dye64HvgR1tCBp8HywQDVYJVj0q6yc06E=;
        b=VZPtRNlB3x/UGaIj3e08uxnwZM/5hiWVhFZn7bOEq5GEOnU2aamiqNtEVvU/BuTSwE
         CSH+gbPvfgPLIPXrNrmSBi7ufQ0amsJPQPpgY3i1eFahzGOAZH0JLvqfHiNDKuaZTtXs
         XO7/U9A1zGl/jYfNg+LwmOzlCojCIPV28DkmxCfHA+LkAuyrAtEyilViCQfH76Bw4S2T
         +6WqxUhoGn7QAImdetuU27/uHBNT41DFyF+1leHNDFPTPYfoZh0cv1vAVLYBVlpcqQQ4
         FcbgnnTAlxA51RetWWZsIDq0lyNe10cv+6WzSOfPe+KI2aYt7ihmODZOm+SeudWgHtYe
         3KOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721246269; x=1721851069;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjZVSqo752Dye64HvgR1tCBp8HywQDVYJVj0q6yc06E=;
        b=dov/TdUv22O+1u6ga47K4mIos6jTfDveTi6XzHGFNenAjFzJL+y3QEeedcAhfU3JEt
         PzJVZG59uhyJZC/NxqkRcbw8TPJUBHZRFs3GUARrh5lgNcHrAAspTw6n75xiKs0BgO9M
         p9kZetIcV9DGrFXokDLM9RpX983NgEJ/cSLkxh6AgQ/bEk260FUoXZHlMJdegCi3cqMd
         0X70oRMKV96zR0WvtA1AVFRFGLiXvhSCL8e9XG47k/dA63oggeB9/p6XO6VMFkOSdGsV
         XlY6IpxdPVKd1/LdksczKHs/Hp1IKGUc7bk+r/34zkNbjgrqNi3NY0GeXvwyTNjQ1N5v
         gtjg==
X-Gm-Message-State: AOJu0Yzh+3+ragLBcr6MzLMgvAxTKwmVLp9OvE9FDlh4vGuSJ3v3b+1T
	/h/nq+IwNrZbY8s67LqcKQvH1wn7fUElyiOufwwBCijC8LSU/CHolmzzCg==
X-Google-Smtp-Source: AGHT+IG7+G0wPO1JlZ4qGwlMNrjJdFOH6FkwhvCPhadNjdzRM3MpLxA/9nHklzY4yzZCWjXF7Y3k1A==
X-Received: by 2002:a5d:5919:0:b0:362:2111:4816 with SMTP id ffacd0b85a97d-368317768ccmr1773223f8f.55.1721246268819;
        Wed, 17 Jul 2024 12:57:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c780c9d5sm8559885e9.38.2024.07.17.12.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 12:57:48 -0700 (PDT)
Message-Id: <10e240202f79a0f50edf47391389c4e0892edf41.1721246266.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1747.git.git.1721246266.gitgitgadget@gmail.com>
References: <pull.1747.git.git.1721246266.gitgitgadget@gmail.com>
From: "Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jul 2024 19:57:45 +0000
Subject: [PATCH 2/2] git-svn: use `svn:global-ignores` to create .gitignore
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

Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735EC1DDA24
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917186; cv=none; b=l3+Fek5bcqTJ6/4uHP0ZST7g0ud+Lh4cTsXGqkSVdo//m0OODYRFte+68EvPZyd2XS9FFBCIytMZs7xbFMxVfxE2yk8mtdYIHdBQuTWCdLtlI1qcpZpFjBpQVITN5s70h7JrjGXMA6Q6FKhO+xms+/lWKPJsziQCEzMPsx1Guh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917186; c=relaxed/simple;
	bh=bDIUxKP+CHIxspRGdmj7qTjNhBGxuWtKZ5SKtgEO+ng=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=gWyJwtcdeg/4BcRZwsYZ88lTT+1B0OyzTpj01oeRMhQd2I/HKot6e6yfvvEXrdfa6QuoYyRAfWeVetbAV7YmRTCuAVVhfywUE8wx5yfllbyYyYbMzNJaB6EUURTR94qqa173BYonG5wiGbFcsdMAdigJfWrIFTjHx4swlDQYi5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTEuqXK/; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTEuqXK/"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8a1744d9b8fso292228585a.1
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761917183; x=1762521983; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N2YG+kATCuh+pxurOYZ6Gxsj3Ca9kmi/K8zSgSg+5Jc=;
        b=OTEuqXK/Wz30g9xOe9OmnQb/3eFWau0QWPZPL66WZd4h5lZwnRzxivzS1av1pRI6AG
         MsVzdIL5jaTEmzj7Eikd0y6/UognjnOztnbu6+7fjfrw+5gbmoO3TNng/Kj462RQK7yD
         7kTUhak7Lc+j+N0nEOOq1haCO4WW2C0PRKd6gK59fBOqm+CC7oZCXyRCom/X82Nfvqww
         c0Q8cWHQHpSIHjoYp8/MWze3FyaBSELh0xNsLrR7HPuxp/H6V1oqaB1kgMEIVWuUAQsN
         OJpowAHRZTNMORentoGPrzLsOj1j59kRCg2CaTwgZTxlXtyEozOsSH01fU3JS7FCbCrG
         jDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761917183; x=1762521983;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2YG+kATCuh+pxurOYZ6Gxsj3Ca9kmi/K8zSgSg+5Jc=;
        b=qEU+t7FCugcwvidGjYNF2Yr1Fth12qvyltRx8uK6YH5C0pQ1/ylDu0xE+y/1tt5SEL
         9JnzjnIDhYIF4lDRTRybbT5Fe+KapAsqfYikNmuM7Rie+oKvjKora21Jx2WTdBtO3pKi
         +BCvzIMrnm2ydJzfYphOIaveaDQROufDzcsDsEUY+sZdfrN7Ecid0ti+A3Zm181AoFLO
         eG7u0vEuSZsbyngu5G/6mMulgfWHNiB8YuKKhdYczFJGRth3G0fs3iWF2O2VPjnw1yEQ
         pDjV24DWdp+XuSfuhoW7GquGwJBxvpGpBomiSqCHnbHcuNUP4eFufG0C20WzGpHq21q+
         ydOw==
X-Gm-Message-State: AOJu0Yy+BgSU0M+L9WsWW4JrNJjmYLOVPRhv6I2GT10oHvPIVxP6y2dJ
	ve9jkrJ917ywBXOVDYpd+YZgaH9fLgAJq+aVUWehkkQ04TNKOFk5xNCQyxgmfQ==
X-Gm-Gg: ASbGnctL1l0gEy86j60BGR+w7A5RRe0ThH5UgwbzDwW4PtDNXYFZIiT4pznAoGztuGR
	WpI7A9RLOnv3W3VWAxLrwkd19kA3Z/kxKJeXG5fNkFq9RYlF3IoF5u+OBC1FkHqfVSDnfsRP5rd
	Sf/2W8wAsN9Vsa5G/tMHyMLk4fBfZc0ViUBXR/nifpT7oNB5spiziG5wC3x3ls6lxJvx9iULO5t
	PiWXtaTMW8ohgRu1oI7NXFUuVH7Rd3kfVvyOInvYvua0s+NcyL8EHmGyhFzqZyOGkKqYQ4vQx0p
	zO6yLYo498DpoRrIWZwRubWeNr7flym3r0mwhYEOM0wZZkY6oGtELJLKpSqlgWlF9zX1sJWzRXq
	vmgu6stlxfrlbkRPPqeHV5V3RL1rQuSoF0fQUrFpRic5h1eVPHs4utDOxsokOSEJmexEKfPrrES
	C3rg==
X-Google-Smtp-Source: AGHT+IGtJTO4Y5Fcq+KZkFtCV6fi07w5pKZTLTfbpw19xdDwB1/88noeCFiLVQamhms6XEfVoi+a0g==
X-Received: by 2002:a05:620a:3720:b0:89f:19e:46fa with SMTP id af79cd13be357-8ab99498a0amr339159385a.20.1761917182742;
        Fri, 31 Oct 2025 06:26:22 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.191.134])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ac00c87281sm108736085a.21.2025.10.31.06.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:26:22 -0700 (PDT)
Message-Id: <pull.2087.git.git.1761917181558.gitgitgadget@gmail.com>
From: "Pavel Dydyshko via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 31 Oct 2025 13:26:21 +0000
Subject: [PATCH] svn: fix path strip for branches
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
Cc: Pavel Dydyshko <paul.dydyshko@gmail.com>,
    Pavel Dydyshka <paul.dydyshko@gmail.com>

From: Pavel Dydyshka <paul.dydyshko@gmail.com>

When checking path against ignore-include regexps $path argument is
given relatively to svn repo root. This results in unwanted prefix which
is path to svn branch location and should be stripped before testing
path against ignore-include regexps

Signed-off-by: Pavel Dydyshka <paul.dydyshko@gmail.com>
---
    svn: fix path strip for branches

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2087%2Fpddshk%2Fsvn-fix-strip-path-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2087/pddshk/svn-fix-strip-path-v1
Pull-Request: https://github.com/git/git/pull/2087

 perl/Git/SVN/Fetcher.pm | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 968309e6d6..5ac8c71a3d 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -123,6 +123,10 @@ sub in_dot_git {
 # This will also check whether the path is explicitly included
 sub is_path_ignored {
 	my ($self, $path) = @_;
+	if ($self->{path_strip}) {
+		$path =~ s/$self->{path_strip}//;
+		$path =~ s{^/}{};
+	}
 	return 1 if in_dot_git($path);
 	return 1 if defined($self->{ignore_regex}) &&
 	            $path =~ m!$self->{ignore_regex}!;

base-commit: 419c72cb8ada252b260efc38ff91fe201de7c8c3
-- 
gitgitgadget

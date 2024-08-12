Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC4187842
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481916; cv=none; b=j0W19ikoWvv53gytOll33RGqbdtB3YK6ttEL9zOccjwFnwIDQ7RP3WN6wqxY1mMGYpDiXOWQ4xayHeZC7sN0OBDsdAGa0fieN3G5O1Rh11T6I6nsZVco7QXifjmrAYcHI9tVurjNL7/AjLxyPDJ0DlWhjjSEcjvkVdR8Kg6nQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481916; c=relaxed/simple;
	bh=RnIPL0Vwwfu5FDbxcPLf1KiRnZ3swnjXo8NhMKFVvT4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FUWaUb0SBhOvbj674xQMn159Tl6p+7euSgbWTWO0UkZXuqwTlKRs84eA/2v6gQgEXyTZQWLu4YiSzUrHwoly14MfuG1HNg5fBp0qWUhk+u7vQbHngqzQ6oRaJYFn7SKLqcgCyPtNYA88J80jLMqtJ1JEBNWyle5XxG/NfnDJHIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMsA9jZ9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMsA9jZ9"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a1c49632deso5077420a12.2
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 09:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723481913; x=1724086713; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKAd2VpYAN5pgPyva1FgFManUItg4ctPO/9vknl1sLc=;
        b=EMsA9jZ9qjrR28HKc+TKvpiBp8YRh/WjschAn92xF2rFyERKMhRTsz3G4uqHggNKTI
         cDI6Hdmc0qLtIst3RVz9ZgwQ5rbeY4BOIPE+Rs6B9MvFVTnIh3MxFdcqR++pjbow1SY6
         1uWgxbvZA0O/4ewBVmnOLi72cbSIlGsVhv5PkjPD9nInUpP79UysNqS6Q+M+os0akmit
         APVxCvDfgGQwSq/5xlqFEzNdwcC+o1NkbuBKSxmEAE4kjPwuBJ9jijRjcjMXFddu9D5X
         8Y7v5qIYF7F9vg0p5cqjjmZ1oLEH5zshABGhlE+Vy6ndetSaTo84LTxxrNePRYq7q+4p
         lPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481913; x=1724086713;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKAd2VpYAN5pgPyva1FgFManUItg4ctPO/9vknl1sLc=;
        b=qMOl20vHOsQHgilqB/fudAfel+uZP4unmHGhhJD24bMjomGckkRRHGJy/BXf9BMHwc
         0McvBUo0Ngwey09g1Fu3MakMPZjhYMumcqRqvbgcRcu5HplXAyl8Xd/3q9wyvq4tbVTU
         Fz0JykU2CpXuCHae5TF3p/1287v+tUawoMRMtpB/5Z5C6zslBkE+zKr6ArfTh3gPfwuc
         /do1rl61g88Pm6gIJMDNxKNhvafWI4COBrKhUCssR0TXUv43nOgFm7mhkF9Azzi3wBie
         M3IiCtJsegwuVFoL9aTk6WbpLl+9ERsKRaUo2+cpV/h1XKSXdmi/HXNJ1Td82yPUBWj5
         XC3A==
X-Gm-Message-State: AOJu0Yz2L7X4nNVlUCQSveB/fQho9ZYVczRxd+K5WJSwsRfEA0oEEoMa
	C55zAzX82+eeObpehptzf0Ihd6JOoHnJOWi+nIrluyW9EleT4DTRvUCVxA==
X-Google-Smtp-Source: AGHT+IEbAiajSZgKXW/BxerHGlWiWRdQblIHhirV8o3ZmRzk77eVSeMHaMrk9Bb03knNXIl1/y6J7A==
X-Received: by 2002:a17:906:fe43:b0:a77:d63e:d8fd with SMTP id a640c23a62f3a-a80ed1b4ecfmr84392166b.12.1723481912474;
        Mon, 12 Aug 2024 09:58:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb119cc7sm244349466b.94.2024.08.12.09.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:58:32 -0700 (PDT)
Message-Id: <18dffbe992e07cc6c9ce81f53977e256c3bb1ad8.1723481908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1747.v3.git.git.1723481908.gitgitgadget@gmail.com>
References: <pull.1747.v2.git.git.1721335657.gitgitgadget@gmail.com>
	<pull.1747.v3.git.git.1723481908.gitgitgadget@gmail.com>
From: "Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Aug 2024 16:58:28 +0000
Subject: [PATCH v3 3/3] git-svn: mention `svn:globalignores` in help
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
    Alex Galvin <alex.v.galvin@gmail.com>

From: Alex Galvin <alex.v.galvin@gmail.com>

Signed-off-by: Alex Galvin <alex.v.galvin@gmail.com>
---
 git-svn.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a2a46608c9b..b824011154b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -219,7 +219,7 @@ my %cmd = (
 	                "Set an SVN repository to a git tree-ish",
 			{ 'stdin' => \$_stdin, %cmt_opts, %fc_opts, } ],
 	'create-ignore' => [ \&cmd_create_ignore,
-			     'Create a .gitignore per svn:ignore',
+			     'Create a .gitignore per svn:ignore and svn:globalignores',
 			     { 'revision|r=i' => \$_revision
 			     } ],
 	'mkdirs' => [ \&cmd_mkdirs ,
@@ -234,7 +234,7 @@ my %cmd = (
         'proplist' => [ \&cmd_proplist,
 		       'List all properties of a file or directory',
 		       { 'revision|r=i' => \$_revision } ],
-	'show-ignore' => [ \&cmd_show_ignore, "Show svn:ignore listings",
+	'show-ignore' => [ \&cmd_show_ignore, "Show svn:ignore and svn:globalignores listings",
 			{ 'revision|r=i' => \$_revision
 			} ],
 	'show-externals' => [ \&cmd_show_externals, "Show svn:externals listings",
-- 
gitgitgadget

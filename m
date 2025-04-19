Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D413C9D4
	for <git@vger.kernel.org>; Sat, 19 Apr 2025 04:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745038799; cv=none; b=prrCsUPSIYYUv5dlecrijYQLr6lDcONmiEbOdT8Z7xU77ctZry6MfBKqgGSePSw19wk98cqCWIns2z9U9Pz21yLnANumvfcKJYbWA2WSe438qCJDhq8onf31dxlJHDvKX+g6E5VpF+RgMwWSUlpP4EEmget+Bro7+jS2oXGwQtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745038799; c=relaxed/simple;
	bh=ijXdUnosvBVG/o3sQ5fStoWTO5L7tCFHAxRh9NA9Uv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8BgoIpUwP6Exm0FQt3MI4TiM0fKLqpslc+UtmNuDHk3g7z+HQihChuejwV5tk9cXppXkb4uDsSwv7v2BybypIvK4urzKIPZDfu4aoglXbWek84AXsWZOfjGiJMrfRE1ucWJr6Tfz7pxsk3My9+BQ0+9/gB6ub2pbUx0w1ibh1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eu7XYg8B; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eu7XYg8B"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47691d82bfbso45441971cf.0
        for <git@vger.kernel.org>; Fri, 18 Apr 2025 21:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745038797; x=1745643597; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ijXdUnosvBVG/o3sQ5fStoWTO5L7tCFHAxRh9NA9Uv8=;
        b=eu7XYg8BOP7QL0RzqeGlpvLwLOrHCyB2Fq2w7TkGiuLcjFGUfxMR78ZoSyxro6ZNCF
         nX66IsU7SnghMjwKmL8uCQO5th23u4OWxT+vlHUnGEY41xVLrIUFydk4wypUd2xhYE4u
         3Z5HiJLQerZa48CinHc+ymGFqRNAjcZvNCsZQ5dZtU27SQxO46XLR7+Wfb6Nnu5CQ8Uc
         exO+iZElLnjZ9Q6hBrDj2E1D6Ibnl7a5nag2LyX8M8T8tQ6E8VnLGRPd5x2fUpIBz6eI
         IJ0SEOQTryWAWffuK0hx9z0qglFDhfM702nNvzC1tBuSp6VbGAlj9TFABu9HahqQhNSl
         BdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745038797; x=1745643597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijXdUnosvBVG/o3sQ5fStoWTO5L7tCFHAxRh9NA9Uv8=;
        b=uWoMYPXPLWl4pFohAGN7jIY3tgSzXxdrO0mNP9xGqEBELVqV33FsA1psnxj/YFbHMA
         hOsT0mV3wgI0OQF5GwsKv2NH1u5gB18H4OManpfUhJpQm9LdkASkagatJVfFgOXk8cdH
         rO0ed4vo5Lh1NHeXhQSXvwvTdUaMa99sJtovkYKe2khgW9omebiILW38e+uLMerlMsUQ
         kshO9lF4DyfKvi4kupVKKDA6it40H4kOAiJrxp0Q/EXDbwNVZF0/UkO7JNCQO9Zq1l8J
         ro2faGEG2H0MPXwZd7qZi14PufQAuAzeNyGJSxMbhIm0p6LGVZALETpnjAfIfdGsQgDr
         j7aA==
X-Forwarded-Encrypted: i=1; AJvYcCUfXwyu6JAn9JUYD3+VcIbm7BXDpkKPVPyL8REwmOrsLB3Hqm+DgSrGYb/Dq43L1MBt8js=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvOM9bPVHdSYRcbgv2ZGfvj5jRb6Ngb4GD9j7z9/VpIAVbKwJr
	UStQO6DRZGOgIxj/levAj5C9J4/zrJ771Ln9JnzUiQ+mgz0wyTfrnlZASOhLsbpSuyXxWsePL+S
	FNoi3W6GoVvIa1oGMzjgHL/yMcA0=
X-Gm-Gg: ASbGncv5orSdRObi4UKqW0ypNNRB/QD160KD4SGz+Wu3oqi4brnzI4/9GODDIjbYEDs
	fIsG/WHBzwLdwWzRmwsAwaOaF0kikPkIuXF74znjs20r9XXpL9cvL35/V7X2H/QbRogVsWHx2+B
	+P7NVtbUch0KNi7T0OVW0UbPk+ZoRaBDK0szY72vqSLV6sSR5b8uE19hE=
X-Google-Smtp-Source: AGHT+IHTrVh9J+OUy+h6funt7SD9GZR/aFCdEa7/0TbrcxAkyFWK8ynHIyYho4n/aTVqdhrW4hk7Vtrm5ixWEVSxgvo=
X-Received: by 2002:a05:622a:1890:b0:476:964a:e335 with SMTP id
 d75a77b69052e-47aec3c292amr75252661cf.24.1745038797199; Fri, 18 Apr 2025
 21:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412094607.236382-2-jayatheerthkulkarni2005@gmail.com>
 <20250412174051.780148-1-jayatheerthkulkarni2005@gmail.com>
 <Z_7ekhsBzXK6LKuV@tapette.crustytoothpaste.net> <CA+rGoLfAidyuomeNym5WX8Bo7-jPcfHx35wDeZ7W2aorAN-B7g@mail.gmail.com>
 <xmqqa58gjlnk.fsf@gitster.g> <CA+rGoLesZ3nSjruJ8_XRWVsFpMu8mo_4cCOdB-GFHU_qXkXDCQ@mail.gmail.com>
 <717161C8-497D-42C7-8C10-AC112238EEFD@gmail.com> <xmqqcydchz9o.fsf@gitster.g>
In-Reply-To: <xmqqcydchz9o.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sat, 19 Apr 2025 10:29:46 +0530
X-Gm-Features: ATxdqUFv5KBl5zDpkH_AdWTnyPWoI2OItzhkyxqWlcgyeyefonO_aO2UHJ0ARYQ
Message-ID: <CA+rGoLes1u3LZiStmDPmh4iiUNzNY43KyYNdLadQU+cy1TCc4A@mail.gmail.com>
Subject: Re: [PATCH] t3706: Add test for wildcard vs literal pathspec
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, peff@peff.net, 
	piotrsiupa@gmail.com
Content-Type: text/plain; charset="UTF-8"

test_expect_success 'commit wildcard pathspec limits commit' '
reset_git_repo &&
git add . &&
git commit --allow-empty -m "Test commit with * wildcard" -- "*" &&
cat >expected_files <<-\EOF &&
*
**
?
[abc]
a
f*
f**
f?z
foo*bar
hello?world
hello_world
EOF
git ls-tree -r --name-only HEAD > actual_files &&
test_cmp expected_files actual_files
'


I get issues with these test cases,
Specially at git ls-tree -r --name-only HEAD > actual_files

For some reason the test_cmp doesn't get resolved
Is it a bad way to do? or is there a better way?

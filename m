Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E8A2E400
	for <git@vger.kernel.org>; Sun, 21 Jul 2024 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721564944; cv=none; b=XudKsPoAd8Z+axQLTJ5IJ/njEABPYuzTTJLy2fUfUYaF5Llz0PErrhhv+FnhM85NPCoD5smxBTDAw8Yh9mZBdb/qrR/x66qLclL9XMtfvCjBaBABU2vSFLhPpKQjz3pDiYo5CYltSY4pThmq0BwAlbK/bYBS8MimG/8ehuHNgWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721564944; c=relaxed/simple;
	bh=3Cf2vUOd6/P6sDMQapiTdJEZi8gmWI1cUaeuzSKHGNw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a/Ar0tuMd3iAaVE0bAYwP3uSeOaeHSkhxvoWzIHeWN9bA7yGPXhafYAJKoZNnKH0mOawGCFbkwtVzELVxdDZW6cYuuwgnOHJ3IuZGk4BYbTDDbv8E9gBYBAdERMxB2h6dPzP+mmqDi8quIRFnvYwfy53rHuJsftAcI+hR1D1IV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=H1pURnhw; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="H1pURnhw"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 31680240105
	for <git@vger.kernel.org>; Sun, 21 Jul 2024 14:21:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1721564467; bh=3Cf2vUOd6/P6sDMQapiTdJEZi8gmWI1cUaeuzSKHGNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=H1pURnhwCSI+wlpWTKrSLWRvBZrMwvcoir171gkcgWYWJmwRgAS1uX5jpffkenf7h
	 TyzYBAb4eXKB5TdUZ51iNlb4+TSjsGVtiBuHzyd7zxY8xdekfEy49WZ7LfPsVGloOA
	 1ZL+orbojVQND84MuO9f8rt6SkfT6oubTciaBqmPl4XDe0ncAIcGepofMABBOHKU9F
	 IvKncCpuAJpUA4eIIE/qDVL4yXk8EooxmKq4kKPCZXAt16lUbfWjHCBiI3Vs3jyb1T
	 jiP12pHYYsLMvjY6GMK3RW4xLpivE07naNomTysEvlgZNBnZ5YFKK7XFrfFw7RYcIs
	 Y/MJZVEIWw3qg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4WRjDx5lHMz6tn4;
	Sun, 21 Jul 2024 14:21:05 +0200 (CEST)
From: Tomas Nordin <tomasn@posteo.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Charvi Mendiratta <charvi077@gmail.com>
Subject: Re: Unbalanced closing paren in help of git commit
In-Reply-To: <xmqqcynnejwl.fsf@gitster.g>
References: <87o7792xgu.fsf@posteo.net> <xmqqcynnejwl.fsf@gitster.g>
Date: Sun, 21 Jul 2024 12:21:04 +0000
Message-ID: <871q3nx7f3.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Tomas Nordin <tomasn@posteo.net> writes:
>
>> Hello List
>>
>> The second line of the help message for git commit looks like this:
>
> This seems to have come from 00ea64ed (doc/git-commit: add
> documentation for fixup=[amend|reword] options, 2021-03-15),
> if "git blame" is to be trusted.
>
>>     [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]
>
> We can have --dry-run but we do not have to, we can have only one of
>
>     "-c <commit>"
>     "-C <commit>",
>     "--squash <commit>",
>     "--fixup amend:<commit>"
>     "--fixup reword:<commit>", or
>     "--fixup <commit>"
>
> as they are mutually exclusive, but it is OK if we have none of
> them.
>
> The last closing parenthesis after <commit> but before the closing
> square bracket is unwanted, I think, as you pointed out.

So then I make an attempt to provide a patch to remove that closing
parenthesis. Please tell if it should be done differently somehow. The
patch was done on top of maint.


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-doc-remove-dangling-closing-parenthesis.patch

From 5da052f43b119949c0ac0c7c3047542bc7474c17 Mon Sep 17 00:00:00 2001
From: Tomas Nordin <tomasn@posteo.net>
Date: Sun, 21 Jul 2024 13:16:50 +0200
Subject: [PATCH] doc: remove dangling closing parenthesis

* Documentation/git-commit.txt:
  The second line of the synopsis, starting with [--dry-run] has a
  dangling closing paren in the second optional group. Probably added by
  misstake, so remove it.

Signed-off-by: Tomas Nordin <tomasn@posteo.net>
---
 Documentation/git-commit.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 89ecfc63a8..c822113c11 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
-	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]
+	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
-- 
2.39.2


--=-=-=--

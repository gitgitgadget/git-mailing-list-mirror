Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0015C7CF03
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550344; cv=none; b=rV46IQooK7DdY11hw1OeOrOCc0V5LMgd/So7hBE4HduN5BDj9zdWQMWQ9vjZ3yae7KpLxj3CqWI4pjFqP3rF1RVQTIGE4Xn3SzgupPupTlYkz0BwmHTrEbfThn2zcqZOx975M66NgMbsk3Sj3RpmaEHCtVw6BAVhrfA7C3rah6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550344; c=relaxed/simple;
	bh=dQIJl429XOO6e55cDcOonNO3ab9IH9KrriZGuhI/ZhA=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=UhkWgNFjEy4zJuYRnOFhaWLHx6FE9m1aGaUg57PIS4KwBZzo0AGPxevjRD1JUvCZ28D/4oEQe1KhULV/4qGn9GRHA6mIp89S749j160cghHf0L5v7omHWdMcI/IkzQXSs6uX1LYVtB0o8fNcDy0Rzv9EptZBAt/VngWO5mSZyTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfLwZobD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfLwZobD"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d6fe64a9bso1790254f8f.0
        for <git@vger.kernel.org>; Wed, 21 Feb 2024 13:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708550341; x=1709155141; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o+uCZCnGPRR67gtTKigIkub+JniIl8THLGtPHFp7P/0=;
        b=AfLwZobDjjpC/JChznh14Cxe92i8QXUmwLyWNFguO42nAyFqPdGeXUDJZLeEivFMsI
         3rORnbGTo4aHhg+USOaMHewypLwkRS9qvMX6U2ePoJcrKMx0PnglPsVaol8MFDdCs+/C
         HMYQ0ihqbzDdFIpXu1J8DNjl2+QEyMBwU0kSohaPFnqpFxz7VrWn2r75R97aIuFK7yVL
         Vp+waozO3dsbJ9WkyAU4IYk3fv7EqhPMW9IwGrYMNfbnUuX1jFTr0Pknclxi92s8EvwM
         9e+LTHFwYuHcK0BdVBsACq5y5Dt28GmnJHa6h7aKghlbiryRasEmlYpKOGUW0hkSZeMe
         4ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550341; x=1709155141;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+uCZCnGPRR67gtTKigIkub+JniIl8THLGtPHFp7P/0=;
        b=GhV4QzCrFwfvlTGvJkQx0OTWLnPhtC939VjCDMxSB7J8epcF+RgvhRUTzKl9JPpN6J
         yaQ1zflyYw7J0Dwit/qb9YuhJ/rEmoYynDwqet2UuwkVqtdh5jQEdeNVfYw+/xe95TfI
         TjRixG+X3ehJDTqc4iH7KeSIfP47ta835tApe8bCe4BnZfvEdT58KZc5ELAtRJX4vu+j
         bAvsI/WMGlUjRbM8sGuZWQNmWl+HL67oPK1+1J3DQUplGYspV2ULglCpWG31bnDdN+ws
         nycldRbmoQbjxn02/BWzSGhvN5ZUw2i1HnKmv/1gkjDO/IXswkRG81vYZt5puzGCIJk+
         oFOg==
X-Gm-Message-State: AOJu0YzCpL+yZYqGSZkiKt8bqO8jrCUb8CUAk6aBA6yjH5Sw4hZ/0n0F
	gmaSyfEfm+KIwvV9/Ii8f04yKzsBicT+HEBpfMSmBLWtF6NsGEOoKgaRg3aV
X-Google-Smtp-Source: AGHT+IFxcvd3RQMUPfQSDzLA7lT6cTzcsp/4p28Hsk6/2UnAUumNv6MNpPCrww3dxbV0zF9nlAH9Kw==
X-Received: by 2002:a05:6000:1c8:b0:33d:3067:d96b with SMTP id t8-20020a05600001c800b0033d3067d96bmr11205510wrx.2.1708550340824;
        Wed, 21 Feb 2024 13:19:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4-20020adfee44000000b0033d8ce120f2sm71065wro.95.2024.02.21.13.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:19:00 -0800 (PST)
Message-ID: <pull.1671.git.1708550340094.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Feb 2024 21:18:59 +0000
Subject: [PATCH] doc: clarify the format of placeholders
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Add the new format rule when using placeholders in the description of
commands and options.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
    doc: clarify the format of placeholders
    
    Following the patch "Doc placeholders", there was a question about
    adding a formal rule on writing placeholders in description paragraphs.
    
    One agreed output was that the placeholders in paragraph must be
    surrounded by angle brackets and not set in literal with backticks.
    
    A new rule, to be accepted, is to force placeholders in paragraphs to be
    italicized.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1671%2Fjnavila%2Fplaceholders_document_guidelines-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1671/jnavila/placeholders_document_guidelines-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1671

 Documentation/CodingGuidelines | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 578587a4715..a6a965609b5 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -666,6 +666,11 @@ Writing Documentation:
    <new-branch-name>
    --template=<template-directory>
 
+ When a placeholder is cited in text paragraph, it is enclosed in angle
+ brackets to remind the reader the reference in the synopsis section.
+ For better visibility, the placeholder is typeset in italics:
+   The _<file>_ to be added.
+
  Possibility of multiple occurrences is indicated by three dots:
    <file>...
    (One or more of <file>.)
@@ -751,6 +756,8 @@ Writing Documentation:
    Incorrect:
       `\--pretty=oneline`
 
+A placeholder is not enclosed in backticks, as it is not a literal.
+
  If some place in the documentation needs to typeset a command usage
  example with inline substitutions, it is fine to use +monospaced and
  inline substituted text+ instead of `monospaced literal text`, and with

base-commit: 5fdd5b989cbe5096d44e89861a92b2dd47c279d9
-- 
gitgitgadget

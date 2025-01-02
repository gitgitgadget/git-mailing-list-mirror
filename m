Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FEEA95E
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735818537; cv=none; b=SISkL1E0YTS6ZPjRUA8ZGKBG3CAmnIcoHgSYzHjMgi3DMTH9iszExdVzeDqVpJ/0pHPiF5qyVnVSdYM874740mR/j9REHgHQIdOl/Ad/ycxR+UzSUBXPjJO2nXiY6xAvpCs2Sax6gfAFClMelcSTmjkkA8lQyvivEtYZ0uSpwK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735818537; c=relaxed/simple;
	bh=2vZQPCiRuIrbeiSd5AWjhS2+/3TMbGjqEPYydSNStV0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cNiM2HqdL/uIxjpGK+2c1Gk2i6PHqCNac8cC8PVFFhdMrREqiSz48gMG38DeozqKkDNjuT916uNeImWsVQk80Ks6agUKZFf83Nxa7UZEynxYpu6b0de9sDkfKlLRuYuC3+lJ6t5hUGvH6V06fNx01P83NwJ+aCSuusbqTinB/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQtE8Akt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQtE8Akt"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21628b3fe7dso149424145ad.3
        for <git@vger.kernel.org>; Thu, 02 Jan 2025 03:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735818534; x=1736423334; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RIf1mZxdyOWKz/a/BzWN0WGH/0ZqjIxF5SEI1TQ5lQA=;
        b=IQtE8AktVnVW0bHvcyyXnYVPQ/ZIIYjF5BZBPifmP5XBrKWoK2nV/lq2p/RKOFUtCE
         EbPfWR8bebT27GXyfbO6q5gmFO16aswNwt9wKeL0EgQpQ91hbCgxkHwRPJQasaZDpEwa
         ZTgPs+O57sDfgygm0CJVt+iZCeNIR5U+GAs/ElcA7Qr/QgBBkRSeB8KkUIhc4JT/mLVN
         u22Q6W8TYONssjTZC/cz1r3Iml5xOxKBlXKB+kl7iECsmDe0duSoXlF/zf2zOTgUBgTP
         Snfc30z8W47HdcJFWxymtITKzj26u7Ni/k6ZWzjE4F7MXztFDvSDqRVTBTIDiRz7eeSq
         5LLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735818534; x=1736423334;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIf1mZxdyOWKz/a/BzWN0WGH/0ZqjIxF5SEI1TQ5lQA=;
        b=Jn3vwGcKvIOqFG+PDTcaGxRAgkwTx55Ycsk6dKB5OXFmNnF3iQ7jzG12GU6pz/ICsi
         hhjD/fdZ0+NUFFqpbIqIyPRzy9jK1H/0rLKs6zGSKOsGEXkfqaCTR6ff9Bsxr6SL4F4v
         DJgLFz1cJIhPG5V+4PtZ7wYckt2CZC4GiOQKy9t1q5epSBn1RrG+cxGlD9WqddI3pP74
         /zJ2K4bTbU59RWN8pQLpDb8ki2ehsn2NNUTRyIxwgm8JfBCivWFp7gsrvUApm7DeZD9w
         VdACnpiH2syXhax0Zzo4/BVA1g+RfaX+mEOdUDXCFnu+J0OFLaQKINieDkBoD88VJOO5
         JqhA==
X-Gm-Message-State: AOJu0Yx3JaQPeA7ux/g2aoMTPRBqjgsBwPIDayAQdw5ksy6o2jsj1eXo
	8pb+tCuZAem9oBr026eScEiEsUfNrBB+x7IOb+UtYwTGflyBpLqV5cbqVROuNQ/BEECr8gA0YVs
	B7EMfcq/oR4aac70peVb2EBkuBcZ0RT1Fql6Q5A==
X-Gm-Gg: ASbGncsXU7bB8Q8IHLHx7NWG0sq+L1DAaI5UgUNOFopdJCO4pLvx6xdOm56ONqsQcPb
	lr5oK2PHHhBjfwPJuEZ/7WG+3oSToUbNGbG+9VA==
X-Google-Smtp-Source: AGHT+IF9BvLM7fWtmfE7izNbmypmMOT8QGGAUgaoYQ1b96f47lPiCBqamp/op5WUUoc8NmxUq4a5/yvnR/QGuRrpzRU=
X-Received: by 2002:a17:90b:538b:b0:2ee:5bc9:75b5 with SMTP id
 98e67ed59e1d1-2f452dfccf6mr65844739a91.4.1735818534018; Thu, 02 Jan 2025
 03:48:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hongyi Zhao <hongyi.zhao@gmail.com>
Date: Thu, 2 Jan 2025 19:48:41 +0800
Message-ID: <CAGP6POJX9GFsNkgGd7o9Pr-tFoz0sgRk51vVG4P0Kn1DPZe+3Q@mail.gmail.com>
Subject: Change the grep command called by git with alternative tools, such as ug.
To: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi there,

Can I change the grep command called by git with alternative tools,
such as ug [1]?

Say in the following command:

$ git grep -i jobflow

I tried to replace grep with ug, but failed as follows:

$ git ug -i jobflow
git: 'ug' is not a git command. See 'git --help'.

The most similar command is
    gui


[1] https://github.com/Genivia/ugrep

Regards,
Zhao
-- 
Assoc. Prof. Hongsheng Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Vocational University of Technology and Engineering
No. 473, Quannan West Street, Xindu District, Xingtai, Hebei province

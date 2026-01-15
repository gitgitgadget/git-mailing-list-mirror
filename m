Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333E823ABBF
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 04:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768452193; cv=none; b=QDiAsLKwQiO1qSVTjL9CwJTjf+49WRwFvxpAoMCfm5wRkdAWaWiayn/l3RerRNFQ9CLXRawclf4yV6sc5336FLyzzTN1SZcJNYMs97BDrn958yZ7o30TurGy60L6SqVuV6agsfnzpmqmnZZG/CHiLoWVockWzpA5nFzCJ8ppdMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768452193; c=relaxed/simple;
	bh=mbvwdTCoqMom0ft1aheH0EcxTyfXy+qyd8SKOft/h5A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QVd844VPdamKuPQCsDl/TAVk5TPicXSxA/8OfklmT6TtPOLIwDgH/Qj2sIblVTPoCi8ZST/lzQ3z9rO54KCRfcKa+ZUs9BbRyod8+2TO2qn5ip15OS+Y042PDA4Qgi1SIWgSMI8P+sqwDueqk8I84sYTK8l70n4vGd6bbvf9jrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DK51fun0; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DK51fun0"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-93a9f6efe8bso185143241.0
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 20:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768452191; x=1769056991; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mbvwdTCoqMom0ft1aheH0EcxTyfXy+qyd8SKOft/h5A=;
        b=DK51fun0E+1gnFB4jHGIPG9Rau7Y/X743dF+EXBdFLL5x1wrSpeF7bmEXNSGyYvJQa
         UtaT9/d0ziUd2AngCL8nfsw4WjA45kZx24/KeNAwp1iD3FMvPlET3nIqjPJATxcsLE20
         7YA1Ceeg9ymc3l/GBKHq4MAB9ztVId3JX6Soj/BdIWQq3C8MxdFpx9SyNR6AXpzti8c0
         LlLr5THwT0GW+ed2ebeth8fYqDbvYkLoCHJ883zBxBGwAxB1IoKR1iDXs2RrSB+Ab51F
         G6wKqF2xv6k88yEFMmRSz2TIh6jAC1VDOHj8q5zCumIoPeaGoy1v8u/y9OlEHM6TMeWX
         yymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768452191; x=1769056991;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbvwdTCoqMom0ft1aheH0EcxTyfXy+qyd8SKOft/h5A=;
        b=jc+GSiqRSRQkuxfk7Gy/ZcRCsp0wos1YYVwJRZOuf+r/xqlPe+Dcxv+h5xAJXoUJd3
         5PrtgGe8zfwjUwAFMhHcxtZNrgP03QwNm6LAsdUG7VGYdF78S3OYOjiBL0LptK2yfazR
         7mVkrk6IAMJoO52+6XFOvRLKu8wRimaLiJ7RhbDPcAiLZQtA3K97fJTN0M8LpAbSIO3H
         hbLxhCZlcRLZzobDcNIofDgjvzwpotHukQ63ymk3ha5bY0+hNxUoS9FdUm62Z1gerak6
         4DiVZVrgY2OREGcJTdinRgQ0vhCwitEB+4LD6Ay5I/WQS/SBUvQsktcTgRp+sRYAxO7P
         uVag==
X-Gm-Message-State: AOJu0YyLb+DhUU1AJutqg09Z3cz4sFJhSyNNNo5KzyUMpvJA7MUt06RY
	t+UdksQN67PAEXZKGTwDTt98fSt0ATtfUIY4ply6cYC63rXdNc78yCn9s3N/wTXaWbk7WzukYxY
	yl5A85DhJXuceGDJCuPtBsBwDmnV8kJ4vki3yBLw=
X-Gm-Gg: AY/fxX5WfmYFYRG21zc9VkDZEWDRxYqkqn8YinT2BluGqlv7qIa0wONVgw0B1+en/Wz
	s8A6/YZNRfPc8+ihO4n8nDyiaIZQ6dajkrZnxpXEfQ3RAp64m5XFKztBYpG5pz2EvAs3L1Zabgg
	I8F6X46Lys/SWAdjoVvuZmbIHaSzH9cjJgt8bZuIcoFWhNjo8D5caNgIp0YbC8JuJXbMJxNIK8S
	YuTZPfr+82X39xO0F6CKr1gnqlupOMpX952TgiCqZFDFWu2atJi1Pyzh5AuWIOBqAo1U9IQ
X-Received: by 2002:a05:6102:579b:b0:5ef:b3fa:c89a with SMTP id
 ada2fe7eead31-5f17f640e57mr2055532137.32.1768452190759; Wed, 14 Jan 2026
 20:43:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: book lv <thebookofunknowable@gmail.com>
Date: Thu, 15 Jan 2026 12:42:59 +0800
X-Gm-Features: AZwV_Qhpqovvy_UEplhR6tZeF0dWkVWGp2JVvSD-Tresga9mcTkVj6RTkDCnbsE
Message-ID: <CAFePT4xDGegpEFuFemCXsH890E2WXnG3JzUZeiLi9KW8D8beOg@mail.gmail.com>
Subject: git subtree -P path split [rev] should check for path under rev, not
 in the current working directory
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Git Developers,

I encountered an issue while using the command `git subtree -P path
split [rev]` to extract a subdirectory from a local branch (which was
not checked out). Due to paths in that branch that cannot be handled
on Windows, I was unable to check it out. However, the specific folder
I intended to process did not contain any problematic paths, so I
planned to split it into a separate repository for further work.

During the operation, I received an error:
fatal: 'path' does not exist; use 'git subtree add'

However, I confirmed via git ls-tree that the specified revision (rev)
does contain the folder in question.

After reviewing the source code, I identified that the check for the
existence of path is performed against the current working directory,
rather than validating whether path exists under the given revision
(rev). As a workaround, I temporarily created the corresponding folder
locally, which allowed the split operation to proceed successfully.

While this workaround resolved my immediate issue, I believe the
current behavior is unreasonable. The error message is misleading and
does not reflect the actual problem. I suggest modifying the
validation logic to check for the existence of path under the
specified revision (rev), rather than in the current working
directory.

My environment:
Git version: 2.52.0.windows.1

Thank you for your time and consideration.

Best regards

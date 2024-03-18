Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157831E89D
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 01:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710726937; cv=none; b=aQLJ/cykcU6lj7LF7AsvawLT7gxxq0GIcCz1BUeTFSwhxa27yP9pZSk46+X5DDcXJcsc1YWDo+fNeKlngizqWeGT4md+TmrJIVq6BlKjxI6bUS/JYReYN8jz9VyjP/auyEnn/CzvTEILuOblJJ+wVcDSu+YoBXgkRg+vZdL+Y6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710726937; c=relaxed/simple;
	bh=ZskHhXti/5inyDeu0Y+b9gZdmGxgPFGy3x7FVFNJACQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fkIZARPG0hGFdJfu0HcGuVRaa4KfiWVfqx9rMmvx/15GLiS0WZswmfYHQ7NeHmOrrtGyWRYvV0DQqorbwVyDo2twEz4Z9M2bXEbyhYhKo0xhVEL/E4cqdgGzxjrLPmj1G26EJ3SrVriBp7YCLubg5nKOv5aZirYtJDPLi3yyq5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE/veRT0; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE/veRT0"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dd14d8e7026so3072614276.2
        for <git@vger.kernel.org>; Sun, 17 Mar 2024 18:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710726935; x=1711331735; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K5eCnA8DiIMggio8ixrUksmc7n+IZZxkmHueTLsLTUY=;
        b=JE/veRT0HuvM1T84NElsvuLDXbKabTp0jo8P0whkimwawh5Ex+t6nAvZ7Jip6D4M2k
         onfvq7OIPNz2MMP5nkic6wjitfcQy0p2wIqtDX2ForAzEPdHakZWeKqfC3TiUvJlmc/U
         vfV8QWaDudustkGIPSKRdEkGPTeh6L9YnYvG8VnraI2vJPF+oOWKNgZKjaMOafyXHVF5
         82dz4omn03D8nC8BOiLsmtYyWd7hle+ZaHnvjbFOarS2/OWAWa6aYV8YOL47aBObuu95
         TKsS4uRpyfV0w8ULb8qaU61jtNZIiy5614VgKYA6fagBYLnA4ATbfoVzcx2cvwKf95+9
         Pstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710726935; x=1711331735;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K5eCnA8DiIMggio8ixrUksmc7n+IZZxkmHueTLsLTUY=;
        b=uCELy1RDQxXAIjuMVnlKkl/lhIKNKKA1ZmZW/80KTUa0re0jtsQXPnkpgxEa0PkkMD
         M6p44pzIVb09/92S3vqav3CRSb5afWXataJOMsCQ/uvEIydV+/i9agOItlh4axIA6blX
         7NtYWWs9eTKg+3z+H+XqH8yIthjJg71ANeiY2e2XB6FIVZpYAjygBr395fmBAiwGosls
         B44dNW0XmWgqlQl7SM7+JqFq82KFNOi7Y7ydPhfVzRpTASt1SVD0Sw7P70JDZxI2XLy/
         p/MM5i3qgaFGOJkEOk4d7QozS/GdjD+F4t2Y/QxORITpJ/2J7kl0oPnW+1xLKux+v6fP
         Kvbg==
X-Gm-Message-State: AOJu0Yyy/ETbJIqmsMIma3VxjZ69Op1dg2+fQ6XXoRkZ+EDorVr+p8Uu
	gGFxy5dKgAUhvdiEQ1o59FYZQNrmD1KfqnQa+RuqyHu3IwkuLrR6bRKZk4iUAxsuUStOz1OED3Q
	gpPvyrN+j1dlB+mmc815XMdEMIIhira5UG5c=
X-Google-Smtp-Source: AGHT+IFsIq40FaGOXX+G8HDtVJ86ioGVwR+JPyHx97k70vNNpF7DzDBw7zdGJZpKeUFe89nJxHi6WKlGV6q+sjshMvk=
X-Received: by 2002:a25:8541:0:b0:dcc:d196:a573 with SMTP id
 f1-20020a258541000000b00dccd196a573mr7324337ybn.36.1710726934788; Sun, 17 Mar
 2024 18:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shubhu Rana <xhubhurana7777@gmail.com>
Date: Mon, 18 Mar 2024 07:25:23 +0530
Message-ID: <CANWjJ0M_buzhES7g+6maGFgC668cEcWtMivOfPBPvnifhKjjkQ@mail.gmail.com>
Subject: Subject: Resetting git account from system completely
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey! there,
Actually the issue is that I've installed git on other laptop and set
up my git account using my own git username, mail and password, and
start using remote github for cloning, pushing etc. But now I want to
reset my all the setting from that system, so that when someone try to
using git on that laptop they won't be able to manipulate my git,
github repos, It will prompt for them username and password. I've
tried every possible way from deleting credentials from windows
credential manager and  git config --global --unset credential.helper
renaming and deleting .gitconfig file changing PAT on github resetting
password and tried chatGpt's steps, gemini and what not. Could you
provide me step-to-step guide to resolve this issue? Please help me to
resolve this.
Any advice appreciated. Hopping response from git community.
operating system using = window 11
Thank you

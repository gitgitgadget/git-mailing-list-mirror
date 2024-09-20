Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E7C13B
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726845366; cv=none; b=e2NP9fYDD4bPdJ0NTDo4lXrOiPyBES+9P1cNLAH6tCl7+VfLCJK6WvsA1B0sg2Y9q1Gn9PkEQkJRdArzkDupCkofpijK+QdqbQCSL+wQ16w7TDK4TO4wBytpBmndA7Hp32gMTiFhll4MPeCh+M3Hdp7s6GMk3MAcY8VBQPV1YQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726845366; c=relaxed/simple;
	bh=mkSGv8Fl8QyT8V+97xYfmbbpUxvJu///aQA6P+0AMMg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=U0uSGG+BiKOz637X2eUo7Gdc/rUp8D525p7vqG8xVkYATLHnP6MPFuURCCkF2SlmH9B1CdaY0m0Mn4Ktu8VvDRojJ2IstuE6kd+C04be8QF7wbKOGxUTHGPtUtDkB/4/0YivV+ZHOpsZf8u+mSriW5idr8PtB++GQD18f6m81CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zvh9d/Ra; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zvh9d/Ra"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-205722ba00cso19334155ad.0
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 08:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726845363; x=1727450163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mkSGv8Fl8QyT8V+97xYfmbbpUxvJu///aQA6P+0AMMg=;
        b=Zvh9d/RaZ0QBoyoWHMIGHNISu0CsAfZL3ukwmRQiuXJC+4DEpbUHtKcd4TsTmkqY2g
         ENFImjdY7KcL0/a8ljM6E7genanizQnWL3BRG2NB6vncYodHZr8I9wx/aJ5AdLZIVu7I
         zp9qDkVsh5SpmbV+Yju87WPCbn/+drCgnPCnwEhARgz24u3g7UxVAfEDEi1k+JGqqV3G
         mPC2geXd4tQRxrecFXqBo4jcegoe5r7n/MjoWAr6p0tCGekaAZxiN7Cq7bGG2qxI4AHs
         VuSalPPveSYymhbPqPwysOSWx0bBgb9BJBFBs+H1mVvF0kZTHa42kS0Yjtz8aKO0tp5f
         6Qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726845363; x=1727450163;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mkSGv8Fl8QyT8V+97xYfmbbpUxvJu///aQA6P+0AMMg=;
        b=Wo+lKzMq1j11qfIVoN5xtOCKqrH5snxnK4Mpnve7MN6L457vuYS20FMe4rUUqHdDow
         PgOMutE0b+wTrquVELtsIu9ulItyEjEwmNlJ2sQylZPd5TW1kYPuznRnVitqrqMpAFLT
         8HYT6mSMTfGAby9rXwp5yM77kq2cgl/wMZYcDaDVk8Z4Fm3UvE1651xB2YY9wiQWN35c
         dM6VFm1Yl+fuqqf4G6T3sPBCBtEMC3nZLDXFtrcnZs2WEufNkTmvqexxTD8gfmeei4IX
         0IQE8virWvdXKq+m5FcA4AsEWobXcyIUedroVm7nFyJHzXBgVJcCqt8Sb0E/F+FmHm8m
         Ii2Q==
X-Gm-Message-State: AOJu0Yw8H6b/kXPSfjx397FFWXsm0Ft+apCYWSNQFQCK8r9BQyfIiILx
	g8SwTwYyVTzUh0gxfKFXl2rFvYE6Sco851gxyMfhEK2Sa+woxWMugMHq7QrNC6yqmY1rd34jjyh
	tZ1CehesnamdltDHrSJHZgowATh4UKEDZX4I=
X-Google-Smtp-Source: AGHT+IG7nSLcSL0rMOQ3zuD/aNcmmeORcYtHVHrg+bFK5eaJgaLoAAkGEIDGqmv4q5tJ4Ny7MSasE/qAgOPQT4RlRmY=
X-Received: by 2002:a17:903:32c8:b0:201:f8b4:3e3c with SMTP id
 d9443c01a7336-208d97f02f9mr38995995ad.12.1726845363307; Fri, 20 Sep 2024
 08:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Fri, 20 Sep 2024 19:15:26 +0400
Message-ID: <CAG=Um+3C1JMKoW+j03nF6uS2DjcJnKD7+0PSaiXGB-td9qyc8Q@mail.gmail.com>
Subject: Prefetch maintenance might lead to thundering herd issues
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

The current git-maintenance prefetch command allows daily, weekly, and
hourly schedules.
However, in repositories with many active developers, timing `fetch`
to happen at the same wall clock time can lead to a thundering herd
problem for the backend server.

Ideally, these fetch requests would be spaced out by a small amount,
so as not to lead to a co-ordinated load on the server.

I don't see a way to configure this at the moment in a cross-platform
way at the moment. Perhaps it might be sensible to offset the cron
schedules slightly for users so as to not cause such an issue?

This might come at a small cost of predictability of the run, but that
should be okay as predictability isn't the primary goal for
maintenance.

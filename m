Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFBA320F
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743323490; cv=none; b=pQItkSoD0R4WnmZwMTcDnrxNR4N3nSn8j9BiWViWImXb3LnQRymbqP7BbEVGb2eWoRxpL4hHEX1yeP7VyR+mcGLgX6UjuRTbdlE2gt44tyL+zlkoU0cD22d4R1FfjKgCpclHMT6DHPmqW52apGCZLJWp8o7EuYOlTlbRsccVhWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743323490; c=relaxed/simple;
	bh=Dgbg/23DzLAwbVrNDVVxao5G3EThuK26/Ut1vGCXBLg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cUUxFtPqPTjGe5cZ/x5ftIOi6ZWeoIGFGcB+0AU8ccyAZWs+cqqWxMqsPHEC65T39IkI020kEgyFBq1E10EU/yqfdHCHraxkYfgSGvZBipERCmXZuOgCgUTk3UMSIj0txPlzIcaf9tS0dxu0LvKkx4X5Q/w7tbvMlQ1HwVGMQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEdOLFw7; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEdOLFw7"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476977848c4so36733631cf.1
        for <git@vger.kernel.org>; Sun, 30 Mar 2025 01:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743323487; x=1743928287; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dgbg/23DzLAwbVrNDVVxao5G3EThuK26/Ut1vGCXBLg=;
        b=QEdOLFw7/lgt4i6btLtShYpJ0qbu29LJlSpLw3j6EQ2XciEa3so8Elcgg5tmOdi2xi
         82M5uWywQSKBuRvghTsgsCzzmqojmgahyi1LdicJlaiYYDZlibI1sbjclPGafT7zP5f0
         +blvcP73cURL9RwPX/Rgvo1MRvL+7k0rMaQV9lLKO6er8j0z7nH7RVeIDyylC82CCLjO
         l13Qzj4yyt1PQiG00wwKeifPmovwZHWu/4hrSXHlP9uMw/c7oqMhgmsB6Wq1V6o29p/n
         oIkAXMJWV0IMFh0RSYzuhrKd8VN9zypsYvZY948jkAo1NPd8si1Cnij2VPd2bxnx5eMQ
         ZbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743323487; x=1743928287;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dgbg/23DzLAwbVrNDVVxao5G3EThuK26/Ut1vGCXBLg=;
        b=f4vhbOBEr8rdXYJf1YwIDd6/7S2AXdir2U5aB46E81QzKwLiopRumUlh6fLgFB87C5
         IYhH/+6BTopt1Fb0N9ivTeU3HnGk84s9skM/oNuWzR8ymjgZM0Fu5nZqsqSwqNZpPKW8
         MVRge5l/ih7j+GgXLiMGQC0H5NJQIixXt2tSRy2lHNN/qnOd/4tvDuCIZkO6WCycnoU9
         8DQ8gAqIafmtqV7YcA5pyy8SKVDJy4aJGt/bIs4B5vbS+t05bgpNccRJcJH8luL42sSF
         hYT5ZFR/GzADD3xSEgir+DNR3jyrcn/Cxkc3B9HBWX/o+4MJgVvtYss4kyW9RTfZO3UE
         rktg==
X-Gm-Message-State: AOJu0YyGxjCLfXzPAIEbToBcZQFj75LKb8TRIwLtNO4kNYMl58POGCGA
	DoDxOMkOwbF3VHjWlRdNChq4sMEXMXDsGOt8+MDdrlYxXBtiZ0u/2If7KeQzOtySmEAOvEykp4P
	geoJhWSbwqo08i97PbvvxfFZZ3V7KrnG3
X-Gm-Gg: ASbGnctJYTXLqFsxL2c3TAIUAU5mN3x/d+yCqc+tk46r/x/+utTL+BQp5WdIyCrcQVY
	CTA7fMYHkIWurl5tE8gDhei0dPJPXCUiIyf31j06QFwHt6DdVcdi0oI70WfGB3sm8TGThqqSP4C
	sNucVGXe6EZGwMyt5W7WxD8Sfozw==
X-Google-Smtp-Source: AGHT+IHONsdYvggS8SWUQJHq4iCc6psA1rywe+mcTVD5wXVN2LTJE9ikfAt7URp6QY5lHoxTh4QzJl4e9a5xEJ+fEUI=
X-Received: by 2002:ac8:7d13:0:b0:476:8d3d:adb1 with SMTP id
 d75a77b69052e-477e4b66d45mr83945531cf.21.1743323487299; Sun, 30 Mar 2025
 01:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: MegaBrutal <megabrutal@gmail.com>
Date: Sun, 30 Mar 2025 10:30:00 +0200
X-Gm-Features: AQ5f1JrauLwINYc-nKvesTnfOCgREM7O5GrDeCOhyF3UuHwme42ib3BpgQuDaFY
Message-ID: <CAE8gLhmKtV-Kz4jYT6r1NanmGdAyzd0CumVGsVnVpePQPAtnzQ@mail.gmail.com>
Subject: How to get git-daemon to work in a post-CVE world?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Everyone,

I'm new to the list, just thought it's the best place to talk about
Git. I'm running a public read-only git server with git-daemon. I've
recently noticed that my repos can't be cloned and found that
particular CVE which made git to verify the owners of the git repos.

fatal: detected dubious ownership in repository at '/srv/git/mgsautils.git'

The feasible solution is to declare the directory safe in .gitconfig.
Contrary to my policy of not creating a home for my services, I made a
home for git-daemon and placed a .gitconfig there. It seems to have an
effect, because the error message has changed to the following:

fatal: detected dubious ownership in repository at '.'

Now how to solve this? It's a relative path so I wouldn't know what it
has a problem with. I obviously can't declare '.' safe in .gitconfig,
because it could have unintended consequences. I understand it's a
security feature, but it's starting to get too cumbersome to work
around to reestablish the original intended behavior. (Earlier I found
out that I also need to create a .gitconfig for my git-shell users as
well.)


Best regards,
MegaBrutal

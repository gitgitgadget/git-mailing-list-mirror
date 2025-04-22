Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9391C2C18A
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 02:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745287290; cv=none; b=Rhsn8FMb6LM+C2lISPI2zPe770iDoGiPHq6wH9QdJYnxmDxVaTZeyFvGb1+fFSEKyeJQ8oN++AOb268NR5nDEKmE4+lfUC3oMfmTlpounpsa5d2/7gIs4Prb66IQVyCtFzi0F3tuWMNmV5RAlKWfocXaQ7oHpHQzjmrjYKsSWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745287290; c=relaxed/simple;
	bh=Cmk8GWUpN6F5TOaOqwrjTEJ1x7CA0pmrfjdfwT19RRY=;
	h=To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=kEIySvAOkl7Can7avf0Nz6ZYEH7+dOfNTMCHaBsdNBKXw5aPGAHDP/pBAfVah2Zhx1f/XqZ4IGUMfkcuw0wz5WhuXqqQdLlLPcuxYpmfeTBPVA5/5rx28hdKaOqhbuJqI+faVzkNxpGuAGEAO2LMWJBb/DK083M9ifv65NBqJkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyOl1OgD; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyOl1OgD"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c5675dec99so427353485a.0
        for <git@vger.kernel.org>; Mon, 21 Apr 2025 19:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745287287; x=1745892087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBbBMHEKiKJG3fJgVZBoG7s5b54oxvIS6Ed54iLxx70=;
        b=YyOl1OgD1LhiLn6BvBWyM83KWeIhMwff5+KLtmLXpPvFJ18hSrCrU4ZqSpcnBQwcgQ
         myjinYRA5mmrfLsZ8tChzBK53E9apfzXzi4AIT7QM3YAi7QMXL19A3XhFi4SofEjXVWy
         gNJW4MtRVZEaxmkNXfJuXbTE5JaJ6hYBSFrC/otqOIQHPYLPtt2gzMvS5Rx3kIpRqcAb
         WMRTQI8/NB6k+xotFmUVYQ9zJWgvh4wEAS7+i8oUH0dALrWNCZuTB99TUgHoO/c0djxU
         tDo4AiISvmfI44htOk83P6FTA8M236CYRTieSlE3xc6E3dwgjEbosB/sSyko7RxBmBVP
         2Bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745287287; x=1745892087;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBbBMHEKiKJG3fJgVZBoG7s5b54oxvIS6Ed54iLxx70=;
        b=hZxKyfk1WzUI+SodO7NyN86Z0hUAvvQS71ZJVwQ9u9gp7Y2QrDjVXFh/jVst3sNg5C
         ECRJI+FW3MecGTkpv3MzNXSdUKSVoUv0/u0rPZHEI0Cz4KVYU0qk3nM544mPHWe7WYhr
         VmO4CVdcfTrTfjgwvVJWzA/Rw7jncijjHk2F0uipWPncXgocfb8N0vIqYn/cZYZ3u3R2
         VPSQff75v9LHNIs+tTH9LvwYIu+VQo6shBtjRj1dQ0YaWurHt6DxJnDOT4MbERdmo+M7
         vJnLE5gkFheUoDWIp8pmXIBBvfp/8sNLGTIRm0VD4u1jOPeeVEkHB0MSlGxi4F2Xr4ts
         thlQ==
X-Gm-Message-State: AOJu0Yyy/rrZqTxW2RP6vGk7UuDkEXaO5L/2JFMoNjkcrcls/ntoLOoq
	H+8GuOJfff4RESHYQoVfT6ABVTq1inuG4p+9RecvIS+/rlvD0T0d1x0bYA==
X-Gm-Gg: ASbGncvfLe3zFaSy6g14/spkpJOf1zXS9z7KSvlrVvQ4NDi5m59DQ0erXf+jEtAfxSf
	iW/c8/MIetjbL6gjuQRUcDH+oNthY+VpZR9ABwyY0cvrN04Js445mfmPqw9MGk/ZaamSokeq73T
	tSo0Hz8iSUwE3cBbQMBjdi1EUqW+E0OwhkWp9c0QDonxQf5tly4xg43IWQJlYhgKPpTx/9qMtds
	n0xJf7PjXh+IY59HQ2dsh+/qabKvjrokM8r9cjOcFLH/R6v36tqvba/EyqL0yHEAuDvE+gVF8Si
	Qzqj17jToX0jNxk0hcButZvhqfl3icd+zyh1o/E7O36YlKardcLpTBh77gjD8fIz18kuOaTJaog
	brSCiTXnRwYCIUeymCj/fJEiSS1RgvBYYG8g=
X-Google-Smtp-Source: AGHT+IEnhWwE8YAblmO66vsqFl9Jn5a32wo7GR0yVu/Jo8SiFjDJ1p6wMA5Ss28yK0HwiC5AqqSthQ==
X-Received: by 2002:a05:620a:4415:b0:7c5:6410:3a6 with SMTP id af79cd13be357-7c927fb6a1cmr2160664585a.27.1745287287129;
        Mon, 21 Apr 2025 19:01:27 -0700 (PDT)
Received: from ?IPv6:2606:6d00:11:958c:1f9:dd9:b9ac:d355? ([2606:6d00:11:958c:1f9:dd9:b9ac:d355])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a6e75dsm492836685a.16.2025.04.21.19.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 19:01:26 -0700 (PDT)
To: Git mailing list <git@vger.kernel.org>
Cc: Taylor Blau <me@ttaylorr.com>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Test failure in p5332-multi-pack-reuse.sh
Message-ID: <292ae7a3-2aad-1f22-2afe-739ec921d6b7@gmail.com>
Date: Mon, 21 Apr 2025 22:01:25 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit

Hi Taylor,

I noticed that p5332-multi-pack-reuse.sh, which you added in 
ba47d88795 (t/perf: add performance tests for multi-pack reuse,
2023-12-14) fails early on in the second test ("setup bitmaps for
1-pack scenario"). Since perf tests run with '--immediate', I do not
know if further tests in that file also fail. It is reproducible on macOS [1] as 
well as Linux [2] (I don't know if these logs are public though).

I also tested on Linux on version 2.44.0 which is the first release
in which this test was added, and it also failed similarily.

Sidenote: on GitHub CI, I could not demonstrate the failure on Linux
because all Linux jobs run in containers, and the images we use do 
not have Git installed, such that actions/checkout@v4 uses the GitHub
API to download the repository instead of cloning it [3]. This leads 
die_if_build_dir_not_repo from perf-lib.sh to fail with
"No $GIT_PERF_REPO defined, and your build directory is not a repo" [4].
We could fix that by installing the 'git' package before the 'actions/checkout'
step, but we would need to account for the different package managers of 
the distros we test on.

Cheers,

Philippe.

[1] https://github.com/phil-blain/git/actions/runs/14580975799/job/40897421311#step:4:896
[2] https://gitlab.com/phil-blain/git/-/jobs/9780586827#L2889
[3] https://github.com/phil-blain/git/actions/runs/14580975799/job/40897421399#step:4:28
[4] https://github.com/phil-blain/git/actions/runs/14580975799/job/40897421399#step:8:838

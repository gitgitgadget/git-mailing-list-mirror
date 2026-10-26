Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022745;
	b=EjKZbuFYY1wbXbzDU25gzbA4b4lysUGu2gRFSZdbNq55N4L1L9j6kKeHAd615vTwm97D
	 NYqNGXjKf2ui/JaUjZmrxAaflgpTtzhUP7p598Alez6e/+L5LXzp3qpoUi/lvKuCSXJW+
	 mh1/YJvRO+T7TvqBfkKYXa2ES2ZdFLqczIoifpPHSM53PhijBF9Y6RytWQF3kn/Nv2gic
	 U9YaEpw9xm5zx9H6syW93unGnnhOXd22nvfD3+ew4qlKe+zTGQYvrnA61TCDPjXuxI+L9
	 J6XRU/d8woWakCLWe+MkG4JkNe+E9MRj8WXJL9NGO4pTv3ehwhjaVi73BeUa3qItdnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=+qpO7y5YwMljFkLuJelpqf4bWRyQXzChEQnxHoqe49I=;
	b=Ie7YKkdV0X/1ncqcVOYBa0PogXLuGWt6AdWTJPEtdlOCt0fZPQRJo2rjx+BxrmdB8A/C
	 Kk31jzRfdbw25o/72BuwWQrTmVd/ES8eX6XSPG9AkHJZVWwXW7CruGc2tv9ygD2T5/wKk
	 oL8OPza2wW+wVveP1mNAeiAv1to/l3+0dnJ40S+SXiPORNW7YJEtMrFa51YvKJXtsr8Ql
	 fyYbyhyUkxgvhLvfKcNuhxIggvXlzfZ9Gw7I4snFIJoBOhd5+m0hfUX5fx6Hq3eXxqQlD
	 zhNPN+y1ZkdRx0bMrnAFis+yrjzbvc3O2rBi4I+TaGiVSR+9pr5vDSaTL8zQqnkTjxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="h/Jjv02+";
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C8606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C66C8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h/Jjv02+
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3282db206d3so5949318eec.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 06:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793022744; x=1793627544; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+qpO7y5YwMljFkLuJelpqf4bWRyQXzChEQnxHoqe49I=;
        b=h/Jjv02+oTvBs9TBx064xRjiJuMQYxves3mAerIu8sdb4U5EhvXgyqz/KTdkBCagH7
         iu+8ZlCEUsGCayC++UPqEL8btGWhlzOOgpPt2J/KmLx/pjg5maMLuobJNwQm2h8LXwT9
         bE2Mo66JMnqc9DE+pNDg/B6TuOQFQ+d5EJwb42uZkKiIQ/FVur6JJpU+KrqEKf+7v+EN
         J15lUsNOB1ZIvDxWJfj7Xwvg5vIsUOt1cGfqnQTdJuNrN/hl0itY2HgI7YwQ6I8vgAlZ
         s6XxtWgBc39ctuPYH1a33FDps59r83Z7HKqpIYQG/dbgo/jY93F6yvf6nV4kAdq9TvYh
         /DGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793022744; x=1793627544;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+qpO7y5YwMljFkLuJelpqf4bWRyQXzChEQnxHoqe49I=;
        b=btdQb0z2hHSqrMdeRGhqoj/KQcp1P24vI6XK6SvISZncV4QMfH+XiohL6EXfnVe1na
         JMInc4mgkYm8vFCzP2Y+uba6B5p9j1A7yUJDwvVthQRA7WKPVT7/kqu2VJO0GmvGWfXQ
         usR6bkIzqzm4o+svoaRs8nbz6kTY4I9anHs0VK/NUZU3SwUJDKgchNRKbFWAkFU/E+uc
         WidwjOLn8j/ymcO8rSuQCw60hRiClu8WIRJYB1uAM6MyxanUOTLMJB7k/yzEde/M6zbo
         BB8tKhsvZYqw9rWrPWvK+eTGAW2GELGXAq4h5EttBdmhKKZGksplyn4TiOhPMrzNB68y
         18Sw==
X-Gm-Message-State: AFq9FYJB+zMzqeI/jzoClN18eQeTnBpEGibH+xgCWcxbCUQthGY2aXlp
	v9295l5af+SedhPkuU9KQZI45oSuCJaK5Tye42BRuLaXDvIN/AcLfN2bc1t2wX6F
X-Gm-Gg: AYBFou3U0koLUY3Ccw/3thQXNestHeJ0ILlYrfv1BjVkJVKx73McHGGlpekWDRtbX8C
	FkYJCd+MvLITTl6JdorP8CA1HntJqTCn7wUoajtqkvP+vPSHGqTj+1A3E5GMKgsrOYJcPm/HSgA
	R04hehnTKhmYSuulrN2J+VHjvEKM9uQBmUWI6iV6VvJcGoX6S3Re7I6bWm6cVRpPJVfRJdPKqYl
	bU7qx3DHpTq2fKF4HeXyfDy4V+UdSIjfxNMFQ/vNqxsRib4MkWD/h6ois1z+Fy5Apo8uy0ECwu9
	cIXv++6SV2SynTv9MkthuyGXZ1lnQgxlYQzBScE/zo9gBSP+k20ZLi77EprDPPm4KLX+0F4iqEJ
	LShYRjDRvDIT65qSzzFwiZ3jNH6RzD07dNhrmEdkTf9ndoroKXtyW1+t3fgFitUkWluPU6r6Ng+
	OgIQvbvEbUYXhcxcXfxoUhJDfDxNrAHvcim6CU/gBfgg4Ys5+bEYsIAGCUySoEbMdPJF81nkgYJ
	q6+dR5di4/jYhv3UOJ562IPCI7tQ2MTIFThW8UTqpCbLD8HLLw1NrLvTmKv
X-Received: by 2002:a05:7301:a22:b0:361:75d8:5c59 with SMTP id 5a478bee46e88-369e850d1d8mr10194840eec.30.1793022743476;
        Mon, 26 Oct 2026 06:52:23 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.158.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f27d5bf8sm23890810eec.4.2026.10.26.06.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:52:22 -0700 (PDT)
Message-Id: <pull.2241.v3.git.1793022742.gitgitgadget@gmail.com>
In-Reply-To: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 13:52:20 +0000
Subject: [PATCH v3 0/2] [doc] Remove gittutorial-2
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Tuomas Ahola <taahol@utu.fi>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>

This patch series removes gittutorial-2 and all references to it, leaving a
stub behind to help out any users who might be looking for this
documentation.

The goal is to remove obsolete documentation and make it easier to improve
our tutorial material in the future.

I tested that the docs are staying internally consistent by running git grep
tutorial-2 and making sure that the only remaining references are in the
Makefiles, the document itself, and some example output in user-manual.adoc
which isn't relevant to the actual manual.

Changes in v2:

 * Remove changes to .po files (thanks to Junio)
 * Reword commit messages to doc: ... (thanks to Tuomas)

Changes in v3:

 * Remove gittutorial-2 from command-list.txt

Julia Evans (2):
  doc: remove gittutorial-2
  doc: remove references to gittutorial-2

 Documentation/MyFirstObjectWalk.adoc |   2 +-
 Documentation/git.adoc               |   2 +-
 Documentation/gitcore-tutorial.adoc  |   1 -
 Documentation/gitcvs-migration.adoc  |   2 +-
 Documentation/gitglossary.adoc       |   1 -
 Documentation/gittutorial-2.adoc     | 422 +--------------------------
 Documentation/gittutorial.adoc       |  23 +-
 command-list.txt                     |   1 -
 8 files changed, 14 insertions(+), 440 deletions(-)


base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2241%2Fjvns%2Fdelete-tutorial2-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2241/jvns/delete-tutorial2-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2241

Range-diff vs v2:

 1:  5fd36f91f0 = 1:  5fd36f91f0 doc: remove gittutorial-2
 2:  68867aa3fc ! 2:  0a42345cec doc: remove references to gittutorial-2
     @@ Documentation/gittutorial.adoc: digressions that may be interesting at this poin
       linkgit:gitcvs-migration[7],
       linkgit:gitcore-tutorial[7],
       linkgit:gitglossary[7],
     +
     + ## command-list.txt ##
     +@@ command-list.txt: gitrepository-layout                    userinterfaces
     + gitrevisions                            userinterfaces
     + gitsubmodules                           guide
     + gittutorial                             guide
     +-gittutorial-2                           guide
     + gitweb                                  ancillaryinterrogators
     + gitworkflows                            guide
     + scalar                                  mainporcelain

-- 
gitgitgadget

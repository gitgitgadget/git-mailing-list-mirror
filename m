Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FABA218AB9
	for <git@vger.kernel.org>; Mon, 12 May 2025 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066380; cv=none; b=UZ2wNWzrTLFneuuXiLkAVFKY9LEIWF/pWn++z6OGabCXaU61h1EAsR3dSoDO4JUk5fJ43AqaPVNhxgvkv3a8GoqLcoPichaA/UWOLXc5SctqcUxCyGysZjgx/QZ2TP4e0rqhgswIR+tRP192Ze0oJ08qzh+JzmO1SYR+WMuvcz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066380; c=relaxed/simple;
	bh=fboMPgFG9owt1BGaAW+5Vm2CHspA9fFGIQTJ96wQRY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BESPFdkk+S8NaeXcgqoMsSzUDA1hhfpy3/H6lQ+A5474MwClj/NbQhjMD33N+YaNhKniFNDGveGIaaEjbS8j3V9zY5SjLsVb4j38twA3yS09IhEPQSi5gI34c9fiMKsPRi0C8cZjsvpyBwo0Hv6nZg9ZoMrzZvdfv+xeIpKlIxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJmAOgmo; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJmAOgmo"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-30a8cbddca4so5328284a91.3
        for <git@vger.kernel.org>; Mon, 12 May 2025 09:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747066378; x=1747671178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ID98vSkEiRPfyJPMw42q5L0vA2y6265kaedTxrJF2XQ=;
        b=AJmAOgmo/A5qdVUVgWVpI5ogJ7KozTqrOPeCtfXAvKLSuFn0hPcrNC8/iaIbZ181qh
         I5qQ2vaKNlNKudUR2bz5HvNVpbmJrCdsW19L1oDkcevjpDMmUGzt41pRNr2sK4vHiQkW
         vca9Mx6fPWWd+nXsE1thbzAMsJAqjdqDZKrJP3bum5CpSdxDXjhqZ/y1n1YnIaBco5MI
         TzjN9L+z7i7/zZhpjM1QQBquTEn5WBiNx4fAvbpPbNerStT73s36+TLSvJ5s5j4Upy+s
         6690/K6S3Grjexbx5+OkJbWQZt58pFtptGK08ZsIiXzFIzrZ2cUOTP7Pcnk9YL+notjN
         uM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747066378; x=1747671178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ID98vSkEiRPfyJPMw42q5L0vA2y6265kaedTxrJF2XQ=;
        b=KsFjejSbShCbA8p2Zga0JoAODDRRJd4zQeuVxge8kdg2OLPDRhyYgKGLEKJwpj9ROx
         snysNj6YvKT2WoNZA3l0llz1V3J9hgWjpqUKymkzoMUKQBnty4aH9CGcC0hlGHXwSagc
         SFVCuBSkDU1fiBu/lDJO2CUedhe7edaNl8K+yTLhuZGrrTB9tuyfvom59VGqGAi0s5iK
         EoP6JScJJog2mwcaoHM+rh5w8Ssb/XQroTerIUZ2EiFAXG7BEj6BHU+yCqDGifUQFtFk
         iPs4OLA178GFG4IwhYe0ypOxygP/1HON1F90labYt+FrVfdUcAKj1ZlmG/5aR6WUy/Cs
         +Mxw==
X-Gm-Message-State: AOJu0YxUwJkJaRfROMxmSQA8jOeVshOLEP5NWGnA4mORjaDFnwxWZJ90
	r4RuOF5kT6cKzaNnE3brQodBmrC+6vV5LAMuOFfa/9pYphRel8M2zVhaAQ==
X-Gm-Gg: ASbGncuJvrAG0GmIJuXB83jCxFzd6Q0z7nocsV9ocXvYNS8gpRIXpk/VskGK+OJ2A3w
	TmSw9k8sTlq0CrFPO5kpx1AgvlNSJ82vZZTGvlqoHb69FsliNPd1NSpdZv+kkHaIBuXSwh4NuwA
	1H9Bw0W/NkOBWOg6gh7BoT46ZuSMbT9lcnTGY7MWmrl/62Y14BDKmD+3VVhSJxgFU+x/gwGUQOs
	DIqcT3E6vgGLaJFOzTLxgIsUsGGfRwNBXxq0oZBBMrsLWY8IScgInPBELGW25K1S7qXx9Ea0DAl
	fTEKZ1suN1LCY2Hy06kSXep4bZfInXANnjATNEBXFH99BiSw1XQShac60uoFFR5Wgro=
X-Google-Smtp-Source: AGHT+IFOxj3G56zGY8NOfFSEAE6yoILxO+syiPrAJJuwWZkSGdm+rQ9kYtq2fw0moCOgS3VtF7ZZ0Q==
X-Received: by 2002:a17:90b:1846:b0:2ff:58e1:2bb1 with SMTP id 98e67ed59e1d1-30c3d65cc2bmr18344402a91.32.1747066378222;
        Mon, 12 May 2025 09:12:58 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39e61056sm6736561a91.39.2025.05.12.09.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 09:12:57 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: smacdonald@kaimaging.com
Cc: git@vger.kernel.org
Subject: Re [BUG] git stash incorrectly showing submodule branch instead of superproject branch
Date: Mon, 12 May 2025 21:42:52 +0530
Message-ID: <20250512161253.58427-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.0.533.g80f4e02b4b
In-Reply-To: <TO1PPF29324B4CE6D3518208073452C3C51CD97A@TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM>
References: <TO1PPF29324B4CE6D3518208073452C3C51CD97A@TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Thank you for reporting the bug, Stuart.

This is genuinely one of the most interesting Git bugs I’ve seen in a while 
I was able to reproduce it with the following minimal steps:

    mkdir sdk && cd sdk
    git init
    echo "SDK file" > sdk.txt
    git add sdk.txt
    git commit -m "Initial commit in SDK"
    cd ..

    mkdir ui && cd ui
    git init
    git -c protocol.file.allow=always submodule add ../sdk
    git commit -m "Add SDK as submodule"

    git checkout -b feature_foo        # in main repo
    cd sdk
    git checkout -b feature_sdk_foo    # in submodule
    cd ..
    git checkout -b bugfix_bar         # still in main repo

    echo "Bugfix content" > fix.txt
    git add fix.txt
    git stash push -m "debugging"

    git stash list

After this, the stash message shows:
    stash@{0}: On feature_sdk_foo: debugging

Which clearly leaks the submodule’s branch name into the superproject’s stash label.

This is indeed a `git stash` problem 
I verified that:
- Branches were unchanged after stashing
- Submodule state remained untouched
- `git status` correctly reported the superproject branch
- Yet the stash commit was labeled with the submodule’s branch name

So the stash mechanism seems to be pulling `HEAD` information from the submodule 
context by mistake, even when the stash is purely for the superproject.

Also confirming that this is *not Windows-specific* — I reproduced it on Fedora as well.

The historical detail you shared (that this used to work fine around 2021) is helpful. 
I'll dig into the stash code paths to see if I can isolate a regression or misbehavior.

 
-Jayatheerth

Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6BD399012
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770201946; cv=pass; b=dsXUK6tIbF1NoqRUskxr6UGscVQQl5FAy53yborgqcZmo/WiSSl2Yn2daPWSfN3lYmknVojTC+ZAb9pEeM0Wx0EQ8s/fDIraLxdnVeMd7WtUQBzsQ1aDzCCRCVkoOUXw1kilGIqQL3hgO6lM/+gIOubVhvmIZyo8wlKjuP+46MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770201946; c=relaxed/simple;
	bh=SuyHWO0t/6tOa1UCjAtGkBPnND7qkn+tpEbYKE6z8wc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=arCinzBm9nkjxR2TNt+quaZNT0AyBVJ7JUa8zQvvb0UMX8IZ0UONHUZkPOSlVDvsLMceCoWcDDPvVC2fO+MFqyUQ+fJFOv86S0AM7Q5kF+ZSl/LENA1RRl+tF7JpvQfkiwGFbPVZw1D++OQgXUCsha5wSRizWjOeiqzpVw7VROk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gh6PtGCF; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gh6PtGCF"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so9214945a12.3
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 02:45:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770201944; cv=none;
        d=google.com; s=arc-20240605;
        b=H11X7VkSNKehid4Hu5x1SSjGGTkyqn4zOiqpMw+5BwE+l19G9KiBgpDoUTJpJXJx8y
         RDoIQLz9hJ5c6aGzniDHGtm1FGsXKKlKiiVmc8QWTtJduSUc/EvegFLU3Ny3rK35UrXv
         /Wk0TcYeHBnwnQwUFQMzFCVJUHRCJKSJ5frF0OuLttxvI1xOQe2vqkpr3Shv1ixPuXjC
         bB7GSeF6vgw05H0PduuScyi1IdREjbwwxSZs6VW9xe1Hb/zkUan5BUKe4SzfgsA6DjxQ
         xd95x2GfLW+i5qtogvnFYmi/+v3xpoPS3jBDjskNAiG2tIQTM2KvZPkZ2BRbBwlI7rrG
         XfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=SuyHWO0t/6tOa1UCjAtGkBPnND7qkn+tpEbYKE6z8wc=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=M96tww+VW6K5ZV70mAyfv4o5aiwMPGTuf4Hr9NoAx4zPzpPbov/AojcvO2E0xslt32
         c0TBDADJMpFBUD/NtkSQvBVuQ8ce6rzGJglJn/jSycXCLMgQtH4EZiLJ//NUMcwV6b0U
         kbXEoafX5rPdxkYtCYv5YGenNrTyrYuAOukOqILo0m2yONDOLNJMXpK8Qzoqg79b9Gjy
         KuXaqpYIwcamE5SDgq/NDXYEhlK0mc1SU8pyZdoC5i7qoz6117RITNOxptd6SmzYQrrG
         p2eIjKqrm1U0fmJNqgkR3Myqa6lbJvwu8MwbQTOVh81njyTjZJ6kDAKJroBKT9ROUr2D
         eyFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770201944; x=1770806744; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SuyHWO0t/6tOa1UCjAtGkBPnND7qkn+tpEbYKE6z8wc=;
        b=gh6PtGCF451PjM09aLAC1GikyzwL51AAObLI37UhVc7R17SSIrHgfH6BEIEneoC0c7
         sqwceShdhKTn+z7PU7KsU3H27qglE8G6VxKDEeb3UIheA5OYNNT4KhLEQCgNTPE/beIP
         cFoV68Q2eZfY5AnmBHk19KzFRGEh5mbCVr2v0vPHoIrgM1nQj8ZOQoCKWyixoE4xPIUC
         QXh99KvLcFiD3tRJFwRBNMVEubkDgy1wrueZrg2cVUiNiT5k5LGSDw60ysIaWB3pH41x
         XPxqSigtVEor/1rMDfcswylaJdG9lc3acbnoMK5PP7M5OH98RFfQ2PTTyJSr8opC4INs
         JFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770201944; x=1770806744;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SuyHWO0t/6tOa1UCjAtGkBPnND7qkn+tpEbYKE6z8wc=;
        b=vyfrpjZ8SV07K1AZnZLFXvQOqQ2Jo3EDRmojV4upQLwV2h0EwUXsdNchTFcfou89pG
         jdXPUS2+KuaUZjT58klsywqwtrsN6gDu95apb1ksu03uUfK2GRt/d3aw4yE9TS7idQRT
         yOIL9cPNzOhRpAWKTqyBJcA5tRn05844JSgfeGiQK+etWgnTmPUYQdaNEk9C+IpRaAxW
         MbzjIdMCAf76TdMemQ0CZR41APp2v+3NcKfbJn4WtA0P4+ffYcrgjAxOS6Bo0RldKzqz
         +clGaO0/Ak9wmdooRKNsKua2KeoxYP4xJJZEY/U6418S/MupsJjtHAgje0Y6Tim+CVEG
         AfqA==
X-Gm-Message-State: AOJu0YwV+vToV0A1IKitQtxG5Jpni/UJbgzFjDWqslCLIPOeHD4vFr4o
	/9WvjWSVqMIY8UZ0m8QbmE6oVhT9hD/oJ/cODnbxAVtzdmelltmqml8GMpaOgV5p5m9sO2euw1f
	WgaEEr6lkxS25WMbKfyNi7sXsMdV5eft9SoO7
X-Gm-Gg: AZuq6aKPODYNv4aeNki54nZDq/MPe0ckaXny74KvkuzT8PZiAwfyNl8gwxTjWQCIXFa
	KHwvsR7SKkGxO8qm0//nzbj4HXHrrtl5y+pQ6U8d1eS5unJuXMJfUQoYOM072x/i5rL/luHQ+L6
	qxemlsSbtgKEQ0o+TcqrkGmuW+TzXk6ePd8+1v9I49fU2Z+pK+ZxxLeOnXs3rOkDW3mDWB2qNO7
	ASNFM+OBKGzA1G/V7VFQ8/arQiKFA1xnjaWhThKdMPgO3tYOv0t2KgFspjVI0Nj4EC6Rboam9+s
	EKUladYDVk0TjgNqOgIPTgxVrsR0bZ72KuTC7nG8M1UXuSLx5FfSEvtkxiVezJZr02AtKVAVwyB
	CfbIzqTggHR4hEA==
X-Received: by 2002:a17:906:ee8e:b0:b88:22f1:768f with SMTP id
 a640c23a62f3a-b8e9f428f9cmr208261566b.54.1770201944310; Wed, 04 Feb 2026
 02:45:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: soutrik das <valusoutrik@gmail.com>
Date: Wed, 4 Feb 2026 16:15:32 +0530
X-Gm-Features: AZwV_Qhpelb11w-7lHW-rlG060XHYUx71rEscF79woN2L7piQRXoK7h6143gFnI
Message-ID: <CAPHqhPmDSh8WRwYt0TJUQQajM5r84m6tc6RZsiM-YzeBbxzwaw@mail.gmail.com>
Subject: [Newcomer] Question about inconsistencies in MyFirstContribution.adoc
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi everyone,
Newcomer here, while going through the MyFirstContribution.adoc I
noticed some small inconsistencies , which might not be a problem to
anyone really, but since I was doubtful I am writing here.

> Add a line to #include "config.h" and #include"repository.h". Then, add the following bits to the function body: function body

And then the tutorial uses `git_default_config` , which I am assuming
used to be in `config.h` but now it's in `environment.h`.


Another small thing was
> There are a number of single-key lookup functions like this one; you can see them all (and more info about how to use repo_config()) in Documentation/technical/api-config.adoc

But There is no api-config.adoc in ./Documentation/technical

I couldn't find any other place where the repo_config() was explained
, Inside the Documentation folder it has been mentioned in 4 files
- MyFirstContribution.adoc : excluding this
- MyFirstObjectWalk.adoc : excluding this as well
- user-manual.adoc : used to explain what `builtin/cat-file.c` was doing
- 2.50.0.adoc : is about a release ?
So I assume the thing that the tutorial refers to is currently not present ?

While writing this mail , I checked two previous Patch mails:
One was about a patch by Arnav Kapoor (
https://lore.kernel.org/git/pull.1972.git.git.1748005233977.gitgitgadget@gmail.com/
) another one was probably about rejecting this patch ? And then
From this ( https://lore.kernel.org/git/xmqq8qmso59i.fsf@gitster.g/#t
) I am assuming repo-config used to be called git-config , but a
search on git-config shows up too many matches , and I think i should
stop here and ask for advice.

I believe this won't count as a microproject for gsoc , but
nonetheless, it may or may not help newcomers.
Is this a possible patch ?

Soutrik Das

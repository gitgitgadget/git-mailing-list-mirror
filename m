Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC91C2AE6A
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720210353; cv=none; b=sEBBoyp2CieBomDHzWu3x3SbBJCZ0ZuxaYxhRc5roz4u5TsPn1ToSyaPBUg/Fv+s8km68EJBlp1TyR8p+Vma2Aflhn6++N3NwpuKxXol/SF4GjDJuJl6I6pVngZ4HOIk5Tk3p5bbWHyufelKiVUYSBgdcAfOrI6GcGAqJe8TDMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720210353; c=relaxed/simple;
	bh=7oe+0L4ghGaR++P9qK7tuwGgS/Qm3bvNNldjSqfA8/w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KB7zvRF+VRdEJSUjgQ2vOi6FEUWt9Gy2QIIXKR1aW83ELazju/kT9Q6mjpqD2yPJDps1jmLrJIf5TwNQnf4wbvHqrqjD5Vsqyhg1PiPJdvBR3a3kCpbrWnaEo0Df3iyUOjb7yuFc/ZI4Ka91vMMfipi7fpaqCFegxRYjDtlzvF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXiTVg2R; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXiTVg2R"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e03b243db11so475155276.0
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720210350; x=1720815150; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UG0Uci5Di5ShYJz8ARqJpLvAd19CcYk6/KECAspUkpY=;
        b=nXiTVg2RLaIQ60aFY81PZGg1TR0flRxLLCsgpquFGSWbGfTebtkVgoU5E3P5wid1SJ
         8fHvNRk0+2yeLZRX9nYAcGzt+FYwJXNiRqlANBR8k0qDyETeNEwUds+86c50+gksztH8
         mar1dNBJGepyoJsGGhmU9IPX5B7JZvwyMN9suNCSGmfCfRhUXXoNUkdR4Rw56N6Fw1jO
         LR9yk2GxxXPSD5qQ3R73Chh9u5WjvGhgVQBut3vanCKx8d+5/yXBxCWvyIjtclyJAeta
         1VfzfN4Zd1MqLk2dpr/O0jWxI2SibMd3wFB8GZ4TRd4N2ftii3X8k/ySjfVfjZhrV7JW
         DzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720210350; x=1720815150;
        h=mime-version:message-id:date:subject:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UG0Uci5Di5ShYJz8ARqJpLvAd19CcYk6/KECAspUkpY=;
        b=dJWJBBb/6B8E5/G2kvhkwL27UwVze/hWaLofMBkZOKLzM3sl9x/9/Fuqhtyp4AWcGk
         j93rrXOKVzBhJ9kVJLfONWid5vjiOvCt7IYKs3yO990J2PiDoN/aDNNH9voz61izwMzz
         nXH7s4MCIg1VvfjkvJHZcAD6OD1gYUULcHd+4McrwabFQkKfXEVSndou2MNZYK9ezU6w
         R2/G3e99ReDLBWfQ+w51ZBQmMt/llAt9pFvDmyOq77G3jZla8vakfLL+cN+o0t1kGlUj
         ONnABUghys1nEePmN7Okaw/DTIoqar0JRQQjVUyC9ivCAT0w8kb2wOQ5GP1cADO9M/NU
         tRjw==
X-Gm-Message-State: AOJu0Ywbjxer5vQX6Hri1WiF/XEnJ45Gsg8eApr90x4Y+lwbN0ctE9rh
	P6JowH1e9gUTo7P8Ptdk0fYIJ2rNK2F2/16IYcpAPzY3vPtY4BIzlT8vUg==
X-Google-Smtp-Source: AGHT+IHFl+BVNsfZDkGlon2uOkHkbBty+PwHEQ6uccFF4u4wAkFUhjHLynkAGEtfEJYb0fNBwmGTSA==
X-Received: by 2002:a25:ad9c:0:b0:e03:c68d:b45f with SMTP id 3f1490d57ef6-e03c68de2c9mr4289062276.4.1720210350369;
        Fri, 05 Jul 2024 13:12:30 -0700 (PDT)
Received: from epic96565.epic.com (pat-verona-h.epic.com. [199.204.56.213])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e03ac73c62fsm1013542276.48.2024.07.05.13.12.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 13:12:29 -0700 (PDT)
From: Sean Allred <allred.sean@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Subject: Should commit-msg hook receive the washed message?
Date: Fri, 05 Jul 2024 15:12:29 -0500
Message-ID: <m0h6d3pphu.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From githooks.txt:
> This hook is invoked by linkgit:git-commit[1] and
> linkgit:git-merge[1], and can be bypassed with the `--no-verify`
> option. It takes a single parameter, the name of the file that holds
> the proposed commit log message. Exiting with a non-zero status causes
> the command to abort.

Of course the actual 'proposed commit log message' doesn't include the
comments included when running a commit, e.g.

    git -c commit.status=true commit

but the execution of the `commit-msg` happens before `cleanup_message`
is called on COMMIT_EDITMSG.

This seems like a bug to me; is there something I'm missing? I would
propose adding a call to `cleanup_message` (with the appropriate
arguments) inside `prepare_to_commit` right before `commit-msg` is
invoked.

It's causing us quite a bit of grief (e.g. with external tools that
invoke hooks incorrectly [1] + some other internal workarounds for
things like patch scissors).

Thanks,
-Sean

[1]: https://lore.kernel.org/git/17df67804ef7a3c8.df629cdadcf4ea15.524a056283063601@EPIC94403/

-- 
Sean Allred

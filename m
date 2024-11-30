Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9578029A0
	for <git@vger.kernel.org>; Sat, 30 Nov 2024 04:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732942747; cv=none; b=TfeoLMB/5eqITFCMe52suXIKN9eUlU1qBQBr6q2FZGZP6tTe1dtH6OYxW8Jddsqm9oBNGShk1Wi+mbuebG4qPslEPGDc9bcH2KQ8oy+A9jR6bPtQtqdb30R7rEjNF3JFOPl+SUQ+J1+vV3D7Mydwrzs802zGD3gD3/cvFRVwLso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732942747; c=relaxed/simple;
	bh=5HhOcrmGrF/iemIT1P0eHOGZ9AWJnwb5fzyk9ovGNY4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SRgXnzJ9bYNI6irZJ7X432wIofUk6AmV+KHjbLvXIMYrox5RxDUlWSrHZFMWUAJZKjZkTYQt9H8YV1TkbWuKXZEAf9sjqVu4q9IlQdSgyTZscSLp+z97+X3EYbQd7/t5PdiRPX4WaK57IN52oSrMVikOOe/pybGmfu1gHB33puc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5YD9LNE; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5YD9LNE"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffc3f2b3a9so36344651fa.1
        for <git@vger.kernel.org>; Fri, 29 Nov 2024 20:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732942743; x=1733547543; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5HhOcrmGrF/iemIT1P0eHOGZ9AWJnwb5fzyk9ovGNY4=;
        b=C5YD9LNEAOy3/mi8sbR9J4rbxKHpihqerwHbvOXjjrsGffJtd3A1u4rLNQJGnpGVku
         8maR6M/vzVTj3XClpQEV5vIy6hBO71qbRdXG9o0fPjS3EvkDmW5nfRTMUBskUnfHQu/G
         IHbDq/92LC6atEHzPLx5CFDEYbRos4mWofa0Vgq+kJnQxrmSBctVNRIJFBRGgEi4LcSJ
         4V2Wy9pawqpzYFBxhQFeF+R4wYbEvpZibxcj1I/fudeBLKI3ptMqJWNLz2U7SrEUTuEs
         bDnr0fmmFb/vynl3Gt7udplWYbIM/7CyioYUKb0X2S8dkDDn9xWonHSsl9VhcGgHET+K
         IOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732942743; x=1733547543;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5HhOcrmGrF/iemIT1P0eHOGZ9AWJnwb5fzyk9ovGNY4=;
        b=QmgSO8v9Nq8ExgEbhq6YEqOLbRQtsj7LIzKlvJNCg2MGlhhddZVBwH8c1MpOhZsZKR
         manPVShdsFBN7YYcSfFCZ55yMjvEztJbuGE3kONAUPfO4ndFvRd/JT8AIx2vEIgh7tQS
         aBIbSQLOwRDtZN1rBl3vw+wNk7KhgZ8BvWX0p9pH4PV5mNqfBub3Dhf8bUM0LvLdemuC
         Lx0nZr9lddEQQh44VEXk1Z0DQxAnu5GibeM96SRqJSQL5LKB3hqODUdCbZ4EFnKwzOhb
         PdFIXCB6NF7v4xLvC1cflACJ7APEAMkVv/VDJHzBOGu9WFccfJ4jZxfsWtBt25s60Z2a
         vqkg==
X-Gm-Message-State: AOJu0Yzx4qwmLDrH9ibaZNU/jXGg0uSXXKn6Kv7E+kyVBYAgq39rVFDk
	x4XDQiBscQM8bi0SshiiVXpwGjJvcx9tNeJ+Nryf9kRiszKuLjp2km7Q/fydEWiNN++tbo4tntH
	7tgXB0AnZuuWKB3Q4z3vAgmoKJjTt2/jg
X-Gm-Gg: ASbGncvZxM97K6G0YW/YZXchSjD97sV1h/f3q/QEzwber0lwZN5ISYlHYNA4FGxQ316
	sMy5dkjOemcvNb99Jg8lyKuJgUbRH2Fc=
X-Google-Smtp-Source: AGHT+IEoXvN/ogrR8uzaTzntnN42iWqYi/t+Tu1Aj94+1MftBMcpMCx5VlNH7XlBJLqc13fB9CQdPO5lVBjtCtjqCWI=
X-Received: by 2002:a2e:9b53:0:b0:2ff:d7cf:bfbe with SMTP id
 38308e7fff4ca-2ffd7cfc09fmr84632991fa.5.1732942742645; Fri, 29 Nov 2024
 20:59:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dmitriy Panteleyev <dpantel@gmail.com>
Date: Fri, 29 Nov 2024 21:58:51 -0700
Message-ID: <CAJ-DG_DpNVmn1e=8hBX4YbEhzgX4xxn7AVBQnhKJOvHX4hx7kA@mail.gmail.com>
Subject: [BUG] commit fails with 'bus error' when working directory is on an
 NFS share
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I've recently upgraded my (Linux Mint) distribution version, which
came with git v2.43.0 and I noticed that I can no longer `commit` on
any working directory which resides on an NFS share mount.

Git reports "Bus error (core dumped)" and dmesg shows multiple "NFS:
server error: fileid changed. fsid 0:68: expected fileid
0xf8e3d8e80230ddb5, got 0xeeb48230d99ed0d4" messages.

This does not happen if I move the working directory off the NFS share.

I attempted to upgrade git to v2.47.1, with the same result.

I then downgraded git to v2.34.1 (the version for the previous
distribution release) and the error has resolved.

This seems like a bug to me.

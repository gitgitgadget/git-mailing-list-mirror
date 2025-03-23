Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894072E339A
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742741432; cv=none; b=lxqjv19XDANuB9+DBIYLqpbu1i7y6XzWj3gjqwc123wIwy6Cg72fxbJNzSsCNx7hQJwKqMhUpRQPVtRTzM0Flig9mibf+dxI3mgd63GU3mIrNyZ5D2uRk3cb63kjmD8/OEWAH6HhL5IIK9XxhRzL+U0Co1Zx+ptinyqY/E1sKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742741432; c=relaxed/simple;
	bh=QPmb22lRI5X9W90ruEVsg763i96ODBu6+3SwtLgiyZg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=raOcrdR1N7VBOy0bxT7WndoEZlTwkGgqXYM0GwyOEdgVXxGc3TDJq4xRdXKJ8xZGHoQXuKJhc1NOmxTvZ47fPbccm0rBC5EWvQ/YI6N5qrpFfEYU/iKkgLIu9ZcHvszfl9jnjyVghDBvuIAZTMON2r9WjyDTdhZRHbT29fPP648=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wh9fqQdP; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh9fqQdP"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47677b77725so32128351cf.3
        for <git@vger.kernel.org>; Sun, 23 Mar 2025 07:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742741429; x=1743346229; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QPmb22lRI5X9W90ruEVsg763i96ODBu6+3SwtLgiyZg=;
        b=Wh9fqQdPn9P7l0si9WR2XwyF2/ZUNwL7/NcfG+TKMrixUErOPY1g6xrd7t4SXqc63n
         ZFN5UVxjfGJZ42I7ydMzrUIuXrZ7muCkSi/1M5SWS08feZ9lURPtqXCxp1muGQWqHJ7I
         HFU/vOZLiwD+i/bs+neEYVot33t83af6NZ5xJmCvEgygt6cQZW99rnjU+VCxDfog7F8E
         5pJpHUd5luAJZhFdlrLu6U18i78IVCY9SQXJFeGjjPesAJ/y4CD+WxrJEfAAZlbuWRM3
         JuDDWXPStc2XGGbNe2m3hxH+JCB7xo5i3c6bkq2XyLyUH+gcOUxebRvP1Vq4oF/+t9AZ
         +ZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742741429; x=1743346229;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPmb22lRI5X9W90ruEVsg763i96ODBu6+3SwtLgiyZg=;
        b=nk7QVe5NbZTmL9BaO5DXqK2qQ4ArpFtEfAzl7S40j659NN8aNhu1tbtwQUQmLBiKur
         r8d+cBlRr/K6oqNmljTM+yuEulvPupMqTagz6+x5W7qFlhyk+swsQNuLD9t35AeoXq1z
         GxOo+pMlnytko64zRVIWD3aj1liUdX2BxLZbVIjzjJnyO268rQT97LXeNtzFU5evDWrh
         oedxA5lF26Txd4z03L2VzgrlwONtlNdrCYmvupQYI5S++pJUhe0KcKCbw4aWn8HLK4Cx
         pPMc2B5UGL0bRVPdoduHq0754iXYNmFd8zlO6+1Uo+zJnXCTLw5HQBz2G7jHsIFeHoOl
         MZzw==
X-Gm-Message-State: AOJu0YxCLgcfXbY4wxorqtNuOlmzz8tye3FuDxnAgSsdVvqERwdQ3s5e
	PDSjdrw+g7dBn0ig9Jllq5vJGYto9/msJvFA+lL7abHeYbpQNyNAbDiQj77/6jiIh4D0RXF0QpB
	Cti4L1MyNqQ1hiOM3qrGUwP3vQsXsUVPG
X-Gm-Gg: ASbGnct+XNvYAclAIwVcMen5yJtg9xkYYQJPbUik1G2LcnZfKg8HkzieUUObk3hh667
	m169lfW8Ey4QvXqFTcKsQ/0GwRRRhZPi8uKtWsWRArIudtom1L2OvRJZm4P4e5ZsJ/jiua/Z2ZH
	Yw/TdgFVl5omblgbH5bhPsC6bnG3kE6ygU9HkEbCW0JgwX8J+/R7KKIsnT3NI=
X-Google-Smtp-Source: AGHT+IF5k2ZVsHvHSiE/umxJWyNlH76oh4+LocJ7WvArY3mAEh+fTp52kXCetRv4HPYdFjPuuR4nDn0BXwU1HCN1qEQ=
X-Received: by 2002:a05:622a:244f:b0:476:77ba:f7 with SMTP id
 d75a77b69052e-4771de41cdcmr197915671cf.34.1742741429227; Sun, 23 Mar 2025
 07:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 23 Mar 2025 20:20:18 +0530
X-Gm-Features: AQ5f1JpUUYDpU7uQACX-4LPkPppo7DJY2MRaHvojjWYBNQ1Vg2jpSgguIlJXh7k
Message-ID: <CA+rGoLdvY+JdgdzgE04EJoF9KGUpd39+2S_AgpFyucP38mdFgA@mail.gmail.com>
Subject: [GSOC] Machine-Readable Repository Information Query Tool
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

With GSoC proposal submissions starting tomorrow, I=E2=80=99d like to
understand more about the procedure.

As part of my microproject, I worked on modifying tutorials where we
create new Git commands[1]. I also have strong experience with C and
Shell Scripting and would like to contribute by developing a dedicated
command to fulfill what git-rev-parse was originally intended for.

Could you provide more details on how to proceed?

[1] - https://lore.kernel.org/git/20250321143022.5406-1-jayatheerthkulkarni=
2005@gmail.com/T/#u

Thank you,
Jay

Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24239D512
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 02:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713236113; cv=none; b=Xw3vo4YKXZg5Cjwdlv8r4fqVpvEYO7UcS9F6exkBhyM8tNiOJ/kOYVegLtBP0tANBCPx7r9fyEib8SCaZFZv/EZhqfxUlf7xT49adnez60ZCmuQXy7xTaSokATyqcBIOxoH3j7AhGeQHvpgkbmrvQYM45cxiUUFF7zywzybUSQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713236113; c=relaxed/simple;
	bh=99Hlvh/Avh20aRelmXUe0HejqYEMJTAnZsqWnbhXB7k=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I40bdmOaNGzObaDRRYIvT7riFPLux7kPCwYtJkx9qr6chLLbZa7FBc0/YiRS4So1/pdI7vk7Qt9IDAJ0H99GEEes0NkqRoouuWKSclJZLvDYmqQqp0+II/VR3AMRiHiX+41+uK7+eIEnBDznoiowE02zG7KPpABifs5ovGx5z80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfJIOS6n; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfJIOS6n"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e5c7d087e1so23708555ad.0
        for <git@vger.kernel.org>; Mon, 15 Apr 2024 19:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713236110; x=1713840910; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CDCtkw6VYnf+1+GN4/1l9tEV0lCXukQFLkQUGUb3BTA=;
        b=CfJIOS6nxu+K69YcSTiobIyu7wOmv5FGLGg+pJoB57UKSi1mKcvBNOyMPNYofqiiJQ
         kUHmrxtZTzQbBn3LDUgeifaGwQKHy3E0yCUbwH29qwawB412kTnKVTim8Re4qf05B/Rz
         PjbefohrG2IzCSeAH/rCzp1cF+W6X0bXKSltGlstJvKd6gvwDuT3j3kV2RBUUSSKaULX
         1vVD3xXWrSQya/Exuy3OyhqKMS4InNTrfkOLz9u/w5U4Awnl22vk83jIlmYrGSBxWVRQ
         PXIqrL6zVgbCfxofdlKpLthZfq5C9J7J9vwpMSQrgHg6trn1mYYJn7ofPcKJp0udgJHY
         5nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713236110; x=1713840910;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CDCtkw6VYnf+1+GN4/1l9tEV0lCXukQFLkQUGUb3BTA=;
        b=wD6jaWMpJt8LCigrJxhuTcEw7PBtS7BAdsYRBeNCWbnKKNYscw3jkKbuXugf70nnjO
         w8PIv14S+1HFcl4XlTncb+JChwbfUbK9elP9EoNjgJXH5Kouo67zMKpNZFYKgUNk5s1z
         f/xaSU6kEyNdzX6zgoCDDFUloBR8ESbZNqIChJbMjyKJ2+p3HSMFh51Ub8bhRGUlES0R
         /dd25ocbeqc3dr4h2ZBz+ODef/SIdiyzO3ywzat/hwlK9Y0J+4GZO2CCBB1wlG3lV4mR
         3ONdGAaCSzp3RVMq54cz/vjqolU341w2MFiIXIIdU9B2CBgOwsAyED0wS9KB6Fwg9hMo
         ibeg==
X-Gm-Message-State: AOJu0YzjMtQ4WhGP1sRp8tKgMouRiPeEc8JajjLrzLCaLSg2Pi35lfjG
	XNyMKSsennxNLa95hfXafp9FFhG51FtWEU/R79y+o7P2CjJF5z23uYUh5w==
X-Google-Smtp-Source: AGHT+IFEqYWxZonIbB8fm/Sf/nf1azrdocRvjulo+sVohO6bEnsomEcfZt+eVjARlsaiX9+q2Nxd2g==
X-Received: by 2002:a17:902:b104:b0:1e4:203d:ab80 with SMTP id q4-20020a170902b10400b001e4203dab80mr9840936plr.57.1713236110341;
        Mon, 15 Apr 2024 19:55:10 -0700 (PDT)
Received: from gmail.com ([172.56.121.20])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709026b4600b001e520495f51sm8611193plt.124.2024.04.15.19.55.09
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 19:55:09 -0700 (PDT)
Date: Mon, 15 Apr 2024 19:55:07 -0700
From: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
Subject: [ANNOUNCE] Garden v1.5.0 released!
Message-ID: <Zh3oi4LL1xt524v7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello Git Developers, I hope you've all been well.

I am pleased to announce that Garden v1.5.0 is now available.

- Garden prebuilt binaries: https://github.com/garden-rs/garden/releases

- Garden on crates.io: https://crates.io/crates/garden-tools

- Garden source repository: https://gitlab.com/garden-rs/garden

Please follow the release notes link below for a full list of changes.

What is Garden?
---------------

Garden grows and cultivates collections of Git trees.
Garden is a mashup of a simple yet powerful command runner and a
multi-repo Git configuration manager.

Garden helps you define development workflows that operate over
collections of self-contained and inter-dependent Git worktrees.

Garden aids in common development setup steps such as setting
environment variables, configuring search paths, and creating
arbitrary groupings of repositories for development.

Garden's is a tool that helps you,

- Bootstrap Git-based development environments from source.

- Apply Git remotes and git configuration to freshly cloned
  repositories.

- Define arbitrary collections of Git repositories for running commands.

- Define environment variables scoped to specific projects or trees.

- Define custom commands and workflows.

- Leverage your existing shell scripting knowledge. If you already know
  (bash/zsh/etc) shell then you can learn to use `garden` with minimal
  effort.

Garden is configured using YAML files extended with a simple shell
expression syntax. Garden lets you define (multi-repository) workflows
using the vast ecosystem of UNIX command-line tools.

Read the Garden User Guide @ https://garden-rs.gitlab.io/
for details on how to use and configure Garden.

Read the Garden release notes @ https://garden-rs.gitlab.io/changelog.html
for a full list of new features and enhancements.

Have fun!
-- 
David

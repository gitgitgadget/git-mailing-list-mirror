Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7892648A2D7
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711391; cv=none; b=YuHHYJ/gWl1EA/4grF3RUa/Lzq2ZP47+oK+utcxhl8xTVEDr7uBzGY4T0Rqn2Sy1kYFAD7PK02D9G5nXFfNmbAfBGv/8f4ukadKJS12uYGOLu/iWQtys1lh4UI8EX1UzDVhopbWVtNkQJLfAGuWqBHZBv3obdVyC9ZXMnlmDzr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711391; c=relaxed/simple;
	bh=UPfTpdgPpPzaFJ1clW5sNpTe4TH2EVT9wxTMXpTa+X8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UFGPTKyZyQJNwWjoU9IxSCjGqgM/4Jn+zqZRkX9sTF49NAy3KY8nZ15zyj8BGklT5n+QmM9l+iyJ/SxWjovnx/Mxff1Np1PxF8tvJNoDa2dH0L5tEp+vGZzE2kbj+mbkxNASMkY8XYWtu2EvWMHcJkOpSms/cXZ9c/JqY1wm38k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=Xo36brsB; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=hW1dTjbP; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="Xo36brsB";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="hW1dTjbP"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Xo36brsBCdDITPmprddwn7nBETI2RTebMXhp8nRJRy/gCaZbCTCJ6SfL2CyoJqntj7EbJLLggA4lRNMHQMdMegZfshqcZRCGDZaXGcWFWOtzY9f+Wuj4dc2ALWiYE+SMA7ZazdtkXTi2AVx1fmqCiyRxUEHCA2V0bIK6ncfCt1+hnzXaTx/UUbXAcuiB7Xe1gu+qiS1MZC3HxkUzxGJHZYcOeG8Pyfr3TNUC5aGNtN/QnhNGRv1jTYqJWiQ2q349FZF4u5SP0nYGnby9XbNyzqENxMRMPCnYE89icY41cNI7V2PkaEO2KIvzVRJoQvqLquc0e6PrnjAsPAUHgwC62A==; s=purelymail3; d=malon.dev; v=1; bh=UPfTpdgPpPzaFJ1clW5sNpTe4TH2EVT9wxTMXpTa+X8=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=hW1dTjbPIWeNJwXjO1+yhA3tfKY5r2uSR/iFo/YVSwK4IOGAwGRrOrSkqPQ7ZzkiTnKpXxEM/wxC5bH52MWmgPfJL5EvYghhty5NaRLX6cPPJz5EqC7sBNYV2K1773uc1MpOPuJHrBpNdCyWJKzRYflcQeu1E+8dL5JHJSKnMEtHr2lBl0FqvYWV9B1puBrkx48Jr6Flpv7HsOs2chX8X2joerNF4TJuMN72CvUAt0elJSnCrghAD4nb0Sqrvqg95V/txw0MP/ydgJ704rZ2INucqGEcNx6xKhy+xB/93Q+OQCltXoy3nIz3LMjAjARywplE+WC/HMfjF/VNsEo3rg==; s=purelymail3; d=purelymail.com; v=1; bh=UPfTpdgPpPzaFJ1clW5sNpTe4TH2EVT9wxTMXpTa+X8=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 416529734;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 17 Jun 2026 15:49:36 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood123@gmail.com,
	johannes.schindelin@gmx.de,
	stolee@gmail.com,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH 0/2] environment: move ignore_case into repo_config_values
Date: Wed, 17 Jun 2026 23:49:27 +0800
Message-ID: <20260617154929.564498-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The 'core.ignorecase' configuration, stored as the global variable
'ignore_case', acts as a core filesystem capability flag.

This series continues the ongoing libification effort by moving
this global variable into struct 'repo_config_values', tying it
to the specific repository instance it was read from. This allows
us to encapsulate the configuration without altering its
eager-parsing behavior.

The getter function 'repo_get_ignore_case()' is introduced so
that we can safely retrieve the configuration value whilst
maintaining the correct fallback logic.

RFC Questions:

environment.h --- Is the fallback logic for repo_get_ignore_case()
correct? I am unsure whether gitdir should be used here, since it
might not be ready when we access it in the early stage of
initialization (e.g. git init / git clone).

dir.c --- Performance overhead?

compat/win32/path-utils.c --- Is it appropriate to include the
repository.h header file?

Related materials:

[1] In this patch to migrate protect_hfs and protect_ntfs, the approach
of introducing getters has been endorsed.
[2] Derrick Stolee's previous attempt. The reasons for the failure are
also mentioned in [1].

Thanks!

Mentored-by: Christian Couder christian.couder@gmail.com
Mentored-by: Ayush Chandekar ayu.chandekar@gmail.com
Mentored-by: Olamide Caleb Bello belkid98@gmail.com
Signed-off-by: Tian Yuchen cat@malon.dev

[1] https://lore.kernel.org/git/20260606143412.15443-1-cat@malon.dev/
[2] https://lore.kernel.org/git/2b4198c09cb6c04c60608d19072d419503dfe5df.16=
85716421.git.gitgitgadget@gmail.com/

Tian Yuchen (2):
  environment: move ignore_case into repo_config_values
  config: use repo_get_ignore_case() to access core.ignorecase

 apply.c                             |  2 +-
 builtin/fetch.c                     |  2 +-
 builtin/mv.c                        |  2 +-
 compat/win32/path-utils.c           |  3 ++-
 dir.c                               | 18 +++++++++---------
 environment.c                       | 11 +++++++++--
 environment.h                       |  9 ++++++++-
 fsmonitor.c                         |  2 +-
 name-hash.c                         |  6 +++---
 read-cache.c                        |  6 +++---
 refs/files-backend.c                |  4 ++--
 submodule.c                         |  2 +-
 t/helper/test-lazy-init-name-hash.c |  2 +-
 unpack-trees.c                      |  2 +-
 14 files changed, 43 insertions(+), 28 deletions(-)

--=20
2.43.0


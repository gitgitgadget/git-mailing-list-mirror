Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977A53B42C2
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781887120; cv=none; b=XFpaDx9E27M1vBXGZllb5cF+AeXgQEdCpdGPprkJJOydxUaSjM0HvMw8IxIDaxlHP0warr2irZIeY8P/HSsXqypbOPoVG72eqThuAcdiHNF01VCdYjWuRltFLkr+jyOrzMaC2RF+6Nwnku4nQUmR/tznSoJAi+Uy9vLbYCcfMVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781887120; c=relaxed/simple;
	bh=6q+czPWacePL6DRJ/SwpsPjSrI/SZjFAff7vAtA6MzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bhgCGMBhTb97gZ99Bn8uOOeDD7+Ew2ISJMy8HDHwQ1mNut6PSWDfwKNqabmQ8NX8NmkrQier+Y0Gu0kb/O61nN2l3zM5LirbHzFVYpNcG8cGzmgllPeipa2AYHzPyUtYML+H/Xkt3jTIP2VDUuD2xWAsgTFhSKS5tY0hdQEvgvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=jmxiR2Ko; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=dO1ZNzMW; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="jmxiR2Ko";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="dO1ZNzMW"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=jmxiR2KopJt0Ivg3HnM9/fO08gHSVEjvE/sYp772jsI+bXez2etHjLujaK9oCu91o/4uEh8Krq7htnKZz6H7jL7r1kOyvKvDVv2rzV5FQ+A2l3X6secN179Txzr6Y3/4abQ11aw7Z05CVifINakYLb2Yvj8JAgnaN4sIJEg2aK82aouuTbF7vj7PQIhUI93c1sZEIQX3vUtRrgE0kG1t2Avla99C2AWj/zFxy4EZAxzn+cMUo2pwk7KFgnTRT1kUsff1HqWtIC8epoEBcguO0GaNds8waSVhvWWSKE4ibRhpJJjp8DaeSs+7Ln+d1z8qDqR4fx04RxhX8luUeNan3g==; s=purelymail1; d=malon.dev; v=1; bh=6q+czPWacePL6DRJ/SwpsPjSrI/SZjFAff7vAtA6MzA=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=dO1ZNzMW8w30p2i5IHZUlcZytht5eFuuFn4QCmy74yNdLnXR24sehUUfhYHLpg6cxQlbOCPapTZ0eJlfBcUNdFSAZ1Tb8Ahsxyh+bc9Nxqn1PRQkgE596DUrwHXF8HFLQXJRfBfE6Htcd7g2Hasj6PSfvMqxGr3OjkdSR2HlhlF1TyGuORCZ3OX8K+T8VIzP+RVB0br0gME1YZ4IByxJ5lswcNtLCeXEmS5Ezdsv6xa/7XFrIh+cMBHccgWcatS4otTtzE/pUbfeOOjmgNvl9Jps8nsA2h73t5T5yd8Tuzx8YACTFlNSjwMsxUIMoLVJGr0a6u5w4TGKZC1G8a0fEw==; s=purelymail1; d=purelymail.com; v=1; bh=6q+czPWacePL6DRJ/SwpsPjSrI/SZjFAff7vAtA6MzA=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 474948874;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 19 Jun 2026 16:38:37 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v4 0/1] environment: move protect_hfs and protect_ntfs into repo_config_values
Date: Sat, 20 Jun 2026 00:38:22 +0800
Message-ID: <20260619163823.652091-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
Reply-To: <20260613153302.168801-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Hi everyone,

This series continues the ongoing libification effort by moving the
global filesystem variables, 'protect_hfs' and 'protect_ntfs', into
'struct repo_config_values'.

Place them within the per-repository configuration structure
aligns with our goal of removing global states.

For reviewers familiar with previous libification efforts, Derrick Stolee
attempted to wrap this kind of filesystem-level variable using a
lazy-loaded global accessor get_int_config_global() [1].

However, as Glen Choo pointed out in his review of that series [2],
it is strongly preferred to use plain fields in a repository-scoped
struct over global lazy-loaders, provided those fields are properly
initialized during the setup process.

By moving these variables into repo_config_values and parsing
them eagerly, we successfully tie the filesystem security flags
to the specific repository instance without altering the timing
of configuration warnings or introducing new global states.

Thanks!

Change since V3:

 - In repo_protect_hfs() and repo_protect_ntfs(), change repo->gitdir to
 using (repo && repo->initialized).

[1] https://lore.kernel.org/git/a42dd9397d07b2dc4a0d7e75bfe1af2e46cad262.16=
85716420.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/kl6lbkhpzujf.fsf@chooglen-macbookpro.roam.c=
orp.google.com/
[3] https://lore.kernel.org/git/20260612160527.167203-1-cat@malon.dev/

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>

Tian Yuchen (1):
  environment: move 'protect_hfs' and 'protect_ntfs' into
    'repo_config_values'

 compat/mingw.c             |  2 +-
 environment.c              | 22 ++++++++++++++++++----
 environment.h              | 12 ++++++++++--
 read-cache.c               |  7 ++++---
 t/helper/test-path-utils.c | 24 +++++++++++++++---------
 5 files changed, 48 insertions(+), 19 deletions(-)

--=20
2.43.0


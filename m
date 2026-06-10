Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B343F7AAD
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095444; cv=none; b=LmzuUkd0uyd3PNrGKhI+P/HCfQDzxY8wVkoj/kAP2zoJYo6YTFyQkEKU3IteZYaV1Qatqtria8OfE5FzjUYLaDKCKVxvLTHf3xJgRx3kJ/yBEpVqf/wTLQ6zmkjx7B8UtRCRJPImcU0cI6ej89nZbhr+LOCnKPsM9N5OslXqEk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095444; c=relaxed/simple;
	bh=csQbB7RdedliIscqQ7j5jFzkiq6Bo9IBxozMEW39atk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCIzChxqs7w2mU8FEIz97rWce52Bnm3CN/Mh4mL5jSb5NtaH0RhqUlZ2lmHPt6ScjR2/14AOoXuWCg/aaFWeRIvujYPy0Zt/93SpNkcJ4UWbyGr0lcw53d7zyy0YgKmkbGDZjNbRLXdWagikZGZG8cmxSmiThIYxO8Q9RI/QUmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=MrXRldWh; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=ViZtPYRR; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="MrXRldWh";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="ViZtPYRR"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=MrXRldWhjM0uuwcQUtism2leRuMFX6KzSw2jDJHb8iYx+H9/ZJQSqvNhhFGNJilcgjtf4oQ+MwMjFefxuQHWaf945bntKUCFxXB95W/6ZC4M4c0im1jL+cyuCSKc0cFyesh5XZ68aMpTGHmwf6nqTIDRCj5RKR8oHifpSbjti473CloLVrdkAZdfWs4GUO7LoiJn6EK5E7LpibKSn/G4uSyk1LaFKY/n4RHxa3J0UQtslNCPH9RquA+2bzQ0UwAADWE8Ymqaom5pVF2Cgj9XWdcyKhenTEp9PWemA4aWcn4uhKKfBzXtUGniha+g1ouic0/UnEKXnqQZEuW8uldIJA==; s=purelymail2; d=malon.dev; v=1; bh=csQbB7RdedliIscqQ7j5jFzkiq6Bo9IBxozMEW39atk=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=ViZtPYRR7/o1remzhFy4Y7fk/GwflDbIRS83eaj/mmkAy4pxeDjMXntrNz7FzuPdLNovyNUdRDGrVCZ9PEsnRfzOfW825dQqT7W9wb1Df4q6iR8QcjZo2Y0YpSPPpabHVkbeiH6ENClEQFU0+nNL2xZL22CuEuXlztekE+nCj51QWwIRFUoiNSthpYfxrT0lgg6uigWha8OELQrDMNNMZPT7ox38tj24qObawtHOUZ+SNweJHDMoh5V9roVNpMTkQeSZXKkaeAB/q3p0DI0W9TjcTKBYjB7UlEQcFei2mu477Rm4PRvmZa7c56OBwRwTkK4zp4LGRZfOc4Y6LPyhxA==; s=purelymail2; d=purelymail.com; v=1; bh=csQbB7RdedliIscqQ7j5jFzkiq6Bo9IBxozMEW39atk=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1900269065;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 10 Jun 2026 12:44:00 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 0/1] environment: move protect_hfs and protect_ntfs into repo_config_values
Date: Wed, 10 Jun 2026 20:43:51 +0800
Message-ID: <20260610124353.149874-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260606143412.15443-1-cat@malon.dev>
References: <20260606143412.15443-1-cat@malon.dev>
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

Recent related patch (environment.c: migrate 'trust_executable_bit' into 'r=
epo_config_values'): [3]

[1] https://lore.kernel.org/git/a42dd9397d07b2dc4a0d7e75bfe1af2e46cad262.16=
85716420.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/kl6lbkhpzujf.fsf@chooglen-macbookpro.roam.c=
orp.google.com/
[3] https://lore.kernel.org/git/20260610093635.139719-1-cat@malon.dev/

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>

Tian Yuchen (1):
  environment.c: move 'protect_hfs' and 'protect_ntfs' into
    'repo_config_values'

 compat/mingw.c             |  2 +-
 environment.c              | 22 ++++++++++++++++++----
 environment.h              | 12 ++++++++++--
 read-cache.c               |  7 ++++---
 t/helper/test-path-utils.c | 24 +++++++++++++++---------
 5 files changed, 48 insertions(+), 19 deletions(-)

--=20
2.43.0


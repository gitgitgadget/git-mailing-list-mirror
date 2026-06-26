Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157CE3E00A3
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782460252; cv=none; b=BeXqta1d92UESTye3vSNYDf/XHDY5oq82iB7CoFtT8UlLiE43Y7rdNiZXEwZz+AAgVd4uM+2R25gZfSgVyJzHITdk2EAOW7bFkNulU/tEweed6JeVSnCVkyxAz82g6Te93lTpQh4u/4X+rRs4Zn8+91YSCYPiIusSJRH266W/gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782460252; c=relaxed/simple;
	bh=hQn9AbN8TUY4mPSrEpDKACT3e5WZ+e/00zu2nZECtTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gbSBfD2UzoYbJP3WwiZcjCj25wLYanL3hHaEH4SMM7mtsARgm7OXzoVStttCHIlCfVYA+jVaErqbIBWcFIIBKQdOJW5C2FcBkl14U3IG3k/3K0Mj07jFpgAXIXee9W85PbbN01PgTNu4wajrxiflWuD31l5/IypQTTEj5DhsCww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=csMRFkp3; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=DaK6zvQV; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="csMRFkp3";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="DaK6zvQV"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=csMRFkp3Z9hSNGfuI7wv8EszKE3bOF20oBfnCkJU49yUMbbvszepGniMQBeP6kvdx20oDYQ0ZL4HtXBdKqR3ee3yJZm4iP3IJbbYe6bHBNVkIxfiY5IDhD8oze3HewdChXmqvCLPWnBH5L0+BjY0tbdrU9GS8OAcJB2xjWKfeSOfq8LUhOHPTuRXIKyCf9ou4sip0XISUz7lE+Whoorg3woh1ovIoZgpDOsEwsyXQt5upYK1O6QGesYjM8V9WiBgO7s/QzHgk3cqgUXYnYsMK6qwr4W9ghIYtBYylTK5oAQ0wqBJkYAQFBLrSKvQXOC9rbnnXXSxz7fPKjqK5XnCCg==; s=purelymail2; d=malon.dev; v=1; bh=hQn9AbN8TUY4mPSrEpDKACT3e5WZ+e/00zu2nZECtTg=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=DaK6zvQVld6R8U8nPopEC5jQ2y/KpGfYC7v0fhkZRShxPknMJiwh2pHm66voCw9XWJjxb75DKCBQ6zmO74fbsCoK+Ra5nh86Ki9HUPTo24N9gOC5fwVVgy+7jcdhCqWX/KE2Ue5rtZ/HUoYrtrENeiXszCAnBYVvhuMIW3cet7eEpo3cDwqUDyeAK2Dc37htk6dxRk3SOCe6f+wcQqD8zSJU8VK/4Bfn5Q4FoKsiYE2TDOPp8cG7xzPnwNRxGO6zxPJv5MlAna0T7YDDmuMs8HNyvZ2XchTw/AVpkhSxagxMwynqQiBJBJYy8cDMtI84keYzmZtp21ydWQQ4NXEMgw==; s=purelymail2; d=purelymail.com; v=1; bh=hQn9AbN8TUY4mPSrEpDKACT3e5WZ+e/00zu2nZECtTg=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -72641762;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 26 Jun 2026 07:50:48 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 0/2] environment: move excludes_file into repo_config_values
Date: Fri, 26 Jun 2026 15:50:35 +0800
Message-ID: <20260626075037.532164-1-cat@malon.dev>
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

This series continues the libification effort by migrating the global
string variable 'excludes_file' into 'struct repo_config_values'. Since
this is a dynamically allocated variable, the migration requires proper
heap memory management.

The series is structured in two commits:

 - Abstract the XDG fallback lazy-loading logic out of dir.c into a proper
getter.

 - Move the variables into the struct and introduce 'repo_config_values_cle=
ar()'.

Note on Submodules: A temporary shield 'if (repo !=3D the_repository)' is
included in both the getter and the clear function. This prevents
uninitialized submodules from triggering the BUG() assertion.
(Inspiration: [1])

Changes since V1:

 - fix a typo in the second commit.

 - initialize excludes_file to NULL in repo_config_values_init().

 - call FREE_AND_NULL() to free attributes_file as well in
 repo_config_values_clear().

Thanks!

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>

[1] https://lore.kernel.org/git/c95a7730-7b14-4be0-a4e4-861b2f5430ea@gmail.=
com/

Tian Yuchen (2):
  dir: encapsulate excludes_file lazy-load
  environment: move excludes_file into repo_config_values

 dir.c         |  4 ++--
 environment.c | 32 +++++++++++++++++++++++++++++---
 environment.h | 13 ++++++++++++-
 repository.c  |  1 +
 4 files changed, 44 insertions(+), 6 deletions(-)

--=20
2.43.0


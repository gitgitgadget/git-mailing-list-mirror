Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786288;
	b=OY5F0BqmsnLpm+vy5wqKxT79SrCV1HI1W5Eu6PAhCXMJCSULHiOlDCKSqLcwBfkJjFkY
	 7I4NsQKyz7z0Yn3OshSC0NQY0O89bbNPjORa0/idxVzTGpzJx3n5JwvjDBHrNKoiyT5+x
	 uf1dLUvtDs6CZltHdv0VC29fUbI05IZu+694CB7in45z1UZAA+oTn7yRP5yovISs5LvCI
	 MsYEFfBs7e1GPfbv3YNIZ5bQRYjUxyVS8E3Yh60Vww+nXGoeooGTdeG4gfL2DovKvVdxr
	 MUYT58UywamGBu4nEHYfXGmALAtW+3IXq+XJF2IoGQZBTGZFQV92Zf+iY4mAIux3wEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786288;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=stMFVKr/27ccCbelraShAab0DK2zFA8pYJ80TmVfrss=;
	b=TkaXzNzGqyhVVSu9GszXjVduhJQm9xf+esMrPrAzPHgmbWffZWmjuVxeSfQAJwOpskhS
	 tCybZUFSd5kXV9ptujGfibHdcV0QWl4F26nWIkurRjDbc795eIY0+/yN98JGuI/YrgPpe
	 JV7vDgrzW8PlFCKI5ftgBI10gtbI3l9E05evU1Bf1AN6AqY7j4CPbGx3ZLYLw+IOCzWUo
	 8kq0fnvL3iZJnVa6LfzSDETu9Y87+4xlQ9YGMVMvEHPD3gJWWgbWcyAqyhOEBS8g4QTKE
	 tDpNeYfIVX6vkt8y7uTkZ7i5BeSuiO1vHUcPvNuUUmhO3XIebfh6Bvow7F/Bf2wMZFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b="Rz/ka8Ym";
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAB5606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 09:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BAB5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=Rz/ka8Ym
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 6A49vrrP020958-6A49vrrR020958
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 4 Nov 2026 11:57:53 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xOXkf-002x5d-5f;
	Wed, 04 Nov 2026 11:57:53 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 11:57:52 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 718ba637;
	Wed, 4 Nov 2026 09:57:52 +0000 (UTC)
Date: Wed, 4 Nov 2026 11:57:52 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Carlo Arenas <carenas@gmail.com>
CC: Patrick Steinhardt <ps@pks.im>, <git@vger.kernel.org>, Ed Maste
	<emaste@freebsd.org>
Subject: Re: Is anybody using .cirrus.yml?
Message-ID: <20261104095752.2rs5_%taahol@utu.fi>
In-Reply-To: <CAPUEspg_9CGMtakHO3Stj--exd5nRNv7i3vW5tmMF0Arzmo=zQ@mail.gmail.com>
References: <20261102204151.MA00I%taahol@utu.fi> <aumQMJLMeI4sfeNI@pks.im>
 <CAPUEspg_9CGMtakHO3Stj--exd5nRNv7i3vW5tmMF0Arzmo=zQ@mail.gmail.com>
User-Agent: s-nail v14.9.22
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ex19-05.utu.fi (130.232.247.45) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhRSBgbKBgDG0YBBUhYSFpIWVxI
 WVtYRlpbWkZaWF9GW1hIUEhYSFhIXEhYSFhIWEhZX0gLCRoNBgkbKA8FCQEERgsHBUhYSFlQSA0FCRscDSgOGg0NChsMRgcaD0hYSFlRSA8BHCgeDw0aRgMNGgYNBEYH
 Gg9IWEhRSBgbKBgDG0YBBUhY
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=stMFVKr/27ccCbelraShAab0DK2zFA8pYJ80TmVfrss=;
 b=Rz/ka8YmSLvPPQfFfuZ0jiHpt4E/eweEYCPLDkeaPbQ8sZMWoGKJaZMqnMYcIggUs0M8XpdRORlS
	ZQZruQsYH5IFK4+TdOxN8+2rhLJ07S831PSaTz7qeLfRtV9Wip5G7h1WElIbsuZ9DNuMS1ltoQoI
	1xq76W1hEEi0qXi08IO0jmmfMX5m4VY7kOtrU2Yo1AfGs4oCI5HerKmdUhqceij/PY9+EsHuRdAA
	+ViipPi+xRQuhFeKM59D8lttYueiiwcuEjkmNLFNKtSMYDw4llnuPx84irJ25dX+jk7LeJf3gybj
	P6Xw8RgmCwJKLSz3Ty6Xxvu8qJzVBi/dqF0iXQ==

Carlo Arenas <carenas@gmail.com> wrote:

> On Mon, Nov 2, 2026 at 11:41 PM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > Anyway, if nobody runs it anymore we should remove it. But let's wait a
> > few days for Carlo to answer in case he still does have a usecase for
> > it before we send a patch to drop it.
> 
> Thanks, but there is no reason to keep that file around AFAIK.
> 
> Carlo

Thanks both.  May I have your acks please?

-----8<-----
Subject: [PATCH] CI: delete defunct Cirrus CI configuration

Since b5a9d7afcd (CI: add FreeBSD CI support via Cirrus-CI,
2019-12-20), .cirrus.yml has powered Git's VM-based FreeBSD CI.

However, with the shutdown of Cirrus CI on 2026-06-01, there
don't seem to be any drop-in solutions available to support our
usecase---while there exist tools in general to run Cirrus pipelines
locally, managing FreeBSD VMs doesn't appear to be covered.

That renders .cirrus.yml completely nonfunctional.  Delete it.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 .cirrus.yml | 24 ------------------------
 1 file changed, 24 deletions(-)
 delete mode 100644 .cirrus.yml

diff --git a/.cirrus.yml b/.cirrus.yml
deleted file mode 100644
index fef04a3840..0000000000
--- a/.cirrus.yml
+++ /dev/null
@@ -1,24 +0,0 @@
-env:
-  CIRRUS_CLONE_DEPTH: 1
-
-freebsd_task:
-  env:
-    GIT_PROVE_OPTS: "--timer --jobs 10"
-    GIT_TEST_OPTS: "--no-chain-lint --no-bin-wrappers"
-    GIT_SKIP_TESTS: t7815.12
-    MAKEFLAGS: -j4
-    DEFAULT_TEST_TARGET: prove
-    DEFAULT_UNIT_TEST_TARGET: unit-tests-prove
-    DEVELOPER: 1
-  freebsd_instance:
-    image_family: freebsd-14-3
-    memory: 2G
-  install_script:
-    pkg install -y gettext gmake perl5
-  create_user_script:
-    - pw useradd git
-    - chown -R git:git .
-  build_script:
-    - su git -c gmake
-  test_script:
-    - su git -c 'gmake test unit-tests'

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
ta/delete-cirrus-ci

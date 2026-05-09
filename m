Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604BF3914E2
	for <git@vger.kernel.org>; Sat,  9 May 2026 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778316550; cv=none; b=GKrGNBHXzD5QzrA7WNKHXSWS8ZCcfM7dgf2Jjrw+7/6mhN42XDXo/J5zVOJ/gd45cSnn0QcsVjP05c9OevJn5UZrO2DwoQNtXRDJaW65eHcoLGAiUaTMMyE7gR8qUYPjnGnFpQydSopkjZyGUBqqepQA+BxIFVYE1Hbc3UaQ4zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778316550; c=relaxed/simple;
	bh=OWWaso70dT8a3HYyGu2T1A0GmyxdobMdasvKZ5nLiMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltR5kwxI8JxBC0+c1ctP379xBgEpMBdgnpKO6a3GuoKjUrxHrseSpTe+5+9Bo8IVbFotdvt1oz6QmjSMqsPziRC5QoH5T7RJ9p5PS5Jh0pRiACVcmRiQZ3Up/9usonrYyXa6nm1KMqQ0Fwy/ZomYjzO7vEvZAU7J6bdSjceHIrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPzQGDOG; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPzQGDOG"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-50fb8e9a4edso29760471cf.1
        for <git@vger.kernel.org>; Sat, 09 May 2026 01:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778316547; x=1778921347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWWaso70dT8a3HYyGu2T1A0GmyxdobMdasvKZ5nLiMk=;
        b=jPzQGDOGipOzs3XbX4dCL9Q62ksPJuJeqqDv0e2T4OutjhuECCIGSBlRJBedpTUkh+
         j5esvxeE6fuhLgOU4l4k3XQWiPrt+5BEtqNW8FtxjY93G5BCBrQZk+GgckRpyAlarYZL
         I1itlxfX83qAWtg5sFh+sD97Iyd+aDiCpzSgT+PrIhYAcdyvesnlBiTlX414R+hd+n5Y
         ZxGDA+JKbxX+Y0Rhqt3i7e6Jg50I6JVTAMtyy12EzT/nHZD76VXyHwXFImUNdnhqfkq7
         HsqExcf2NklWtn4ISbJWPmyONRZ2LWOhn9TGqh78ePChr10KRec3A/DOWgi+bb3IIgeM
         YOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778316547; x=1778921347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OWWaso70dT8a3HYyGu2T1A0GmyxdobMdasvKZ5nLiMk=;
        b=JQ60N89J/kcoJATOFT0u+k4ogXnADNmKAxOjVcluXGA0LvMBjdCWVzA0dPjEr3V0eD
         jtsGcmhJ+UTUT63Nu7I9a1uxZpP6ROgAiqU3GUUqpK6x/98Kw8utcgbwZXPDkK1UKU22
         SpGkfHt4Cqpmhi9VIH2GdJKxGyxTBgKLbkudbvKp0YNciGCVLRAiHpyfKE3TqfWFhPqs
         z1N3bhnVs/n5nJhq/Atwdtoly1nohZTRrp0cIGgbLMiA6k/p3nOhggOc0JqGUJujZ05z
         8BHgblVRXiJjblTUhUL+E9aPKvF77j7V/srzArqdsPN4BgoQ1++oidxJxoiiprnyVeui
         N+Kg==
X-Forwarded-Encrypted: i=1; AFNElJ/Q2mW19CpuWTPnnYe/lw3H/F5jiTvKGJjxhJW+0lY5lPVwnN0r+nuWTfBTlMCGLzllA/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkvZQHbRTzDK1egXRHpLLCFeOTUtIXBM9xwsV4hpemK2uKBsDV
	MZndl+r7Z/dYZTVH0wtm0hfVi/eGBgl+Amb5+Hm/f6ozvEzSdsgB8cnP7VsBzHtsV1AqMw==
X-Gm-Gg: Acq92OEb67xpPjP99fR3KXPwGkQuKGG3KMycwPF8nDAn9+Grfsj8gZ9GhOfu5g1MsYi
	aJ4cctwjrRMLnt1VMven4zByhFn1Ko469+YzZv4nDUPat8YWXa+QCEasFNXFPhnIxvDLMx52cZD
	vnANUvNYcD/p+Hzf3JlPkUeZmg7s5S+n1jKZ8X/26afJZN2z0FQPCJ9gR/CsE24uN3JW7WrV/zH
	1ObEyXmHukGrQdPqRn8BHMC8lIOHTDlJGpSKhTVnpSeAW6wHI7tMfpttRpVJXau7DJPxD6zuaYu
	LqZDgZLmW4zRVzJ5Q7H6DzUMmkqCL3xtnx9C08xpg1H6U/PwYEWJoK0cl7vpIIs2uZ3zOWoPQ54
	3ARwqGWtQPjRhiR1tDmpva/Pc3TwkQKeygiD6YOUiA7Ud3Eb15vWrkhq459Gxla4Mh0g/lmw/oK
	ZGBqUebIIkTJVCvd0+xkicUpVwozUnw14QCTeL8B0Z3DxuaF+N
X-Received: by 2002:a05:622a:2593:b0:50f:bc35:aae with SMTP id d75a77b69052e-514621d6f63mr233717371cf.52.1778316546926;
        Sat, 09 May 2026 01:49:06 -0700 (PDT)
Received: from DESKTOP-IB4GOVS ([240e:479:5840:42c:bc3c:d5da:2633:dfef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3a33fab4sm39172916d6.23.2026.05.09.01.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 01:49:06 -0700 (PDT)
From: Aina Boot <bootaina702@gmail.com>
To: Mark Levedahl <mlevedahl@gmail.com>,
	Shroom Moo <egg_mushroomcow@foxmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
Subject: Re: [PATCH v6 3/3] git-gui: handle GIT_DIR and GIT_WORK_TREE early
Date: Sat,  9 May 2026 09:46:56 +0100
Message-ID: <20260509084846.1694-1-bootaina702@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.3
In-Reply-To: <54d3c28a-040e-470c-b061-8d3a1cfe4257@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After observing, I=E2=80=99d like to propose a clearer way to manage=0D
GIT_WORK_TREE and GIT_DIR environment variables.=0D
=0D
Five procedures in total:=0D
1. set_worktree_env =E2=80=93 sets GIT_WORK_TREE in the environment only if=
=0D
$_gitworktree is non-empty.=0D
2. unset_worktree_env =E2=80=93 safely unsets GIT_WORK_TREE (ignores if it=
=E2=80=99s=0D
not set).=0D
3. clear_git_env =E2=80=93 unsets both GIT_DIR and GIT_WORK_TREE before=0D
entering a submodule context.=0D
4. capture_git_env =E2=80=93 captures the current GIT_DIR and GIT_WORK_TREE=
=0D
values for later restoration.=0D
5. restore_git_env =E2=80=93 restores the saved values, setting GIT_WORK_TR=
EE=0D
only if it was previously non-empty.=0D
=0D
These would replace scattered, unguarded set/unset env(GIT_WORK_TREE)=0D
calls and ensure we don=E2=80=99t leave GIT_WORK_TREE defined when there is=
 no=0D
actual worktree. It also makes the intention more explicit and reduces=0D
repetitive error-catching logic.=0D
=0D
Aina=0D

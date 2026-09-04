Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3E950EBED
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540856; cv=pass; b=oYJwA6lmFFEPhv/VJ2OSLABlBc5Flej4qhnbjXmHavoH0PFVTh/vFIp26AxRpvzfOls8pXMp+v9I0WqxbihmtaA2ZuK32HSU6KkacNJqmqUbSlaeaoWiVZNGzGCGgogFiZHk45xelzPS7tzdzWSlrjle4NPGUt4305/oFkRfYR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540856; c=relaxed/simple;
	bh=1eT1cka2XGRe0BOx8acxnLaV2l3UdeIw1Ix4PNNnsZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaQfot7cbpdW0xZaB7Nq7GWGGtszYCXTbvpZMKhmMGjdt9v+PAaPtciQhgcK4WFAC77xreKonvD7JL6yMxTr9NahGilEdx/FAVCgyIGlBzpALixPyAzUbF6/i6jz2KjwTPNZOLaEpYaMdgCBsUgzMbJ66ZH324hbD+hSKjoI/Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=Kzs51VMy; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="Kzs51VMy"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-86c0e4dd49cso16578397b3.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 09:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788540852; cv=none;
        d=google.com; s=arc-20260327;
        b=nVCtkaefrn2MlKGu0NjnpCNVWaw4uZ7tSfQkEGj4wZQElh7O19Ux4Af8pUCW/jz8PE
         t9a3HaACbhjAQAdjNZNIFW9uFfviMBxQGki5jOPYTll90YOuEiSPhfejLENm4PxEa5nN
         GVc2NVYZCP8j4ukQcEXbn1sLg58Vih9KA2OFgkNyM3/5pGdHX+YBQGp4FG5RVrsEuWie
         ysfBHSCSXdbwWAYa//PlU7HzInv4zZxF19DdsJKyRVJh9bz6rZ4f8uopaH+7rpfT/Y4y
         wDyZbNWJicgFHa41dMork8gZtMRFyItYZqSp4uyjMSTA3yHiUG++IBfKeRyKiDm1N6vq
         YvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9BZllBZs/lhIXcZyX6WHVGI46wwyUR7WYkhrwqfkJNI=;
        fh=ppQUgUn1WqyBO62nl350Heo9lP48LLowkFWK5VS+Y1M=;
        b=aYsZK17U15z2FN4MTHFOoqZrt5YC40Npixizv159oSQogyhTjpz/8fvfoDr3IcOIim
         Ab3f0/xSiH35dUsofGXp6rLaZkODNURNZf61fl1ZuA6tYwPRxRblUfMWaPhAPYDlD1Do
         7DjfXr1ETxu/sTFdF3lygrPYY59DmteZNL9pMZrpC4Erzl6mSXjz+QRITIUDq7JfleX8
         CcqNPZb1tD7Xh20s2bsNoLVMEvPl7XxuWjBKErvW5HscAzMmBWsukjeYfuzYB6OxJaWT
         cln9yn57gmVBPdE3BXzndQZ8grcg6LbtTXWs+4h9E9QSnmS5+AIx7WuPhTRx8Sbc0KCc
         8Fug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1788540852; x=1789145652; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9BZllBZs/lhIXcZyX6WHVGI46wwyUR7WYkhrwqfkJNI=;
        b=Kzs51VMyx6LoFNcOo6MvyyCLGOggfD8nWanhCdX3J/+h773w89RMRLMeg7g5WbYMki
         KIctQfrv96t1btTfB9hNBKBrhyP5pfeSa1y2xUVeKgX4U8ipUmb8M8Iyn0AB2WbCnNT8
         yspuFDFC9NDHgxgAc+AUhOD+qM7GPor8EXn5Z6Eg8YSHFPuOZKBOnu/j4eNMXqE6CFnD
         Is7sG8Ij7j7p/opwlBaUcczN49OBFcJrTo2+AAUkaCzcqyoFjDO7hgVKpolJYuZoZVHV
         Lk7TpA+gN2tHRg0NF+96MzQQT062Dq6bGAkL08p/cv1ib7E0Q+ZvDp5wpULWnJvNPASq
         j4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788540852; x=1789145652;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9BZllBZs/lhIXcZyX6WHVGI46wwyUR7WYkhrwqfkJNI=;
        b=VBH0Nga5S6IR8JGEX/VtIznojn1TbFWXLcaUmwNDKr55XXTzu1a3QsgW3nuc/OB8+9
         b4QoGshhE17UFNA+d5RahuSBDEYl5SuGUH/mKcbTqiPm257bPswE0utleNEf2R7kgQAX
         CgR/hgk5v+rmuuaKnhyBxd5LV8i8xfc1fv5cg/Oo/a3SSg3K5cR4323DhBGWXZ8nyGvy
         vtPRAIdM+UiOar8Xq0iKBWwVLm2e0vRnh3dUzvkRCIkV4TBRl4b5zFrsor9ejJEn7R9u
         auLkuBBgPqSRLNOC3KNd9BqKHh0tz1aj8/jUhLha6JD65+5jkbUbv5f1ZphnLMe//nIb
         Sodg==
X-Forwarded-Encrypted: i=1; AKwUvByYUHWZrFAmXm7+asSyjq0BryBBgYF20pPN4yawjRe+qIYmzp8eyvgSWp1dPLBemm0gcz8=@vger.kernel.org
X-Gm-Message-State: AFuF++kl5q75Ups4PQxEFHJhYkxgqHaOKknnpqD8IyGGeSZKMtidwRo7
	YYiDQwzKc6jBoFWqmyhMI/svm/NwA90FUQ+mscF06AZVcVWsGesiOyVt3tZDhhC1aJRuUv/dkxU
	5NmikSkNHYra8wJ6Io7HvqSnpWMZPpHjIsPOi0pQzq3BiGTToo/PCBozt8cJCEp4=
X-Gm-Gg: AYBFou39LkQ+bzuepzuljve3kUQ8hu3eAujYqFWqqrPf4Nm7nfl1Pvk/aFJaMbJltxg
	z/pg5JqjSHpaQMtkf3Q8OLSmwKjMvdp564v8KbxwJPo031eg3FMWpOUL8GlQ8lboT/V4iVbRHHT
	51riE05OXNcWlzETrZtYx9BsvTcUiq2bMPJ/HkDy4PywPAU9jcsx94MLtQ5QR1kNMXZFqDeSaHG
	UvrXcrMty8rxdEyLp1lsWOa84CWSDcVjaG88tQdCsz/4wEOHBkglmkyEzrgM213CZaImrOWq62a
	iHcCXiNbIbQR6qb6zGRUTQ2OIQjvQ6bTOVbynLbNjMaD2SFGMTk+yqwVPSUMiq862UU3zimzUJG
	FSQ8=
X-Received: by 2002:a05:690c:e3c2:b0:873:5c7b:c0f0 with SMTP id
 00721157ae682-8735c7bc1e3mr10280647b3.40.1788540852098; Fri, 04 Sep 2026
 09:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im>
 <20260904-b4-pks-maintenance-rerere-gc-heuristic-v2-0-b1691121fe1c@pks.im>
 <xmqqfqzp6pir.fsf@gitster.g> <xmqqld9h56yt.fsf@gitster.g>
In-Reply-To: <xmqqld9h56yt.fsf@gitster.g>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Fri, 4 Sep 2026 18:53:59 +0200
X-Gm-Features: AcwNN1U_HkRyxef6KdvLFa6I19g1o4zoXORm7N2LOWTP05grDQjscMTA7Du04xE
Message-ID: <CAA0xjtrL8DJp61jp7s0L6L+RviwQz=-PEo7qZvCTh+8nT2cdfw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] builtin/maintenance: improve heuristic for "rerere gc"
To: gitster@pobox.com
Cc: ps@pks.im, git@vger.kernel.org, stolee@gmail.com, 
	phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

On 04/09/2026 18:14, Junio C Hamano wrote:
> So the two-patch series is not about what happens when two "rerere
> gc" trigger in quick successions, and even with the "improve"d
> heuristic, the second "rerere gc" would fail the same way when when
> another one is already running?

Right, Patrick's series only makes the gc run less often. The lock
itself is the subject of

  [PATCH v3] rerere: keep a background gc from killing a rebase
  <pull.2214.v3.git.1788537081930.gitgitgadget@gmail.com>

where setup_rerere() waits rerere.lockTimeout for it and then goes on
without rerere, and a gc that finds it held gives up at once.

Thomas

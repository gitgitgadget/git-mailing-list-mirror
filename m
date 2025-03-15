Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BDE2054FD
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742062886; cv=none; b=bzbypEON99h2/RwnDQD6PIN9ZuCWonL3No0TcV49cc+CaxONcnms9XRsUPd4CFFKEVcf+7kAnnB52VwZ+OKLpC7lFu+dxXtX5NG+VmHr7OagNCU7VdnkyowBzDrHCSBeO8v36UQRkXklY3/mrDgaRctMp7SeWyCtYaT4e0/l1V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742062886; c=relaxed/simple;
	bh=O/EZyV/G4OtP5Xj0p58ZJhlH6WtM4BGK45ldjoFrX9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpMw/VEbrGhghzzgUWL+/oJfX8Jass8/vQwHvrBUejCdzqK6gFlCCwiDgdOKcEyP3THo8pzQitwTfPYUoMoyokOdcyKjcmklrbZG+awraSW430oIuvlpqO9XSm149JDXcZ8EbxQgkHjtNF35vuIyxarbf1/oicuhy2k5FgH6qXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WA6PpgDY; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA6PpgDY"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-476b4c9faa2so38873331cf.3
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 11:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742062884; x=1742667684; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O/EZyV/G4OtP5Xj0p58ZJhlH6WtM4BGK45ldjoFrX9Q=;
        b=WA6PpgDYMGDLbp39Rgu2ivm74sy1lGH/G1QjSx7yuADJVmBIWU1+vWL05b6+LCFByK
         YmU1kgTDsUu8joUnfPrMqDHJYzlamihckfopVhRJqulrB7RNq1n/0o33w/ip5xFWJOVo
         s1W0bHx2jXwOq62oMku9XKEXBHf52SYmIvA1YlB+/Qyzvq5btBLiw/mu6Xn7zC4SwsuZ
         jIQSJ+IoKBpovT2U6Ezue2Edl96iLJtK1L2NCe/yajvZt/GR1RAUqlQUmwnm7kMYHLrN
         OlCZnya7z8WAyVp7xGcxXdfc+TJW+XWQ9oZo8piIjX4/dScUCLgH3gkSHp96U64TsZC1
         C2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742062884; x=1742667684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/EZyV/G4OtP5Xj0p58ZJhlH6WtM4BGK45ldjoFrX9Q=;
        b=M1b/MYVdhAEicaGNPrHKqcndPeeM+ulR3BBCGOItUY2rsO3cJjlbWHvsGASSy+AdPN
         9fgTF5os4iwS4ItIslekiKjECdjsFq/QXG7kelipi14eLHxVl2sa3MP/UUcLTSneLNBr
         RbvEEFrKOpvloQaR3kspoYmDSUbMLn3isB2PKkCrewspyOYntTpo/Xf5fcrJIFNKDK+3
         zzL9xOqVuKKbvoJtFZ7mvaOrA/sI8s15Wo/e1vOquvnW56mLaHpcYAVBHK/sHApnkdYM
         ZPvKjNiMQ4YyzXemGaJfRFMujO3TNlK5gOvwZjCUHnFEDndgnLJmJVPihQ07h9xMACWq
         p54g==
X-Gm-Message-State: AOJu0YzD1yeNuLrSPbkV1ewUvjY8/XDKmw0qNe+jqHtL2xbkcf3RMUxj
	lHoIb0LeVDOYJUmAfUPPXpoL0aObhmIXKGIUm+TUmgkq7aPBv24o8WZOdqiBvtWFshIjXqGVSU0
	ViY8LdMS0Qtt1isGAoZWIHUjfbN5AzkXM19Q=
X-Gm-Gg: ASbGnctK61D7BqR1XKaViryCZK2Ka046sOG2rcxz5ltiMkH4kB6AQlJ5PBo+xH70dWd
	k+6LIeKOhhcLgGpgnZ3kVNn/y4bgYeT/xSXZiZShjAXuYMHwy7eayPsmWfqLgM1mAtCZQ8EWBk8
	/1pwQFBB+n7JptHqa8BME8c2VOoqBdvVl1U+Wypr5Em86/UH0UgkS9nwBwY7I=
X-Google-Smtp-Source: AGHT+IHTy9xS1x7uz3qe/lMSjglYMnoAZzR2AiDxJ5op8XlHenwB0dxb2Z5kd2/JQBwVUxhsPdMi4kftd/iRb0imiqk=
X-Received: by 2002:ac8:58c6:0:b0:476:959b:7592 with SMTP id
 d75a77b69052e-476c813e44dmr99358381cf.17.1742062884014; Sat, 15 Mar 2025
 11:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315181504.65069-1-jayatheerthkulkarni2005@gmail.com> <20250315181504.65069-3-jayatheerthkulkarni2005@gmail.com>
In-Reply-To: <20250315181504.65069-3-jayatheerthkulkarni2005@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sat, 15 Mar 2025 23:51:13 +0530
X-Gm-Features: AQ5f1JqBCXWLsk1jci0vzmb3wF2Qd3zU3I1A2LxDlFPsj9iTlGYTunVBDjNBmRQ
Message-ID: <CA+rGoLemaWouUHnUWxjPwwRzr-x9mOdbYK8cUcjyZY_pj+vHGQ@mail.gmail.com>
Subject: Re: [GSOC][PATCH 3/3] Replace git_config(...) with repo_config(...)
 for modern Git compatibility
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"

I've sent a pull request completing all the checks [1]

This has no conflict,
as asked [2] I've divided these into three patches for ease of understanding
and I'm expecting feedback.


1.https://github.com/git/git/pull/1917
2.https://public-inbox.org/git/CA+rGoLfrJ-+QVb5=zc=j84sM=MTz3nt8NMYgXVZdfYf70AuDZA@mail.gmail.com/T/#t

Thank you,
Jay

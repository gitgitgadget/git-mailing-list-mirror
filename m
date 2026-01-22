Received: from outgoing.selfhost.de (mordac.selfhost.de [82.98.82.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E547B3559D5
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.98.82.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075076; cv=none; b=iWZiCyQb+OiPEztR/uc1ODIMdmFq5XfZTGj14e2O0yX3M/Yaw5d3uRcBu9rNJph/dJiXIQmbSsNQuDkfZOA06FMLyZ1jFV0vu3OyQVN8mU4808/cvJC2b25SzjdM0Mnt2DHXa29jf0KmTBJgi/oGaNKKekjZImqdz1KgirTimEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075076; c=relaxed/simple;
	bh=2TQ8km0jMo9rMFjMWoZ5T/S2qdZOhp9UBYWi4rzTLOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r1wuyG0T1SpzJQ2WnSZfY8dygrCAw+f8sfNJOeAKRXQnccBdQudIeqitce5BOYglzVtIk14EyBtvwQKBA55GI4ZSbdg5p/D+VF8bu5Bfp5gY2ZjUl56jqIYjO9sbogDcjv8Qdc8D0YrVzRnVt/drUXY3QYgvCXeOBdsXVtbLp1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de; spf=none smtp.mailfrom=afaics.de; arc=none smtp.client-ip=82.98.82.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=afaics.de
Received: (qmail 29813 invoked from network); 22 Jan 2026 09:37:49 -0000
Received: from unknown (HELO mailhost.afaics.de) (postmaster@xqrsonfo.mail.selfhost.de@62.158.100.94)
  by mailout.selfhost.de with ESMTPA; 22 Jan 2026 09:37:49 -0000
Received: from afaics.de (p200300e31f38630288658ffffeb7694d.dip0.t-ipconnect.de [2003:e3:1f38:6302:8865:8fff:feb7:694d])
	by marvin.afaics.de (OpenSMTPD) with ESMTPS id 50d09228 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Jan 2026 10:37:49 +0100 (CET)
Received: from localhost (afaics.de [local])
	by afaics.de (OpenSMTPD) with ESMTPA id 36e68f13;
	Thu, 22 Jan 2026 09:37:49 +0000 (UTC)
From: Harald Dunkel <harri@afaics.de>
To: git@vger.kernel.org
Cc: 
Subject: make "git --pager/--nopager" work as intended
Date: Thu, 22 Jan 2026 10:37:49 +0100
Message-ID: <87o6mm2djm.fsf@tweety.afaics.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi folks,

maybe its neurological, but the current behavior of "git -p" vs "git -P"
makes me feel uneasy. Some commands (like git diff) use a pager by default,
some ues it even without need (git branch), others don't. For every other
git command I run I have the feeling git output is not working as intended.

Setting core.pager to "cat" is not a solution. It breaks git -p.

Regards
Harri

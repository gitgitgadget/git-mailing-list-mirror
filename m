Received: from ra.horus-it.com (ra.horus-it.com [65.108.3.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD6C12EBF1
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.3.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825191; cv=none; b=C6dxeMsDSzDqQJJ22QkI49bnAaraq5In4rHWISLP8ggnkDfQ7bZ5nPervJ+aFVgO4vCEtwzO5UfHiZj53eywX2zRgWFd2RUHv17YkkpLvtORXGWHR6AQXDRWSbR23MhHaS7FYljkex1uOFmPkaM+BzIHio7clq0CCzDT5D0P6s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825191; c=relaxed/simple;
	bh=uR7YB6TnWtjgRIsZ4582pTCbvuWPBp1cIA+7sMpmbEg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OdLsWXtpUpg2q8pbGzbi6gU02EIrwHlB9ANwFpF354E20Pzp9m+0qCInEdxuea69mhKqU7Wq1u6sCrGnNfejlll8UT9Zt6Ep+d6zzeYxIn5iNmE5V8to3JpU+wXMWUqI6yrvAa1X9TJT/ZsDLtD/oOVkGlXdPR/x/5sZqGusicM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de; spf=pass smtp.mailfrom=seichter.de; dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b=A2TTf+kU; arc=none smtp.client-ip=65.108.3.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seichter.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b="A2TTf+kU"
Received: from localhost (localhost [127.0.0.1])
	by ra.horus-it.com (Postfix) with ESMTP id 55BE7BE0031;
	Thu,  7 Mar 2024 16:26:25 +0100 (CET)
X-Virus-Scanned: at horus-it.com
Received: from ra (ra.horus-it.com [IPv6:2a01:4f9:6a:528d::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	by ra.horus-it.com (Postfix) with ESMTPS id 330DFBE002F;
	Thu,  7 Mar 2024 16:26:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seichter.de; s=k23;
	t=1709825185; bh=uR7YB6TnWtjgRIsZ4582pTCbvuWPBp1cIA+7sMpmbEg=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type;
	b=A2TTf+kUV94+/MQvUHcBDcoT9Z8vVQZBAqQLGKLSBUOf06NH7XEOsEorspuqYySaR
	 Z8FjxSGeZuJDyqZGfWyf+agGsfKPVnATScq7cs5zVgjUyv1Oe9q1BSfiT9NbdK6VtI
	 xtRyW7f+6tI4nsaXXMBREMBv8Vb6T5n/dklfcQemUkcsVixvEsN285u5v4o3Q04c2k
	 1/OZ8oeQlPkn+62EwPnf0nV/StXtDj256nhq7G0DPBStThDnaypLyOh34PzGgqE/dx
	 a5ByEBZIDvK7zvoXERNPI+N1F9ruVzCLBvT9X0dT5k7YzVXEIXPOxDmw55Rr/8vYat
	 eZR7oBJIpr8dA==
From: Ralph Seichter <github@seichter.de>
To: rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>, 'Ralph
 Seichter' <github@seichter.de>
Cc: gitgitgadget@gmail.com, git@vger.kernel.org
Subject: RE: [PATCH] Allow git-config to append a comment
In-Reply-To: <098101da7096$cd773d40$6865b7c0$@nexbridge.com>
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <xmqqttljtkn4.fsf@gitster.g>
 <2560952c-4495-4a71-9497-aa40032e1d2b@seichter.de>
 <xmqqplw6nsuz.fsf@gitster.g>
 <098101da7096$cd773d40$6865b7c0$@nexbridge.com>
Date: Thu, 07 Mar 2024 16:26:25 +0100
Message-ID: <87h6higj1a.fsf@ra.horus-it.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

* rsbecker@nexbridge.com:

> While comments are permitted in .gitconfig files, I am not 100% sure
> that all stakeholders, particularly those who parse .gitconfig files
> in their own scripts outside of git - sure, it is their own
> responsibility, but this might be unexpected.

Comments are nothing new, and humans have added far crazier comments to
their Git config in the past. The patch ensures that a '#' precedes the
comments added using git-config, which is not guaranteed to happen when
Joe Random User manually edits config files.

I think that anybody incapable of reliably dealing with comments in
config files would already have fallen flat on his/her nose, regardless
of how those comments were made.

> I worry that this might unintentionally introduce incompatibilities
> into repository configurations.

Do you have an example?

-Ralph

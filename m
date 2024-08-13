Received: from cat-hlzsim-prod-mail1.catalyst.net.nz (cat-hlzsim-prod-mail1.catalyst.net.nz [103.250.242.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D6376F5
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 03:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.250.242.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723605515; cv=none; b=BBgGbgL8ZstCrJOzHtU6sbZ6ZDfGAjYFYCMbySWjvnXhfBTFCgLWdd7sm+PlR3RHOslya/kfDbSDeWFCSIZdR5ZjkdVS4aWLdeC3G5j4NkAqE54NDJ2peGIAVmBcPTVDp5VYSTrHwirPMoF8SCIs9KCu3JWYa5teVMErAD5qSdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723605515; c=relaxed/simple;
	bh=EqEvwsAtuiG3R88/O7ALQzqbB6BQOlOllO2+B/EQmZ8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=IteKZZAxPx4cdcYZK4LKNVDF/8yEwHryFqLtdLH9Hgm1Xh4gXAXyPKiCEB4B0+UWLVO8bIsu8qm2hkmSaKb7teiy+AhklQxZLmAc1y/IIQ5ngeSabY9ZSLG6RcxMM/J+IupfoAn5mrK4KH2MGOcqoibZX7YV2lOrgieDYB1c65E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=catalyst.net.nz; spf=pass smtp.mailfrom=catalyst.net.nz; dkim=pass (2048-bit key) header.d=catalyst.net.nz header.i=@catalyst.net.nz header.b=E1/6LFi4; arc=none smtp.client-ip=103.250.242.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=catalyst.net.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catalyst.net.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=catalyst.net.nz header.i=@catalyst.net.nz header.b="E1/6LFi4"
Received: from phil-lp (unknown [115.69.188.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: phil@catalyst.net.nz)
	by cat-hlzsim-prod-mail1.catalyst.net.nz (Postfix) with ESMTPSA id 312FF3FFCF;
	Wed, 14 Aug 2024 15:18:20 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=catalyst.net.nz;
	s=default; t=1723605502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/E/ibaDavml25DurYoWdDAM1cxvl2hwQQnsTLCuPAk4=;
	b=E1/6LFi4wG84tnRIjYvejWmfoWDQWg3QpdfGHCTsQWoYIiQQOKRjVCSvUpcU3s0cKQZrIR
	JZZMSqYOvBOvEZ+zr45Bfq+kEXc+NwCyBlb1S6+QOOoDdJOXPW9iivnHh5HhfLoFCcwB+9
	cmxtZboVfyZLwik8ms5Gg/N8JvOD+ovd4ezo6hXB5L8XSy+CBtbZyAcZISr1juk+nQZaEN
	u9edG2kf48rqNcbEBbJt+eG5j6rqNGzBX7X9fRpP6TqfFPWIG56PUymljZx9I/weYjV+Kj
	15vrwz7HZtwgg/OedoeVDWyCjkOO0Hch/jESVL+5gGI2UulHNuUS0/zJbLUGfQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=phil@catalyst.net.nz smtp.mailfrom=phil@catalyst.net.nz
References: <s5wr0azfeh9.fsf@catalyst.net.nz> <xmqqed6zht04.fsf@gitster.g>
 <8436c2bf-45cf-8009-14cd-c5ca708ece08@gmx.de> <xmqqle105oko.fsf@gitster.g>
User-agent: mu4e 1.6.10; emacs 29.4
From: Phil Sainty <phil@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, pclouds@gmail.com,
 git@vger.kernel.org, hvoigt@hvoigt.net, me@ikke.info, rafa.almas@gmail.com
Subject: Re: Adding nested repository with slash adds files instead of gitlink
Date: Wed, 14 Aug 2024 11:13:25 +1200
In-reply-to: <xmqqle105oko.fsf@gitster.g>
Message-ID: <s5wed6rg5c6.fsf@catalyst.net.nz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.10 / 15.00];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:55850, ipnet:115.69.160.0/19, country:NZ];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,gmail.com,vger.kernel.org,hvoigt.net,ikke.info];
	DKIM_SIGNED(0.00)[catalyst.net.nz:s=default];
	MIME_TRACE(0.00)[0:+]

Junio C Hamano <gitster@pobox.com> writes:
> Let me make sure I understand the above.  You create a commit to
> contain the change in the submodule and at the same time create a
> new commit to bind the updated submodule commit to superproject tree.

I can imagine this ability also being useful, but it would be an
independent feature from the one initially requested here...


> But I did not get the impression that it is what the original poster
> wants.  My reading of the original thread (this is a resurrection of
> an antient thread dating back to 2018) was that you have a submodule
> at path S, you muck with a file in S/file, and you want to commit in
> the context of the superproject, having the superproject track S/file
> in its history (not just S gitlink).

That's correct.

My common usage was that I would add the entire contents of S, along
with some associated configuration outside of S, and then make a commit
of all of that in the superproject.

The two repos (superproject and submodule S) are then tracking the files
in S independently; so if I was to pull new changes to the submodule
from its own upstream, git commands run from the S directory would not
show any changes vs the state of the submodule repo, whereas commands
run from the superproject would see new changes.

Cloning the superproject repo would produce its version of S, and
without the S/.git directory.


-Phil

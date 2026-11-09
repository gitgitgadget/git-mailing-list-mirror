Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241330;
	b=U1E76lg6OajzZGlmEjyUxgODFtA9ILRxrOO/cQ3H5Ll5OPQvcbe6+AIQho8XJlRmosWl
	 Kw66ZgnVhieHv+aFLNZ14WcgqFeK1M4XM5CWMRtDbUCr/jRBJLywkcixQokH+kLa/wWwx
	 WYAdk51M73BI5wZ34Veg4SPrO4yEq+Kr5htMMWiYJmxoqksSJI6LTfdHmtLd1dExcLxKf
	 2OCDySiZgAal9quhvjesOYFlbVVg6W+M59z5TMM0UUGcK+KDGZC1qsX3K5tmC517YrQNn
	 e6OgedV1HiOZZqDtFt1Z7ncpZkePtiPVimC+8w4rHS57D7hx6E0Z6mMz5/vlgURxsVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241330;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=uWP9RxbBdbJHdQEdy0o5WMRefqtYaOR71Nq708xw7Kk=;
	b=Y/AMBlFDD2jiRFzFrwcZW5cPnQvuwK5EAmwj5ezlwsCL2aC1gyp6/NcgDL4mN0pxzbWj
	 CCW/1FEudYIZRjNOtys5WwY6y/y57D/AmK//wL2ltmIwH+TWv9kmaRw48vb1ndFW6jIEg
	 b/9ykykb1JCwAeBE4ynuzV0xmQ8yYHGLhfmfb62DxjeiumxWIL0LDhFh7NHGFOG8E6Vrg
	 SOTVPWwu4DJCr+p98d3v3Jm7GmmDJm+eznJTtjmGA4wMIVCsalOVhWEm6Q6Fga1WZKYSC
	 kTCPcQZxWoyXnxkCYyGUTVHLGfNvNjDdHLxSEEgZsyHq2O2gacEHMcBdRn7TukY4gew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=rOdnfB9w;
	arc=none smtp.remote-ip=91.218.175.37
Received: from mta0.migadu.com (out-37.mta0.migadu.com [91.218.175.37])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5506B606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 16:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5506B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=rOdnfB9w
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vtio5B9N+vh2Z6n+mGDj94J8hjpzVAGHorE2RLEQVGM=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794241327; v=1; x=1794846127;
 b=rOdnfB9wPx/p/ACmWpznL26Om2LwpGRFaMnPjjU6qBDNbruDw01pRAPnlu3MgTMkmO1XrCuP
 s1sZjD+HkUrTHS5OdhiOc+3pMGGdHG88Gk7lL39yI7GLH+J3x6VzFB9YNUV8ZMTlY4AGDySdahe
 MZR6AudTLoXFGH4tNaHGKwR8=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id effe9407172c1073;
	Mon, 09 Nov 2026 16:22:07 +0000
X-Mizu-Trace-ID: effe9407172c1073
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Root <rootminus0x1@gmail.com>
Subject: Re: [PATCH 1/3] builtin/grep: read submodule trees via their
 repository
In-Reply-To: <aunAR67MHppLt--N@pks.im>
References: <20261030-pks-grep-recurse-submodule-v1-0-d4eb5c87d8fb@pks.im>
 <20261030-pks-grep-recurse-submodule-v1-1-d4eb5c87d8fb@pks.im>
 <87fqxnyx3s.fsf@dev.null.iotcl.com.invalid> <aunAR67MHppLt--N@pks.im>
Date: Mon, 09 Nov 2026 17:22:01 +0100
Message-ID: <87tslqx9ee.fsf@dev.null.iotcl.com.invalid>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> Small nit, shall we use test_when_finished here?
>
> Normally I would, but in this case it would have felt weird to have "rm
> -rf sub super && test_when_finished "rm -rf sub super". We have to
> delete the old repos because they exist already, so arguably the correct
> location to add the `test_when_finished` would have been that preceding
> test. But I'd propose that this can be done at a later time?

Sure.

-- 
Laters,
Toon

Received: from sneak2.sneakemail.com (sneak2.sneakemail.com [64.46.159.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B1C7F7CA
	for <git@vger.kernel.org>; Fri, 31 May 2024 22:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.46.159.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717195284; cv=none; b=pPhiNFBX4qOXuc8CXEAa3oeO8c8nhx73N7fp2JGCoK6qdEuhme+denlAjxvbkPhzjOCfZ6f/U7ouSf65LuE8PzE72HbDjYZPTv/yeXDJsSn7G74dlD9KC06b362XHh0JeuJ7Y8c2PgfybeEa6ttn5EhZOGqLiNdSSzcY7Ci7aU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717195284; c=relaxed/simple;
	bh=V3A3TNMKQZWah42TH3d8BvQUf3YzmVlOE7NHi/lae/c=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=WO8pvJ90cMd/9/G+bXD4GQWev52mrpJm64rMlQ0xyGLy1xYYIACmEj+ms3PdYrQzlqXCUPXxpq27m07TJLAkLRKNrn0yY4cUzT/i/GkRIRyc1kg4niZveecw5mPBlfHQ7Ql0LUA0BOAMPJ+4CjlyXTNiBU3t+BPgmZTW+mB4c+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=liamekaens.com; spf=pass smtp.mailfrom=liamekaens.com; dkim=pass (2048-bit key) header.d=liamekaens.com header.i=@liamekaens.com header.b=IeYG2dgN; arc=none smtp.client-ip=64.46.159.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=liamekaens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=liamekaens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=liamekaens.com header.i=@liamekaens.com header.b="IeYG2dgN"
Received: (sneakemail censored 16919-1717194882-875013 #2); 31 May 2024
 22:34:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=liamekaens.com;
	s=mail; t=1717194883;
	bh=V3A3TNMKQZWah42TH3d8BvQUf3YzmVlOE7NHi/lae/c=;
	h=Date:From:To:Subject:From;
	b=IeYG2dgNZ0GHTS7HxeSckxXpuF2vFmB20QUL0h+kJwKXOBTOQqo+wZ5qbxumnpzbm
	 R4xNNQWmNyepoQC1attuqXup1TIf6SMRFR9TY0QmV48VvcDnZrn+xWQBPNqCvtzwol
	 bCkbvfWXKntkV+ESbR0WkvRJDS7Q1t8PrAp1qy6+8k/kluQsMbObRZQfcsyImQGOSr
	 11m0E7G0Q79lOLtzB3fom8GloE4BoJaLXztzRbY6jEY0/E4ogLhHcAc5PzDuk4WVAO
	 dxNFGU98+g59Y8Syh2J/UXQfjfxtNpDz8p6QzpxVPq8w6IJWuShnUR5CB+qFcetsxi
	 AuDVtCSu+rBtw==
Received: (sneakemail censored 16919-1717194882-875013 #1); 31 May 2024
 22:34:43 -0000
Date: Fri, 31 May 2024 22:34:42 +0000
From: "Curley Joe" <m48cv7wg9w@liamekaens.com>
To: git@vger.kernel.org
Message-ID: <16919-1717194882-875013@sneakemail.com>
Subject: git fetch --prune fails with "fatal: bad object"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: Perl5 Mail::Internet v

git fetch --prune fails with "fatal: bad object" for refs that have an invalid sha1 pointer. It would be nice if "git fetch --prune" could prune these refs, because it is a hassle to do it manually. ("git fetch --prune" only shows the first invalid ref, and you have to run "git fsck" and parse it to find the rest.) If it seems like adding this functionality to --prune is a bad idea, then how about adding an option like "--prune-invalid" ?

Thanks.

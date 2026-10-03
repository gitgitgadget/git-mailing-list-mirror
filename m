Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC8385D72
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 20:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791061005; cv=none; b=pGUTnUjxbRYvE4LNpMV3WjHL8pE+LiYr9HPkuyQt2VSys8WVx+YdwAftYXRIecibwUKv4T/IpGnOGIeoBtJXkFq9n3Nj6skfv3oIgxZpU/bc4kDPyMkJfw5GbrZGqD92MkMpCsk0o8i+smk9iVYG57QSm28ZMXdQUIgZj9HWQN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791061005; c=relaxed/simple;
	bh=Bv0JUzjIMRH0VpPxTnz/egkq5FjI5TYdMjQxllpp35Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOyhAkbax43DptVnh0WkUOVXh2Tm0/W45Nz/3QSZJ5FzmjlUy+Gx6dCNq1WXSsTWaBPgmDQvR3uxpp8N/03H8mFX+VvPttqBPjj8E0xrqFN3UZjkdaO6JPGSXBJY8kuV0h/MogOfNWCI787zk+7GCK7mYQgbhmhHMK6tqmDf1iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=XKEjOAOy; arc=none smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="XKEjOAOy"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B6A524C13E7;
	Sat, 03 Oct 2026 19:37:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.96.5.122])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4E1C34C1478;
	Sat, 03 Oct 2026 19:37:11 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Broad-Wiry: 72115c8f32bcb82e_1791056231553_2192387501
X-MC-Loop-Signature: 1791056231553:1883903443
X-MC-Ingress-Time: 1791056231553
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.5.122 (trex/8.0.2);
	Sat, 03 Oct 2026 19:37:11 +0000
Received: from ubby (unknown [24.28.102.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4hxws25D47z1049;
	Sat,  3 Oct 2026 12:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1791056231;
	bh=TRqeIKz9cJ5TYkuVg5QHzQb9f+1d8uiGvl+ouLlbGyg=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=XKEjOAOyjVdHD422zZxybPcS0sfvNztWsIcFZcsgX4Lb7gQjANSLxcfsPhgVz26Vl
	 ayK8sTUQ8QFOgewpR7aYBaoA6D+TBKOZOF4CBjBU70tKu8cBVCxhsjikOwEs8SkeiH
	 /bPsxmMc+GlNSsCK7Ac5/G9VoiA6ug1lSlAetHf9MY4sxbnkxk7RG/R1ByssXhc5AF
	 SW7KEFfRZ6v/n02NcSFBh79SIK0/eLQjf9IRurC18QWaIpDkcn3gHyOYEbnzg8yPqG
	 EuwePxnXmUqiDXpy0SMdkbjrRavHancvrnInk2n0GeZ0cCGuESa+y6AwWyB5q9jeSn
	 +3oPCfcazJ7ZA==
Date: Sat, 3 Oct 2026 14:37:08 -0500
From: Nico Williams <nico@cryptonector.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: git-rebase-walk
Message-ID: <asFZZGzXgGtQ4A6X@ubby>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar5eereSq91xldo-@pks.im>
 <ar5-7ZtM6C23H-8m@debian>
 <ar9TTB5nmPPAdABE@pks.im>
 <ar9ZRrVyr1-Fk2LZ@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar9ZRrVyr1-Fk2LZ@debian>

On Fri, Oct 02, 2026 at 09:19:56AM +0200, Alejandro Colomar wrote:
> For a git-rebase(1) option, I guess it would have to be named something
> like --first-conflict.  --first conflict because it doesn't really
> rebase on the target commit, but rather on the first commit of that
> branch which causes conflict.

I really like this.  Or `git rebase --onto-first-conflict`.

Nico
-- 

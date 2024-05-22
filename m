Received: from smtp.biuro.ib.pl (biuro.ib.pl [185.38.250.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983AB3D54B
	for <git@vger.kernel.org>; Wed, 22 May 2024 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.38.250.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390178; cv=none; b=PDoy6i5+2S4e3+QpbTy5sF0Rue0zfUIy+PwKF5fKWt90nD9+ZQjMEhoNr63cJldKdcH8KCSHAl/hubwWUiCKmFtijhzkZpNpxeCwuiGEHRcnzMi+uOn2QJoHNQFA2u94qT9WK13E2xLefI5lvP6QAOxQJOXzTGyszZnl7VuKjCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390178; c=relaxed/simple;
	bh=mhtMi7BnHxy9Te7GU63xovUWyAFDR239ujRZFK0J69k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=ZDkBTHHLrvApy841JKFCbViv4bBp4DSd0IPWw/0ADYBHGXD+QamtfBZkMmnyoWCUsw6h60CkvSUuDAiU5s4z2DgZI3VLFTnMDEQtqU+CL8L9Wh79/w2emqeYmySj03SVYa75L0gQcLs6XdorDcIa8Y5af2gfeyWCrWXyCzfyWig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ib.pl; spf=pass smtp.mailfrom=ib.pl; dkim=permerror (0-bit key) header.d=ib.pl header.i=@ib.pl header.b=IJYp7jRy; dkim=pass (2048-bit key) header.d=ib.pl header.i=@ib.pl header.b=dXm5RCYl; arc=none smtp.client-ip=185.38.250.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ib.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ib.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=ib.pl header.i=@ib.pl header.b="IJYp7jRy";
	dkim=pass (2048-bit key) header.d=ib.pl header.i=@ib.pl header.b="dXm5RCYl"
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed; d=ib.pl;
	s=20200714201541; h=Content-Transfer-Encoding:Content-Type:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+8p6ovZnIw5riucMVO1xjbZrS0YR40evKh5f22yzpgM=; b=IJYp7jRylfLJ06feHbkbjs+QCq
	di+xQDRBaIYkJoXo9H1PTI6S/ertelR22bqYOJpJkRkWexdWCBn8rDbau7Cw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ib.pl;
	s=20200714201541bc; h=Content-Transfer-Encoding:Content-Type:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+8p6ovZnIw5riucMVO1xjbZrS0YR40evKh5f22yzpgM=; b=dXm5RCYlwZcYWIMauy/O1Y962H
	OXqjLopFDmtlOMHBSiGvgkoxyPbXRi/6z/YIQR2xlxJSUFtRLpGg6qIqiRUPQsb0RX8MzbFpve3eC
	Kp3UI+tG+n0rin9G28eqfJZ8Nkj4tKL4DeB+GQutrzhfHNWm3l5tWTssBFEdusV7sDbhPRAow+3Gc
	+sKpnS5a1QSTKFhRuosVJTO/PojcLuwNIH8WXRlPYVRJuRf3o3pNDUOmo1JVDv0KqrR/paQRAxxXR
	/S9JZrU40Ixm/WgVyB2kjqU9N/FyucjLXguDtzEk+neLBAbyEfx/jH8aEGWaR6fFTVY5qcQFjDAT2
	RNro9rnw==;
Message-ID: <ed79092c-c37d-4e4c-aae9-af68cd8c20a0@ib.pl>
Date: Wed, 22 May 2024 17:02:51 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Pawe=C5=82_Bogus=C5=82awski?= <pawel.boguslawski@ib.pl>
Subject: Cloning does not work on available download bandwidth changes
To: git@vger.kernel.org
Content-Language: pl-PL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Started to clone big git repo on not-too-fast, _stable_ VDSL link (up to 
20mbps down)...

     $ git clone https://github.com/googleapis/google-api-go-client
     Cloning into 'google-api-go-client'...
     remote: Enumerating objects: 644446, done.
     remote: Counting objects: 100% (6922/6922), done.
     remote: Compressing objects: 100% (2904/2904), done.
     Receiving objects:   0% (3859/644446), 20.82 MiB | 1.01 MiB/s

...and then started to watch a VOD movie on same link; when VOD buffers 
data, eats almost all available down bandwidth and leaves only about 100 
kB/s for git...

     Receiving objects:   1% (7111/644446), 44.49 MiB | 130.00 KiB/s

...and when VOD stops buffering and whole bandwith is available for git 
again, git transfer starts to grow...

     Receiving objects:   1% (7660/644446), 50.56 MiB | 575.00 KiB/s

...but finally git throws an error

     error: 181 bytes of body are still expected5 MiB | 1015.00 KiB/s
     fetch-pack: unexpected disconnect while reading sideband packet
     fatal: early EOF
     fatal: index-pack failed

or sometimes:

     error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly: 
CANCEL (err 8)
     error: 6109 bytes of body are still expected
     fetch-pack: unexpected disconnect while reading sideband packet
     fatal: early EOF
     fatal: fetch-pack: invalid index-pack output

No such problems when downloading bigger file (i.e. linux kernel source) 
with wget or curl instead of git clone (wget/curl transfer drops to 
about 100 kB/s when VOD buffers and increases to full speed when VOD is 
not transferring and transfer finishes successfully).

Sounds like a bug in git; should not throw an error on available 
download bandwidth changes as wget and curl do and should not require 
any params tuning (to stop users flooding bugtrackers).

git versions tested:

     // Debian 11, amd64
     $ dpkg -s git | grep Version
     Version: 1:2.30.2-1+deb11u2

     // Debian 12, amd64
     $ dpkg -s git | grep Version
     Version: 1:2.39.2-1.1

Similar reports:

https://lore.kernel.org/git/71f2b28b-3e27-4773-8408-2f4c13757b73@gmail.com/
https://lore.kernel.org/git/0d741b90-8307-40cf-b0b3-163203651a57@gmail.com/



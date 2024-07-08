Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55898BA46
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720417927; cv=none; b=gCXEQmuLKFa4FKGjv0SXj2RpNJH2pSDm9cWp4JoIF18F5+2qSjQ/4MQWkB7SPQZRQraVD9me2R3O841uIXa9tDzyYwqkiNjHh5ne9EGBSrDs8gjKauTysYVz74nVCGSOaKlsZNcb3SDanrR3neda0fcIfnX9D/H5yuVGRZSyx1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720417927; c=relaxed/simple;
	bh=HSaJIlsi58nXwB9tmUMeNtF1ey6B0nSr5ghmGom9S+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ksFzQIWucIcslspgrfJAlPJaJC8SduXxmaLeqx81z0DowEw0TbQoXdueCzQ2peOMA4RM/rkk14lbDcobBVgYv+V5FnDIdnkf0y7lY6nGS4xqUrQDkZXUs3LZB+rW1cMvA24qaqPgMiQ7n4shrv9PyS+ZtooeYohpVFyt2RmHitg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tUgNmklQ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tUgNmklQ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AB46836B7F;
	Mon,  8 Jul 2024 01:52:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HSaJIlsi58nXwB9tmUMeNtF1ey6B0nSr5ghmGo
	m9S+A=; b=tUgNmklQoNCQ0trb/Hyvydgb8s2IMJ0kc+favfjxrwrdoOm9aKFhfV
	jojSOX54wlm0VjLrS6JU/tYpNAXtDMAdCtI8OmropfVu6WAednDgAjiMpxF/3AWa
	721sIo1k8uBQlaP9+Y497ZRd/b3Qu+9mAhig4+6T1LrAkm160P30Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A364336B7E;
	Mon,  8 Jul 2024 01:52:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3385036B7C;
	Mon,  8 Jul 2024 01:52:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [GIT PULL] git-gui pull request
In-Reply-To: <c3fa919a-2c4c-4c0f-9e6d-de7bdfeee80c@kdbg.org> (Johannes Sixt's
	message of "Sun, 7 Jul 2024 15:52:53 +0200")
References: <c3fa919a-2c4c-4c0f-9e6d-de7bdfeee80c@kdbg.org>
Date: Sun, 07 Jul 2024 22:52:00 -0700
Message-ID: <xmqq34okmnwf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 32B328A8-3CEE-11EF-9759-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Johannes Sixt <j6t@kdbg.org> writes:

> ...
>  .gitattributes   |    1 +
>  Makefile         |   16 +-
>  README.md        |    4 +-
>  git-gui.sh       |   37 +-
>  lib/encoding.tcl |    2 +-
>  po/README        |    2 +-
>  po/fr.po         |    2 +-
>  po/sv.po         | 3611 ++++++++++++++++++++++++++++--------------------------
>  8 files changed, 1863 insertions(+), 1812 deletions(-)

Will pull them in.  Thanks.

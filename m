Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BC82C69B
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460497; cv=none; b=McRbZvmLBUq8UuoAXeUdRnMjo5jrg12sySyz+1KM02lTsYkNVFPPLrhEnR2q+5rEDfO/KKbutRrfsxq6fpddfM4R6aB8fERiCVvBpMoRQRnimAu99dVm6mE04dfDruUy+bGMwCWkXlVMyARjneYxfwvVew6drKKFZgJtnlYxI4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460497; c=relaxed/simple;
	bh=UYJ0qzjOFlKNb1CKXNWnM8eUXKeycpi84IEjoHWSW2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NxL4sloJAhj7zcl3V/DaRCmv/oUN9WRzNGy4FM24M/+kJmymVoaBo9F8sY22a9sLF8/Qwtjuod55hAbqPqUwRc/RNYsgb08g5Wm1IOdU5wKP3njFg+k7ie+Kwu5JSdPgn5YvJ29eocrRNhEU7G9n9dNQKprxzpqvGx/Lvbu52dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CZ39Iiue; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CZ39Iiue"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8369E1BE35;
	Wed,  4 Sep 2024 10:34:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UYJ0qzjOFlKNb1CKXNWnM8eUXKeycpi84IEjoH
	WSW2I=; b=CZ39Iiue+sxDiuMf3sBxc7UohKyK6QQfmxSE8EMEWPBze/Fb5rFwFm
	QA85xlnSd/4vxdASqqxDJpVLTrQi15R0A5ZHBiHTIYRfxo8/6jivh3lq0knLSC5V
	8Q1kpZroDvFWwWmgfDZfHs74Ok6LcRP85TzlngBXVBlPaQ8N9FqtM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 78EAC1BE34;
	Wed,  4 Sep 2024 10:34:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 376041BE33;
	Wed,  4 Sep 2024 10:34:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Han Jiang <jhcarl0814@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: `git fetch =?utf-8?Q?--refmap=3D=3Crefspec=3E=E2=80=A6?=
 <repository> =?utf-8?B?PHJlZnNwZWM+4oCm4oCLYA==?=
 providing NON-empty <refspec> to the --refmap ALSO causes Git to ignore
 the configured refspecs
In-Reply-To: <CANrWfmSe0ekbRR9VsX8jALWQQVdhDv-2WTSm47jHTiV9-Z7-pg@mail.gmail.com>
	(Han Jiang's message of "Wed, 4 Sep 2024 16:09:51 +1200")
References: <CANrWfmSe0ekbRR9VsX8jALWQQVdhDv-2WTSm47jHTiV9-Z7-pg@mail.gmail.com>
Date: Wed, 04 Sep 2024 07:34:52 -0700
Message-ID: <xmqqle07ebcj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D93DBFDA-6ACA-11EF-811C-9B0F950A682E-77302942!pb-smtp2.pobox.com

Han Jiang <jhcarl0814@gmail.com> writes:

> What happened instead? (Actual behavior)
>
> In `git fetch --refmap='+refs/heads/branch1:refs/remotes/server/branch1'
> server branch1 branch2`,
> `remote.server.fetch=+refs/heads/*:refs/remotes/server/*` is replaced
> by `--refmap='+refs/heads/branch1:refs/remotes/server/branch1'`,
> so these are what would be done:
> branch1 -> server/branch1

This is totally expected.

A refspec specifies "what to fetch" and "where to store locally what
we fetched" at the same time.  A refmap only specifies the "where
the stuff is stored locally" part, and what to fetch is specified
separately.  You asked branch1 and branch2 to be fetched (peek into
the .git/FETCH_HEAD file to see both objects are fetched) from the
command line arguments, and your refmap specified where to store
what you got from their refs/heads/branch1.  As the refmap does not
say anything about any other branches, they are not stored anywhere
in your local refs/ namespace.

Typically --refmap is given with a glob, but the story is the same
there.  If you fetched refs/notes/commits from that same server with
a refmap to map "refs/heads/*:refs/remotes/server/*", the notes commit
is not mapped to anywhere with the refmap, so nothing will happen to
it.



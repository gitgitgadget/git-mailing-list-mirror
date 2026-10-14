Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA210155C97
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969041; cv=none; b=HeD2gleILAVyALCRKqvD0lBEPvJCShEcqenxYQlNL02nrtOjd+YIOUifX3BAc544avXvNVeXu59NoHdzibWWSlxMKOzp2FKuqjwQIu7Kim3aThv8vyZQeNjntyDmT8YGeG/FspcQnlaqzj8HwTBTIABkqd3TlUvfsQNtX3cJPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969041; c=relaxed/simple;
	bh=TRi3U8cNtlwhbEYYG8pf9ZCjeBWTqSrh3y+tBTFHZsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Otpc2EC3JTUqfK/NE3fIxo7MnvhJVUU4LG/mlahvbFf9HwUSHS8MUVVhWB4D7HplFg/zNmwxhiAwuchogG+JoPRJDlexcaNqWYN9o630aRpwPDtCCj4RGg2TH2fi2J3r56xyMt1L+qn5dk1W5Vns6NaSHgBZs6WrqVjhSjVphB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ug1uasHW; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ug1uasHW"
Received: (qmail 68835 invoked by uid 106); 14 Oct 2026 09:10:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TRi3U8cNtlwhbEYYG8pf9ZCjeBWTqSrh3y+tBTFHZsM=; b=Ug1uasHW0xp9CmAgnxHQO+dgweTb+pbJoRyCSuIAPve5v9kVaLviIYRTnlHLgJpQmvXkKU0jTQlWGTqsDBNJIB+TtILCL4WrxeDg3Cea1LMkEDVo+0K8ONAiCv3Hdvu5/qw272QkgJnhxV+NuxYTtIgIXG3GBt1WKAuZycXfk219yA/TOTWx5CMCJg/uyWs/MT+Pu7a1/w0csCb0YLCWMPicymPAT8pZobmgDS569wQvClBUmub+YrWyOF7i7SxgJ57qWBKjV8UPGzsWgwvRmZVYh8AYBJcxyi0Qq0X38xytngUn76tjNyatdDbrPRxedON8yeTuhm4a4Sxbqh+kbQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2026 09:10:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 35600 invoked by uid 111); 14 Oct 2026 09:10:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2026 05:10:42 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Oct 2026 05:10:37 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 2/8] ci: fix "fedora-breaking-changes-meson" job
Message-ID: <20261014091037.GB1341124@coredump.intra.peff.net>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
 <20261014-pks-ci-housekeeping-v3-2-04c24e1f480d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-pks-ci-housekeeping-v3-2-04c24e1f480d@pks.im>

On Wed, Oct 14, 2026 at 10:30:28AM +0200, Patrick Steinhardt wrote:

> The "fedora-breaking-changes-meson" job exercises Git with breaking
> changes enabled on Fedora with Meson. There's a typo in our CI scripts
> though, which has the effect that the build does not enable breaking
> changes by accident.
>
> [...]
>
>  case "$jobname" in
> -fedora-breaking-changes-musl|linux-breaking-changes)
> +fedora-breaking-changes-meson|linux-breaking-changes)
>  	export WITH_BREAKING_CHANGES=YesPlease
>  	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
>  	;;

Seems obviously correct, but I wonder if just:

  *breaking-changes*)

would fix this and prevent any issues for possible future jobs. The
downside of a loose pattern is false matches, but it seems like a small
risk given our universe of jobs.

-Peff

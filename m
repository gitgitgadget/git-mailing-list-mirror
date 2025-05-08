Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6791C3F0C
	for <git@vger.kernel.org>; Thu,  8 May 2025 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746729563; cv=none; b=jXv8EczKVfendH4m3X2chCZSMonxh556LYteBVUmOFOdCV1w67bfLIUTyMlNkwAYE6g3R1qWO3+OVfgleKQaAGxjeLCg99o5FV6F5WbsrvFXv+tHIeVraJpu1WenVkfr2bxUMPe+OD9wPJCDhjdBBgd9REfv18l0cML/9tIlSF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746729563; c=relaxed/simple;
	bh=AhWkJZ0VgJ/E6rSDoi/rHxtvI/rvicxjjSZp8BLVnWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSoBRTZ8LP6sgIm18NtNyts8rHbcv7mhEbawLK45qGS46xE6QqJ+9V6/HUi0JP3aQrnpoo7fPLY+Ckx5efrJEoXE+HP+hx7NVqAFkJF2JMuhC4hfcmBklxJ/kdCnXQRoDIBfwt4H/ctPKbpy8MVMiWZ7n7WpTELGk/0OzmKdw3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FdvJk8b3; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FdvJk8b3"
Received: (qmail 28684 invoked by uid 109); 8 May 2025 18:39:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=AhWkJZ0VgJ/E6rSDoi/rHxtvI/rvicxjjSZp8BLVnWQ=; b=FdvJk8b3Qh7VsVqUCOkPcTEQitNOidp4wu3ClVYLuEa8AuSUldNdizr0I0RGOMAObd4DchUzRIIgL9/oLGkNV+BLEKUXMGxQtPtuTZP8KjsHnkK66J93HCCDmkMgx7hsPZVms8AqnpMylI6aJkhuY0FOMPi41+LBFPiGD/RtLwSnNu/Y+4VKsscpWXqCMgWbVIW/+BYcFqEDA6euxRhjHDFzdR3lUaBx5w8YtM8h9YCpgqCfZCU4EgLsB5qaDOBJMKuasKb991wUGz0HKeIRiypuL6j10cU3RAWA5IqOzDeYdWngUQs1uhhzpS0dyjWrm1g6s0j5oS8/dM6Ghod4oQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 May 2025 18:39:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18715 invoked by uid 111); 8 May 2025 18:39:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 May 2025 14:39:12 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 8 May 2025 14:39:10 -0400
From: Jeff King <peff@peff.net>
To: Abhishek Dalmia <adalmia@commvault.com>
Cc: Justin Tobler <jltobler@gmail.com>, Akash S <akashs@commvault.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Adithya Urugudige <aurugudige@commvault.com>
Subject: Re: Incremental Backup of repositories using Git
Message-ID: <20250508183910.GB10864@coredump.intra.peff.net>
References: <PH7PR19MB70252D42F5D04FFC0331AB63C08E2@PH7PR19MB7025.namprd19.prod.outlook.com>
 <2dz3cema2mr5mrlvuroemnyeqyrglxfmusfdz2kaghv6rvj3ro@ti2dhu45fdmr>
 <SJ1PR19MB6401D7734B73C453E491D54DAE89A@SJ1PR19MB6401.namprd19.prod.outlook.com>
 <hanlqq5mma3dvbfq4j4u2zgz5mjegejjg3gjrhyggg2e6ozd5t@354nrc4nq6gn>
 <SJ1PR19MB64010CDB3F21FE91C97E566BAE8BA@SJ1PR19MB6401.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR19MB64010CDB3F21FE91C97E566BAE8BA@SJ1PR19MB6401.namprd19.prod.outlook.com>

On Thu, May 08, 2025 at 10:24:55AM +0000, Abhishek Dalmia wrote:

> I ran into an edge case while testing incremental backups with git
> bundle. If a commit is created with a timestamp earlier than the
> latest full or incremental backup, it can be excluded from the next
> bundle due to the --since parameter even if there is a buffer.

Yeah, I don't think you want to use "--since" here, since it is about
commit timestamps. You care about the state of the refs at a particular
time. Or more accurately, you care that you have captured a particular
ref state previously.

So ideally you'd snapshot that state in an atomic way, feed it as the
"current" state when doing a bundle, and then save it for later. You can
easily create such a snapshot with for-each-ref, but I don't think
git-bundle has a way to provide the exact set of ref tips and their
values (it just takes rev-list arguments, and wants to resolve the refs
themselves).

You could probably get away with just creating a bundle with the current
state, and then pulling the snapshot values from the created bundle.
Something like this:

  # for initial backup
  if ! test -e last-bundle-snapshot; then
    >last-bundle-snapshot
  fi

  # mark everything from last as seen, so we do not include it,
  # along with --all (or your choice of refs) to pick up everything
  # we have currently
  sed -e 's/^/^/' <last-bundle-snapshot |
  git bundle create out.bundle --all --stdin

  # and now save that ref state for next time; this is inherently
  # peeking at the bundle format.
  sed -ne '
	# quit when we see end of header
	/^$/q;
	# drop comments and old negatives; copy only first word (the oid)
	s/^\([^-#][^ ]*\).*/\1/p;
  ' <out.bundle >last-bundle-snapshot

Or alternatively, instead of using git-bundle at all, you could just
store a collection of ref snapshots (from "for-each-ref") and thin packs
(from "pack-objects --thin --stdout", fed from the old snapshot and the
new). Which is really all that bundles are anyway.

-Peff

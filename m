Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2230A28B4EB
	for <git@vger.kernel.org>; Thu,  8 May 2025 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746733655; cv=none; b=PpiaQ7rY7usty+fAS9cj+uj+bqTnIYm5KONCvY3uVal25X+sXIjas6LCDOk3LD5GlZr2SRUvpZ0RqKTz+MJRvJI3lfuTIgcUJskgbhsw2VUlgVRWTsQSc66RbpiNLhV9qpoHYSC4YKVqWFno8iUgLHJdo/SZIXzrmvKc+64Blv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746733655; c=relaxed/simple;
	bh=GV0feVIA19JmMpLGHQpcsNcz3N7NztPIUTWGgjOxTwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eymVqTT4332dPCObzJrITNaKucYuPVBvNc55id7RlHtr5shGVBfD8v4zK4EDrlWYigWKgEa3rFypX/BzCrKClewVcdStYTuePsI5qIU05Kkh3VtQYG3yWWAi16W3AwqVIKuS9yYGBiAkw1jvvlue4GiTRaxVoSFC9rS4ShBfYgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AXW1M1Cf; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AXW1M1Cf"
Received: (qmail 29039 invoked by uid 109); 8 May 2025 19:47:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=GV0feVIA19JmMpLGHQpcsNcz3N7NztPIUTWGgjOxTwM=; b=AXW1M1CfcJwBe1lr+6d3DWa31WzVZ6+B42yPSerkRToRG7n2KHhTKaAUKs7xpOenc+JT57w+vr+8eNWpiPdxeD8Q7R3eLACmlOkZn2PWKgu3zyOrhbE9A2QFoKqr/PtKS9aCdYIogQVXZGdQi3tYmIzPVSiP4dFI342phIc+XHrwTdj4aw4KrQMux14xsb3mkOL8e9gsuQI4lBIvnm/nhwd4w+VqRGck2zKKCXIht6/dJ2Nric7CM2wp/GDJ9rarEr3ZWQeUvdqfVmzui2WCvN2NR05aZYb7hVAnq0vWRDb+MktlzRV7J3fwe9JaDkuJ38TdFn9WZvot6e0f8ovlLg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 May 2025 19:47:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19757 invoked by uid 111); 8 May 2025 19:47:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 May 2025 15:47:33 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 8 May 2025 15:47:31 -0400
From: Jeff King <peff@peff.net>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: Akash S <akashs@commvault.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Adithya Urugudige <aurugudige@commvault.com>,
	Abhishek Dalmia <adalmia@commvault.com>
Subject: Re: Incremental Backup of repositories using Git
Message-ID: <20250508194731.GA13108@coredump.intra.peff.net>
References: <PH7PR19MB70252D42F5D04FFC0331AB63C08E2@PH7PR19MB7025.namprd19.prod.outlook.com>
 <aBz8U35YX7UH-PTW@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBz8U35YX7UH-PTW@kitsune.suse.cz>

On Thu, May 08, 2025 at 08:47:47PM +0200, Michal Suchánek wrote:

> If you have one of those filesystems that support deduplication on
> filesystem level you could make each snapshot as a full repository with
> all objects unpacked, and the filesystem would deduplicate the objects
> for you.
> 
> The downside is that you have no way to do multiple full backups this
> way, and you would have to use something else for that (such as those
> bundles, or plain archiving the repository as files in a tar archive or
> such.

This is tempting, but I suspect that storing the objects unpacked will
become unfeasibly large, because you are missing out on delta
compression in the packfiles. You can compare the on-disk and
uncompressed sizes of objects in a repo like this:

  git cat-file --batch-all-objects --unordered \
               --batch-check='%(objectsize:disk) %(objectsize)' |
  perl -alne '
    $disk += $F[0];
    $true += $F[1];
    END {
      print "$true / $disk = ", int($true / $disk);
    }
  '

It's not entirely fair because the "true" size is missing out on zlib
compression that loose objects would get. But that's at best going to be
about 4:1 (and in practice worse, since trees are full of sha1 hashes
that don't compress very well).

In my copy of linux.git, that yields ~135G versus ~2.4G, for a factor of
56. Even if we grant 4:1 compression from zlib, that's still inflating
your on-disk repository by a factor of 14.

If you have the patience, you can run:

  git cat-file --batch-all-objects --unordered --batch | gzip | wc -c

to get a better sense of what it looks like with the extra deflate (this
is cheating a bit, because it will find cross-object compression
opportunities which would not be there in loose objects storage, but
should get you in the right ballpark).

You're probably also paying some inode costs with loose objects (1K
trees at the root of linux.git all pay 4K or whatever as individual
loose objects).

So you're probably much better off with some strategy .keep files. I.e.,
make a good big pack and mark it with .keep, so that it is retained
forever.

-Peff

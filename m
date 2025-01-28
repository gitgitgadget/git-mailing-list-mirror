Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128B51B0439
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082779; cv=none; b=Uc2j63u04/bjxO2MACZBWw6JDT5BcrSO/tOqdz4FzNI1yCPJy6dsxbnD1PTFBVv2GKJSoO+VCaOj7WpSgL0QsmShm6ePvfBIPCmRhjalDAvyCFMmF80GBBu+pja9XGKSCVRZzMo5X2kfZcfug4qC6zUyA9bE1qoxkmwRzc3DJ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082779; c=relaxed/simple;
	bh=zPPrdYnllw1cK+rTSvcvZP4co+MkJufr2WpuClI/m8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABHJUBaq3Lx7HXq14YojrePWtNB69kUTwtD4wOpbnwRmHfipgO3mQfm2ykcRildp02N1SZHmq+G9laiEFjTZ/q1MZshCafCnkXSOPJP7NHzES+IUw6kSjC4uDLCJSzH3/TEMbPnMi0/4f/kCLPm5d756wmG0/C09v0nMabgD43w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ODLeC3Xi; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ODLeC3Xi"
Received: (qmail 12308 invoked by uid 109); 28 Jan 2025 16:46:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zPPrdYnllw1cK+rTSvcvZP4co+MkJufr2WpuClI/m8I=; b=ODLeC3XiR2hGAizOV7QXVgYBtUA7eJ/AEaWzFk/Nwnmv+JeKRBQS3V95fZbHgaGAZXfioN3h7UGJFluNe8Ar+HQX0W5AY9YsxvAEBiYM+L2krG4S7RYEdjCRRJE+J0ku2yqsc/UdySc9U8aMWeynl9sbx1YXYljdMfG21cGZXGOHFOscAUr4W9CFIn+2E3tml0JEIC4Vs+TAREc/mmUXXgP03Q7n5ycos8b/tfS1vA5LYBMlE2H+4E8NBOUQkE+QraYBd+C1fgw6mbjFiBQcczXqddEbjTupQpLfTK+BNGHvhFFuebfEGyWZjfs/Hx097KvuX/ZCAO0tRoIsDCUXdQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jan 2025 16:46:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31561 invoked by uid 111); 28 Jan 2025 16:46:08 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jan 2025 11:46:08 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 28 Jan 2025 11:46:06 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #07; Fri, 24)
Message-ID: <20250128164606.GA1688180@coredump.intra.peff.net>
References: <xmqqwmekvubv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmekvubv.fsf@gitster.g>

On Fri, Jan 24, 2025 at 12:19:00PM -0800, Junio C Hamano wrote:

> * bc/doc-adoc-not-txt (2025-01-21) 5 commits
>   (merged to 'next' on 2025-01-24 at 737049d332)
>  + Remove obsolete ".txt" extensions for AsciiDoc files
>  + doc: use .adoc extension for AsciiDoc files
>  + gitattributes: mark AsciiDoc files as LF-only
>  + editorconfig: add .adoc extension
>  + doc: update gitignore for .adoc extension
> 
>  All the documentation .txt files have been renamed to .adoc to help
>  content aware editors.
> 
>  Will cook in 'next' for at least 3 weeks til mid Feb 2025.
>  cf. <xmqqmsfl2gro.fsf@gitster.g>
>  source: <20250120015603.1980991-1-sandals@crustytoothpaste.net>

I noticed CI complaining about a missing include file:

  2025-01-28T15:51:45.3979314Z asciidoc: WARNING: difftool.adoc: line 16: include file not found: /home/runner/work/git/git/Documentation/mergetools-diff.txt

The problem is that the line was introduced by another concurrent
branch, aj/difftool-config-doc-fix. So we can't fix it independently on
either branch; the line does not exist yet in brian's adoc branch, and
the file is still ".txt" in Adam's doc-fix branch.

It has to be fixed in an evil merge of the two (or brian's rebased on
Adam's, which has since graduated to master).

-Peff

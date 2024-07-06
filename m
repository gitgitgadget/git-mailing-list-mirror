Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5401798F
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 06:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720247322; cv=none; b=u+HM5e4mViA0k/GxOSHcjZBeOOjEVrVDXG1bc10ZlmuKVTgq9f8+qKamppQ/+LRV+hkSNrYnAmRqv3thfC3wEJnzQOcY3EGcu0CdP37NEyEyQ9bVwGAvRHkW1uQ3bcGNXDVd54AlDfRUzmOefwfXm/RQAye/OiyHz931tkfwK2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720247322; c=relaxed/simple;
	bh=dmZrqFzORzcGuN4KwJ5KW6fkJDlBYEQbf4SLbOItyBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiNOp015nG2m028N0pzxtaIYun+s19B/NpDZJKgONv2BrGFjEIo8cwZw5B31FVZzFl+bkcRoZcbq+Z3FALjYecF7mAoMaewJt2zTCY3IkOfL914Su7+gTpQM4UOv1wiDndA31t9sOgg+sEktlCmWBl+wq6+nJrALVFPnuSeWTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23750 invoked by uid 109); 6 Jul 2024 06:28:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 06:28:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31370 invoked by uid 111); 6 Jul 2024 06:28:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 02:28:37 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 02:28:39 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] merge-ort: fix missing early return
Message-ID: <20240706062839.GD700645@coredump.intra.peff.net>
References: <pull.1758.git.1720123341342.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1758.git.1720123341342.gitgitgadget@gmail.com>

On Thu, Jul 04, 2024 at 08:02:21PM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> One of the conversions in 500433edf49 ("merge-ort: convert more error()
> cases to path_msg()", 2024-06-10) accidentally lost the early return.
> Restore it.

Thanks, this looks good to me.

-Peff

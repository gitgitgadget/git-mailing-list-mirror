Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2D62DEA7B
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 23:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773876500; cv=none; b=sfE+1BfgbNvlgu+s1f/qCEsF2+0irT4TrlRntt7VObeN4s+Cp8VTg2H2mxpAqabkzuh0iPGXkNASm2QdqocRdc5vW+IBWsU0sUN/1DH3VpKDlda9ElIckQPLsuwNXyyKNhAIn0/8heJUdaEpWw283tPmTFsOtryod9/kyKl3iHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773876500; c=relaxed/simple;
	bh=56aqRN9PBCYnHpkCAOV2fk3kR/u9UjrxqbifXrjOmaQ=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=obBLFKNRbzF1VIPWvsyXU6Xpj7sqUhMqtRCMSMTMQdcFoJmyS/Cj4cojpqs0pcfxaVMclTrdb9/FNPEJwol7UKjtripWipnzCWwEqe6wYh3lWp8EfzwtRm2B7A7W9BzatT52WzVGihbBs0nasFrkOZ6m9lSKe/xGjxcHd+Z/fBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e3DmxhIT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e3DmxhIT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:Subject:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5Kx+5jyABHwCOpuMo6TmZskugRB36z+nGoit2wfR1bQ=; b=e3DmxhITA8ddX67u+eYYv8bpv1
	2kmm4u/cQhFeFsrtmKQh5N9yfolHGv3kbuGTkNvoACwAlu4r6rl3c50Esff7eDMQxy/sQBLMkSUVb
	4dUo0B1eQhUQ/NeGHuQwkoyNOygub3gWs7N7v6Z59HMdnV9au3fy+2nBSLybJ6Dhlq7a0SSdgsVcQ
	M5ZfTogju34Ff/hBLslLYW/CjEcNIW8VVFFA9TV+GFz4bo2eEKugyDet2vxurkL9OieTCk0+Tq+OW
	TtVpKh1PIQsm9fUsdSisRYrOWyJCqO7L7s/fk6it4h9WFP7JoMADgfFpjNd3vE2jDoNnZbloOPEsM
	7Gxoj9lA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w30JF-00000009WBa-48Sv
	for git@vger.kernel.org;
	Wed, 18 Mar 2026 23:28:18 +0000
Message-ID: <7bbcda60-dad4-41d4-b994-c19f83f37e2f@infradead.org>
Date: Wed, 18 Mar 2026 16:28:17 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
To: git@vger.kernel.org
Subject: git grep failure?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

If I apply the patch at
https://lore.kernel.org/linux-doc/c5bb61cf789df1ecb32facc29df9749987c7ddfc.1773346620.git.ljs@kernel.org/

Subject: [PATCH 02/15] mm: add documentation for the mmap_prepare file operation callback

to the Linux kernel tree (e.g., linux-next-20260316), it applies cleanly.

I noticed a typo in the patch ("struct vma_area_desc" should be
"struct vm_area_desc"). When I run
$ git grep vma_area_desc
the output is empty.

Is this expected? (but not by me :)

thanks.
-- 
~Randy


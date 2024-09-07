Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBA532C8E
	for <git@vger.kernel.org>; Sat,  7 Sep 2024 05:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725687683; cv=none; b=LtIt/ej47c50+V+e1EiZryLc5BGq9eSlj1X2oeuvG/Du4W6p/IjB/HFFdHr0xb41n1N/UWhPWYr03t/oyuVM/26o5zmvXp3YcJUe7ooG3mo86lMlNJwB7XosN29kwcoVHKohA+Lb1mHmR/scgMStTS+gxCw6aqSb0SeaVN3iidM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725687683; c=relaxed/simple;
	bh=CNwTIjB9vcuZFIiTT/vEgB4o7E4mnFDA5/tB828ds98=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nrz1l8QX8E63Mfr8802YrpCYaCSUCeKB2fwHIRCkYB9nmoUSTWT4kIP0Vf7e9sK75rx+7B150G5epHwkrda+bmvl1E9PTnObZPyNLbX4uH0R93VdWcSS44Or1yeQ7/bvGBVhLGtvMzY77uQRrnZLX3ahcY3rb0NVdbC1DIReljs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vb7BE+j7; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vb7BE+j7"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E64653F8AD;
	Sat,  7 Sep 2024 01:41:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=C
	NwTIjB9vcuZFIiTT/vEgB4o7E4mnFDA5/tB828ds98=; b=vb7BE+j74khl1d7lK
	OmMFoX9rfe3J1Lh/kr2Mgn7d5m5I4+4zYhl1CvLVpLg87GG7PIrGAIWGbLFzX/VJ
	RkECijzaB0skbSm14mwZxpESLsanMSXm/dhVFntYOQ/SxlBRpOIlgtY+LW23oYCJ
	S42ZF0lSV0v9Ew5mEucHzKJQZw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF26E3F8AC;
	Sat,  7 Sep 2024 01:41:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55A9E3F8AB;
	Sat,  7 Sep 2024 01:41:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking draft as of 2024-09-06 late night
Date: Fri, 06 Sep 2024 22:41:19 -0700
Message-ID: <xmqq7cboyq9s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CF51E8F8-6CDB-11EF-9CCB-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

This is not the full list of topics in master..seen but just a
selected subset.  I am hoping that the topics marked for 'next' are
already ready but if I missed some objections, please let me know.

Thanks.


Needs review.
 - tb/incremental-midx-part-2                                   08-28         #16
   <cover.1723760847.git.me@ttaylorr.com>
 - ps/environ-wo-the-repository                                 08-30         #21
   <cover.1725008897.git.ps@pks.im>
 - jc/pass-repo-to-builtins                                     09-05          #4
   <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
 - ja/doc-synopsis-markup                                       09-05          #3
   <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>

Will merge to 'master'.
 + jk/free-commit-buffer-of-skipped-commits                     08-30/09-03    #1
 + ah/mergetols-vscode                                          09-01/09-04    #1
 + rj/compat-terminal-unused-fix                                09-01/09-04    #1
 + ps/declare-pack-redundamt-dead                               09-03/09-04    #1
 + jc/mailinfo-header-cleanup                                   08-20/09-05    #1
 + gt/unit-test-oid-array                                       09-01/09-05    #1
 + ps/index-pack-outside-repo-fix                               09-04/09-05    #1
 + ps/clar-unit-test                                            09-04/09-05   #14
 + tb/multi-pack-reuse-fix                                      08-27/09-06    #5
 + kl/cat-file-on-sparse-index                                  09-04/09-06    #2
 + ps/pack-refs-auto-heuristics                                 09-04/09-06    #3
 + jk/messages-with-excess-lf-fix                               09-05/09-06    #1

Will merge to 'next'.
 - ds/doc-wholesale-disabling-advice-messages                   09-06          #1
 - jk/sparse-fdleak-fix                                         09-06          #3
 - sp/mailmap                                                   09-06          #1
 - ds/scalar-no-tags                                            09-06          #1

Will merge to 'next'?
 - pw/rebase-autostash-fix                                      09-03          #1
   <pull.1772.v2.git.1725289979450.gitgitgadget@gmail.com>
 - sk/enable-prefetch-per-remote                                09-05          #1
   <pull.1779.v4.git.1725565398681.gitgitgadget@gmail.com>
 - ps/leakfixes-part-6                                          09-05         #22
   <cover.1725530720.git.ps@pks.im>
 - bl/trailers-and-incomplete-last-line-fix                     09-06          #1
   <20240906145743.2059405-1-brianmlyles@gmail.com>
 - tb/weak-sha1-for-tail-sum                                    09-06          #9
   <cover.1725651952.git.me@ttaylorr.com>

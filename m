Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0831CFA9
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733190867; cv=none; b=td4jUZlTSZT2XP3Rm2uYV2RQvF4t/s+N9pHWe6ADv6dmcOr87wjroShqkB+jVEg6gNCBMbnbWOHfhUTmKWL2HoolEUVeoRAfxQyHVVivx72vVuPTdjald0YUwB8Hh/R3a89zzh+qN0eHoj5nvyeKKpeVN1D/UhVkUiaufMFg3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733190867; c=relaxed/simple;
	bh=AdVyOBZwdN7dmSr4hSOw4mkUCdi7nqxG4QOXFrc2btU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=hs1ocZ8Bj49PTQaESDw2fQ+rtOKVN8eSBpt+Hzhk+/Vyqogwd4ZFcL2JXPR5e8h9uWNRurHuYLB2jlGQZ66cUpxIkONpRhMKH9t0anlq2vuECdvtTQWqrE8aPj/hGrwCBEq3ADuFPrpL0M0s7C8NA961Q3FxLarwCnyiKGpkn5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4B31s3DL3005854
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Dec 2024 01:54:03 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Eric Sunshine'" <sunshine@sunshineco.com>
Cc: "'shejialuo'" <shejialuo@gmail.com>, "'Caleb White'" <cdwhite3@pm.me>,
        <git@vger.kernel.org>
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me>	<xmqqed2qkfn0.fsf@gitster.g> <Z02eKA8i51QyXgJ-@ArchLinux>	<xmqqed2pioff.fsf@gitster.g>	<CAPig+cQHW9=A5ejU5aZ+Wy0uOQsLU_uqUibeYzZs2PXK37Vpbw@mail.gmail.com> <xmqqo71tfsif.fsf@gitster.g>
In-Reply-To: <xmqqo71tfsif.fsf@gitster.g>
Subject: RE: [PATCH v2 0/3] Ensure unique worktree ids across repositories
Date: Mon, 2 Dec 2024 20:53:57 -0500
Organization: Nexbridge Inc.
Message-ID: <025b01db4526$3b05ef00$b111cd00$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHZQR+UqnR1y6U5HdhCIquXTuJIeQMos/+5AOhGRA0A/QMHJgFdlIwvAacgxXCylzP6sA==
Content-Language: en-ca

On December 2, 2024 8:46 PM, Junio C Hamano wrote:
>Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Unfortunately, I haven't had time lately to follow all these
>> worktree-related changes or discussions, but perhaps shejialuo is
>> referring to the ability, from within one worktree, to mention a ref
>> from another worktree (which is a feature Duy added some time after
>> the initial worktree implementation).
>
>Ah, yes, that exposes (and has to expose) the worktree ID.  It still does
not have to
>be unique across repositories (only has to unique among the worktrees that
share
>the same single repository).

I might be mistaken, but I think the intent of the worktree series being
discussed
deliberately wanted the worktree ID to be globally unique on a specific
machine.
I might be wrong (hoping I am). The original author should comment on this.


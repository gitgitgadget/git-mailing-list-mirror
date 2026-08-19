Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D49448CD4F
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787162340; cv=none; b=G1Bm9KmAbz+VbbCyUA+nW8oAm+ggolW38codv7y8CpUOZfZvA2pn0b3+c1Q3Dtnc3a4920T30DFsE3RPkPgFLDS1F6mcnX+qlzKI5K2kN+YSfijTfDkv6JG9moWXZ1vfcyDoG3Ksjedq+SYBdiR4F0hhcmfS/SpIikG2cIvuZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787162340; c=relaxed/simple;
	bh=1CAz+HocnOAf68QhIcSfE5X7HTS9FnpYyhBQ+o4LLmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LNRjGvxGqPltf8gSaQ5KkZNV1WR5n0FNttcQMLeneBvDm4xklS8Iww/vxBG87lgloAsnC6FhzepJjSoc1yhDZoMrXMEvjI3I4Pzvdx5r0x/ddE2jtVv/SuSbwBVZ2hvaKy9mAIaScOCqRvNBHDslverQmxfB14iEtQsmdxxNiwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kYB/uvR5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C5DwkWL1; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kYB/uvR5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C5DwkWL1"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 5D0D91D000E3;
	Wed, 19 Aug 2026 13:58:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 19 Aug 2026 13:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787162338; x=1787248738; bh=1CAz+HocnO
	Af68QhIcSfE5X7HTS9FnpYyhBQ+o4LLmQ=; b=kYB/uvR5Ey8W3xo//+8sr/oeXl
	6sejtqxWvbpKOI1Qmqt7HH6yAs9VTJVfqQjkvKWkRlpp6kgX7VhkYQhNZEJi3Om4
	zCSoVMnvy9rjYsbOCWyPAAeRslxcFvl7yHrdao7Rpc78FGFxJNIGDqV9g0rpNtDs
	8hojcM1ksnLeSy4E2N/DcdaJrgNpJ8Gnif+Ak9QUfsqZG3U/ilLVP6He0ffZZWJt
	bQXujWueFwxWx+aVzLHH51RIgEFaUmwPBZ8vf9uc5BQpFR0WjpMpeI2bEi7Y5OoY
	+p7AcfE398xVjygUU7Jao7o+b8Q4AtZ2jQjMQuR73byF/ZzxLGd7ZgT1F6wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787162338; x=1787248738; bh=1CAz+HocnOAf68QhIcSfE5X7HTS9FnpYyhB
	Q+o4LLmQ=; b=C5DwkWL1AV4piNnJE4m5RmMyUjkuKW+5ahOp7FOvvejtVlugX5s
	g1Y2M9NhWC1fez8efyxL1DmrNQ9cuesbgvbbTyljMWihhiBbY5M+XWwjawVqP5PU
	dzhJ42SRh/XxqA9kNy5hWt4aDLnLOlj0gEHYWlMZOOlehvguW0CrYKCBXgCAs/L2
	P+z7ihDLxIE7/FfmZsiYWSN2G1gP9seiYk5PTgBAEmrEvNLIBVqSaE3779Gc780Z
	wGBXj1aoMxF/RDsi8CVLgQLskpJdFy3UsAwvtXh67MNKNEMmmVVr4+zsZIyWvTql
	HDSRN1bamxpT6/BRGhR8jXqdJMgwHNL0WhA==
X-ME-Sender: <xms:4u6Fauv3mTmbOkToRjvRlaMZeqq4cNJ5sgeCHMWV59XneZ9XVAfSqw>
    <xme:4u6Faq6oweMB_oWTxDMCjD6u3o-5G_WEbiC5U7iGtZvnSSAILo9wJUGxP4TMuxB02
    Yz93x7k6T2RM3uXdSF0x-j1_JCZRJ6OHNB9XFjj9Ip-MjTQOTgshw>
X-ME-Received: <xmr:4u6FanIu54-n2Xi1KZ0oE39CPAAcfKOorE_Qt5sBJk3OxqrCrNJB7ZfiRaBKutP_wpYzJ2Yiub-AY-9bfV_xddZRQy2bAuEN4g>
X-ME-Proxy-Cause: dmFkZTGDODTuNPqT/OX50UopxFpeHkC5wzrXtayZ/jIjIoLAqtbZLBi35uhhbzRiya7Ntk
    QuA3+vzg50Z0XPr4Ae5hHiBwhuCOlXMYJrUc6nltm/3A6uwOXow23MvyjyHDrQReBDL28b
    LS4nEOUfx5DRymn9qZ6yUpBJmD+GUO9QIHDqYwC2+renTErYH01Y49paKwKQIXiKWxFhS/
    1gEABLKg1itSwYe3S2w8IHGRIPZs2J1b8llLnChnCveIqRMs7d4XXigaoFDNmsMeFXuqXq
    +EdvWVMtDhKrchDXd5X8CpgaYm09OEgr+dWlvUDpxxgl/vNlg8DlFw3v3s3+plOJUZrCC8
    pUbnPw94JI0RET0/M/lHSHZRKOBMH/ta43ggF2wMna0itsl3VO3KhmKPxsJCQFUZeEjCId
    XMMbabsBtg9b2tacbiUXe+YOnEL8CEVRrO1qAvDAvIKJm0wGj5ye9qSoIXQ7w16IAO5w3a
    HNC9nmwx0/ozLyfCY4XQqvc6IFvwY6WokpUtej/GGlVH0f4p09vZTmklkTWwL64TvoMmxu
    FgEaqOAdsp1NMRFSdUlJYjoZX91GP8r2FDpmXlMQ1WJjjY2RtX5nNPV7Mygb/JcmfJOQIz
    aZkd0y4TLu+U721IVdW9SapLn8GNkg8KdcgunHc2FuizM8l0H6d8ov6ZQHTw
X-ME-Proxy: <xmx:4u6Fai62C48Loc3HI-QnkhcluIr738aCeFlU9_aQVQw2Mv0QE8fAhQ>
    <xmx:4u6Faixhc67SxUnE54sVl0i6mP5hABzOjlMwUf7lITuV-Ov0Mxq9cg>
    <xmx:4u6FauZoj7emCSnHT15CpH_dIJOfzXNVMv6sxpFJLmStc7ImtE_AOQ>
    <xmx:4u6FasRXKZbNxGj0T5HNR2W0Y1Tmi7orA8Qu5KFKAOqjTHfntCp-3Q>
    <xmx:4u6FaijOAEoOgfuAzrK5xcV-0NSoufc_24UxYTDQgfNgDfCbmHjudspt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 13:58:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kenneth Lorber <keni@his.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/1] config: surface editor failure in exit code
In-Reply-To: <20260819150922.2984850-1-keni@his.com> (Kenneth Lorber's message
	of "Wed, 19 Aug 2026 11:09:17 -0400")
References: <20260817211936.2943278-1-keni@his.com>
	<20260819150922.2984850-1-keni@his.com>
Date: Wed, 19 Aug 2026 10:58:56 -0700
Message-ID: <xmqqjypmuh3z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kenneth Lorber <keni@his.com> writes:

> (Apologies to anyone who gets this twice.)

You should not apologize; instead make sure you do not send out the
same thing twice ;-).


We actually have 633ac346ee (config: propagate launch_editor()
failure in show_editor(), 2026-08-12) in flight, so we do not need
this patch.

Please build from 'next' and use the resulting "git" binary to try
it out.

Thanks.

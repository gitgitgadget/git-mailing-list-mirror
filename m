Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008F4199252
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 01:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754271900; cv=pass; b=dyI5wy3dDXVSNFLnoSnIfiVCAOSer0Yd769kkGPiqwSryVKzQjMtzhFtEHagGiaQmfDPgs73KkbF7r4IYg2DmqPuDtoh/28QuAEeWrEHtYvxxgGgXliPmcbIbUv2WExLxFvnN3kF/cXnrI5ImQRy4yf2sCwNjz4tWyQ01QLzeEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754271900; c=relaxed/simple;
	bh=OG9+l8hgLrPYiDK4yxNIMQBU9WYNNH0S45Kt7YDvxrM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=j0UxH2G2F+/F4rqrL8g7VqUBdH1glIC4pf1zySdU9ws/jcIaltKVtcZoEUtbHP+NqVt+7TmsFRveM9daFVCeTgm1b4c2BOZZG7FfdKFt/hM5Y1OMmTF9ShaMPZxuw98vzSkcZiWU2EFxkp2wf/MpBRbWNN48KFW4DTGWG4IVFaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=rGK+KA3l; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="rGK+KA3l"
ARC-Seal: i=1; a=rsa-sha256; t=1754271886; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PcySx0xjBuki2zRFNyMD0LZDaHURTdUjPH3V43Hy5jtvSeDtrlArByYeP7AGBaBJSKndCBxKCCK8Ddt4ck31KYbMBHFNZ/ljWjWuPrY7zbhKfydGgkr9ZiB3yVdSBhf+3UQ6pvbpek9o0+DWfMUbi5g7kMveSXic9HDbK2RjV5Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754271886; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4TsePD8rlZaBoowrDuIglq01VgFjb1N5NolVWfnLE80=; 
	b=Mk2/KBsQMNvskPJoHhJxDiapqvmzCCncbuWqwyYCCBAOYZj/BpH3B/PinBGUOwjtbijXb5tSHDXZqwbWCoW9TAiztKAsf9yewNLedBRBMLUk/ypwChr+VKWSdtE9CVrWziIuTQRIwv1HqJlJuIYCCYgcxn9vu5gA5NPqhH2eieI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754271886;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4TsePD8rlZaBoowrDuIglq01VgFjb1N5NolVWfnLE80=;
	b=rGK+KA3lD6VRKy9dQkuklHr6vrpL3KRfVXtz2qJwoEMUyb5HwMgZUlq4ym8wgwqk
	ffBooYo0UTiJSAwFnZ8oHHtpgpLZU+aUMYtV3NEnakrpnBexT/OpfK9aI30c+powvM4
	+/UuaQai5IHLJt4GzhPrCLOlYGbFOJaoeWDAwmQk=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1754271885327796.7323984915935; Sun, 3 Aug 2025 18:44:45 -0700 (PDT)
Date: Mon, 04 Aug 2025 09:44:45 +0800
From: Li Chen <me@linux.beauty>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "phillipwood" <phillip.wood@dunelm.org.uk>, "git" <git@vger.kernel.org>
Message-ID: <19872c0a7f9.4f0ce123219344.1150677041521426116@linux.beauty>
In-Reply-To: <xmqq8qk0fjma.fsf@gitster.g>
References: <20250803150059.402017-1-me@linux.beauty> <xmqq8qk0fjma.fsf@gitster.g>
Subject: Re: [PATCH v3 0/2] rebase: support --trailer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Junio,

 ---- On Mon, 04 Aug 2025 00:35:57 +0800  Junio C Hamano <gitster@pobox.com> wrote --- 
 > Li Chen <me@linux.beauty> writes:
 > 
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > >
 > > This two-patch series teaches git rebase a new
 > > --trailer <text> option and, as a prerequisite, moves all trailer
 > > handling out of the external interpret-trailers helper and into the
 > > builtin code path, as suggested by Phillip Wood.
 > >
 > > Patch 1 switches trailer.c to an in-memory implementation
 > > (amend_strbuf_with_trailers()). It removes every fork/exec.
 > >
 > > Patch 2 builds on that helper to implement
 > > git rebase --trailer.
 > 
 > Try running "git show --check" on this commit.  My attempt found a
 > handful of whitespace breakages ("indent with spaces.").
 > 
 > Thanks.
 > 
 > 

That's a great tool, I wasn't aware of that command, and I will fix them in
Next version. Thanks, Junio.

Regards,
Li

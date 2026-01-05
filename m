Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974B62DAFAA
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767646807; cv=pass; b=os6yavBGFSIoV9KXL+Kv5kkhL92uagT1Ift2U2FeytHvvJ0RF8xextXNUmbW7ZgyuChFOmSgeFGKDTr5TAoJys8cKc0rzsWPHG68VsLhWK9M74Y01yPXxQaXYze4UL7Y2Uks+Uf7ouQEmj51J8eBUrc1ALQB0xj0xzJYN8JXom4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767646807; c=relaxed/simple;
	bh=bDqWXAtfSiYuoxWMtzRrvXu+OewVZME8KTzeLOuZ6jg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BqbBOH+lKHLAZ3Jz5LQaQsh/+ZTeBZQtjZ8OfoLHP6or/ElG1JhzKZ73jfsQBJR2DL111Yt0CUqZrvrpRsSmfqHxq3NYGlSH7tPbUKOXsCD1/XhSMZygM8dQKhddSR8nEo+c5+Xu12BhDyNNRJpeggOkHC/c0Huhznzu+swCu90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=WSm1QO3h; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="WSm1QO3h"
ARC-Seal: i=1; a=rsa-sha256; t=1767646797; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PdwoCVnxKSnpjBOeicg6kyq1zEBP5RAjHvvQZhjoNtOIpcYS7G3yFlUG+aRT8dCdtNGBg/XFZ9f5SVGEkQfR8mg6NKPIOdk8Ep8YVwS6cO2WjJHruVrnmYgYz4FT+TEfLflPID4b2vEZiJb+JEp5fmupnPG5zKzWpuM2L1OCMWo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767646797; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UsCDozsdVZM2p8luoe/DdRt4zspNZ1JQnhA4CAlRQ80=; 
	b=Zb9A3DEngyo/dlTTs3AYEyHfFp7QZEl0sB5LbmkypJde8AjI27g3/N1VoHa3OAPgXljDUNFgWkHruF76jmC8FOyAvStSiOnwBZR3I0P582zTsKDttcDF4nDydFbg8H+P1UTIUk8I8TKiFABNWDlCrdmw5b7JMF0213ixHe3e/4E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767646797;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=UsCDozsdVZM2p8luoe/DdRt4zspNZ1JQnhA4CAlRQ80=;
	b=WSm1QO3hDqgpl+CGVYeJT2IHyn3PIUm8Bi+f9/hY0jxNDhZ+NfaCgmFiqEUSE4gw
	3uoptb269f+5KPEHhqeZC5On9hSeRkeUNJXgxR9UIiwfXRsgf/dTXgJVLSRMTfEQhdF
	PWssqGuYy2r7DuwKNUdeExCI6G/xnQUl/MR2PjMY=
Received: by mx.zohomail.com with SMTPS id 1767646795466345.48479021271044;
	Mon, 5 Jan 2026 12:59:55 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] ws: add new tab-between-non-ws check
In-Reply-To: <xmqq5x9wpvor.fsf@gitster.g>
References: <20251223132756.604036-1-adrian.ratiu@collabora.com>
 <xmqq5x9wpvor.fsf@gitster.g>
Date: Mon, 05 Jan 2026 22:59:51 +0200
Message-ID: <875x9fai7s.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 24 Dec 2025, Junio C Hamano <gitster@pobox.com> wrote:
> The above is sufficient to make "git diff --check" and "git apply
> --whitespace=warn" notice, but the code change in this patch is not
> sufficient.
>
>  * Colored "git diff" output needs to highlight whitespace errors.
>    diff.c:diff_colors[] tells us to use BG_RED to paint them by
>    default.  At the end of ws_check_emit_1(), when stream is not
>    NULL, we emit the middle segment as-is, but when this new
>    whitespace error class is in effect, that part needs to paint the
>    tab at 7th column between !isspace() bytes.  Introduce a helper
>    function "static emit_middle_section()" to do so, perhaps.
>
>  * "git apply --whitespace=fix" needs to turn such a HT to a SP.
>    This is probably done in ws_fix_copy().
>
> Thanks.

It took me a while, however I now have all functionality working
properly. Just need to cleanup the code a bit, add the extra tests and
will send a v2 very soon.

Thank you for your feedback and patience.

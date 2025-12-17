Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE41A336EF9
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765956646; cv=pass; b=KTkIiWQTY7UaDHyQL4fTKm05fLVvCeH9JBTAR8ehxZruNCLuGL6KW7e2JkEbHQ1p0h0oJ9F5puKRmOIFjt+JiTsH8ATMWqRQPRexA0jQDeGnjVu67g4FQmG79Uq/zTufVn59NZd58D689FbPPdFVv+DgYnAwOl8EQ116nfRTkWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765956646; c=relaxed/simple;
	bh=zUKbztCea/rwSdycPI52X+8JR/dqCywP7qhPgbMEpTo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a2WGyVNGVHsjplWQNB1hBmuN+ckBS/WHNjls31afuUUox2fwuF/yy/acnf27t+wgCmjBlShVupUHP01IL2yFCXrGjuwwu6M51dCKoKawddR7ytldf9kUhcU3ANrXO2n2Ab7DaO4oSvP2vb7U6M0WDMYtJSkYDeNsp7soyKKrl5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=keCv+gMO; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="keCv+gMO"
ARC-Seal: i=1; a=rsa-sha256; t=1765956612; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Gj+Grolh2XQts8mfum1AGhsBOL0zfGuwCqEx3FoY/NksYrYxVATz3p+eLMqDclo85uDBMsOh/ZkkqocdaK52TMkjJ+NupV7ey2sxg3MDdXLLUpb8FfPMRK7d5jluoeag8+exRuY55xngFek62604wj1WA/f+kbmCVRucKR8+qOs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765956612; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=B9ptVjjD3+jSMxMRkw9Mf9IJe1N1uqRZqBCRnt42PHM=; 
	b=U20ivnm7x1BFScL/H0U+Xl/t/DdyysfIjZIkmWZvKcjRIH9uO7CINNogznO3zM6EhO8PBquHgQgVQwxBPvCkHAL8KCmgFHWRceBAcbRuTYUhRNno9s8JSjyUWWTGsu8cWpQPPNu/Y27kzVSMR0LjKilGl+vxF2b85J6MAWkIPmc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765956612;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=B9ptVjjD3+jSMxMRkw9Mf9IJe1N1uqRZqBCRnt42PHM=;
	b=keCv+gMOcL+Ix5mCb/mSAYiGpZ0655Qt2w9ElH69ovYgCJTVt/sT0fSj6A1L65DE
	YSLhS7lj1siLQLbToMKSR5IjUJPa5RW8Wdi2Ww2MhCBRQEqCu5lxnKPmgJmpkOSzOnU
	hNJVWlpbBY1O8HRmeBtD+NipPPa+ihVnFO3ArSZU=
Received: by mx.zohomail.com with SMTPS id 176595661005682.91006064577448;
	Tue, 16 Dec 2025 23:30:10 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 04/10] submodule: introduce
 extensions.submodulePathConfig
In-Reply-To: <y7hfbq37mh2a6rnwvycul2e3fhxl7bljkdlukdpl3obgg57u3p@vgdsj2wo5nab>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-5-adrian.ratiu@collabora.com>
 <y7hfbq37mh2a6rnwvycul2e3fhxl7bljkdlukdpl3obgg57u3p@vgdsj2wo5nab>
Date: Wed, 17 Dec 2025 09:30:03 +0200
Message-ID: <87ecotefb8.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 16 Dec 2025, Josh Steadmon <steadmon@google.com> wrote:
> On 2025.12.13 10:08, Adrian Ratiu wrote:
>> The idea of this extension is to abstract away the submodule gitdir
>> path implementation: everyone is expected to use the config and not
>> worry about how the path is computed internally, either in git or
>> other implementations.
>> 
>> With this extension enabled, the submodule.<name>.gitdir repo config
>> becomes the single source of truth for all submodule gitdir paths.
>> 
>> The submodule.<name>.gitdir config is added automatically for all new
>> submodules when this extension is enabled.
>> 
>> Git will throw an error if the extension is enabled and a config is
>> missing, advising users how to migrate. Migration is manual for now.
>
> This part doesn't seem accurate in my testing. When cloning a project
> with `--recurse-submodules` and with the extension enabled globally, the
> resulting .git/config does not include gitdir configs for any of the
> cloned submodules, yet no error occurs.

Patrick already pointed out in the other patch that I misunderstood how
the global config is supposed to work.

What you point out here is a side-effect of that. :)

I will fix the global config in v7. indeed it should throw an error.

I will also add four test combinations for cloning w/o
--recurse-submodules and global config on/off.

I also missed these cases in the tests I added.

Many thanks,
Adrian

Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C41533122D
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864906; cv=pass; b=AIgvPQVb8YIoafUlxYpUYI2SJDYgCYV3S4CtX87OcvOPxKrsc9vfNaSuBxdK9SRlrE6Kbhr9nYsq3lgzHuwLuJ8/VAs2yEvpeNR8AV8ma0Z/Uy24Yulzez0bZIKnvju8OdpcTc3wRpmhFbJMJQ3iIWOqx52QV7DyCquV3TpIxgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864906; c=relaxed/simple;
	bh=qXKP6TiT2GyxSBIWKBh/uA4Eu/xyE1xDiPTVlU7LkC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IViyfa0RVnFLCsqvOsb9uuQmXXU8j8W4Pr3JQLKKrXOJwbNTSWp/gUISTNM2laeECPvriaE+hPg4aICy75zem18v1R957Uy2+t4gtJdGgTg6OUqkrSBtJezqH3JjZlhRap7EIg0/br4sjSSBsypi7sPW0+/CAAsZYOmCg5ruF7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Xr4OLiCO; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Xr4OLiCO"
ARC-Seal: i=1; a=rsa-sha256; t=1762864887; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fXAthQD5HG2+DrzpN/wjiYKY4PbOcy7yuttj1d017S1XjvwMD2ZaUfV0jMNeuTY79kNv2wORbDUf9+8AQzcTe9vn9aL+o+EurpXl5VBE8T1aXELslNEsjjAqcoRvL3MQONRUDpkvf49t2s/7ff/PJ62flUC4/cZSLiYcZz/uO74=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762864887; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4cSFlPhlMTlBLmQpBqFQrlHMHwxDUdiJ9kSkbFqePnE=; 
	b=buRLKCeEmcNvqr8KIe4xPANC79mt9+7q2c+tScLJU3WWyOT05wpdp5rGHrnJ+REP+2pf8uI8ESHyzh2m8pDNQhZyzWGboFP83XKFBpxQNisaExNF+UceBlK2veoEOUHBcc1PPEiqW7YhhmkkCjAF9+lc20C/kHPkhNcqdG10XVg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762864887;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=4cSFlPhlMTlBLmQpBqFQrlHMHwxDUdiJ9kSkbFqePnE=;
	b=Xr4OLiCOfdeZlvWttyWjUfP+HBP7JsKjW5rrmHfTYXcUoc+50AR+50JcUm0ihCWq
	P+g4jmiIio3Vs5eHAgZIa/OktEHHRA5fBHCN/YY7oKc9O9/+IUwR2bzAbX2AXRrD0AY
	NL7xO7xWhemCLOG5RWRbptUurKc5ckh8VKQ/tXHI=
Received: by mx.zohomail.com with SMTPS id 1762864885724715.2595592490744;
	Tue, 11 Nov 2025 04:41:25 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Aaron Schrab <aaron@schrab.com>, git@vger.kernel.org, Emily Shaffer
 <emilyshaffer@google.com>, Rodrigo Damazio Bovendorp
 <rdamazio@google.com>, Jeff King <peff@peff.net>, Jonathan Nieder
 <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 4/4] submodule: fix case-folding gitdir filesystem
 colisions
In-Reply-To: <xmqqjyzxxyt0.fsf@gitster.g>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251107150547.3272180-1-adrian.ratiu@collabora.com>
 <20251107150547.3272180-5-adrian.ratiu@collabora.com>
 <20251108T182050Z.vbNv4y2kizC1@fnord.qqx.org>
 <87ecq5ke2m.fsf@gentoo.mail-host-address-is-not-set>
 <xmqqwm3xzots.fsf@gitster.g> <878qgdjxvc.fsf@collabora.com>
 <xmqqjyzxxyt0.fsf@gitster.g>
Date: Tue, 11 Nov 2025 14:41:20 +0200
Message-ID: <875xbgkahb.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Mon, 10 Nov 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes: 
> 
>> I tried the mkdir approach. Unfortunately it does not work 
>> because  submodule_name_to_gitdir() is called on all submodule 
>> paths: both  existing or new, valid or non-valid. 
>> 
>> So if a dir already exists, we do not know if there is a 
>> conflict. It might just be a normal valid path verification of 
>> an  existing module. 
> 
> Puzzled.  Wouldn't that only mean that submodule-name-to-gitdir 
> is a wrong place to see if the name of a directory you are 
> planning to use for a newly added submodule is available?  IOW, 
> don't you need a more specific new helper function and perform 
> the check in there? 

I thought long and hard about this in each version since v1 and 
keep coming to the same answer: we need to do it here and can't 
avoid it.

The reason is that submodule_name_to_gitdir() is the unified API 
where submodule gitdirs get computed consistently and validation 
goes hand in hand with computing the valid gitdirs. If you look at 
all the places where validate_submodule_git_dir() is currently 
called, it's always immediately after submodule_name_to_gitdir(), 
on its result.

It even makes sense to remove the validation calls outside 
submodule_name_to_gitdir() and do it inside it for each path 
attempt, like we do for the encoding cases, so API users don't 
have to manually validate the result each time. 

This reminds me: we should also validate the gitdir path we get 
via the submodule.%s.gitdir config. Will fix this as well in v5.

Another related question I've been pondering is whether to create 
two separate validation functions, one for legacy and one for 
encoding.  It doesn't win us much (currently we return early if 
extension/encoding is enabled in the unified function), but we can 
do this in v5 as well.

To recap, what I intend to do in v5 (up to now) is:
- Address Aaron's case-fold corner-case of creating Foo then foo.
- Address Junio's case-fold corner-case of creating foo + Foo + 
  %46oo.
- (Important) Also validate the submodule.%s.gitdir config value.
- Move validation checks inside submodule_name_to_gitdir() to 
ensure they run each time, instead of having API users validate 
the gitdir result each time.  - (Undecided) Split the validation 
function in two for the legacy vs encoding/extension cases.
- (Undecided) If all our path attempts fail, try hashing the name 
and see if that works before erroring out.

Especially if we implement the last point with hashing, the 
chances for conflicts are close to 0.

Here's an interesting idea:

Maybe it's easier to just hash everything when the extension is 
enabled since users now always have the submodule.%s.gitdir 
config, which is also accesible via the submodule--helper?

Hashing + config would eliminate all this corner-case 
complexity. :)

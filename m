Received: from smtp.rcn.com (mail.rcn.syn-alias.com [129.213.13.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26C13398A
	for <git@vger.kernel.org>; Sat,  3 Aug 2024 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.213.13.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722673146; cv=none; b=tRJQIom9JurVrTkmmX0BVppCvrgl8shwapLYX+l6uYfFHlezVhApRXuoWfpv5Oikk3eKXj/CUMyEoZqbJvPUh6VsIHlILzKbRvizkUj3dP5ix2Xz0u9xw7kCU1Oo1hF5iYSTBrN+ga3hu28h4OdVKB2JsdlKlC9prDnbmvkcdVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722673146; c=relaxed/simple;
	bh=aRiuYEZ9HXgfvtGekkEPj8WvPJ+8HknBJCYtH96hOG4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=INhaJkNi4L07VXCn9wEQYwb9PQO+1lgUZeezFkxJTJAgv/pip0sfv5ct8Nc0NfjPx1ZGMOJ/6Gf08tdG6XLT1Ppi0xr1KgfCgJS5Cnn+hz4pHW1kjLTJhmHQBD6rtBxfrusNDFNtcZeCvuJyaTXfRpT9ucWYI+P6pE2AxzVoIZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scarborough.kim; spf=pass smtp.mailfrom=scarborough.kim; arc=none smtp.client-ip=129.213.13.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scarborough.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scarborough.kim
X-Authed-Username: Y2hvd2Jva0ByY24uY29t
Authentication-Results:  smtp02.rcn.email-ash1.sync.lan smtp.user=<hidden>; auth=pass (PLAIN)
Received: from [24.148.58.81] ([24.148.58.81:40862] helo=[172.22.22.107])
	by smtp.rcn.com (envelope-from <kim@scarborough.kim>)
	(ecelerity 4.4.1.20033 r(msys-ecelerity:tags/4.4.1.0^0)) with ESMTPSA (cipher=AES128-GCM-SHA256) 
	id F9/94-00700-043EDA66; Sat, 03 Aug 2024 03:58:56 -0400
Message-ID: <bf5a7771-f616-47d9-a014-f9d3e0afaa08@scarborough.kim>
Date: Sat, 3 Aug 2024 02:58:55 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Kim Scarborough <kim@scarborough.kim>
Subject: Git and gettext
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Vade-Verdict: clean
X-Vade-Analysis-1: gggruggvucftvghtrhhoucdtuddrgeeftddrkedugdduvdekucetufdoteggodetrfdotffvucfrrhho
X-Vade-Analysis-2: fhhilhgvmecuufgjpfetvefqtfdptfevpfdpgffpggdqtfevpfdpqfgfvfenuceurghilhhouhhtmecu
X-Vade-Analysis-3: fedtudenucenucfjughrpefkffggfgfvhffutgfgsehtjeertddtvdejnecuhfhrohhmpefmihhmucfu
X-Vade-Analysis-4: tggrrhgsohhrohhughhhuceokhhimhesshgtrghrsghorhhouhhghhdrkhhimheqnecuggftrfgrthht
X-Vade-Analysis-5: vghrnhepgeevfedutddugefhfedvgeefleetkeehfeduvedtleehvdegvedtjeffffejteffnecukfhp
X-Vade-Analysis-6: pedvgedrudegkedrheekrdekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvght
X-Vade-Analysis-7: pedvgedrudegkedrheekrdekuddphhgvlhhopegludejvddrvddvrddvvddruddtjegnpdhmrghilhhf
X-Vade-Analysis-8: rhhomhepkhhimhesshgtrghrsghorhhouhhghhdrkhhimhdprhgtphhtthhopehgihhtsehvghgvrhdr
X-Vade-Analysis-9: khgvrhhnvghlrdhorhhgpdhmthgrhhhoshhtpehsmhhtphdtvddrrhgtnhdrvghmrghilhdqrghshhdu
X-Vade-Analysis-10: rdhshihntgdrlhgrnhdpnhgspghrtghpthhtohepuddpihhspghnrgepthhruhgvpdgruhhthhgpuhhs
X-Vade-Analysis-11: vghrpegthhhofigsohhk
X-Vade-Client: RCN

Hi folks,

Was wondering why I need gettext to compile git, even if I tell it I 
don't need NLS. I've not needed it to compile anything else. Is this 
really necessary to run git?

If it *is* absolutely needed for some reason, can at least the configure 
script give a warning and error out when msgfmt isn't found, rather than 
letting you go through two-thirds of the make before crashing?

-- 
Kim Scarborough

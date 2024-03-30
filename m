Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFCF36AEC
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711811370; cv=none; b=BPUH9Pk25c+/4gUFbdL+X4VyPHZqxH7ex6+8IhCY09VLFLb+0ZzXpHwyuSUO97C8lYBOGJ7qwGTsYHEUWwQcHj20rqC54H2KCAQRqk+s1y8Qko1HhWcqc9KjWlQZLhtey0bPq6dqphyVQBEpXCNIGy1P06UXy2kZAB7xCtp/LJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711811370; c=relaxed/simple;
	bh=ide6aBaz5qmEZoSo3IA1yH8LM90dPczMnvPYarYKh+I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=I1sZp+oWhxtCZFoDGt0EMhrxRE9tmwd4pQqefzRRkKE5otLmvs5kNcGWGdRhGqNHQQZi61SENV8/4SKIe4PTmfjqAVDckm4TWvwQpswzAllYYCCCAwHXDTwn5YQpCzD+Vmpu6GIY38pFJAsuGGCnVM35aQ3h10WHz+cYElR/QAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr; spf=pass smtp.mailfrom=online.fr; dkim=pass (2048-bit key) header.d=online.fr header.i=@online.fr header.b=eH4dAbt8; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.fr header.i=@online.fr header.b="eH4dAbt8"
Received: from [IPV6:2a01:e0a:122:9f40:dcc9:6f7:4081:991a] (unknown [IPv6:2a01:e0a:122:9f40:dcc9:6f7:4081:991a])
	(Authenticated sender: thomas.koutcher@online.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 9269B2003BE;
	Sat, 30 Mar 2024 16:09:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=online.fr;
	s=smtp-20201210; t=1711811358;
	bh=ide6aBaz5qmEZoSo3IA1yH8LM90dPczMnvPYarYKh+I=;
	h=Date:From:Subject:To:From;
	b=eH4dAbt8QXLtOKiLySTsJ7IkBgx6D0QFED/eltCM0gNqk7ZUMfd9voaYiBq5Jx8Yc
	 Lh+yTs59aKlOOWT01ji4X4XDIkWVv7rG0aydqOF4Q5SZcsqAc7akkr1BPQO06+9wdm
	 yNPlUx6xK2z89qmm/AbOM2sjxCLoSG0XrgDMPtdI6DA3rVhq8Rp5E3f/WpH8P2Tpxe
	 8PSV8eNTUXs9koAZRic9o1Yu5cPekzTMycCPampnQgxDgRwfOxsAJwfnxhZL3RsEtE
	 1Fx9RvwheaNVFrcVsXNkZjyLMYB1JlnU5xpzfDXX/jZng3uI64QJkwo50I7/eR2B2e
	 HqFN8Q5N7yTRw==
Message-ID: <c94a0b01-549e-4dfd-a01c-77a512c04bb5@online.fr>
Date: Sat, 30 Mar 2024 16:09:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Koutcher <thomas.koutcher@online.fr>
Subject: [ANNOUNCE] tig-2.5.9
To: git@vger.kernel.org
Content-Language: en-GB, et, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I am pleased to announce Tig version 2.5.9 which brings some improvements
and bugfixes. See the release notes below for a detailed list of changes.

What is Tig?
------------

Tig is an ncurses-based text-mode interface for git. It functions mainly
as a Git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various Git
commands.

- Homepage:https://jonas.github.io/tig/
- Manual:https://jonas.github.io/tig/doc/manual.html
- Tarballs:https://github.com/jonas/tig/releases
- Gitter:https://gitter.im/jonas/tig
- Q&A:https://stackoverflow.com/questions/tagged/tig

Release notes
-------------
Improvements:

  - Update utf8proc to v2.9.0, supporting Unicode 15.1.
  - Also use lightweight tags in the Refs line of the diff view. (#1235)
  - Support %(text) in all views with a text column. (#1275)
  - Use HTTPS for GitHub clone URLs. (#1310)
  - Move default log view options to tigrc.
  - Allow to go to stage view without Enter. (#1284)
  - Add new "prefetch" reference type for refs created by `git maintenance`
    (hidden in default config). (#1318)
  - Show the selected commit in the blame view title window.
  - Improve the blob view experience.
  - Clear keybinding from all keymaps (unbind) with `bind generic <key> 
none`.

Bug fixes:

  - Fix "dangling pointer" warning. (#1268)
  - Don't use array size in function arguments. (#1269)
  - Fix rpmbuild -ta. (#1276)
  - Initialise struct timezone. (#1291)
  - Fix NULL dereference at startup. (#1293)
  - Enforce a blank before view scroll percentage.
  - Fix refresh-mode periodic not updating branch labels. (#1270)
  - Fix display non-ascii character. (#1299)
  - Fix readline echo when stdin is redirected. (#1229)
  - Fix tig blame --reverse. (#1300)
  - Fix status view lockup.
  - Fix untracked changes and chunk staging behaviour in plain stage view.
  - Reset state variables when selecting a commit with no reference.
  - Fix parsing of `git ls-tree` for submodules. (#1282)

Thanks to everyone who contributed (in alphabetical order): Abhinav Gupta,
Armin Brauns, Conor Lowry, Jakub Wilk, Johannes Altmanninger, Kimihiro 
Nonaka,
Pavel Roskin, Thomas Koutcher, Wesley Moore.

--
Thomas Koutcher

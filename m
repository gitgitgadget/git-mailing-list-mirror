Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672951FA3
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721265212; cv=none; b=Rvg1sVqeL+4NamYJwcYkXsGiK6xx5HCruMetxSAxztzQzT+WRWnB72RCPRHiw0kL/Na/mTbJ3PqEeNtzM4SQXO67ky8JGlk2m2D5enLQdMH2blp3nx2QSyWV53WVuDegsyic/ED9uxpsx2xOc+9AM9OC3qoFombLWGZ4I4mnOo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721265212; c=relaxed/simple;
	bh=W5Z1SjLhdhz5BeLB95ZiB5SvfR9A97E/fEZxzHPdeqw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JSRMJIUpPC8sjVZ0IahpN4ubYgNGhf22fTvXEcpPI+Xdg/KAI9jJnkqOLcP5bTAJzx0orvJTEN04zKQuEC1zzjN6MKHONReJ9pvaMWmfTTNbYU27Et2kIjvah66pLXiCAChdCcFE3qTLfQqBW2RMTCx9dHG8Z4njkSGTT3ljbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Ut3HBfex; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Ut3HBfex"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id UFi1s5yvOX9c9UFi3s8mT1; Thu, 18 Jul 2024 02:13:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1721265207; bh=4z1SiHt+YYS8zJYAQbOyL7NCdh77Nm3H4VwpOGsgL2E=;
	h=Date:To:Cc:From:Subject;
	b=Ut3HBfexvjo3OtofSvJJBFAHHmaK0VDLJQTm5nbyVG/Lpw/TeXIjUwZGzWI19/0Ur
	 YybMMEyzXpCGxEjgx9yfSQwI5dJsWyD8TuTQXQGsfAVGhrzMA10E1oH+zxtZe/Th9x
	 ivXA3+L101H5cYwnbrOnQ1/E5QTkBNq+V/eYshlBvrr18+giRhQvKVwxD0CuAPvpc0
	 LA6Y2LlbHxM7Rb2T72SVbyITKGpFIiIlzz19EzfxmffMtrk6hxW0X7hfq+eCkM+B7r
	 hIMg7Lr19LuJ9nXtmMCqRtsw4K+dLX1mzIyJI8JlNaj3M7ebhp8YB3OGEgTFjH10//
	 qnQmgIf/c4ubQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=NPx2+F6g c=1 sm=1 tr=0 ts=66986c37
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=_cSnwP3T9S7IVaP6OmkA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <0d132370-3e07-4332-bcfb-c4450100d736@ramsayjones.plus.com>
Date: Thu, 18 Jul 2024 02:13:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: config.mak.uname: remove unused uname_P variable
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBU/dxCQDADXjS7jfvCoXZWIyCveBKoEES73BwAXNB57d2CNE5pRBc2tojmaswelF8rgcl+zYG1VCMIb01w+2KbQ8646ljtkUeA9OoGu3epJjaYrAf1/
 TkWXo0VQ/BVM8rvDQEe4AErNMXdbSfqolh3+sIofj8KFx1I5KVyHQVH9cvDN4PaEQ5ClJ89/Gx5VVZDJOlytUhAmlaNc3ZFAymU=


The uname_P make variable was added in commit e15f545155 ("Makefile
tweaks: Solaris 9+ dont need iconv / move up uname variables",
2006-02-20), but it seems to never have been used (even in that original
commit). The man page for 'uname' notes that the '-p' processor option
is non-portable (the 'uname_M' variable is used by the Makefile for that
purpose).

Remove the unused 'uname_P' make variable.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 85d63821ec..aa0fd26bd5 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -8,7 +8,6 @@ uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
 uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
 uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
 uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
-uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
 uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
 
 ifneq ($(findstring MINGW,$(uname_S)),)
-- 
2.45.0

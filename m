Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F45EE65
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839097; cv=none; b=l01I3nuWDbrPKsjtcD1vw0UPOMPO9vcRDA5F3UFz4PQIVcS6LO2IavMF8ij+YJou676xjQK2q7o2lbRM83wZEv6mOAkrUURbDEj2SbdW1OXlaH04hHaDYXe2A8PHMtpvrwjz44denpJD7DwMiuoJGnf1feQZv5y5PzPUgt8BZv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839097; c=relaxed/simple;
	bh=1Yu50JOFHtpxEAW+iuQGMzip2VqwmBIllxyy8e216r8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=MkNkEiqkMMsdW3LqyuIsbrf3r1Pz80PpcTU1UYW3qTZKa3yHAGjJwZDw35oxTJTOXWQX7ZvkvGChxgHk6qay1umuF0loiCbZZqWMSlHezrB5b/3mMmdKHqC3E6Nvc1SzC6ZUSHqbvA4HYJ1I9x3k9DXDdEuC35tvR7/SeGlDVQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTau7LAP; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTau7LAP"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42c0960382eso30351951cf.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 07:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707839094; x=1708443894; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H06pcSVKHFygAYeqmHHJWoCS8fUwx4qCDRLToByLvuI=;
        b=YTau7LAP7OifUxoGAIarfhIarxal99COV2M4YLq6Cpzcd+Q0CeaNDG0n//EV1hc5S9
         fZBhsSdAkrj52nUVToS1wETdBFds01CFrRys2/rjZpGlmNQidTYkd7UbIwBKbnOkUslh
         ag+p+E2fUCx2v/dEICHkwY/kehfKjRu53YtBODXke8IWAuAqwr5cmIrAMR2FkZx5Ocfj
         LS6cocHKplApz2rJGWkvCtJXQWcTPy7u2oSVFdBYJFpkzoYunbyMKSSAxzOEpXT9pBm2
         l3MaPcGtbXpF5D5BTQb7muThN4+kQ192DN9vg7zv98LuzbElYylGsgsmrG3yOIYdCWpe
         IIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839094; x=1708443894;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H06pcSVKHFygAYeqmHHJWoCS8fUwx4qCDRLToByLvuI=;
        b=QzclHE7IPqKBAk0/p1vomED3H0WMdMgVBVQ1hNv2HKVFTh1QsrkuFaBJYanJy/Rq4O
         75Syz5J7A3Evxu/E1ArtDwOIfxxgcX5jFXTHsgL8txW+0C4oLW1h4iW9xbw/tca1Wc8F
         qPZ/OkTNKtq/uSzmcYnUD+DEcxDOddoiZl1yC7k038Xc7cTbbmrIJokAhcJ7aQ+nuP9p
         1808KuDYsC+VRO8w0Y2MyjBpR4p/NHDStEPAdG06sF5eo+/m7W5Ki7UlLvD4KurbBV2p
         pErV2xMMxiu62HiR15qzbGLEQTA4LYiwD6UEXcmm0IsvP0a5Maf4Yq+T8+Pe74Mvi2/I
         B3Hw==
X-Gm-Message-State: AOJu0YzzjmWFaWwXG5MyLSy/SIrTK33bQKnsroFe+ZoNR5IrXdPSsDKL
	w/1NsBUeHGheFpOM6mBOzdZD8QIJPU1jbfdLC1XX5QsN4fkdIcNnU/SyxfQL5zw=
X-Google-Smtp-Source: AGHT+IETv2/R3yXCbywgwDSrDk0QhFCY7aBkljDUd3wcst8k96Sm3IiBqp2TNxXMpbxPPKvKuSXHkg==
X-Received: by 2002:a05:622a:170f:b0:42c:6bfd:daf3 with SMTP id h15-20020a05622a170f00b0042c6bfddaf3mr11475684qtk.26.1707839094077;
        Tue, 13 Feb 2024 07:44:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW0Yvusj9/UAu5Hn5G/KtQOlu2Jj9zMNHY6nXYwdei2ye+asUFE2zxCaEhWBq+pYK4GtlX4DeEiwm7kZ0LE66ZsLG95B8mc6mrVHg==
Received: from [192.168.50.62] (88-160-103-158.subs.proxad.net. [88.160.103.158])
        by smtp.gmail.com with ESMTPSA id ic2-20020a05622a68c200b0042c543346b8sm1226869qtb.7.2024.02.13.07.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 07:44:53 -0800 (PST)
Message-ID: <cbb450b3-b333-4391-ac83-66c2daf0ae4d@gmail.com>
Date: Tue, 13 Feb 2024 16:44:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, it
From: Vincenzo MEZZELA <vincenzo.mezzela@gmail.com>
Subject: [GSOC][RFC] microproject: use test_path_is_* functions in test
 scripts
To: git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello everyone,

I'm Vincenzo, a Master's degree student in Computer Engineering and 
Cybersecurity.

As I'm approaching the end of my academic journey, I'm eager to 
contribute to the Git project
and the GSoC represents a good opportunity to do so. Upon exploring the 
online documentation
of git for the application to the GSoC I'm keen to begin the required 
microproject.

Among the microproject proposed here 
https://git.github.io/SoC-2024-Microprojects/ , I would like to
work on replacing 'test -(e|f|g|...)' with test_path_is* .

Can you confirm if this task has already been taken by someone else?


Approach:

As far as I understood, The work consists in replacing the shell 'test' 
command in the test
script under 't/' directory with the ones present in the 
t/test_lib_functions.sh as follows:

- test -f --> test_path_is_file

- test -d --> test_path_is_dir

- test -e --> test_path_exists


To approximately measure the number of required replacement, I run the 
following commands from the
't/' directory (branch master):

> # Files  that requires a replacement
 > git grep -r 'test -[efdx]' 2>/dev/null| awk '{print $1}' | uniq -c | 
sort -n -r
>>    190 t7301-clean-interactive.sh:
>>     147 t7300-clean.sh:
>>      21 t2004-checkout-cache-temp.sh:
>>      17 t2401-worktree-prune.sh:
>>      16 t2003-checkout-cache-mkdir.sh:
>>      14 t0601-reffiles-pack-refs.sh:
>>      13 t4200-rerere.sh:
>>      12 t9146-git-svn-empty-dirs.sh:
>>      12 t7603-merge-reduce-heads.sh:
>>      12 lib-submodule-update.sh:
>>    ...
 >>
 > # Number of replacements
 > git grep -r 'test -[efdx]' 2>/dev/null| awk '{print $1}' | uniq -c | 
sort -n -r | awk '{sum += $1} END {print sum}'
 >> 853
 > # Number of files that requires a patch
 > git grep -r 'test -[efdx]' 2>/dev/null| awk '{print $1}' | uniq -c | 
wc -l
 >> 169

Although the replacement work might not be difficult, it spans over many 
different test files.
Do you want me to submit a patch for each of them as part of the 
microproject?
If not, How many patches do you expect me to submit?

Thanks,
Vincenzo



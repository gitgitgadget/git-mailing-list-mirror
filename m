Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C635730CDBD
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218037; cv=none; b=fbeYPBnLoH5OPEb5J3Jb9L6DvYbRJZmCgL1hudDvOMtJqnZWJY2FGlHM8/ah+P4eOaENaS9Aoe4z0uSYwmhXRHd2JD/Z2vgt9RcQPTKGOwk+qdjlpVd4TqGw9MZPsAIwoV//dArTRhEFeFITiYmIGX/KHKgw8J6WLjCgWJxKDIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218037; c=relaxed/simple;
	bh=43hS5itB6R2jl9iYpqy8LNDbU1YAR0MLggFwQ1x9iLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gq/lVRgmAC+QALQ4QnNSARXO1orcu8EXdzHo1MwN2fYSZmCumOXfAnH63GUmHIyq8J+nDlaWQ3WKcMmHwY7GdhriRpxCj596hczzp5p0hHFAVoKNTH37hRCyfX9WNIHnHu9O2cbMNUY6eLPp1wM2GbH4RSFXO4StNQGRq1s6y2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlPfCs4K; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlPfCs4K"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-475c1f433d8so5596525e9.3
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 04:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761218034; x=1761822834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qWq3MfVnAt9LPhsoS2gGPHFLqF3h5In5Xktia6nEDs=;
        b=jlPfCs4K53/B6BCEd6Ohv5Sn2IhfzQK2MJSlPpNGdu1cZ7f+nDVbyK2wbo/62ipdzo
         0YlryxT/PPy5h54zmx/OizXijvGB4rS99KDtdLXMr3uKdTRkqYwrMVlDzpF9/KGfopYk
         W5JxsTLmJlOkV7Go+Z4D37Nqaktul/GgYjD2fzRcNdBpqFrM/VUVqH0QZNsQmgALFRyq
         0UxhhXpAHdfAeGE0npqBA39leiaYvfaKHJ6Je4c4gqNGhgInP+b9E3/2DODqKBgCfsDO
         w8e03DLOM/JfJj3wXhLPsFoIDLmHxnOoK5Rrq+kEOndKnKvgBDH95fuTWR8K0SIUIP6c
         SLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218034; x=1761822834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qWq3MfVnAt9LPhsoS2gGPHFLqF3h5In5Xktia6nEDs=;
        b=VePBg91soxc2BdG3z56+n30sg6/1VybfXtxqwjTf3pGN6GZzkVa2L2pvyoGOihddBW
         4z0QpCcLDt3pvOeUD6pW5RuIysN85exXUH7yDz8gnKOFRgI6KgBJfkwZMOW0wc0JOoRK
         uZ1VyAW04OfLwwk93QgyljYBjU0thG49PET/ZdT7UjjWM7dtJaNqFIC1wZq4paNQ3JGi
         fpVPiKhTszGBpa6vQWaOrI7lpOMb+RU8W18s4jys1JJ1hPYyMbm5jFMy9drU+N52askF
         rYfKlWzqz3lCtCGVjcxe7ozQgOfIiEGkL3gpWoj6TAwb3oXJWF5C9frMLZHLjcsNij+r
         ESDQ==
X-Gm-Message-State: AOJu0YyVAc67Jdij4eA8drmj/t+4/jgta0xejtROGzhk+YqZNDDADu7J
	Pzj3DtT1Pt1xmJJiC6qY3VsPub0r5ReIVLb9u4kkwyF2ofcR5GNqJH5N
X-Gm-Gg: ASbGncuz3AeWH6lp/maqgLgJs5Af3VmsFI28O9Yz6JB0OSldxTlvvlCrG1xTKv4RInp
	eGulCiC1KVCzQwICQdUk0ZWwAj/FvPblPFiI6zmgn8upwws7XHVHbH5mkINEeeT90vFO49ENe9z
	2sCVqwmxMZeR9fbT7njbv3gld06i4rgUK56x5XydrUOjfzUWzfTXp8KAF1K7r6j4ynGNlHSi2jf
	Wkkdv90MRf2Y3OqrS7+SVYXOTiQSdpqfFEnFYMsqIkKcCyu0kOEkMunpllTD3MVZhMSFkmG7TdF
	8MAkDmmfeoQGwDrJ2rnVuKCHlSAyWlKReTB5wXmbSvcAbV/VGVg1mPHPJGpTAPzzzT6yJR05ll5
	yWym1pBXBPg7TzgJqYoomKjooIp5lhwmQwqB8wQU970RyWA33Kn/5iQHP5MDV44t/+kedxPlssH
	YVW7c=
X-Google-Smtp-Source: AGHT+IGX1embqzBdTTiCULhURu3TpemTLMc+17lS7XHRI0yeQTDnOJoIqfxMT1pKQIXuJkbp/HrSMw==
X-Received: by 2002:a05:600c:4e11:b0:471:c72:c807 with SMTP id 5b1f17b1804b1-471179079c7mr190607265e9.22.1761218033920;
        Thu, 23 Oct 2025 04:13:53 -0700 (PDT)
Received: from ubuntu ([105.117.6.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428f709sm92559525e9.8.2025.10.23.04.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:13:53 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v6 0/2] do not use misdesigned strbuf_split*()
Date: Thu, 23 Oct 2025 11:13:45 +0000
Message-ID: <cover.1761217100.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.51.0.463.g79cf913ea9
In-Reply-To: <cover.1761135129.git.belkid98@gmail.com>
References: <cover.1761135129.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch series by Junio Hamano with link below,
https://public-inbox.org/git/20250731225433.4028872-1-gitster@poddbox.com/,
notices that the array of strbufs that calls to strbuf_split*() provides
are merely used to store the strings gotten from the split and no edit are
done on these resulting strings making the strbuf_split*() unideal
for this usecase.

Commit d6fd08bd (sub-process: do not use strbuf_split*(), 2025-07-31) for
example, in the series, observes that the subprocess_read_status() reads
one packet line and tries to find "status=<foo>" by splitting the line
into two strbufs which is an overkill to extract <foo>.

This series continues on this cleanup, by replacing instances of
strbuf_split_max() with strchr() to get the required token around the
delimiter where the token from the split is merely returned as char *
and not strbufs and no edits are done on them.
This makes the code cleaner, faster and more efficient.

Tests have also been performed on the commits on Github CI. The link is shown below

https://github.com/git/git/pull/2080

Changes in v6
=============
- Modify commit messages to have proper structure
- Changed logic in get_default_ssh_signing_key() to use xmemdupz() if
  key has '\n' and xstrdup() if not.

Olamide Caleb Bello (2):
  gpg-interface: do not use misdesigned strbuf_split*()
  gpg-interface: do not use misdesigned strbuf_split*()

 gpg-interface.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

Range diff versus v5
====================

1:  df8fbbd3a5 ! 1:  92fc78c203 gpg-interface: do not use misdesigned strbuf_split*()
    @@ Commit message
         gpg-interface: do not use misdesigned strbuf_split*()

         In get_ssh_finger_print(), the output of the `ssh-keygen` command is
    -    put into `fingerprint_stdout` strbuf.
    -    The string in `fingerprint_stdout` is then split into up to 3 strbufs
    -    using strbuf_split_max(). However they are not modified after the split
    -    thereby not making use of the strbuf API as the fingerprint token is
    -    merely returned as a char * and not a strbuf. Hence they do not need to be
    -    strbufs.
    +    put into `fingerprint_stdout` strbuf. The string in `fingerprint_stdout`
    +    is then split into up to 3 strbufs using strbuf_split_max(). However they
    +    are not modified after the split thereby not making use of the strbuf API
    +    as the fingerprint token is merely returned as a char * and not a strbuf.
    +    Hence they do not need to be strbufs.

         Simplify the process of retrieving and returning the desired token by
         using strchr() to isolate the token and xmemdupz() to return a copy of the
2:  5df667227b ! 2:  e52855242c gpg-interface: do not use misdesigned strbuf_split*()
    @@ Commit message

         Simplify the process of retrieving and returning the desired line by
         using strchr() to isolate the line and xmemdupz() to return a copy of the
    -    line.
    -    This removes the roundabout way of splitting the string into strbufs, just
    -    to return the line.
    +    line. This removes the roundabout way of splitting the string into
    +    strbufs, just to return the line.

         Reported-by: Junio Hamano <gitster@pobox.com>
         Helped-by: Christian Couder <christian.couder@gmail.com>
    @@ gpg-interface.c: static char *get_default_ssh_signing_key(void)
      	int n;
      	char *default_key = NULL;
      	const char *literal_key = NULL;
    -+	char *begin, *new_line, *first_line, *end;
    ++	char *begin, *new_line, *first_line;

      	if (!ssh_default_key_command)
      		die(_("either user.signingkey or gpg.ssh.defaultKeyCommand needs to be configured"));
    @@ gpg-interface.c: static char *get_default_ssh_signing_key(void)
     -		if (keys[0] && is_literal_ssh_key(keys[0]->buf, &literal_key)) {
     +		begin = key_stdout.buf;
     +		new_line = strchr(begin, '\n');
    -+		end = new_line ? new_line : strchr(begin, '\0');
    -+		first_line = xmemdupz(begin, end - begin);
    ++		if (new_line)
    ++			first_line = xmemdupz(begin, new_line - begin);
    ++		else
    ++			first_line = xstrdup(begin);
     +		if (is_literal_ssh_key(first_line, &literal_key)) {
      			/*
      			 * We only use `is_literal_ssh_key` here to check validity

--
2.51.0.463.g79cf913ea9


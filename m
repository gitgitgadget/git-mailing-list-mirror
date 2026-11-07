Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794041411;
	b=A5dvSJjYaYo6LfbEyUR1DAstGoTFJPPttfq4aMZPXSxnidbdnvgw3h7lHLbBNWcg73GV
	 soDUnxtcDyIR0cMf6R/2k1Dd/sepjxe/3l6079rIIIPF0j6DqyCBqiMc36oiIaI+pQdiS
	 Lmsf3lqW0ZF1lASlRNB7odGbDXJ7I4ac5L50nxsQkzX06YCpMO7GsGkQ22pLuzBGlLsmx
	 TkAkhQBnAFte/vf171969E35Z7AG8E9xX1lR1uDZm8YnfVQmtmTIUF38nur/c2YQP81Oo
	 whO0Ddqg37mvJovi5p7xC/kC+lnZF67CYA7rTNxk9eMOkrkFKB7cLC03dIQv/u/5ANg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794041411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=awNIEBCtn9PsoqbdLjkT43NcFHeP7WzO0WxwxFS6PsI=;
	b=ROx6sY0ItsSs/UrOfwjOH78apbDjDCo734WxQtrRSJV1djjAdAnWWy+oFs8H3NdViAzI
	 NJUsJvFfk8lkwX8MaxRXwpS5iK0AK8xWsDlk+8Xsq2L4wVdSzEFEheYAMipUb9D2jYMWX
	 uNyBMzl+L1zzZFKIfvKvUoWvlZexDuH8yJTER5/MiJPJH5xbfmb8PYsAE+oDnajL6/AZw
	 f42XWEnVjZeFzwcMDpHY+eKnfe1FVUx2UUIBLsX7GnetyUII/hewPk9+aMxA/wj3mJZlN
	 Ux+hdgWxHDHRITn2XpHJfoovxGoYYH0D6IcPtRpg3zCtck/lK3ao5BFf+VKotBdkCdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ByVEcOZo;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84380606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 08:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84380606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ByVEcOZo
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dee593f18so1105276f8f.3
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 00:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794041410; x=1794646210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=awNIEBCtn9PsoqbdLjkT43NcFHeP7WzO0WxwxFS6PsI=;
        b=ByVEcOZobc8V1GEp8PGE39N2DxKuvQIThcyEUfwqRfLcZlh57wCpXi8f4JiL04K9J5
         MrXP9GZhlMdFq5Fk7skMI4rUIxunMLgqRxpuutKLRFn/E50CPoFYTJmUfcdLwdw1Oa+Q
         ObfdtttwFqhAxIbE0tnPqLKZnJ8fWMHnfDy2dyIDoS20LQwqE0m1kfJOHXNg+eg5xl8n
         wKSPNp9C6XCcM4bhDH2lfch5YWkAurZHNoKTnHLS8/geRDCv90rBx0ch/DGyLx0j3KbK
         aCNFQD5eg2NS9GibAgNSLaZXmzEfzsgEOamCg/ENqRLmsvUYFfeHd7lZH48m+wZUXEMc
         nQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794041410; x=1794646210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=awNIEBCtn9PsoqbdLjkT43NcFHeP7WzO0WxwxFS6PsI=;
        b=WmU1pxsxgaWcE+X9OjIpqS9ui861lLV/AkrfkbBr0z/QQ7Il0UZ07tFk4Ri4ENpMRL
         8FqXMe9dGFxnZobloe69uQoi/DARP7HbRIAH9gV4Dt1jIp+z00qX2mcykETso7e1R8TW
         8bwPCR6pMBtbHZy6XTmy4qHBcKYRk//8HluWHbxG0Lb492VE0Oc/wHNYAfVyjxXGFTkJ
         aeakBjiIiU25fpCo/3CG7bpeVikrFbJszqkjWb+YIMuJnWJS1lnDUTflfA229/zs8BM6
         QZmJC39vWafT3NcFdVr4k7zWoa+aAJMbO9sC2V1w6u+F/7kxWlh00mRfP30lWXoqZbY5
         /n1Q==
X-Gm-Message-State: APuU4Z+UTlcjp18Ni63k4yQt/f5uk2OWg+bK4ybJOvtqsZaqr3x+x1MA
	eKacwnLKmxrRF8AvR5zT0/lE63J95a7qyFUH6KEcCfirUwI2dTZt7PE+
X-Gm-Gg: AYBFou2Ou9Rr5iwm2V/qdlLoQ476pCmch1BrZdzTov1FDyQ5EHi2CysIM3JJY6q0yi/
	QlV5+DpvlW5XhWPt4LGgKC/3PBJ+Xh/AdbjZVth2udLgZyaRSQJFK9orC9mhlAqhZEPxY5+XEvn
	FjhHJLrtP5YCPjaB0/9qGTDTtzgYbJwDkmsuyoZt/Sa5lYRXI3mtnk2/IkcPioyPaQGs0vVrxe5
	Q0aTGTetUFw9K3XXY3MT+NzdjzDQJN+/BZWGugyZFFobBEPeXPd0S3v10nAMuwfVPCcNBFRvJoP
	Sl0sZpk4tPnxr1O6IKU3XfQVdb+x8t5NuMOwaZJDXkAq1KpeCypqXk5yEJWQwljPOfQQcTL89/r
	HmK/YXhbAZ8FphwT+HWChjGreU28qlnvi+AhDyAG1U8krPZyYezUu6TF/9rL9hTJ1XZwCF+tkq+
	PEJ0pJdtpNNTyGTSpkpKGhWQZBRuFPKy0Rh/GK4qmcaljbjsJNGA+bt05QESaZXZFBfLAdcr8Xs
	k3iOLEu7PLfaJK8/1VZRbaUc9LVuNOf6Pw6qmItA1IFCuXAkseodvl2hJOqWff3PwMCn8ABVbqZ
	VhiUxaTVGlPmRC44qNWosWSk3byn/wZCEJOCo5nrrseoXae3xq3n
X-Received: by 2002:a05:6000:4b07:b0:48d:fd4d:7fbf with SMTP id ffacd0b85a97d-49273f500e5mr9381800f8f.4.1794041409656;
        Sat, 07 Nov 2026 00:50:09 -0800 (PST)
Received: from GODS-GIFT.localdomain ([197.211.58.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49354fc5ab4sm6016450f8f.30.2026.11.07.00.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:50:09 -0800 (PST)
From: Cynthia Uche <herroyalpriestess@gmail.com>
To: christian.couder@gmail.com
Cc: git@vger.kernel.org,
	herroyalpriestess@gmail.com,
	siddharthasthana31@gmail.com
Subject: Re: [Outreachy] Proposal draft v2: Improve how command
Date: Sat,  7 Nov 2026 09:49:51 +0100
Message-ID: <20261107084951.617-1-herroyalpriestess@gmail.com>
X-Mailer: git-send-email 2.56.GIT
In-Reply-To: <CAP8UFD0uA+zF4x8WBRA6sGxSGX52Nw=GFBznzdFnX3SptHDUcw@mail.gmail.com>
References: <CAP8UFD0uA+zF4x8WBRA6sGxSGX52Nw=GFBznzdFnX3SptHDUcw@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christian,

Thank you for going through the candidates one by one. Here is what
I will change in v3 and what I plan to keep.

> In https://lore.kernel.org/git/xmqqmrt7c1zf.fsf@gitster.g/ Junio also
> said detection of "--" could eventually come for free as a side effect
> of using parse_options(). So not sure an early scan will be needed at
> all.

Thanks for the link. My [3] cites your answer in that thread but not
Junio's follow-up to it. I will add it, and I will change the sentence
in 3.4 so that it no longer says bisect_start() would use the early
scan. Whether it is needed at all becomes part of the question for
bisect.

> Yeah, improving the early scan can result in refactorings like the one
> in patch 2/4, which could make it easier to implement a dry run in
> parse_options().

Noted, nothing to change there.

> The "must be first" rule also looks deliberate rather than an
> oversight. "builtin/column.c" has the comment "This one is special and
> must be the first one" above the scan.

That answers the question I planned to ask the list. I had only
searched Documentation/ and t/ for the rule, so I missed the comment in
column.c. In v3 I will cite it and remove the question. Since git tag,
the only internal user, doesn't use --command, I will take column out
of my targets and keep my four runs as a note.

> It looks like bisect already uses parse_options() but only to dispatch
> sub-commands (OPT_SUBCOMMAND() with PARSE_OPT_SUBCOMMAND_OPTIONAL).
> The sub-command functions indeed don't call it

That matches what I see in cmd_bisect(). I will describe it that way:
the dispatcher uses parse_options(), and bisect_start(), bisect_run()
and bisect_terms() parse their own arguments by hand. A conversion
would give each of them its own parse_options() call, one at a time.

> I haven't taken a look at this, but I saw that Hussain Sitamouwala
> sent "check-ref-format: use parse-options API" patches.

I had not seen them. I have now read v1, Junio's review and v2. The
points that v2's commit message addresses (abbreviations such as
--norm, "--" before <refname>, options after <refname> still rejected)
are among the risks I listed for this command, so I will not start a
parallel conversion. I will leave check-ref-format to Hussain and the
reviewers, and keep my observations from master in section 4 as a
reference. If useful, I can test his next version against the cases I
observed on master and report the results in his thread.

For v3, unless you prefer something else, my plan is: the bisect
sub-commands as my main target, starting with tests for their current
behaviour, then bisect_terms() and bisect_run(), and bisect_start()
after that. If that turns out smaller than expected, I would go back
to the inventory in section 4 and pick the next candidate with the
mentors, after checking that nobody else is working on it. Is bisect
the right main target, or is there a command you would rather see
converted?

Thanks,
Cynthia

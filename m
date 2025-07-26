Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1761E2838
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753544139; cv=none; b=Q/ak+rZQ+0rvpBlTfc2DchE0YeDO0eBkCHTnQXxrA16MyyW3ekulHVeoBpzUmvnZNgkHffSqllzHfVdmCTPK5K+Q/AMxkedIURsELrD4sYRk11m2rwXg8oPlyugjigJ9AQ8DHIzwcCcWUAUuf+gotEbGqN6uACw3Cp2cCKcWids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753544139; c=relaxed/simple;
	bh=BYFJsWTr15TmsgKdizh0mKwOE1fVsxmecJNp0MwHK6k=;
	h=Content-Disposition:Content-Type:MIME-Version:Date:From:To:
	 Subject:Message-Id; b=uhAtQePkouBN5xss0ufEh8Fisdx31gf0yVcMhzFbVxzj4pea4LmT8GF6ZLFqYSAr/X6Op483jcHPbZ/YdlHTXrdvUaD0QId4baEwqU/xlMUMNazmY6URY5rAqqtAA2D6vltRbIT6/JoG+EMDHaV/uEonz3pvh6vnHqvuwD2Jjhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H23YKDT2; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H23YKDT2"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a510432236so2158232f8f.0
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753544135; x=1754148935; darn=vger.kernel.org;
        h=message-id:subject:to:from:date:mime-version
         :content-transfer-encoding:content-disposition:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BYFJsWTr15TmsgKdizh0mKwOE1fVsxmecJNp0MwHK6k=;
        b=H23YKDT2r4ADNgm5HpQFCkFmInWPM8MUBZL1euzqyxkzdzOsoiLnwK9Ft63nkYZVdX
         r+usyFw4GlIbalP+Txfbdr6ZCMpjouo5oMm86gcVaH3A3D5SokypSU1zNcdtdnjM5LW/
         IDnGVJpYJ/Iq9f4seu79Y6O8JOPNhwBnHyqGnaZzAlxM3xrXH5oze5UnTFNzpt30nPge
         wCstXWBPOIbeZfoEMKMtQidc8QS5DTOg6Y6SBULTt/QZHum9e0P8Enthnn3/t3yl2Hy8
         zzk8paaYSFuy36ASh00PFB/8iSLR0MhI3BSXLofrDxpgQ0SLw98zlbONJ+Nj1gOKDt7U
         S8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753544135; x=1754148935;
        h=message-id:subject:to:from:date:mime-version
         :content-transfer-encoding:content-disposition:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BYFJsWTr15TmsgKdizh0mKwOE1fVsxmecJNp0MwHK6k=;
        b=oYM39vjOVFDIVaW3WCRLQIZZAeCM2FDGvSCwrC7cpzC0Ij4cSjerJ8cHqebshTk47i
         WFi6T35pSpjcxfb3VtSpaOXd74g0zzsyQZnqMvNltZQG6FAF8b1rkvX/9QfIKI90XaIC
         Rg/4ysKNxrRQB2B3HGa6i9r97t4IUpeiqcBAqCS85gIhv8ru6nqzhfs73pmIASU7tHhq
         jIfMcFOo59y2bVpeJv/Acc/IIcVRZsZgrFtXd1xqehjpbxQLSoiKH2SW0HZfImR1x9sq
         ORzW0bh8XsDiRrVEHIdQJARfDfiD3gpyD8iXSG89gDzYVEjt/A5KO0AdpIKX3GhAGc0P
         0GAA==
X-Gm-Message-State: AOJu0YxhGs4b7jA1/JWGxRuRwS0mcpiL5AhWUhMXe8+tp2KGEBYICunv
	lp+aDoPs1yTX2FnK1WQfZ5UcnW4KJqgMwruUal1F6Y0zWyruvGY4bcySHCpg7g==
X-Gm-Gg: ASbGncvJ65rlw0Xe7GGtLlMG8vIXrJc1oa5hOFvDRjX28DzicjAjtA89Za60UHL6qR3
	CfJuRQMxxCrst65ecp6XmI5iIyOjkFisbbdpzVBCtfTuZ20XlqJsCMZ3+MXnXdFHy7R5Hl3Of7Z
	C4nf1MGRfnCemRstHEB2MpmpVD9omN3pdTqwBplZoSYlhcVUXU/Kcr1FdfxGXtXmpMmkcS2utZj
	o0RHSr3JNcBYEl/HyldglDu0JI18Ai24nvFdlfG/EBUHLdkQHS3GhmQtNxWaNBBH4+mP/xo7B5U
	UxyRiEcQ1aDUUZfXkaJbLnH+THMVUxFvRLlPzac2AtT8IssC7KNZ0sV67IWozOH1u1ShfirNgGK
	ykHWnPY9RSoD569cOHDCs/wPGFBaBj40iXj3H02/UdTlywLPZ9H1qkBfke/3QxeIs7zcvMQ==
X-Google-Smtp-Source: AGHT+IFlq6bnESUYOMHbt6EXu135h+Dj3VWwhDUfFiUSWTQ0H9jqDMoFTt1pqEFL0v2pAFQ5pAnj/A==
X-Received: by 2002:a05:6000:3108:b0:3b7:792c:e8be with SMTP id ffacd0b85a97d-3b7792ceb99mr2179247f8f.8.1753544134579;
        Sat, 26 Jul 2025 08:35:34 -0700 (PDT)
Received: from localhost (92-184-97-38.mobile.fr.orangecustomers.net. [92.184.97.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b77e216516sm1794302f8f.72.2025.07.26.08.35.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 08:35:34 -0700 (PDT)
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 Jul 2025 17:35:31 +0200
From: Victor Duprez <duprezvictor4@gmail.com>
To: git@vger.kernel.org
Subject: [RFC] git-secure: add explicit authentication before push or clone
X-Mailer: smtp-cli 3.10, see http://smtp-cli.logix.cz
Message-Id: <1753544131-331603@smtp-cli>

Subject: [RFC] git-secure: add explicit authentication before push or clone
To: git@vger.kernel.org
From: Victor Duprez <duprezvictor4@gmail.com>

Hello Git community,

I would like to propose a new Git feature: a command called git-secure that=
 prompts the user for authentication before executing sensitive Git operati=
ons such as git push or git clone.

Motivation:

Today, Git operations like push or clone can be executed as long as credent=
ials (tokens or SSH keys) are available in the environment. While this is e=
fficient, it presents some security risks:

- Users may inadvertently push changes without noticing.
- Machines may store tokens or SSH keys in accessible locations.
- In the case of theft or shared systems, these credentials could be silent=
ly misused.

Proposal:

Introduce a git-secure command (or option) that prompts the user interactiv=
ely for either:

- A GitHub personal access token
- A simple password generated by a secure third-party password manager (opt=
ionally linked via API)

This token or password would be used only once, then securely discarded fro=
m memory and disk. It would provide an optional extra layer of control and =
security over Git operations, especially when working in untrusted environm=
ents.

Prototype:

A working prototype script is available here:
https://github.com/VictorNafs/git-secure-hub

Example usage:

$ ./git-secure.sh
Enter your GitHub token or generated password:
GitHub username:
Operation (push/clone):

Thank you for your time and feedback.


Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620F01172A
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753542975; cv=none; b=YifzwoAUx235jLzpEqDrG3r67OyNauIk9EQ2upjhZJpmOuWz36mdPkolPGM06YZBAQNdSKqSaYcVfYWugcHcKQK3X0fu0creJtw9srrVPk2vPaHfx6BgFxFR44Dj4HtelXjcNHS2WCm3dL9k8UU6bkqQ1rEt2EgU6aig3OqMMTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753542975; c=relaxed/simple;
	bh=BYFJsWTr15TmsgKdizh0mKwOE1fVsxmecJNp0MwHK6k=;
	h=From:Content-Disposition:Content-Type:MIME-Version:Date:To:
	 Subject:Message-Id; b=rjPPdmCH/FR1GFrgO81CRNXg5uuF2uwHevlzLoIvwFwvnSmCvxP9JH8nSsZykyF2BniA4XlKs6R5pKwM42V/vejug3IVulESxK0aL8GMYik3ursAJiaoWDckNjdwzgIm5/KUtvhQpp+4MURWmdZ9nRVcQ5dZhY/ts100Rm63Cis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHyEpn/Z; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHyEpn/Z"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a4f379662cso2147125f8f.0
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 08:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753542971; x=1754147771; darn=vger.kernel.org;
        h=message-id:subject:to:date:mime-version:content-transfer-encoding
         :content-disposition:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BYFJsWTr15TmsgKdizh0mKwOE1fVsxmecJNp0MwHK6k=;
        b=UHyEpn/ZCkT+GUgtCm01aSWbdnMr4zPPu4PVWpVnC/tR+D3+yvXbTAlF5SmcYkWkO7
         ZF+eCbZRa3JKiRamXbSeNHcNRw044JVfUL0TDZczsmuBLKDu6bJSv/GBp76MzT7p6xKP
         TyNBoYI94C5rPifGS5ye3iglQSwaD3G+xdSsSurKWF98xE4M3Uyxg5PFoygqDnF+nsZ0
         Tr5gYudbhfRHWZZhe/9JYVs53nsAy2cHMHNrYXh6NM8MVmk31/4Pg/rgca5W0sPcs2Cz
         SDChFZqcXzbjOGrEYvbDUJg1vO1KoFuuXqJdmSkNOrD9CN37aIAHOPoaybVAyzuN70rr
         S5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753542971; x=1754147771;
        h=message-id:subject:to:date:mime-version:content-transfer-encoding
         :content-disposition:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYFJsWTr15TmsgKdizh0mKwOE1fVsxmecJNp0MwHK6k=;
        b=Bk1TzUvEr3I3DtN5WSaMNWEWSQxgDpqzhTuUsBPq69m3lCDYW5DbDseVeBmI72r52G
         C92LroDqo2rl4AVjnt0KqePhWKYHhWjICsBmZn1KFQc5+t0rqUGjyMp3KCVIUmXZNEk5
         aSLiPzKzOkkKr+tP+EQi4a5gTTwctl25hzdcfvF6DomuIjKPQI1oleC8Oq6790iuacIx
         uYIsKzBIUdCbONTx9X/khQREOJj+xSE0P870dwQW3QpitdxzXIRaX0J4YkwcaPL966Ic
         9nmgJVNEjjA48BFSv1dO8BDfwffdS6sFebCoYVQ6WiCMkXXFP3cuMiD65M9ND0LzMf+1
         94fw==
X-Gm-Message-State: AOJu0YwOu1wcrhOtwNG/MZoumbxROn+0+xujJSZvEQZWJcyx+OpkJQg0
	qHj/9hFMJz5SfCIZrebpd+Y7Uqv89gDkAsg70/DXiPJURZ5sHdsrazMYg2fHvw==
X-Gm-Gg: ASbGncuQ0ZgZMaQ58HSMFgdYGKFsNyuyiSJ1fKWaVnzl7Riu0XmZDpz0zaMSSImhufe
	QYdh6JCmZJ8+XakPV3RbCMFV1fFHWtdm2ZBYGdAcvYy2a84udNDl75z7URhXi7iYUXjbf6HBzyR
	mJ/jp7lx6THQO0JTGmDYT9NpznBCdjeOCpMWwghpznastDyxUHHdh3keAYcYb7zyR1FcjeZPuBu
	nLekD/UVmfB5cGLqXLai2t6O1Gj52LMo2B5rX/kB34U8LO728jZc5P/8f9ux8rTLEHAo3RannFJ
	HU18WJv7hUUTGOmKRVLlB9Jq/r2RXNtYtbS7XNycYhWDLi2oY6MV1jb0bmPuASWQqmJ4cR7x4n1
	GE6mRbAn/BZpbgpwIl101+JhlMeDCY78f9au9sO6Uy/OyFEGS8fxKSUew0tRgSaCUL35ZH9ME
X-Google-Smtp-Source: AGHT+IGrMsKi62MigUIIg+9sZa/JQRRy3LQttBcRGzsgoiHUA88M5U5PKTJNeSwXqFi7/Md+tJwRPA==
X-Received: by 2002:a05:6000:4023:b0:3a5:27ba:479c with SMTP id ffacd0b85a97d-3b77676ed39mr4110356f8f.43.1753542971362;
        Sat, 26 Jul 2025 08:16:11 -0700 (PDT)
Received: from localhost (92-184-97-145.mobile.fr.orangecustomers.net. [92.184.97.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eba0e6sm3096433f8f.25.2025.07.26.08.16.09
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 08:16:10 -0700 (PDT)
From: Victor Duprez <duprezvictor4@gmail.com>
X-Google-Original-From: Victor Duprez <duprezvictkr4@gmail.com>
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 Jul 2025 17:16:07 +0200
To: git@vger.kernel.org
Subject: [RFC] git-secure: add explicit authentication before push or clone
X-Mailer: smtp-cli 3.10, see http://smtp-cli.logix.cz
Message-Id: <1753542967-670581@smtp-cli>

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


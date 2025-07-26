Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499E32E36F6
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753544776; cv=none; b=sAMH8VVTdogdLLM06CJVMStPbtmByUlriSG8MDZUgCgeRk9dhuU+1YteljUCYbB+7h6SflF4HnynxO0QBJLER9eRnbM17vCCU5/QYb9bBr9u26ZQ5rBUemtS1swQd9qoHAQpf66jg/5SkmGlfHocvhabKqhVTAx79lIXcPOKcew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753544776; c=relaxed/simple;
	bh=BYFJsWTr15TmsgKdizh0mKwOE1fVsxmecJNp0MwHK6k=;
	h=Content-Disposition:Content-Type:MIME-Version:Date:From:To:
	 Subject:Message-Id; b=t86dMyPnNA8NYwgr9SBZ+BCBc4MDwVEVD4G2tQ8cQ5/5ka1anBQ77jse97nu4NmeUVtZmTnUKmRrolnUuVSl9jBWwQzm2K04MUX/Z6M0kirVv/MLWq0w3clEBYOu3Cit2lLqWZDlRRYd93XoUZCsWowAz7ro9sR1gGRi8UFrOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnfGhxPS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnfGhxPS"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45600581226so31363155e9.1
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753544772; x=1754149572; darn=vger.kernel.org;
        h=message-id:subject:to:from:date:mime-version
         :content-transfer-encoding:content-disposition:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BYFJsWTr15TmsgKdizh0mKwOE1fVsxmecJNp0MwHK6k=;
        b=fnfGhxPSrxvSIP6AP1hDIuRnPn1Cf9AhBq5rIfahLShAh9vtF/S62E+/IDLYuajBgi
         inC4VMcj05QDrkOhxMaAMaEMhxR5r6o0qsaWdd8iz41e4kUoEM4Pj9CCC/wGZrFpG7bS
         aBCr3T/TpNDARIn9jj6SVN7nCV1y5hPg+Kj4qSxOzyJ3Z6DUTpo187KIKNC7YwbG2kyr
         plmqSoj598idEd4B5Cu91E7byk2foVzVE1erNbpzWya5FGWmECdNASws8c9ONeaHRkyP
         sUbhNOCsb2UIIzH1MLInh14Nz5yyN/g1wO7Rn0Ph4RLybjO/OYlqLyxrJ9CQ31IKFDXz
         +B6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753544772; x=1754149572;
        h=message-id:subject:to:from:date:mime-version
         :content-transfer-encoding:content-disposition:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BYFJsWTr15TmsgKdizh0mKwOE1fVsxmecJNp0MwHK6k=;
        b=DOa8R3ehXAOz8RNbD5AxCc1vtzGAhpg9AQGA6K+PjvwMkHuPNB2bqaeGdX0yjUyKIY
         S4Tq0u8Duo1EoKc0kZkrvivr3KZhZsDBjT+g9ZwLDcRoTUvF7mcqbQmlX7vCEBrLO6nx
         eW0a8Slqh/KmhNs7ZZSZQdt1KJoKYnGpGRpoECPR9PB8sNoP3UFOu9ZPbOBqwXgU+PKR
         QRMD8+0rUjZ9BWZNKKmOGLV8czNKyVNngXYvtdTNkq7NhpqA4vs7o49VFDBfFs5pdl3t
         F/VDS1ObDLSw3vV93ePmYDB6DfKLP5EaeGTKdvoQ8sTZ5znEGsxa1KrYnS1YVci+3wKC
         hXxQ==
X-Gm-Message-State: AOJu0YzqYWCwGX6X6SMjaUFhFp/IpemrZ3P/p0OHQPhPinSWhSKLP3id
	kX9JmSfmoTNJnQR7n3M2/cYNs2P71R3w6IxzyFImsiH83U190I9quhupPSOtlg==
X-Gm-Gg: ASbGncuAvUtxeYz3wb0oCVAEtiE1jXM1RHttsJCm5EMXn2I1YucYCaNFG5O7IbfY6UX
	qbM5nIp1DJ9ow/A8NagMeOtYd9DfFrNmpdcUlWNPK2AX62KJddPscyC1TW0P65QzLPgUKo9b4sv
	PkKRB96yxlGWunYSv0zibutHyXfadx75B3ASIL+343G+1LGoD7k42CGL9S+qZMTLyN6pb8/b9CT
	q1HHm1P2yoi7lACXJf4IW2FON+1cjUFfV/GX96FnqoKx/4OCVnq3JVOhPXLHZh+/19Tv5llW7xP
	TBTn3HzGLFbL3oI5bKYMIVl7T9dTS1VMaIKXcqCJjd/wRjF7YQJpZ8lUUwi7ExawihQvo4Sy19z
	Y8/keZKIexX+1SvPHXss+aUPccuYiAjSgEiZc30vN1aDFcJOQ0CSUtIqlKJZhbURhksdp6g==
X-Google-Smtp-Source: AGHT+IH84I/vj4pP0TTTa7Y2lOrZJHZAv3uDQ7viWWoYzfTy/GO9jLjJ+AcmQfpDAHsr9PNl9pumSg==
X-Received: by 2002:a05:600c:a0c:b0:456:1923:7549 with SMTP id 5b1f17b1804b1-4587655b790mr46095695e9.26.1753544772405;
        Sat, 26 Jul 2025 08:46:12 -0700 (PDT)
Received: from localhost (92-184-97-38.mobile.fr.orangecustomers.net. [92.184.97.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587ac663b7sm32858045e9.27.2025.07.26.08.46.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 08:46:12 -0700 (PDT)
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 Jul 2025 17:46:09 +0200
From: Victor Duprez <duprezvictor4@gmail.com>
To: git@vger.kernel.org
Subject: [RFC] git-secure: add explicit authentication before push or clone
X-Mailer: smtp-cli 3.10, see http://smtp-cli.logix.cz
Message-Id: <1753544769-115114@smtp-cli>

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


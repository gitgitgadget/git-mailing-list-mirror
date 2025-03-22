Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BCC2E3384
	for <git@vger.kernel.org>; Sat, 22 Mar 2025 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742665187; cv=none; b=KNYNZGEvKFB+QkgLlmpqhhkqQpUHA2OSxLvz5tdQ97+UzzJRHfcLW5N6fm9QI5o5MktF4L8nOtrA9IZpCZXq4Gtos7kWAZ/umZLWNmtPjUJ0WImF9jXBhw3KkFGe28DZI2WyzUIK6Yr79SZZLaNcaIP1uUuEVSql/nbPKrsRB4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742665187; c=relaxed/simple;
	bh=P5meqyYuznEFhBKqI1ig7jPgNF7iOLYrjCmpYkNhHJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4w9FOMk3f+7EdJRirVR8ttboqtxXTYIRhZiiRiAnbDsD3jZvmmJHMqvVKN4+wAEOrYkz0k7sCElvjircSlwdvOwdQAfkJaCD5APyBtwcgx62faqYQlfE7sk+dhsCOHY4Q5S50F8of/hT/o7l6DNryym55Iz9EZ7EMnkDTEaIxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFEqhyHC; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFEqhyHC"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d46693a5e9so27277815ab.3
        for <git@vger.kernel.org>; Sat, 22 Mar 2025 10:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742665185; x=1743269985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5meqyYuznEFhBKqI1ig7jPgNF7iOLYrjCmpYkNhHJ0=;
        b=TFEqhyHCOvz2wq5o8Y8kJ8Pi9dIYSth4XjMtFoDfFyZ/67Q9Jm+w5fz2zr+WWD3r2G
         MaSkrT+7g1pO/DLJ/btFErLnR/CpsuJg6auuKsQi4Klb0hjk9HKzPe6CspLoQNBoqklL
         PWBSjYXDhbE/TWkVGq53vMhginb/UjRDVPdaFXsdv3KFy+DEyFESbJwBhCNGUc/YuAhW
         NdiaPJ+1dPJPNFYubDTK6vvVrUG5fTfGJBOyGEDjXqnx6lcGIghhMT+QekIJTcP5kwv9
         uxufu4aXMYT3AyUUftphz25O5Rnnji/T97CMGdjPiEN66O1L8YS07fpocPtgerOZbPl+
         Kg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742665185; x=1743269985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5meqyYuznEFhBKqI1ig7jPgNF7iOLYrjCmpYkNhHJ0=;
        b=iIf0qqcrUpMZ9RsGRdpDKlhLen9k3UNqjkIXKPFBUg3dA3GQLhAOgeuoDSU8zJ1PDx
         EPDXggx567fTUnBemvUEMpWxP1LnG8JDjb2TFyJgxBlIMo/NBwDE++viZnrKUXVngVm/
         FIut8qdOVxALyrAv85yXwTzBZVOmuA22tNmgYbws2kfDlJRwOYD/AVDcS2SaGUW4H0Gl
         vjvzCdL8uAsko+ofWJLG15Xux/06CVxfZQ2pZp795PY3GGa0kY52RyYhzk7epXApDX9x
         A9u7F6IecHCdXMlZsnB5NnTXGfH6oPffhTdPN68aqLdAxWDt4h87WL4d67bXcDr8XHrc
         X+bw==
X-Gm-Message-State: AOJu0YwxNjr4meXcaM67t4wywmiI0FY0RPjjCEuR2QrVG+KfGhX2WCrA
	WDmkZqG35QQ8CTyC9il9RgOHB0hD0GMLBQhKoTzsIKR4CQ4YhBMNhY4TwJ6xKWSzybtC2W5+wae
	KynWrmePYiFkdcHPNMBofYjSabDSa4A==
X-Gm-Gg: ASbGncvqA7zROWBf4YZtPeCxZn/m2opj3tm9u3m+R2/9F8T9ezV3CogsiXxgUkoMRlA
	h6Z4ieWn1zkauwaG51fVRUNfepseurlBj/rpflbguCKUPK0xQbwsTrEqsEXPQIOyFQCUsqKxtie
	EUZjq9zdZCkDpendltxQpNeIQCpGT3
X-Google-Smtp-Source: AGHT+IH9qfmwFMLbHcPXZ5MJTvtWwd00YIUpf15fStiEP10zlqFN8D5MwuMhUC9yF6D4ONbYfsck7I78KThzFNeX+PQ=
X-Received: by 2002:a05:6e02:320d:b0:3d0:4c9c:965f with SMTP id
 e9e14a558f8ab-3d5961cb4c7mr98620175ab.20.1742665184818; Sat, 22 Mar 2025
 10:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1930.git.git.1742637713157.gitgitgadget@gmail.com>
In-Reply-To: <pull.1930.git.git.1742637713157.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 22 Mar 2025 10:39:33 -0700
X-Gm-Features: AQ5f1JrnOg_JIL257KCooZLysqS3pcV7QdXqAz9AoPf6R0ml-15w3KFvkylJ8Zs
Message-ID: <CABPp-BH9ia_GRNYx+zRCht3n0V=X-uLq2Zg+QWTWCyJfMkeznA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] shell: allow overriding built-in commands
To: Ayman Bagabas via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ayman Bagabas <ayman.bagabas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 3:02=E2=80=AFAM Ayman Bagabas via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Ayman Bagabas <ayman.bagabas@gmail.com>
>
> This patch allows overriding built-in commands by placing a script
> with the same name under git-shell-commands directory.
>
> This is useful for users who want to extend the built-in commands
> without replacing the original command binary. For instance, a user
> wanting to allow only a subset of users to run the git-receive-pack
> can override the command with a script that checks the user and
> calls the original command if the user is allowed.

Sounds like it'd open a window to generating numerous security
vulnerabilities, break git's own commands that exec another git
subprocess (e.g. git-stash), make debugging git bug reports harder,
and likely break programs that use plumbing commands.

I'd rather we didn't.

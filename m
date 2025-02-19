Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BDBA930
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975324; cv=none; b=By2zbd7fan+ialtMHnnBK+ZEGcp2UY0UMsu57BUzxSMDkJ0iK/OoJqNCYS/C7X6WlDzhwF8Z0f7CQGrxChQTj9sCIl3ZVrrjRozx8dbbDV+gKdgVCWJRWZawTIML8AUIoNJFfbV411wvpiXHcIcDsgxzbWEdoz8XzGd8b/n7Zek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975324; c=relaxed/simple;
	bh=kSeqnymrDib2Ga9z5KUukISTOY43V+XlWMIYiZM7qiI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hotjU+fSZna7fMtULG1vzCLT5xp1zEQeeWv22sb8kHmrYsWHFg2IYw4ZqKK6875oYHeYG4JWOOX6fum2YPYKQl+qKuwRFh/vsTt5lY+FFP0CubPy5Jtz9/7JY8SZbHDYvxjCAY+2DHugvV0YC3BYSmhawfPOLFRaoKiMcq1/Jk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByLnx0ns; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByLnx0ns"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72726a65cbaso1663389a34.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 06:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739975319; x=1740580119; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSeqnymrDib2Ga9z5KUukISTOY43V+XlWMIYiZM7qiI=;
        b=ByLnx0nsVJuhbBihLfxtEKWzkgAi0aDK7DnlnJDG0SBHOSWoxKn3uUjRcMqgUuV07E
         s1UdXdUoNQKYkjWiTCYqhGMCZpGVZ8GWqS4zD+sVkTwrKLnfZIBQrfnk3H2fRU29upl3
         pvxQPPRV8hRn0EhOeuWwhJO6Y3/LOagBfsJ0dED4vxzuXXNUfhVcRKLHBBvCsWTvtnAT
         iS8yfhqwhF0IluPPlOo8zzefFM3/AQC8ijqjXE30eMOqb/nkdSQObrpCmyZJlfQIDxTR
         7PWk7CMSMNDP/h1EfEaLAOMKtCXynJ0ILmufjYNgHWMcOeH2P9sy5v4wSTHkDp5OVSMx
         FP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739975319; x=1740580119;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSeqnymrDib2Ga9z5KUukISTOY43V+XlWMIYiZM7qiI=;
        b=lkFBQvUh4166JJaGzyBlLQW5tqIZ0Io9/Sbm39DD7+gm6PG/PvSw7QV7MrHW+iQ3wK
         UQ+HVedwvo6kAndXZvqFty2GFEYzD3Yu5jLoNBQ6tKhD7FeRPCOME4uUgDLqwD5oV/g4
         /iVcVfieUtO2anbMO98DowqHB85NX1uNvFiWBMiogLZYImppBH8f0AfuHPgKigv//VSF
         M2KQiU7yKpVsssAofCXdnpCoXv2ZNGNEgvFL5pnH1iA05gC48Z3jR2mWb2mlE0n8Hzpy
         W0pI8F1WLteaEueGO/Xs0qheUMiH9TPoq91HKgqaU1GAB49k8npyCIalV728Zu0dn1at
         fUWA==
X-Gm-Message-State: AOJu0YzI/mY9HEPEhsxeFwhF/6UgbXVQGMKIN6fDlEOznV6r2UqaGny7
	1HvmjpCijawCuOXsNqXi6LC/8FUvUOBFcrEHpF2pK0GG7+HgjmhQwplNF96t
X-Gm-Gg: ASbGncucUYKNOUnrWae7L50vm2F9CbSutWxpeLwPieK8hbqEVGnnXN/5ixLEKEmKyuX
	mecIK/D+ER10N7iBEl8FPQw7kMtNb3tQKDU4hk/LmKIgVOQfeheZq8bWqYBbbJ0cCNUgNiWLLCU
	fTYbOBvFn0TfghV+gmHL8MEIlA90owmHfYQXrhcX1yBlEqEdCNQVixOETSAT3w8ccIDV8gqbJXr
	ylznXF6HbOWK4A8GTF4i621mEgi+EXVFf0zUDZOhjOhHH2tz4EvkIFfMB6NMGXWze48sqeg/BXK
	S18h5ixeOmev6vz1uN+UQpQfFnJEw3stuGcw7Xg=
X-Google-Smtp-Source: AGHT+IGKTqdmAUmhlQM5YQdc1iDTpCU+/w8aiMZhYvad9govTvXiy16ycn1MQjZeuPt0zK5w8xrJiw==
X-Received: by 2002:a05:6830:3786:b0:727:3a21:7717 with SMTP id 46e09a7af769-7273a21793bmr1733875a34.23.1739975319217;
        Wed, 19 Feb 2025 06:28:39 -0800 (PST)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7273a14070esm338912a34.49.2025.02.19.06.28.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2025 06:28:38 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: Possible bug: Empty magic word list in pathspec is handled
 differently in short vs. long form
From: Lucas Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <216a7288-b599-4333-ba62-10665d6a94d8@anselmschueler.com>
Date: Wed, 19 Feb 2025 11:28:25 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6CE51CB5-4F14-4737-83EE-05B93500BDF1@gmail.com>
References: <216a7288-b599-4333-ba62-10665d6a94d8@anselmschueler.com>
To: =?utf-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)


> If you run git diff for a pathspec with an empty magic word/symbol =
list in short form (prefixed by ::) and in long form (prefixed by :():), =
you get different results.
>=20

=46rom the gitglossary, pathspec section:

"""
In the short form, the leading colon `:` is followed by zero or more
"magic signature" letters (which optionally is terminated by another =
colon
:), and the remainder is the pattern to match against the path.
"""

and:

"""
In the long form, the leading colon : is followed by an open
parenthesis `(`, a comma-separated list of zero or more "magic words", =
and
a close parentheses `)` , and the remainder is the pattern to match =
against
the path.=20
"""

Note that the long form doesn't mention that a second colon has the same
meaning as in the short form. In the short form, the second colon is
optionally used to separate the magic signatures from the file pattern. =
It
wouldn't be necessary in the long form, as the close parentheses acts =
just
like that.

This way, "::" and ":():" doesn't have the same meaning, just like, for
example, ":(exclude):" doesn't mean ":!" (but ":(exclude)" does).=

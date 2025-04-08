Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B410914A60C
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126047; cv=none; b=HaTkwlhkFSjBb539/RiHKXspiWo1V9O3NxsqgVxnxQMlGoPGbMh9xMJalm6PWK4vshN+QxK7FuEztlt2oreW3QQh2KRbVeKKGLo+5kMdJhIMXIKLPx4hJ1Js6ioYxjfqH2lktwFtN8bBcQqehQRj09oFukqWRd8MhyZ2A2ipt+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126047; c=relaxed/simple;
	bh=s9MGmimFY5l42vEgCqDO0gTkVU0HeUEjGHys/gC+StE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EXhW5D3JnS4oUISCtWg5IicBSEEFg26oerBHhQtkSYDMS+JEBOf9WpLpDwbOWLy5SaM60UUKhOXK9w9TxCOanSGm4vE3OiEzPM4JFvOwBlD72GQ4E2w8bKhQkHkBeMPqHHm2mXzFwJGonjtTW1XdFwroaqjwfqAsRvp6bJ9bWng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFbFDgLB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFbFDgLB"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-227c7e57da2so49639175ad.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 08:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744126045; x=1744730845; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYfJ/xnNJJwDRNbLwrePoJAsst7DTbaWOMQai/NIXqw=;
        b=WFbFDgLBqqhQXy8eXgSMXt4eomnCpEcNuL9rxWiOnH+y1ZwD2npTANzTBD97uSJplb
         C1c9MxpQ6xVaQgVEHldn13eBVNuE4boSavLNq5HmbW+yeebS0BOaIKm7qurq191+XlN8
         5XEMYaD0gDGot/TUOJ+KXcbnZCBFZyBWsp7W9BC8upF/VmAPJ8nRILeU+ZRVJg9X23Z4
         5CC8rh4yfMsPTfO2KljyMLib37unIzQE9SvP/ibZ9cePBpyMcRCk7zrimvspQ4vOVV8Z
         FTLHnAUF/CgpSyGf7CnezYSXfu1IJrArDiKmw35thI8mWZN15Rt4mdabo9i7rcyaourz
         xntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744126045; x=1744730845;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYfJ/xnNJJwDRNbLwrePoJAsst7DTbaWOMQai/NIXqw=;
        b=kxOAFq3D6D5wavpYP45og3NxUnDJ5rY5ppPJ7WCNnLI8HRnc3TT8TDf5+uF/402Sxs
         3SVK5r+68rod7u0opcj+NTr2+GPcJznMhUmx93wC7kR6jcjLemYrjA13nupET6jnAGwu
         KqqjnSfpIFxdDzqYp5bjBCdu0tF94pjNkJvYNNvC6OY1R521pASwGfPzdFEKVOwthDDk
         G0MkfDOBkM5wbtAt2YTop4sRmZ8cvx1n0p3UHz3UU6yfCvqOnaqRhmvvXt21dSg30vfj
         c6RXjeaX8+6lvvHq+rNyTmmai9OIBhjd4UO/0uFKc6tU/ZUj85zv6rZZWz0rQjHb/Nxx
         o+Mg==
X-Gm-Message-State: AOJu0YxBWp5rVW/q5YMx5el3WDO19/MZlyNdo1TxS19aGyeZP46VCYxh
	qhbSzrsw/GK+TI9IfZ01hk8ljwfbO5/73FLNiHKhEonnSUNefb+fZeILmg==
X-Gm-Gg: ASbGncvf1QY8CpVLZSqAEEZbAkS+tVyN0NQcJ3G1Neu9melArUipZstLy530nW8UXFN
	9toqjpDcR9LhO/WODMCkgLa9CCGEhBYCwQVi6uGsOLI0GATIZAS5qdyzREdBHOXACDXDuJnuRPW
	qOsbTdFBhaMcgHkI+kxy6HjB/5c08oWBIyfvYW4VgQbRGypPAEZJwfMxYP+rA9t27J1jgybpfJL
	Ntb3W+/kARLoLKWCl5i/i55UBbbIaXmQ0WvjGMlhwh2YhJQaX/1AcLP8H7x4yblgfyWaGnIphgu
	9I5f6swIe0vCgG872qIMXSZEcVGnLM7m+vKXwHgvGAJKiYPMNi/1esnMwDKhou2C7cg0KLm/ce5
	RJHMOizY=
X-Google-Smtp-Source: AGHT+IEnENus0BILoTZPD2NsbUgWPLKPKL2YbTvA5J3XOLgSwbgiDGRQdV7wi+Szo5rOtdRYsYhzPA==
X-Received: by 2002:a17:903:2452:b0:21c:fb6:7c3c with SMTP id d9443c01a7336-22a8a05847cmr217968595ad.17.1744126044751;
        Tue, 08 Apr 2025 08:27:24 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8e7e:b169:70db:1e5b:dd10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229787763fdsm102018045ad.244.2025.04.08.08.27.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Apr 2025 08:27:24 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [GSoC v3] Project Proposal: Machine-Readable Repository
 Information Query Tool
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAOLa=ZQSnwSPw1U_-2YZzjK5z_jUEB3vGy=So5e+gpOa87Ei=w@mail.gmail.com>
Date: Tue, 8 Apr 2025 12:27:11 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 shyamthakkar001@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <92387DB1-F5DC-48D1-9A0C-6AFDC2E28DCD@gmail.com>
References: <2E36129F-71FC-4053-A20C-D41C4B3103A4@gmail.com>
 <CAOLa=ZQSnwSPw1U_-2YZzjK5z_jUEB3vGy=So5e+gpOa87Ei=w@mail.gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)


> Thanks Lucas, for your proposal. I would recommend in-lining new
> versions in the same thread, it makes it easier to review and also to
> note what comments were left in previous versions.


Oops, sorry :-(

> This was a good read! Really nice!

Thanks! 

> One thing to keep in mind is we already have:
> - git status
> - git describe
> Both of them are used to provide summary about the repository in some
> sense. How do we differentiate between these two and the new command.
> Rhetorical:
> - Does 'git metadata' differentiate itself enough to imply what it does?

By now, the main idea is to bring some functionality from rev-parse,
although I think that there's room for placing other information,
like remotes, submodules, packfiles and so on.

I don't think that it is related to status or describe, as status is
more related to the working tree and index status and describe is more
related to the history itself. By "metadata" I mean the data about
the repository itself.

> - Does it convey that it should be used to retrieve repository
>  information?
> - Should we consider 'git repo-info', 'git info', 'git context', 'git
>  repo-query'?

Perhaps `git repo-info` would be a better name, as "metadata" could
be too much generic as it is in some ways a synonym of the name of
the other commands

> We know that 'git rev-parse' outputs in a human readable, would that be
> the default here too?

The original idea (from https://git.github.io/SoC-2025-Ideas/) was
to format it as a JSON output. My only concern here is that if
I used the JSON format in some situations and a plain string format
in other situations it would lead to a lack of consistency on what
it is expected to output. 

That is, keeping in mind the Unix philosophy of "do one thing and
do it well", avoiding doing to much and becoming another rev-parse.

> There are a lot more options under the 'Options for Files' section of
> the 'git rev-parse' manpage, it would nice to highlight that this is
> mostly what we're looking at.

Nice idea! I didn't extensively listing what should be displayed in this
JSON because I think there's still room for it being decided, but having
a reference on what can be potential features mades it a lot clear. I'll
included that.

> It would be nice to add subsections maybe:
>  '{"refs": {...}, ..., "objects": {...}}'

At first, my idea was to bring more information to this json, e.g. the
hashes of branches, tags and remote branches, the submodule remote and
so on. But after Patrick's review it's more focused on the features of
rev-parse that are not exactly related to "rev parsing" but somehow are
placed there.

> Thanks
> - Karthik

Thanks for your review, Karthik! There's a few hours left, I'll try to
do my best considering what you told me here. Very good insights, I
must say.


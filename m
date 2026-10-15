Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9184EBAEE
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055704; cv=pass; b=TpGLyUq8UQhBpZduaaSREPEWKNqyxyepy2tIFGnpS6jIFjqE/M6XWKJua7ACZijJ+0Sph+iXUVFH2TPk/BRDR6aaMp7FXg0h8fVJACzJqBvTlrb/Sr8BcFDp9NEfJr2js4McMHvMcLHd4yZP6RmdVRGiYWPruf7K3rjJV7l7/Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055704; c=relaxed/simple;
	bh=yqnS6IEaZQS6JOGMUgYHJSj+xNeuDlB1XlL4mGc11/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDXOmKCoSlM5PC0RLmTqzR1sdZxtWOXUhdhvTRDLE+8ZwEXOg95zeYwp3t62ETiS0zZnsYBTR7FB+srCV4TRG2waiiIm17Tbof61zUHIeHRnC0iilzThZlYIdPZzO/cYmbQMxaPsw/2dfgBD1AgYD7fh+PpKDaRTtmSZv6IZgEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=IRbNcEBR; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="IRbNcEBR"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66fca0709caso1223980d50.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:15:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792055699; cv=none;
        d=google.com; s=arc-20260327;
        b=YBCo71s1q9/zhjQV6yVA2UqYII1DNqc2DMCc5VuhbFOQ+c5mZ5vn7HObFw0YxQ5fou
         mICY7hGyPX2Baacznk+wdEsU0HX7BqcJRT8YwlmRdVGQ0g+RC4r8bCHis4rsCCffeJsU
         L0kS0CqaslqFAAzI8u5BSONOVx4WpSFZznic94f9+mNuvPLOsH5XCBkqbAHo8yVegXhh
         gdXe6I4IaRlCDmXTlDeGDBH5xCp6Jn/qbA1CDJrhBWUw0wY49CVaFt17h6hNZ/kMhoha
         L1UQqYo9o4zweB6irRvjYhdXqpmmFQ+sGhe5yU9tgteSQGJ4h54FiS0H3AkXrRCZNk34
         NLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=foHcT042Z0Dpx8Cq7TY9pHE96DBWKG55Fnqgml2Aw6c=;
        fh=nPxZy9flPIb7Jrl3Tj1AIgk96qb5gmvPxZNaFkymegA=;
        b=eWqckCs6dHiCB8jd/xzME9qlgv25Avs0l3IsltGXgXQ3+7OgAs5A5Cajvu5mKuLGS1
         2KJpXyGhur6PH8buo1EOsGz7EVFXn23axP/BvLB3OFjuCkWFJa3shDObw/q8qerKJlyh
         JUSi+8df68c6p4E0R3s+GaXRhDn+st0KM9RH377FHyViVqviAG+ebZtLXIXOYesulLOR
         mxxTsJW8YSA5Tgib+FmJo8CtZ1q21w2k/IHrCRbdj+Q4JAVOPu1Iay305y2+INB/c9bl
         75uPAZzs0EZCWXZrQ4lua5f4XPZ1pfSk4zqDyfzY5+iHdlHyhqzz7HLnH7+k8HWVG9rf
         QMWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1792055699; x=1792660499; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=foHcT042Z0Dpx8Cq7TY9pHE96DBWKG55Fnqgml2Aw6c=;
        b=IRbNcEBRKHULLm1JP3gcVyD8DAPtUKKeAORfmPbJ7Mq0S6M69eAgjIcFy7bmxhbqiT
         1OcF01asEFkJNRiZ/4+42/bBqune3kzJT3HoZ8kLDfuwuNyrOnFU7T0b9ma6c4KUwFdi
         SssFdy1c1r/M4B7iabs343ikV40FXVXh1+u/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792055699; x=1792660499;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=foHcT042Z0Dpx8Cq7TY9pHE96DBWKG55Fnqgml2Aw6c=;
        b=DK6Famvhpv/HDQ5iO3OhDq/ntu8zqg4J/t6cwfjc6jt3/VF/FrwG4mnPQDLnSPD1OJ
         m1GI30CprbwfidQvAa/pYVbQBQlNKqbkSUinDInCnwOE/7rdPY0ir6Mj2HOpKD46VNAN
         AN+ZTDh5ih0VLBBhaUkVVvVa3PnyoDPeLwDop91fvnPxZRz11DE/koqXm99B6NA0CfRy
         btxfR1oWYO498aV+QWvBVUrhk7TNP9NJCAhDqk625DWUdxR3IpjPEWSMj8g6OPfno+DJ
         N/9x9fg0F3BJ+HrM3wCUzPaWEN+lWEaL37RlWvvTSTtNlV1cR7kX8+CwnyaeNUfwk5vO
         M1hA==
X-Forwarded-Encrypted: i=1; AKwUvBz9gAA/HOLEZsKnI43fVasCnZoc66d+NApIxUiZ1BW8B9pki2T2JZurkqCpcWbAAaVzvoI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5AiePB9LA47QzNJYHZYj5Eu4N5mwsicstFSoqf+SEzSrl1813
	LhpTsArQtuLrVm5Q7gfGqPCT6hxirXnE5fg5hVmNGdydeAIg4RHQNLahZBAuG4dorwBMnJQrJT7
	+DsviU55dZxHnnRY7SgV6RknzzKs2uMPcDqG6FxdWxA==
X-Gm-Gg: AYBFou0ETyFSQtolTBVEgwyig32uzaV54O1bSPLZokhzYhphGXWrNl9IG860ezjpGZM
	2zZnAXPt+wBd7TEv2X9AFpfRa0u3w8h8toIU1qarnsH3uKW3hez5s7JwJLXSvfiLjzJ+Qlr7LCB
	vHJUzxFD7Mr/lX365STxMAJX7Lnf7HwqflvuyCmeg4s0eLY8mgztNgS3V1ydeo+jcqPGIrotF4K
	bxM7IoSOTko/TkAhkWxYPadfperk+UL2079+ulUW0kUZ1CpDwiJ+9wItpx+0peG32uJFuxBiLcB
	U/sxCaxixfmDySQiZJawilj1clc7BSz5gu+Yus/qGs3wJzidSYrBwk8d
X-Received: by 2002:a05:690e:4403:b0:674:cc60:9aac with SMTP id
 956f58d0204a3-67936297c4dmr4913333d50.38.1792055699412; Thu, 15 Oct 2026
 02:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v3.git.1791806877.gitgitgadget@gmail.com> <211794c9252181fa0c31fcd968379c189d001a8c.1791806877.git.gitgitgadget@gmail.com>
 <atB468yrVqsp9Eg6@pks.im>
In-Reply-To: <atB468yrVqsp9Eg6@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Thu, 15 Oct 2026 11:14:48 +0200
X-Gm-Features: AclHuK-LBbTQKYDieVy0QisSUt5jHJ0IeJYiNCa_4iJ0BLaSzsXCKjRejPWvRyw
Message-ID: <CAL71e4OJGW5uLax2nAZ=XPgbDwXEe1vE-6pf=L_Ka9MQo6NrUg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] p5413: add perf tests for connectivity check
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Oct 2026 at 08:55, Patrick Steinhardt <ps@pks.im> wrote:
>
> All of the benchmarks will need to be marked with the PERL prerequisite.

Ah good catch, will add.

>
> > @@ -0,0 +1,44 @@
> > +#!/usr/bin/perl
> > +#
> > +# Generate a fast-import stream for p5412 connectivity check benchmarks.
> > +#
> > +# Usage: generate-repo-p5412-connectivity-check.perl
> > +#            <dirs> <files_per_dir> <commits> [<hot_dirs>] [<files_per_commit>]
>
> These still say p5412, but it's p5413.

Oops, I fixed the file collision but forgot to go back and
clean up text references, will fix.

Thanks,
Kristofer

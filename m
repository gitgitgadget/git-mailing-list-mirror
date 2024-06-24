Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B01113DBAD
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236751; cv=none; b=Gm9zuajc5C7sU4/a2kMFu+X6UNGuk8kGn5FhBJ7Zagz4y5s0hWN3K+YAPBMLPAlyKaySCidsVHm3Sd+qE1rzFuCUK5o1nheFTsqrAHhG1lbADwehwgwa8BO/uAReZqyfD/9tz7EdhPYhqzAoEFbETOMv4U371r8dn9i6yXVhkEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236751; c=relaxed/simple;
	bh=R4RW6I8wpFSaufyutZCztHFvtYyn6sCBP16ajdoFGQE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XqCC9Y2ppdlb0nG4XZC/wOBw/wjuGHXApEWtJTLF+MTNjc+AUL6rI/cG4f8AdE/zRbE2myW6kQH6ONsnA3Pvip/QqHxjaQ9CPgNdIqmDLqPOoO/vIy+b8crrIzxLFdRXWbyUY8daS5JfGW5YZ61aPdT0eE4E9XggvdoYyxlV+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJmDbKHt; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJmDbKHt"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4413076a5bfso1499801cf.3
        for <git@vger.kernel.org>; Mon, 24 Jun 2024 06:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719236749; x=1719841549; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6S1zK88+vE9c7BYAyqKCTobmXiSXBVfHFoIv5wEIT9k=;
        b=ZJmDbKHtBA9eC9qAtDYe6MPFvrdXKD1tdYP/0Lqg+ZeaQnn5P0YzOOaUial5zOnIlo
         wWTwWG/qjMNGilphm8PHeksKp076YG61/CWPwM1NHrwsFGRYxLyce802Vr4VGIJBvOEg
         Zj56u4rIteSZT6k/KTxBwjcyhIWe2rx10UJBM+Ezr0XCMkhT536tbmfPEpESFaJuvxEh
         Z2DoTSYiJIjwj80HxxC7hJCIG1mN5wF3kHhYRRyRKrKQFQ2YNlBtQe71gd8Cv8E/1oUz
         XoENhcfFjixJbdHaEhIP8U0jDQB0CDWB/Ylr4JAnNVk1BczqxAMEgZUc/Cx4b1q4XIp9
         SFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719236749; x=1719841549;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6S1zK88+vE9c7BYAyqKCTobmXiSXBVfHFoIv5wEIT9k=;
        b=T9yymgH2FMD/5ocTV+IALMCHEaQ3eVjXUPBD/dbc+Nnm7tCzunB+zdqC+1+m4KbpGu
         hQgJg+IWseU4/G0uYoJvOpSSOG+ZxxLoNfYZFakvvG3RTfbXU4P9i6O64ibR6s0CIoKe
         ue1iMT/HEs6tPgtpYLR+0X0Ox3Nfh9DYRj2tVoox9zMT5bHcZnpLxDns06bm/QIY2I82
         5QKvhOl8/eUPVPVevnL6yXfxLEBtvm4Ad6f8o+TtRK7Ny1YD5vb50pP003EnfeslIdBi
         hcbUSeNzK/tiNDLrCb5YHmAVD0A3oQPnWP4ABkeZjqJid5o301vUSEYdDq2AR8kBVUPO
         rNqA==
X-Gm-Message-State: AOJu0Yw0JMtggfAKGyJQD8fkCm9pedjwgWoudvyAGUXYdi/6NpAuLiTG
	7zUoW4l/upft6Y0GkVNAlnr4xdDEIPqF9b8iyHQLBQsDulGasVBDRYHkBw==
X-Google-Smtp-Source: AGHT+IGiBfOkqT7h+GMToA1++WXx9v5Uyxdu5kknMvK8Vg4zJOx6C5wZCqZpD1FravTib4ru1CDA7g==
X-Received: by 2002:a05:6214:c6b:b0:6b5:600:acc8 with SMTP id 6a1803df08f44-6b52e5d7254mr71300916d6.1.1719236748690;
        Mon, 24 Jun 2024 06:45:48 -0700 (PDT)
Received: from epic96565.epic.com (pat-verona-k.epic.com. [199.204.56.216])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b545b13ea8sm14665716d6.42.2024.06.24.06.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:45:46 -0700 (PDT)
From: Sean Allred <allred.sean@gmail.com>
To: David <dark0dave@mykolab.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] submodule: allow gitsubmodules to be pointed at tags
In-Reply-To: <7D5BFC58-9BF1-4818-828D-453C416949EB@mykolab.com> (David's
	message of "Mon, 24 Jun 2024 13:34:12 +0000")
References: <pull.1703.git.git.1718625706679.gitgitgadget@gmail.com>
	<m0wmmepj3b.fsf@epic96565.epic.com>
	<7D5BFC58-9BF1-4818-828D-453C416949EB@mykolab.com>
Date: Mon, 24 Jun 2024 08:45:45 -0500
Message-ID: <m0sex2pi7q.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

> On 24 June 2024 13:26:48 UTC, Sean Allred <allred.sean@gmail.com> wrote:
>>This is an interesting idea, so far as I understand it. I certainly
>>appreciate the desire to freeze your dependencies. I don't use
>>submodules often, but I do want to point out an inherent assumption in
>>your design: that tags don't move.
>>
>>Tags can move. It's usually impolite, but there can be reasonable
>>use-cases for doing so.
>>
>>With this in mind, what can go wrong if you have a submodule with a
>>configuration that doesn't necessarily match the tree?

David <dark0dave@mykolab.com> writes:
> That's fine, my assumption is that if the tag moved the owner of the
> repo intends this to happen. Like a hot fix or security change.
>
> What will happen is on update the submodule will be moved to the new
> commit. Just like if a branch was updated. Its very similar code
> between the two, as this is a super light touch change.

I'm assuming that the superproject tree itself still gets the subproject
commit OID, so the commit is still stable when tags in the subproject
are moved (setting aside the possibility that the commit in the
subproject may no longer be reachable... *shudder*). But doesn't it seem
odd -- particularly for the concept of tags -- that the behavior of
updating that tree could change depending on when you do it? For
developers that add external dependencies as subprojects and choose to
use this tagging feature, they could be in for a real surprise if they
don't realize this quirk of the implementation -- and they could
consider that behavior broken.

If you're ok with that behavior, then does it make sense to generalize
it to the concept of a ref instead of just a tag name? This may do a
better job of communicating the idea that no ref is inherently
immovable. (Not saying this is a good idea, but answering that question
might further hone in on why tags are the 'right' choice here as opposed
to any named commit.)

-- 
Sean Allred

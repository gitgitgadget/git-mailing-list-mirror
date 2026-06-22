Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C611FD4
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782156630; cv=pass; b=lCdQ0YiiYBgaJ86DNYYWQ7bdmH5aLW04EpPoEO8v56CyiEcA108swaC/++fkX6GEpHnTAlSfVfLPsBG5R7x3PrdnKN9azCoGvzR41LNFyoZlI/A0PQQ7PjKqz8W/B9PX2Ag7sVSqkH+LYMhwnZVzReX0MZYMI2QFGXnZVpLxi+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782156630; c=relaxed/simple;
	bh=f4hSOPsLmD+sV18ep5SjuNr2FX/0gdTp2Xx/iHU96EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7p7NMDqUNDJ1qxnebwLBujtS9CuuOcGY929HB43nQRlOwofMt6tYNxyVCpvgtCkQBhnQjlANxufeNtRnWj+hNTu9g7JUKaZIXLWkey2DxrC/GTnOure5ibtSBKhLCRciOXDmGKWxwiaCTIHKkL+F60Y2jY9q4oUw/Dh2fOQ3T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=Jx7H9h0z; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Jx7H9h0z"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-662bb8b1f93so4690132d50.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 12:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782156628; cv=none;
        d=google.com; s=arc-20240605;
        b=HMi7ySRITC+5MHSRXbPGYxSbJxwHE/0GcCELcOF6kPLnvUdtGQuZJ10SlZLzc6wLuR
         4ygjABSdaLTHKpZrLaEc6yisUdzMa6RQ2ZE8Cjy4YBG5Vpj5GY3wzXT4irXH5q93LjCt
         INqCj7MX5EbdOXUti+CkJWPhvFG81eNiwiy/0NT+cHh5yng1pNFjQKJpOZ7qKOu54a4e
         LVy2xdDoFpc+K4Qr+u9lF59LFmlHMsY1AnmWahdsJXSdhnaiqjOaDvkfO5CxFnJ2U7si
         JsA9gHpptg4eTgyw9q9AiRNpUkN+kLaKULAMwv+nwgIkfQImRX/myz5PIJ2eTiEHicsz
         v+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KYuHYVcxgG9lYgFHMJ3sZDMTk4pzhfgenB3x5WwtRJ0=;
        fh=jx8akqWiQrt9XgutDw73otrEUFpUqFfsgcY1dNVNyWI=;
        b=TGp3MmeWFPFEHwo5ZWcRyxeMUXBHnwtuF8NT8k9LGxxsNQviQedapuuiKOlzPueT/y
         J9d06digBC2y1JMPG8IPRuncM+X1UG1OcZ4KPlhMN9Qvq1P1fcZgcI3trY0TTOR8+Zva
         m/h/N08mSPkX4StsM7gtg04/g1P5xOwAbOdiELtxTO053c5Ad+MFm4CN2Iikfe/U6lfk
         QPmF2Umc2rKSgGg5VqAslp8RRM1lfFKhoalFipQsikc2rmyILKgtExWTmdyloMbFrAoV
         IyUErIK6GEAZpUV8qEgM8x77QtshieEBGVa6Im8qpWb/D58ILCncGtPRMe57dhC9cvMr
         z1TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782156628; x=1782761428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KYuHYVcxgG9lYgFHMJ3sZDMTk4pzhfgenB3x5WwtRJ0=;
        b=Jx7H9h0zzZcwgi7uul2QALADeXg5rI9JNxq9idG2au3K1lG3DLxi1hIL2yx22RY9Js
         FWB/pApEbM+mfYcyNiPjnWrXwuIZSGZxLnTLETXraU7LmNa5OqvASOIyO0BQOLNVcfHW
         cUpjBoP3/uGznoY4E5+5NHzZInvxufBfCzsUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782156628; x=1782761428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYuHYVcxgG9lYgFHMJ3sZDMTk4pzhfgenB3x5WwtRJ0=;
        b=ANdQ8VZYAX47lhBU5Ovyi50hhrnStblqN1RkR1EuJGbYOKiIFllQYNo//kJyqnMCOQ
         aghGEOj7EsgCDOhRmcP0cqY/W4JBE7p61sTUdzKcJ+TUnID07Ym64qUiqt+alQWtqgJo
         bpvRIoCxqClqjY7AoIq3pl8ue9nk7bvA/+oTyNq45E9df9s1Q0076DisxWRlNz0FdPUI
         lnOYMvYrqAGTGyNSoNMC1OFJHJbsNxyn413+pN8Y4n+OJiN4PTtTEDuaILJp4ko3OJFB
         KV4OiX6rSDxw1x0G8rziiCDhVL8MIlMOizq8gi7TA81vTR9vXFyOHlrhO7vlhOP9svf9
         eOcg==
X-Forwarded-Encrypted: i=1; AHgh+RrnY/WQszBBxnbOrarTUTGyxLS/u5F5ji3truPdInRYml7uOOIJ80nd+RjIlMXKy+YmMuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYjJWJ6Jc4mWicEQ1Dqe7ZxgZJnaThq6evXzCdaJwlYzyPDxYB
	O0JF7DvaIDyutSvKIYQYAzu8q3oRRhudCJe66lSBWVLhfj6Aw7dOqV8yH3yU8x7lRMUvDWgvts4
	Fbqoi+yx8HQsHvGmdSnW5nvqjCgrv4K6LcMxZ8LN4El+vplJxvKAkgFE=
X-Gm-Gg: AfdE7cmsKBYz0vyc8rpgnzW8T9BPZalYBl3UTloBsIBXkkRqYo9jruefVAnCeF9PV/Q
	RiKvwJlKvcvPbWsP4jv26eIi4DecOFsmeJSYIqkCfD7idxnSXJuasJ+3X7lUHTpZqqzOjsxJQJk
	4nGsSwf7smyfTGr/RZKCnadqK2GQnmipqUHBtButjAxFKbFEFxJiBgsTiuYsK7MgH/xPob4CEtq
	48HYBG6rWpg499IsAyqlYHqioeJmEnR/FhEtVX0odeUmjD8S5avmaws35Pa0mOg1fq7gdL/lQ==
X-Received: by 2002:a05:690e:118e:b0:660:3b5c:6a03 with SMTP id
 956f58d0204a3-66303725144mr12122412d50.61.1782156627998; Mon, 22 Jun 2026
 12:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <9cbfc67d724d91b9abc3621f03a3c97208c76a70.1781951820.git.gitgitgadget@gmail.com>
 <50dd5fb1-6b4e-448c-977c-cdc476f7fe40@gmail.com>
In-Reply-To: <50dd5fb1-6b4e-448c-977c-cdc476f7fe40@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 22 Jun 2026 21:30:16 +0200
X-Gm-Features: AVVi8CdQcyGgq2q2kxj27kTF5oKRtYN-YqnuptrEOXqKFJmZHpH-yDPoFaxiD3E
Message-ID: <CAL71e4PhazEZjaO9nY1SsjbYH+RPAOpJiUo4xSCnBCA6zi6ySQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 6/6] Documentation/technical: add paint-down-to-common doc
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jun 2026 at 20:21, Derrick Stolee <stolee@gmail.com> wrote:
>
> I like the idea of documenting this so it's easier to understand.

Yes I was myself thinking that I can prove it to myself now that it works,
and anyone else could also prove it to themselves, but having it
explicit here is even better. I found the other documents
(i.e. commit-graph) to be a good source of inspiration here.

> There is risk of drift from the actual implementation. You may want
> to add a comment to the method in commit-reach.c to indicate that
> any change should be reflected in this document.

Good idea, will add that.

> > +Termination
> > +-----------
> > +
> > +Termination happens when we can prove that no extra progress is
> > +possible. We are done with the main loop when one of the following
> > +conditions holds:
> > +
> > +  1. The queue is empty.
> > +  2. The queue only contains STALE entries.
> > +  3. Side-exhaustion: the walk has reached the finite region and one
> > +     of the sides is fully exhausted.
> It could be an interesting exercise, but potentially wasteful, to
> add this document as a Patch 1, but reflecting the old algorithm
> and then to update the document at the same time as you update the
> code.

I did consider that initially but I was worried it would be considered
noisy. I am quite happy to rework it in a way that first
explains the status quo. That would make the document diff
more interesting. Agreed that should become the first patch,
and the patch that changes the algorithm should include
the documentation change.

> The changes in your patch 2 would impact this doc in terms of the
> data being tracked by the paint_queue data structure instead of the
> nonstale_queue structure (though those details are not currently
> handled in the current version). The change to the termination
> condition would come along with patch 3.

Agreed, I would need to rephrase from tracking non-stale
to tracking counts of p1 and p2 (and pending merge bases) commits,
but I think that would be a small tweak and well worth doing.

Thanks,
Kristofer

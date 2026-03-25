Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8833CF69D
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439394; cv=pass; b=Tcqe0Pk7DtupZAfEvNFpjkbcrsKh71umDfpPiyYPqJLdOWGAOlLCGCLeZsOcw1s70Gqw46kDTBxCRZPQvkqjBMeB9Qhnftlk8nPBpB+CJWRw8ItJQ6QC7bGSml2hUxUyYX00p+t26+gLfGYmwaEWlcCUMQUz3HOqic6sKC3MaPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439394; c=relaxed/simple;
	bh=lS26Ny4+lIDe0TfMt6GDrClZ0o5RzMJvwULIshy1vjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGASh+qylfreB2ZMbeEWc7VbJGaoTrY825TNHlKJg4OIsVdj22onb7dSDgkNhEAlHMvxFZY0sMT4AonION6RN6iPxVLI1v6R7P7CbsAfPWJP7eQH7FhyF8XjvPlSGGOHXSNwf/pJGFqo9RBKCeWcDqwGbWrUwP4hUCsfSeJFkys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtKFHE9q; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtKFHE9q"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64e9f9226a7so5854486d50.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 04:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774439392; cv=none;
        d=google.com; s=arc-20240605;
        b=d6fQ3YBneoOns94B7yOH41MVgjeelu1a2gyujj1kwo8+9JZO7yCW3YZMCPzkhlhHdl
         hDfyZy/NdwABz5bI/wL91ehT7wNER0sx14rioKbqAvYHW+I68dwbf//WgDzz7CzifeOm
         WVr0PXM3ME/cfQVqCMyh0uI+l9SmGQnTl8zECESdMcsdyUGnBEeUq6lPvtwtJxasUd1V
         6gHwHKfX/hVQLq2FyIlcZde11/LKpsyq0cMOot6Y8kzRMTJiV/aZn4R6Y+bENFcT38ND
         GGqA0m47yoAaMtWiX9AngC3DwmuIyUyrnS0LPlBvKbmwMDdBOru4gRKEbA05NALRA0Fh
         z/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qiUiqPjz2bdpdh5WNWkdr4m0x2bZ63FN0COkEmAHB8g=;
        fh=W2Ymaphljb3B6vMw/6VvJkUdo4VPBGJRIbg71F2JQ9s=;
        b=O6e5rtu9HzT3z8bN3EuZwRJrzaphoEp8iB4KMSYrIuh6INByG4Dp5liLmSVz1quEWi
         U4ctw8UwMXvOPNl4xQa+teMbYE13f0dq/bQkJwz6r/y0kCpQX8ZGul2WBfR+nQXBIkjR
         OH9I51eWOQNKJpYD4d3sBdEAd5s9brrQWgZ0QL7pKQLYxQb2VqVaKVqs2QL3seI+PWsH
         l2KRWOPOjX0L7ILkiN5qbNNB8w9ncwRlTTmqk1HOJyfcaqQMrAqJEuQaZ3JyxIDwVhHo
         7xtsY0Ldff6/XGU0u11wR0WkkmW8g2CzJZ65j79whZBYBsw6bokppcHGZH8Kghajo3BU
         EZIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774439392; x=1775044192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qiUiqPjz2bdpdh5WNWkdr4m0x2bZ63FN0COkEmAHB8g=;
        b=dtKFHE9q2H4CXU09yjpixIzUJXCYfxsxKFYdABsPffNlWttEAwO5TIiofUNRiLwj8P
         Zp3SxnrfrXAaIjLTuRebGZRNECWt6lHLy6bj8RncxaBY5BFhlBcho71ZmHiStL3w7XUk
         QzGMZbNQYSrXh4DYU1ZXiLjFTC1VLYAlA99B0Ix4mmhHqcH0bvTcCDDU8WO9rvW+Wowh
         Btz9B0ENZo3mVLR/qfWT34CwGbPCKWu+1i/eAurQz/i9CpJIIi3Dj/CoQrzWLvwxQupU
         OMVNBJ+deKguxsn9HRTKRbRBMb1zlWpbdN5Q09ASRzre7RPQvwcCptLL3NpHgRQlokGB
         tYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774439392; x=1775044192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiUiqPjz2bdpdh5WNWkdr4m0x2bZ63FN0COkEmAHB8g=;
        b=aM0aLk/mXRrKsNbuMmg1Mvy/ts29MrRN8TCTUj9EUqF9oTKPITfULpjdzVJ3z/irbO
         wOTGJ4xyzX3IN5YSg0YVMNOPlzOS6RVZy00/MLlHcfq3K5LrrYTMXKZxAb7jp7tPAq4G
         StuQmMQDeTWUnPTp3TulcVzGlGSeedkyP4LtFSqaWAeOe2myuSKtkYj2+Vz2qjSwg3Ww
         6dj5KU9Dt7wUeACE8oUMu59n4oB06TBz0isFb9rPWhAFQxxdDq/R63XY8pIluDvYqG2a
         Jj1BMOw0Urjuh7p8KMzP9Aw9gDYZMW+CQe8zxKbyreF/pA5WeHB/KXJHgU5kebOluoSV
         ZQIw==
X-Gm-Message-State: AOJu0YwdXr7OvNAv6m21Csqu6BVP4KIeeNbXiurQDEDjfKgnasR3SIIA
	6xO0npQfFALhGCjlCY5oatuIYgVDQqzRL8lC9futH/9Wm+Z5z2n/gGv5cs60GPmBvuwqais4nOd
	ADNKj0DEE6qvn7/PXDdIXaj4C0i3Csx3UNkD7uhF+IQ==
X-Gm-Gg: ATEYQzx4H1xkaBIP2qShRpbTugZcQNvsjx5jsBP8i6pccd0Ws+qmiQOk/PeOru5pIlQ
	6PcNtDtImUX4JvdGrG0DxgOaiaw+SKdLOZACEf3unHYf1HRcADZomMn+u1q+GinaZChzrgy+fgg
	uTrbvcLwtAIc2ZcWM4CfFwmB5OiFpB7P+XXMfB7GeqkigF+dzlc8C02myBFn6l+n3u2ql4aM3Bu
	NIB4eHb67pPD09Ko6dw6/t/YjzCM8dmeViAVj8rsnOWFedIipjZWgWYSNIi/kYtV0XJL0oQrwNL
	mPArBPnGQmZpY9vzlcXPmZTSYt9Q3Lm+nJQmarIxmTUxSmFw0hpxWi67VJ8c+F+BFhLeDueemsv
	0kk8I8W4rpPb8QPTwNj4nkxk=
X-Received: by 2002:a05:690e:c49:b0:64e:e896:a98 with SMTP id
 956f58d0204a3-64ee896135dmr1758461d50.23.1774439392280; Wed, 25 Mar 2026
 04:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
 <20260323215935.74486-1-pabloosabaterr@gmail.com> <20260323215935.74486-4-pabloosabaterr@gmail.com>
 <6cdcece0-8cc5-4c87-8727-6d3e17424a9e@kdbg.org>
In-Reply-To: <6cdcece0-8cc5-4c87-8727-6d3e17424a9e@kdbg.org>
From: Pablo <pabloosabaterr@gmail.com>
Date: Wed, 25 Mar 2026 12:49:37 +0100
X-Gm-Features: AQROBzBdV7dYwQVUl32jdorJ76Wko3A-qg0pxwvmF0r1KCq0GfujOltCFuxOCKY
Message-ID: <CAN5EUNT+x=OmQb0JqcTYn_6xNSpKKTz71aZOfdM-CShjSbAyPw@mail.gmail.com>
Subject: Re: [GSoC PATCH v4 3/3] graph: add documentation and tests about --graph-lane-limit
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, christian.couder@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, 
	chandrapratap3519@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Johannes Sixt (<j6t@kdbg.org>) writes:
>
> Am 23.03.26 um 22:59 schrieb Pablo Sabater:
> > @@ -1259,6 +1259,11 @@ This implies the `--topo-order` option by default, but the
> >       in between them in that case. If _<barrier>_ is specified, it
> >       is the string that will be shown instead of the default one.
> >
> > +`--graph-lane-limit=<n>`::
> > +     When `--graph` is used, limit the number of graph lanes to be shown.
> > +     Lanes over the limit are replaced with a truncation mark '.'. By default
> > +     there is no limit.
>
> This should probably mention that 0 means no limit.

I'll add that, it is for zero or any negative number.

>
> > +
> >  ifdef::git-rev-list[]
> >  `--count`::
> >       Print a number stating how many commits would have been
> > diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
> > index 28d0779a8c..650701df42 100755
> > --- a/t/t4215-log-skewed-merges.sh
> > +++ b/t/t4215-log-skewed-merges.sh
> > @@ -370,4 +370,57 @@ test_expect_success 'log --graph with multiple tips' '
> >       EOF
> >  '
> >
> > +test_expect_success 'log --graph --graph-lane-limit=2 limited to two lanes' '
> > +     check_graph --graph-lane-limit=2 M_7 <<-\EOF
> > +     *-.   7_M4
> > +     |\ \
> > +     | | * 7_G
> > +     | | * 7_F
> > +     | * . 7_E
> > +     | * . 7_D
> > +     * | . 7_C
> > +     | |/
> > +     |/|
> > +     * | 7_B
> > +     |/
> > +     * 7_A
>
> I'm confused. If the lane limit is 2, why do we have actually have 3 lanes?
>
> > +test_expect_success 'log --graph --graph-lane-limit=3 limited to three lanes' '
> > +     check_graph --graph-lane-limit=3 M_1 M_3 M_5 M_7 <<-\EOF
> > +     *   7_M1
> > +     |\
> > +     | | *   7_M2
> > +     | | |\
> > +     | | | * 7_H
> > +     | | | . 7_M3
> > +     | | | . 7_J
> > +     | | | . 7_I
> > +     | | | . 7_M4
> > +     | |_|_.
> > +     |/| | .
> > +     | | |_.
> > +     | |/| .
> > +     | | | .
> > +     | | |/.
> > +     | | * . 7_G
> > +     | | | .
> > +     | | |/.
> > +     | | * . 7_F
> > +     | * | . 7_E
> > +     | | |/.
> > +     | |/| .
> > +     | * | . 7_D
> > +     | | |/
> > +     | |/|
> > +     * | | 7_C
> > +     | |/
> > +     |/|
> > +     * | 7_B
> > +     |/
> > +     * 7_A
>
> Same here. Why is there a fourth lane?

The extra column is the truncation marker that shows in every lane that
had to be truncated horizontally, not an actual lane, even tho that by
keeping the right side edge might seem confusing.

>
> Oh! "Truncation" here does not mean that the vertical lines are cut off
> and are supposed to continue sometime later in the chart. It literally
> means that the *line* is truncated and just some stuff *on that line* is
> omitted.
>
> Ouch! That was not what I was expecting. I thought that truncation means
> that when the eye follows a line vertically, it finds the truncation
> point of the line at some point, and then the continuation of that line
> is again some time later down the chart. The only clue which lanes are
> the same would be the color, which would have to be remedied somehow.
>
> I don't know what to make of it. I have to reconsider.

Yes, the truncation is horizontal, each lane is cut at the lane limit. I went
with this because it is more accessible starting to work at the graph and
understanding it (it is a 17 years old code).

Vertical truncation needs rearranging which lanes are visible and which
ones come and go, similar to gitk (This is the TODO idea that is present
on the graph.c code) I think it will be hard to do it even if there is a way
of not having to rewrite the whole graph rendering code. prob if this is done
it won't replace the actual --graph but actually become something like
--rgraph as a different graph rendering option.

>
> -- Hannes
>

I hope I a made my intentions with horizontal truncation more clear.
I'll send a v5 with all the changes talked about.

Thanks for the feedback throughout all the patches!
Pablo

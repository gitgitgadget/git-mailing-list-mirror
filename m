Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE2D25A645
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155714; cv=pass; b=FFfTapjBqRE6fmD0dPlD3qMqHw0JW185iAX7FtzWoxhyIH6P2I0EwmIFWyMye8AYhkDJvdD1QrX94n7JtgsFRvZe+922fyEA0t1ldGsjx+9K0rY2imjIcm4+sMrw60Wi0DgzGx05udhedjNeeuxDgyurqNNLwztHSb+28ZjM+8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155714; c=relaxed/simple;
	bh=cR/ZJjBnC9PHYox2LCcXncMewNd9jToPXX48rDUrR/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pau6xrbLPSukq2Nm+Buvp5clKIjCRcIYQK9jg3C/zhTve16tapHXjcN16WvU8tq+yQYJ17WbmkgltPAMk+jqNNiFwFkCHy6oLE1Fu4nn0Im9CCJKHrEZ1P8c/B8Idn+GMI4Axj33Xst2GqNjz28OzaoS0cpUbjsmtLdg1tdXubc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=bAYH6ZqD; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="bAYH6ZqD"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6626b5ace23so299054d50.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 12:15:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782155711; cv=none;
        d=google.com; s=arc-20260327;
        b=RoXQ04CzthE5RxXKfJUvvvd1CX8ASVDqYIpd2A2I91YEhyZI4WLSIptk8unRyvtLAR
         yVOkazkXtUXdFilY6GN1l5JhjFl/lDMn7iij30Vtm8/1XZEolfQme8TlZHKFH2dtimHM
         v97ZqeW0mK1sT+QdeE5GeB7A+v6mzfWiKlXbEldTkLdfmuHzrVlgWTKuHNoBrdtjy9F8
         hmEMR3B9z428CqHICMPS3miNTK3aekkns27ZhPdC9brD+HVPUgydfK+F3y+GW9jZXye4
         vz/MvAxKv4CO+P0i1z7d47keARF8zd9ef91Z4BV75mPlvVyrYn8P0DADupYAWG+ymQNw
         4LMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sq4HeJEckZRANPzvlQxfvqIQ+VD6JzP3lHINL/231DQ=;
        fh=S8vLEE7hdkVMS7CDGuTbmIQI7WgG/qgvFenwtvloN0I=;
        b=Oa0F0W6w8Aan9YiqMTSbyI2PdtycM0fdpXFO7NeGvQvaNOFopTD7Us1YUKqrx73Zj9
         4q6Akuy5klzdiDSti1ZxFrNbC83Bb4LJPGL8SUA8Yk5zE6Wj1ZPqxmx7jtE3FwZIHqJs
         rJnftIkquDpJiQQThAAQ0cKF/SSz1PT+xf1BRJ0xi5NUHoj1926iBvS28E6IafD3UcvG
         5FSXugRrGw8XVvSctNnJaeO7upCGZHs7s5L1RTI3N12I2pfdij1Dgm9EHcY5sVHNf+KE
         ZMyO9TCUSi6LPOi8b/cz+6dbFEizFlyCCAsuQhToc8UM1poCAHgCR7HxG19ejTvou8IU
         M1jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782155711; x=1782760511; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sq4HeJEckZRANPzvlQxfvqIQ+VD6JzP3lHINL/231DQ=;
        b=bAYH6ZqDcTYIN0DYIzxZTjiAS6+iewthDOe1CETvtuWrCWKsSYYUC8qqzapvLMYwQB
         nJLZENMa+bPu0wSvjQkbg/i/syi00MVetDZvrZxiMbNAags+F+1JzZuv1lwugO1ULi2/
         7z0lilnBYfF1TTbvpsCAif9QX2D/2xD5I5YXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782155711; x=1782760511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq4HeJEckZRANPzvlQxfvqIQ+VD6JzP3lHINL/231DQ=;
        b=cPT7sAMi5qqUk1wBce1iDHJC06lkpVRdG0aYRdD9mKtdcCrcjQqmZgEebF2jXeRhyq
         BT6y+tFoIZ3bwYlfZjlt3nl+r24MWs9mbR1pvhApDIj/uLD8AUU2NnzTN/kO2lFbocnu
         cIT3X66MN8Kki90m2tID3tfwL0rU9fxmnuTBEI9UtCBxyN24BjnRvrzICqSNOKM63CIt
         tZrfASFlJnLHxhl7NyUiQsQNsI5+bOQJaJSoPnl3XiQK7WkZpIe9YPsm8Zc3Urg+krD6
         xHT0GGnef060p8cbg8WIoPo6BOmkzySyX6OGiG8jRopzEtPXkghPkV7yXOoDY96vnHj4
         YBXQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro74Zsdrt/45LBX0HmklyA0xunBXahc/+lVh1TX5Hk5JB/wVS1vmwHySd4TCyxBrJBL+yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQp5l08GGOIUnxQs7OvIqu5Bz/R8PKwIscB5c2YMMc1ErTQbkY
	pqIFPeiO7gPn4sQpXq371MNYpI7FMTjwMb/DI5Uf2kWjiD7NctX53TTS61cIW6IWrhWy/7eIhsR
	hAZuz0eiDvjVY5Ijibc6aGB/DuLpFiuWTSwqnHYpsxQ==
X-Gm-Gg: AfdE7cl9YAeGQImECzm2mIeHQ1ldPwrNcxOx65RO/7I0kBY9iEijIQnPrkxtwCkE7yD
	arMKqFRdZna0RPi2d3sZvKaU5+DiU2QHLvpA36TY2BeEmPvoA6CkoaZoB3eVDuConEmFVrPBY4u
	6CYmmwFvRmOOGmISAoCqzLR7a+2DjVB6KN+j7wU53W6LSVNFRZzAFErYllC60kQkXZSDSm0Xz3f
	hhjj2luoxHKJDDQ5De9cDURRtmX7RgwcER5LFUKz/BJs7cJT5rauxBCshtql+v20/9OFZKnoA==
X-Received: by 2002:a05:690e:241b:b0:651:bd7e:c04c with SMTP id
 956f58d0204a3-6635553aea8mr618330d50.21.1782155711426; Mon, 22 Jun 2026
 12:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <316e4dfe261043730c77142639f86f5c3cabe370.1781951820.git.gitgitgadget@gmail.com>
 <f0c9eb6e-60b1-4eb6-86be-3af4d87afe85@gmail.com>
In-Reply-To: <f0c9eb6e-60b1-4eb6-86be-3af4d87afe85@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 22 Jun 2026 21:14:57 +0200
X-Gm-Features: AVVi8CcvOgCCFnkuv68VMNkz4FU4aZDDhhIFSSocl1Hsnbnk2--Qhq2YF-4WEic
Message-ID: <CAL71e4Pcw-UUbHBw_j6PFx2bXmxZ93VLMWG+3Qap=RmCJa_ZgA@mail.gmail.com>
Subject: Re: [PATCH/RFC 2/6] commit-reach: introduce struct paint_queue with
 per-side counters
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jun 2026 at 20:10, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/20/2026 6:36 AM, Kristofer Karlsson via GitGitGadget wrote:
> > From: Kristofer Karlsson <krka@spotify.com>
>
> > +     if (!(old_paint & STALE)) {
> > +             switch (old_paint & (PARENT1 | PARENT2)) {
> > +             case 0:                  break;
> > +             case PARENT1:            queue->p1_count--; break;
> > +             case PARENT2:            queue->p2_count--; break;
> > +             case PARENT1 | PARENT2:  queue->pending_merge_bases--; break;
> > +             default:                 BUG("unexpected paint state");
> > +             }
> > +     }
> > +     if (!(new_paint & STALE)) {
> > +             switch (new_paint & (PARENT1 | PARENT2)) {
> > +             case 0:                  break;
> > +             case PARENT1:            queue->p1_count++; break;
> > +             case PARENT2:            queue->p2_count++; break;
> > +             case PARENT1 | PARENT2:  queue->pending_merge_bases++; break;
> > +             default:                 BUG("unexpected paint state");
> > +             }
> > +     }
>
> While correct and compact, I don't believe that these switch
> statements follow the coding guidelines. We should split the
> lines appropriately so they are more standard, such as:
>
> if (!(new_paint & STALE)) {
>         switch (new_paint & (PARENT1 | PARENT2)) {
>         case 0:
>                 break;
>
>         case PARENT1:
>                 queue->p1_count++;
>                 break;
>
>         case PARENT2:
>                 queue->p2_count++;
>                 break;
>
>         case PARENT1 | PARENT2:
>                 queue->pending_merge_bases++;
>                 break;
>
>         default:
>                 BUG("unexpected paint state");
>         }
> }

Agreed, I will change to that style. I did try to look for style guidelines
but I missed the .clang-format file (I was only looking through text files).
Apologies, will remember clang-format for next time (and v2)

> Also: technically "case 0" should be a BUG() state, right? We
> shouldn't be walking any commit that isn't reachable from at
> least one side. (case 0 does happen for old_paint, though.)

No, this is actually intended - initially I started with skipping
case 0 and let it fall through, but that would hide _other_ bugs.
I use 0 as a marker for "not in the queue" so we have this:
Enqueuing: 0 -> flags
Dequeueing: flags -> 0
Only the case with the modified commit being in the queue
will have non-zero flags. I tried to document this, but perhaps
it is not clear enough, I will see if I can rephrase it, or add an
inline comment around the case itself.

> > -static void clear_nonstale_queue(struct nonstale_queue *queue)
> > +static void paint_queue_put(struct paint_queue *queue,
> > +                         struct commit *c, unsigned add_flags)
> >  {
> > -     clear_prio_queue(&queue->pq);
> > -     queue->max_nonstale = NULL;
> > -}
> > +     unsigned old_flags = c->object.flags;
> > +     c->object.flags |= add_flags;
>
> Diffs like this are part of the reason I'd like to see a _new_
> data structure instead of replacing the old one. Keeping the
> old one for ahead_behind seems like a good idea to me, but even
> if we don't land on that end state then deleting the old code
> _after_ adding the new code will make the diff more readable.

Agreed, will address that.

> > -     struct nonstale_queue queue = {
> > -             { compare_commits_by_gen_then_commit_date }
> > +     struct paint_queue queue = {
> > +             .pq = { compare_commits_by_gen_then_commit_date }
> >       };
>
> I didn't notice when reading the struct definition, but looking at
> 'pq' here makes me think that we shouldn't be using that abbreviation
> as it could stand for "prio_queue" or "paint_queue".

Good point, I should pick a longer name for the field. Perhaps simply queue
(I want to avoid prio_queue since it exactly matches the name of the struct
which could be confusing.)

> > +     while ((commit = paint_queue_get(&queue))) {
> ...> +
> > +             if (queue.p1_count + queue.p2_count +
> > +                 queue.pending_merge_bases == 0)
> > +                     break;
> >       }
> When possible, I like to try to make loops only have one terminating
> condition. Should we have paint_queue_get() return NULL when it sees
> this internal state condition?

Possibly, but that would couple the paint_queue struct very tightly with
the usage. Not a problem in practice since it only has one call site, and
it's unlikely that we want to add more of them but it may feel more natural
to let the paint_queue purely have the queue semantics and counters,
and keep the halt condition within the function itself. I don't feel
super-strongly about this and can change it if needed, I will just need to
verify that nothing else gets complex as a result, I have not fully thought
through the effects.

> Also, I'd rather see it of the form of (!count) instead of using
> addition to make it clear that we care about each value being zero.

I did consider that, and most of the code in commit-reach.c at least
prefers x and !x over x != 0 and x == 0, but my thinking was that
other code in the repo did use comparison operators specifically
for things like counters. Happy to change it to conform better though!

> Finally, I think we actually want this case to get the benefit:
>
>         if ((!queue.p1_count || !queue.p2_count) &&
>             !queue.pending_merge_bases)
>
> I do see that you have this condition in patch 3 with the extra
> detail that the max generation in the queue is finite. I think this
> is more reason to include this in the data structure method and not
> in the loop.

Yes, but just to be clear, you don't want to merge together patch 2 and 3
here, just grouping the halt conditions closer together
(within paint_queue_get)? Keeping patch 2 and 3 separate would be nice
to make it easier to show that introducing this extra counter bookkeeping
does not negatively impact the overall performance too much.

Thanks! I appreciate the thorough review of this patch
(which I feared was the most annoying one to look at).

Kristofer

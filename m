Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3176C79C3
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 23:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="qjfnzEdE"
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA374D79
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 16:17:52 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ca215cc713so22736225ad.3
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 16:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1698103072; x=1698707872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CqpN7uuMqVp8d00/l37hHU6l3cPGhUDpLKKoREhI4SU=;
        b=qjfnzEdER2nNXExjOWQz5dzt1LE38NyfANGxWHNYPazT5UFEh9BMLnLnVv9zGIY95A
         JcQiWAHVdFpiPUyx7x0kbFmBy+WKvcS/Uy2YBXmbhm1hytC63GExzl+jcuy8V86PzDDP
         qWuwxwMJmP6BAIgxIXvj9wsc+iIG8s5QXoeWEu6peyekOn1MR/u4oU0Od3cbz3jlzjeM
         hzq5l5lrlDLB35TXNGcZudXv0T73cWPRRlsTMpKszMssuIYdArz55UKqdylvb+uN7caD
         c8gnB66IJN0+51YNpsh6vRWoToNeONP+NWqAW2G3FGCz8gIRsAhZo2ovnzFFuQW1p+8y
         KAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698103072; x=1698707872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqpN7uuMqVp8d00/l37hHU6l3cPGhUDpLKKoREhI4SU=;
        b=f0sw+Ry72/EvUEcAfPxs01B3pJZeO8cwi3qtg81cmzgPFPXwu0cjC/OhBWq3X9j5Qp
         y8UyNPFWdPFWDR1O1GBdWFBZR9YUrxxT9H4W12mcE2q1hJRPRUUTFaR1VOst8iB1eNTt
         3gAN2aF9kW8G+bokOx8t/sSinL113wZnGhS4765tkFMrovM1kfEsC3jMpH+oU5EikZGm
         KxNN6eglllxlgwmtfqPOUvZNFewfhVZqhDewkY9CzeQmArkphhU129nJ0ARinteE37Oa
         agGcT+qEhO7wRkg0pdoP+1v+spHGpBEhynZ05b+iZBg0aLa9+3SyuDuIj3NDxha974tL
         FvVA==
X-Gm-Message-State: AOJu0YzEIbVnwIiCy1PELMX/CUkWS8us7gzt2c0Mx6Y/X1pZgW2oFpe1
	zznx6s/8SaBnWI63yI6BXzMAefcZlR3yIKWMorY=
X-Google-Smtp-Source: AGHT+IGn2GcnWE73Bsq9pE8ZTFerA1F36A5axR9WeiZIPvJwSPh+QikIXwoIN4w4QrVzg0cql6wUoA==
X-Received: by 2002:a17:902:c404:b0:1c7:8345:f377 with SMTP id k4-20020a170902c40400b001c78345f377mr10614529plk.29.1698103072288;
        Mon, 23 Oct 2023 16:17:52 -0700 (PDT)
Received: from initialcommit.io (mobile-166-170-45-205.mycingular.net. [166.170.45.205])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b001c5fa48b9a0sm6657992pli.33.2023.10.23.16.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 16:17:51 -0700 (PDT)
Date: Mon, 23 Oct 2023 16:17:49 -0700
From: Jacob Stopak <jacob@initialcommit.io>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
Message-ID: <ZTb/HeILRHnZjaz6.jacob@initialcommit.io>
References: <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org>
 <ZTT5uI5Hm1+n0Agx@ugly>
 <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org>
 <ZTZQZhtTxvGT/s81@ugly>
 <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io>
 <ZTa4iqe0lqn/Yg5L@ugly>
 <ZTbJiIkIyXwWK8JP.jacob@initialcommit.io>
 <ZTbVY7Nf+DTYqHky@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTbVY7Nf+DTYqHky@ugly>

On Mon, Oct 23, 2023 at 10:19:47PM +0200, Oswald Buddenhagen wrote:
> On Mon, Oct 23, 2023 at 12:29:12PM -0700, Jacob Stopak wrote:
> > Those arrows showing how things move only really apply to "simulating"
> > (dry runs) for specific commands like add, restore, rm, commit, stash,
> > etc, so making the --table proposal a default status output would still
> > miss those scenarios.
> > 
> you're too focused on the status quo of your own tool. :-)

Ha it's possible. I created git-sim with a very specific use case in mind
so you're right it's probably worth rethinking that while taking into account
Git's other functionality that wasn't in the picture with an external tool.

> there is really nothing that would speak against the real commands reporting
> what they just *actually did*. this would seem rather helpful for noobs and
> other insecure users.

That's true, it would be just as easy to report the results of a command
(and even easier in some cases) than forecasting the result in a dry-run.
The question is how to decide which one? Do you report the results of
certain commands by default while hints are enabled? And only as a dry run
when the --dry-run / -n flag is added? That actually would make sense as
it wouldn't add "special" behavior to the dry run. The dry run would just
report the exact same default output as the normal command, but omit the action.

> if one really wanted, "you can also use this with --dry-run" could be part
> of the hint that would say how to turn off the extra verbosity (or just the
> hint itself, if one likes the verbosity).

Interesting. So many ways to think about how to optimize the user
interaction...

> one could even go one step further and put at least the destructive commands
> into interactive/confirmation mode by default. but that's probably a bridge
> too far, as it would be potentially habit-forming in a bad way.

That would be an interesting add on to our discussion above. So as a
thought experiment, let's pretend there are no restrictions from
traditional users, we could:

  1) Enable verbose results output by default to certain commands, which
     could include a visual table-based output where applicable, and a
     hint to disable it. (Are hints currently command-specific? Or even
     scenario-specific within a command? Or is it all or nothing?)

  2) Include verbose/table results on dry runs, and add dry run flags onto
     commands that should seem to have it for consistency. For example
     "git add" has a dry run flag but "git restore" (the hinted inverse
     operation) does not. I assume on dry runs hints wouldn't be used to
     communicate anything.

  3) Well, I'll admit about once every 3 months I run "git stash --all"
     when I really meant "git stash --include-untracked" and proceed to
     lose a small part of my soul. This would be saved by a simple
     confirmation. I find that the stuff like "git reset --hard" doesn't
     bother me anymore since I know when to be careful with it and what
     things I can get back and how to do it. But I find the nasty ones
     are the things that sound like what you want but end up doing
     something bad. Not sure there is a way to isolate those though...

     I'm rambling now. But maybe for interactivity, at the very least it
     could be added to dry runs, like a "Here's what would happen, want
     to run it now?" I got this feedback a few times for git-sim as well.

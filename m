From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 0/2] strbuf: improve API
Date: Wed, 01 Jun 2016 16:22:22 -0400
Organization: Twitter
Message-ID: <1464812542.3988.12.camel@twopensource.com>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
	 <1069084553.156626.1464607928755.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	 <20160601074218.GB14096@sigill.intra.peff.net>
	 <1464810629.3988.11.camel@twopensource.com>
	 <20160601200959.GA13061@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	matthieu moy <matthieu.moy@grenoble-inp.fr>,
	mhagger@alum.mit.edu
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 22:22:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8Cet-0007PA-5T
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 22:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbcFAUW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 16:22:27 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33197 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbcFAUW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 16:22:26 -0400
Received: by mail-qg0-f50.google.com with SMTP id 52so48911043qgy.0
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 13:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=81rPN5yP5NnVvns2ibgs1O0ecAPke4/VCCmRjOYB4W0=;
        b=HmlpZk8ssSoeueW9MAgwoO1Ck/ksTb3wp2AoH20XfnKhxJ777P6SimBxd7ILuF4loe
         tDUpCniHJ6NuBcFupNfrm0kBDuLnocpsQ3lJzm/RLeur67DMj1JgfPjikBv58j/DFiez
         WzcdW3s1129ErXoKNnZnByI9IW4JufHtPvFPHCZi4WEDB+RGHMkky2soZPVRqrnrwJOM
         hNyNQIeg6NL1A68lJE3sXXS5IoUXn6CJ/3TnAtEOfKV+cyOgtvBEGbcQDTM4UI5rmzbO
         ukoOtbPgtKML9pztnJYO0e4HmY3wX3ralC+fJwkW1PPHAlzxtMeCrDMKT4hDi2pMTrZ5
         k9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=81rPN5yP5NnVvns2ibgs1O0ecAPke4/VCCmRjOYB4W0=;
        b=SlMJgDC8yQ3UC7VE4TfHC/abfQI0AyQNk9eXJaeJ8zBStkAJYM0rVwiMlJ3R3Pl5pe
         afdPVUux6uI8QZS80OvBAS5n+vxlYGcyIeKfnq5mqHmQ/e+PIeJDMGLPVS1a9L5s7ds8
         Mjq5FSS/86EDYQiZ4miAPw5BVhIInBx1rEL2nTyRADpANp4XxkAQU65jVrVeBaT4LQay
         xR2RDTtVwqYCzriDWm8dwRb8ah0lFmr7e+fCWga0oP+DpauxgS8zwiIdTvi0w5tM/EXZ
         G+sOz01c2Nnz5VXV72Idd6q1DAteJzbFrw3h12uM8r2am4qTh+4ZdKoGrA8E/T95XsdU
         XvXw==
X-Gm-Message-State: ALyK8tJ8VqxrWexC3P3kkIH9m3LBChBt8erRkxQoLlfxs7J1SB3X6v1mFuiVLA1TUSpZjQ==
X-Received: by 10.140.230.81 with SMTP id a78mr40646349qhc.68.1464812545130;
        Wed, 01 Jun 2016 13:22:25 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id w43sm1120300qge.32.2016.06.01.13.22.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Jun 2016 13:22:23 -0700 (PDT)
In-Reply-To: <20160601200959.GA13061@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296156>

On Wed, 2016-06-01 at 16:09 -0400, Jeff King wrote:
> On Wed, Jun 01, 2016 at 03:50:29PM -0400, David Turner wrote:
> 
> > On Wed, 2016-06-01 at 03:42 -0400, Jeff King wrote:
> > >   2. Do caching tricks for strbufs used in tight loops. For
> > > example,
> > >      have strbuf_release() throw its buffer into a last-used
> > > cache,
> > > and
> > >      let the next strbuf_grow() use that cache entry. This cuts
> > > malloc()
> > >      out of the loop.
> > > 
> > >      You'd probably want to protect the cache with a mutex,
> > > though.
> > 
> > 
> > ... or make the last-used cache be thread-local.
> 
> Good idea.
> 
> I almost didn't mention threading at all, because I'd be surprised if
> malloc lock contention is a serious bottleneck for us anywhere.
> 
> It's hard to really say much concrete because it's not clear to me
> where
> people think strbuf allocation _is_ a bottleneck (or again, _would
> be_
> if we were to use it more).
> 
> If we imagine a loop like this:
> 
>   for (i = 0; i < n; i++) {
> 	struct strbuf buf = STRBUF_INIT;
> 	do_something_with(&buf);
> 	strbuf_release(&buf);
>   }
> 
> then yes, we'll call malloc() and free() a lot of times. But unless
> your
> libc malloc is terrible, those calls are all probably just taking a
> mutex and reusing the same block from a free list. The strbuf case is
> actually really friendly to allocators because our blocks tend to be
> predictable sizes (they're sized by ALLOC_GROW, which has a
> deterministic set of block sizes).
> 
> In practice, I'd imagine loops get more complicated than that. They
> call
> sub-functions which allocate a strbuf, and sometimes don't release it
> until other strbufs have been allocated, etc. The proposal in this
> thread is basically using the call stack to mirror the allocation
> patterns. So when the pattern of allocations matches an actual stack,
> that's good, but I'd expect a reasonably smart allocator to perform
> similarly. And when it's not a true stack, the stack-based strbufs
> are
> going to end up with wasted stack space hanging around even after
> we've
> free()'d the memory and could reuse it. And I'd still expect an
> allocator based off a linked list or something to handle such cases
> pretty well.
> 
> There are also other non-big-O factors at play in modern systems,
> like
> CPU cache footprints. Is heap memory cheaper or more expensive to
> access
> than stack? I can imagine stack is kept in the cache better, but if
> you're reusing the same heap block over and over, it probably stays
> in
> cache, too. But if you have unused stack buffers that _could_ be
> reused
> (but won't be because you'd have to manually feed them to a new
> strbuf),
> that hurts your footprint. And on top of that, the stack proposals
> I've
> seen generally involve over-sizing the stack buffers out of a fear of
> actually calling malloc.
> 
> And then on top of that, there is the question of whether anything
> involving a strbuf allocation is actually a tight enough loop to even
> _care_ about cache dynamics.
> 
> So again, I'm slightly negative on anything that makes the code even
> slightly more complex, especially the call sites, if we can't show
> actual measurable improvement numbers.
> 
> Sorry, this turned into a mini-rant, and it's not really directed at
> you, David. Your email was just what spurred me to put some of these
> thoughts into words. :)

I agree with all this stuff anyway.

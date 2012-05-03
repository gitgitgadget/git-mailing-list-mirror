From: Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>
Subject: [git] Re: Bug in git-stash(.sh) ?
Date: Thu, 3 May 2012 14:44:01 -0400
Message-ID: <20386.53745.200846.115335@winooski.ccs.neu.edu>
References: <20379.9312.943088.350379@winooski.ccs.neu.edu>
	<87wr4za9mr.fsf@gmail.com>
	<m2pqasb8mr.fsf@linux-m68k.org>
	<xmqqvckk93ta.fsf@junio.mtv.corp.google.com>
	<CALO-gut4csy5wef4iGPGD5jVPc1f0iFBfS3MUWrOwc2yczdviw@mail.gmail.com>
	<20380.33897.666338.766096@winooski.ccs.neu.edu>
	<20120429220132.GB4491@sigill.intra.peff.net>
	<20381.49180.329586.983166@winooski.ccs.neu.edu>
	<20120501134254.GA11900@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Yann Hodique <yann.hodique-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Andreas Schwab <schwab-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>,
        Eli Barzilay <public-eli-oSK4jVRJLyZg9hUCZPvPmw-wOFGN7rlS/M9smdsby/KFg@public.gmane.org>,
        git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Eli Barzilay <public-eli-oSK4jVRJLyZg9hUCZPvPmw-wOFGN7rlS/M9smdsby/KFg@public.gmane.org>,
        magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>
X-From: magit+bncCOHCzKWgHRD1o4v9BBoEoO7rEA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu May 03 20:44:08 2012
Return-path: <magit+bncCOHCzKWgHRD1o4v9BBoEoO7rEA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-pb0-f58.google.com ([209.85.160.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCOHCzKWgHRD1o4v9BBoEoO7rEA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SQ10Y-0000uJ-Uv
	for gcvgm-magit-3@m.gmane.org; Thu, 03 May 2012 20:44:07 +0200
Received: by pbbro8 with SMTP id ro8sf2262959pbb.3
        for <gcvgm-magit-3@m.gmane.org>; Thu, 03 May 2012 11:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:mime-version:message-id:date:to:cc
         :subject:in-reply-to:references:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=4UH6vX0qsY+Lnq2LYTB4OuFsbtfQJv3rgoOyA9AI1k8=;
        b=h5IYcDC2ji/7G3M5cIXNnu2G6tL0afUl7o1mK1AuCqQBaIRjFtSzLkjK/v+ztw8zid
         r78BtnJqp5UuXr7WVlPcOwFktZjzKtTXzEs5/DW8MM1Gm165AnfF99caapwv7u0D9FfX
         8lNMveXsMYeFm7K2C9tr+e9hOlL4nb/7tZu2E=
Received: by 10.50.34.231 with SMTP id c7mr177317igj.6.1336070645326;
        Thu, 03 May 2012 11:44:05 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.231.58.146 with SMTP id g18ls1283935ibh.3.gmail; Thu, 03 May
 2012 11:44:04 -0700 (PDT)
Received: by 10.50.197.137 with SMTP id iu9mr1389310igc.5.1336070644488;
        Thu, 03 May 2012 11:44:04 -0700 (PDT)
Received: by 10.50.197.137 with SMTP id iu9mr1389309igc.5.1336070644474;
        Thu, 03 May 2012 11:44:04 -0700 (PDT)
Received: from winooski.ccs.neu.edu (winooski.ccs.neu.edu. [129.10.115.117])
        by gmr-mx.google.com with ESMTPS id xn7si517600igb.1.2012.05.03.11.44.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 May 2012 11:44:04 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org designates 129.10.115.117 as permitted sender) client-ip=129.10.115.117;
Received: from winooski.ccs.neu.edu (localhost.localdomain [127.0.0.1])
	by winooski.ccs.neu.edu (8.14.4/8.14.4) with ESMTP id q43Ii2Ii032280;
	Thu, 3 May 2012 14:44:02 -0400
Received: (from eli@localhost)
	by winooski.ccs.neu.edu (8.14.4/8.14.4/Submit) id q43Ii1GT032276;
	Thu, 3 May 2012 14:44:01 -0400
In-Reply-To: <20120501134254.GA11900-bBVMEuqLR+SYVEpFpFwlB0AkDMvbqDRI@public.gmane.org>
X-Mailer: VM 8.2.0a under 23.2.1 (x86_64-redhat-linux-gnu)
X-Original-Sender: eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 best guess record for domain of eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org designates
 129.10.115.117 as permitted sender) smtp.mail=eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org
Precedence: list
Mailing-list: list magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact magit+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <magit.googlegroups.com>
X-Google-Group-Id: 752745291123
List-Post: <http://groups.google.com/group/magit/post?hl=en_US>, <mailto:magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:magit+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/magit?hl=en_US>
Sender: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:magit+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:googlegroups-manage+752745291123+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196934>

Two days ago, Jeff King wrote:
> On Sun, Apr 29, 2012 at 06:26:36PM -0400, Eli Barzilay wrote:
> 
> > > which led to f4ea32f (improve reflog date/number heuristic,
> > > 2009-09-24).  That fixed the case of:
> > > 
> > >   git config log.date iso
> > >   git log -g --oneline
> > > 
> > > But later, 8f8f547 (Introduce new pretty formats %g[sdD] for reflog
> > > information, 2009-10-19) added another way to show selectors, and it
> > > did not respect the date_mode_explicit flag from f4ea32f. Which I
> > > think is a bug.
> > > 
> > > So the right solution is to pass the date_mode_explicit flag through
> > > to the pretty-print --format code, and then pass it along to the
> > > reflog code.
> > 
> > Assuming that I followed all of that correctly, it still seems bogus
> > to do that, given that %gd and %gD are described as producing reflog
> > selector, and given that Junio's note that stash operations are really
> > intended to be used only with these selectos.
> 
> Keep in mind this bug is not about stash at all; it is about showing
> reflog selectors. Those are a more general mechanism, and are used for
> more than just stash. The fact that user config affects the format of
> "%gd" is a bug; it should follow the same rules as the regular reflog
> pretty-printing (and the behavior of neither should be affected by user
> config, as scripts rely on the output being consistent).
> 
> Once that is fixed, then we can consider whether something more should
> happen for stash (though I am inclined to say that is enough; it is a
> feature that you can do "git stash list --date=relative" to see the
> stash timestamps).

Since the general problem is bigger, how about just the quick patch of
adding --date=default in the list_stash function as a stopgap?  That
seems to be close enough to how it should work anyway.


> > What looks more sensible to me given the necessity of %gd (and the
> > fact that it's different from %cd/%ad) is to change things as
> > follows:
> > 
> >   * %gd produces only the date, with the "default" having the same
> >     meaning as elsewhere (so it doesn't show the index numbers)
> 
> %gd is part of the public interface and will not change its semantics
> (or at least not without a long deprecation period).  It's a shame
> that "d" is taken for the selector, when it would be better to mean
> "date" as it does for author and committer. But I don't know if it's
> worth changing at this point.

(Yeah, I can see that.)


> >   * Some new %gi uses the index number: stash@{1}, and %gI produces
> >     refs/stash@{1}, unrelated to any date setting
> >   * git-stash.sh uses %gi so the output has the numbers
> >   * Some new option for "stash list" for the format string, so it's
> >     possible to show the dates if you want to with something like
> >     git stash list --format:"%gi: %gs (%gd)"
> 
> I don't have a huge problem with that. But what issue is it really
> solving? Are people using "git stash list --date=iso" and then
> getting confused by the output? Or is it simply a matter of
> mistakenly applying the config when it should not be? The latter
> needs fixed in either case.

It's basically an attempt to have a %gi that is disconnected from date
options (config or flags), which solves the config problem in a
trivial way (no date options are used)...

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!

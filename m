From: Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>
Subject: Re: Bug in git-stash(.sh) ?
Date: Sun, 29 Apr 2012 18:26:36 -0400
Message-ID: <20381.49180.329586.983166@winooski.ccs.neu.edu>
References: <20379.9312.943088.350379@winooski.ccs.neu.edu>
	<87wr4za9mr.fsf@gmail.com>
	<m2pqasb8mr.fsf@linux-m68k.org>
	<xmqqvckk93ta.fsf@junio.mtv.corp.google.com>
	<CALO-gut4csy5wef4iGPGD5jVPc1f0iFBfS3MUWrOwc2yczdviw@mail.gmail.com>
	<20380.33897.666338.766096@winooski.ccs.neu.edu>
	<20120429220132.GB4491@sigill.intra.peff.net>
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
X-From: magit+bncCOHCzKWgHRCfgPf8BBoEMbLpOA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Apr 30 00:26:43 2012
Return-path: <magit+bncCOHCzKWgHRCfgPf8BBoEMbLpOA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-iy0-f186.google.com ([209.85.210.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCOHCzKWgHRCfgPf8BBoEMbLpOA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SOcZk-0000HM-TD
	for gcvgm-magit-3@m.gmane.org; Mon, 30 Apr 2012 00:26:41 +0200
Received: by iaae16 with SMTP id e16sf3570318iaa.3
        for <gcvgm-magit-3@m.gmane.org>; Sun, 29 Apr 2012 15:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:mime-version:message-id:date:to:cc
         :subject:in-reply-to:references:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=8BQ3CU6I7MzLqnkdNDpdMPyFxVQllkNQjdfvrWIqEA4=;
        b=2evOPkFGvy3mDsMBfWIAfDZVou0M3cHv750EtW2iyWjdUW9hKKOQCivAluvqclxrCA
         eoGZ5dyloLei9Ql4Wo9eXXeaiuaGU5dQLX7IFXW2pVBeIJwtj1kipyt1WdMilh1R/409
         yI+fE/WTS1UTCjtdfH5zqK0DUVxWdTcjxCBhg=
Received: by 10.50.88.169 with SMTP id bh9mr895780igb.1.1335738399929;
        Sun, 29 Apr 2012 15:26:39 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.231.2.149 with SMTP id 21ls3114281ibj.5.gmail; Sun, 29 Apr
 2012 15:26:38 -0700 (PDT)
Received: by 10.42.169.67 with SMTP id a3mr14976475icz.8.1335738398503;
        Sun, 29 Apr 2012 15:26:38 -0700 (PDT)
Received: by 10.42.169.67 with SMTP id a3mr14976474icz.8.1335738398491;
        Sun, 29 Apr 2012 15:26:38 -0700 (PDT)
Received: from winooski.ccs.neu.edu (winooski.ccs.neu.edu. [129.10.115.117])
        by gmr-mx.google.com with ESMTPS id em8si5343625igc.2.2012.04.29.15.26.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Apr 2012 15:26:38 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org designates 129.10.115.117 as permitted sender) client-ip=129.10.115.117;
Received: from winooski.ccs.neu.edu (localhost.localdomain [127.0.0.1])
	by winooski.ccs.neu.edu (8.14.4/8.14.4) with ESMTP id q3TMQal7031044;
	Sun, 29 Apr 2012 18:26:36 -0400
Received: (from eli@localhost)
	by winooski.ccs.neu.edu (8.14.4/8.14.4/Submit) id q3TMQaP4031041;
	Sun, 29 Apr 2012 18:26:36 -0400
In-Reply-To: <20120429220132.GB4491-bBVMEuqLR+SYVEpFpFwlB0AkDMvbqDRI@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196518>

A few minutes ago, Jeff King wrote:
> On Sat, Apr 28, 2012 at 07:59:37PM -0400, Eli Barzilay wrote:
> 
> > > How exactly do you make magit generate these calls?  AFAICT, Magit
> > > should operate on whatever "git stash list" outputs, meaning
> > > stash@{N}. So I guess I'm missing something.
> > 
> > ... right: the offending configuration I had was log.date = iso.  This
> > calls for a simple chane for git-stash.sh to use `--date default':
> > 
> > 	git log --date default --format="%gd: %gs" -g "$@" $ref_stash --
> 
> I seem to remember dealing with this once a long time ago. And while
> "--date=default" works, it is papering over the symptom of a larger
> problem, which is that "log" should not use a non-commandline date
> to make the stash selector decision. Searching turned up this
> discussion:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/128569

Ah, that looks like almost exactly the problem I started with...


> which led to f4ea32f (improve reflog date/number heuristic,
> 2009-09-24).  That fixed the case of:
> 
>   git config log.date iso
>   git log -g --oneline
> 
> But later, 8f8f547 (Introduce new pretty formats %g[sdD] for reflog
> information, 2009-10-19) added another way to show selectors, and it
> did not respect the date_mode_explicit flag from f4ea32f. Which I
> think is a bug.
> 
> So the right solution is to pass the date_mode_explicit flag through
> to the pretty-print --format code, and then pass it along to the
> reflog code.

Assuming that I followed all of that correctly, it still seems bogus
to do that, given that %gd and %gD are described as producing reflog
selector, and given that Junio's note that stash operations are really
intended to be used only with these selectos.  What looks more
sensible to me given the necessity of %gd (and the fact that it's
different from %cd/%ad) is to change things as follows:

  * %gd produces only the date, with the "default" having the same
    meaning as elsewhere (so it doesn't show the index numbers)
  * %gD is useless
  * Some new %gi uses the index number: stash@{1}, and %gI produces
    refs/stash@{1}, unrelated to any date setting
  * git-stash.sh uses %gi so the output has the numbers
  * Some new option for "stash list" for the format string, so it's
    possible to show the dates if you want to with something like
    git stash list --format:"%gi: %gs (%gd)"

With this the output has the number independent of log.date setting,
and I get a --format if I want to see something else, which makes more
sense than --date being explicit or not.  IOW, I'd expect this:

>   git stash list --date=iso

to not have any effect.

This is not a backwards compatible change, but my guess is that
existing uses of %g[dD] are suffering from a similar problem anyway.
(So another option maybe making %gd use the number and something else
for the date version.)

(But my opinion is of course limited to my short encounter with all of
this...)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!

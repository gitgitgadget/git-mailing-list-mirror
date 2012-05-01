From: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>
Subject: Re: Bug in git-stash(.sh) ?
Date: Tue, 1 May 2012 11:02:11 -0400
Message-ID: <20120501150211.GA14185@sigill.intra.peff.net>
References: <20379.9312.943088.350379@winooski.ccs.neu.edu>
 <87wr4za9mr.fsf@gmail.com>
 <m2pqasb8mr.fsf@linux-m68k.org>
 <xmqqvckk93ta.fsf@junio.mtv.corp.google.com>
 <CALO-gut4csy5wef4iGPGD5jVPc1f0iFBfS3MUWrOwc2yczdviw@mail.gmail.com>
 <20380.33897.666338.766096@winooski.ccs.neu.edu>
 <7vlilexkcq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>, Thomas Rast <trast-oe7qfRrRQfdfcPYw/2PL0g@public.gmane.org>,
	Yann Hodique <yann.hodique-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Andreas Schwab <schwab-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: magit+bncCN2hpKqZChD59f_8BBoEkKwGtw-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue May 01 17:02:33 2012
Return-path: <magit+bncCN2hpKqZChD59f_8BBoEkKwGtw-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-qa0-f55.google.com ([209.85.216.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCN2hpKqZChD59f_8BBoEkKwGtw-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SPEax-0002K8-50
	for gcvgm-magit-3@m.gmane.org; Tue, 01 May 2012 17:02:27 +0200
Received: by qabg40 with SMTP id g40sf4243135qab.10
        for <gcvgm-magit-3@m.gmane.org>; Tue, 01 May 2012 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition
         :content-transfer-encoding;
        bh=N4A7oWhBCRSZKGsUjLskHQZRoQuWxFvweW5B2dC32/w=;
        b=mlSYSMByUJpfypmPaH/TmIb4wBfALvBL68eRp56c/ZXgRszNtV8jdPKaxQvrRCAvDd
         7r0MEAPJSFkVMbkewCWeO2vaR+MOINud+tnbnCJFjoGsbFdWQZiYdZftPu8j4wTd4cjN
         +/2DoWhpI0mWAHaPfDHBAc90E84dNeVyj4fus=
Received: by 10.50.216.133 with SMTP id oq5mr242231igc.4.1335884537182;
        Tue, 01 May 2012 08:02:17 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.231.58.146 with SMTP id g18ls4312836ibh.3.gmail; Tue, 01 May
 2012 08:02:16 -0700 (PDT)
Received: by 10.50.153.168 with SMTP id vh8mr1884905igb.1.1335884536688;
        Tue, 01 May 2012 08:02:16 -0700 (PDT)
Received: by 10.50.153.168 with SMTP id vh8mr1884904igb.1.1335884536678;
        Tue, 01 May 2012 08:02:16 -0700 (PDT)
Received: from peff.net (99-108-226-0.lightspeed.iplsin.sbcglobal.net. [99.108.226.0])
        by gmr-mx.google.com with ESMTPS id t9si8522641igb.1.2012.05.01.08.02.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 May 2012 08:02:16 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff-AdEPDUrAXsQ@public.gmane.org designates 99.108.226.0 as permitted sender) client-ip=99.108.226.0;
Received: (qmail 5558 invoked by uid 107); 1 May 2012 15:02:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 May 2012 11:02:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 May 2012 11:02:11 -0400
In-Reply-To: <7vlilexkcq.fsf-s2KvWo2KEQL18tm6hw+yZpy9Z0UEorGK@public.gmane.org>
X-Original-Sender: peff-AdEPDUrAXsQ@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff-AdEPDUrAXsQ@public.gmane.org designates 99.108.226.0 as permitted sender) smtp.mail=peff-AdEPDUrAXsQ@public.gmane.org
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196684>

On Sun, Apr 29, 2012 at 03:07:49PM -0700, Junio C Hamano wrote:

> Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org> writes:
> 
> > ...  In any case,
> > it is also questionable -- reading the documentation for %gd:
> >
> >            ·    %gD: reflog selector, e.g., refs/stash@{1}
> >            ·    %gd: shortened reflog selector, e.g., stash@{1}
> >
> > makes it look like the problem is there -- in get_reflog_selector() --
> > which has explicit code for showing the dates.  (This was done in
> > 8f8f5476.)
> 
> I think the root cause of the bug is that there are three cases:
> 
>  - If we ask for "log -g ref@{0}", we should show them counted no matter what.
> 
>  - If we ask for "log -g ref@{now}", we should show them timed no matter what.
> 
>  - If we ask for "log -g ref" without specifier, we show them counted by
>    default, but we try to be nice and show them timed when we can infer
>    from other context that the user wanted to see them timed.

Right. My argument is that the context in your third point was always
intended to be about command-line options. Respecting the log.date
config there is a bug (and not just in breaking intent; it also breaks
scriptability). It was fixed for the regular pretty-print code path, but
was broken again when the "%gd" code path was added.

> An ancient 4e244cb (log --reflog: honour --relative-date, 2007-02-08) was
> what introduced the "explicit code for showing the dates", but it was done
> somewhat poorly---it does not differentiate the first and third case.

If that is the case (and I haven't checked either way, but it does not
surprise me at all), then I believe that is a separate bug. And we
should fix that, too.

> Once we fix *that* bug, to disable the "timed" codepath altogether when
> the caller gives "ref@{0}" to explicitly ask for counted output, we can
> fix it a lot easily.
> [...]
> -	git log --format="%gd: %gs" -g "$@" $ref_stash --
> +	git log --format="%gd: %gs" -g "$@" "$ref_stash@{0}" --

That will solve the problem for stash, but the config bug would remain
for every _other_ user of "git log -g --format=%gd". So that needs fixed
either way.

However, I really wonder if this is the right thing. If I do:

  git stash list --date=relative

isn't it a feature that I get to see the date at which each stash was
made? Why are we taking it away? I can see if it were the only way to
fix the problem with log.date, but that has another solution. Are people
really calling "stash list" with a date on the command line and getting
confused by the output? My understanding was that the observed problem
was purely a bad interaction with log.date, which should not be
respected at all.

-Peff

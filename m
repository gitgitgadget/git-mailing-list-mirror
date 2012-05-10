From: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>
Subject: Re: [PATCH 4/4] reflog-walk: always make HEAD@{0} show indexed
 selectors
Date: Thu, 10 May 2012 11:37:54 -0400
Message-ID: <20120510153754.GA23941@sigill.intra.peff.net>
References: <20120504052106.GA15970@sigill.intra.peff.net>
 <20120504052725.GD16107@sigill.intra.peff.net>
 <7v7gwrc212.fsf@alter.siamese.dyndns.org>
 <20120507213752.GA19911@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>, Yann Hodique <yann.hodique-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Andreas Schwab <schwab-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: magit+bncCN2hpKqZChDVwa_9BBoEkighEA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu May 10 17:37:59 2012
Return-path: <magit+bncCN2hpKqZChDVwa_9BBoEkighEA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-yw0-f58.google.com ([209.85.213.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCN2hpKqZChDVwa_9BBoEkighEA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SSVRG-0001Sk-Sd
	for gcvgm-magit-3@m.gmane.org; Thu, 10 May 2012 17:37:59 +0200
Received: by yhfs35 with SMTP id s35sf2124500yhf.3
        for <gcvgm-magit-3@m.gmane.org>; Thu, 10 May 2012 08:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=PmLWdLHjwozEQiw33lL44K6kWCtI6C1P6HO7bcQNPF4=;
        b=AVOMkAKpdfgUr8Hnq/v9YIzoWrUBwvz7Hx+kQMewbsc37Vv9h1zmBLYQ7jrYxby4xr
         CB981TXBLZEz1AisMkDdJvr5LnZyYHtpFWr0tR+4aiGRLqG6CliJHVwBdVDoAbYsS4Wg
         2U+0H8pHZwTjV+ZyA3w5OBs3g2KhsmVYrLYj4=
Received: by 10.50.173.70 with SMTP id bi6mr755785igc.6.1336664277776;
        Thu, 10 May 2012 08:37:57 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.50.181.201 with SMTP id dy9ls534422igc.1.gmail; Thu, 10 May
 2012 08:37:56 -0700 (PDT)
Received: by 10.42.30.68 with SMTP id u4mr2802569icc.1.1336664276271;
        Thu, 10 May 2012 08:37:56 -0700 (PDT)
Received: by 10.42.30.68 with SMTP id u4mr2802567icc.1.1336664276261;
        Thu, 10 May 2012 08:37:56 -0700 (PDT)
Received: from peff.net (99-108-226-0.lightspeed.iplsin.sbcglobal.net. [99.108.226.0])
        by gmr-mx.google.com with ESMTPS id t9si514539igb.1.2012.05.10.08.37.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 08:37:56 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff-AdEPDUrAXsQ@public.gmane.org designates 99.108.226.0 as permitted sender) client-ip=99.108.226.0;
Received: (qmail 30177 invoked by uid 107); 10 May 2012 15:38:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 May 2012 11:38:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2012 11:37:54 -0400
In-Reply-To: <20120507213752.GA19911-bBVMEuqLR+SYVEpFpFwlB0AkDMvbqDRI@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197586>

On Mon, May 07, 2012 at 05:37:52PM -0400, Jeff King wrote:

> >  	strbuf_addf(sb, "%s@{", printed_ref);
> >  	if (commit_reflog->selector == SELECTOR_DATE ||
> > -	    (commit_reflog->selector == SELECTOR_NONE && dmode)) {
> > +	    (commit_reflog->selector == SELECTOR_NONE && (dmode != DATE_DEFAULT))) {
> >  		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
> >  		strbuf_addstr(sb, show_date(info->timestamp, info->tz, dmode));
> >  	} else {
> 
> I think some of the callers set dmode to DATE_NORMAL explicitly. So this
> code would be confused into thinking that the user had asked for it
> explicitly. Or maybe it happens before the date_mode_explicit check, and
> it would be OK. I'd have to do audit the code.

I just took a look at what you built on top of this topic (55ccf85)
instead of the bit quoted above. I also found it ugly not to pass the
explicit flag all the way down to the point-of-use. I had a nagging
feeling that the original did not do it that way for some good reason,
but looking at your patch, I cannot fathom what that reason could
possibly be. So it looks good to me.

-Peff

PS It would have been nice to see the patch on the list for review. I
   only noticed it because it hit 'next', and had a minor conflict with
   my patches in the area.

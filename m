From: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>
Subject: Re: [PATCH 4/4] reflog-walk: always make HEAD@{0} show indexed
 selectors
Date: Mon, 7 May 2012 17:37:52 -0400
Message-ID: <20120507213752.GA19911@sigill.intra.peff.net>
References: <20120504052106.GA15970@sigill.intra.peff.net>
 <20120504052725.GD16107@sigill.intra.peff.net>
 <7v7gwrc212.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>, Yann Hodique <yann.hodique-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Andreas Schwab <schwab-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: magit+bncCN2hpKqZChCzgaH9BBoEFAQhJQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon May 07 23:37:57 2012
Return-path: <magit+bncCN2hpKqZChCzgaH9BBoEFAQhJQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-vb0-f58.google.com ([209.85.212.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCN2hpKqZChCzgaH9BBoEFAQhJQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SRVcy-0002Wr-UZ
	for gcvgm-magit-3@m.gmane.org; Mon, 07 May 2012 23:37:57 +0200
Received: by vbbez10 with SMTP id ez10sf632341vbb.3
        for <gcvgm-magit-3@m.gmane.org>; Mon, 07 May 2012 14:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=Bn6Tyni/DwcJAbGd//PDtxQOSvz6xN7/UZ/w5CLseDo=;
        b=anyL43RSwmPL9Fp0uYgL2awnmWDizKkalVAkLqe2bmtSGLaN1H+a7UuXaaq5nGMpZU
         jSIkkZNTIEzNJJd7QiBLA2zv1t/jpu9fDxPV+cCOg8rWRXFYTrMIAajNVfdRbfR4ssmR
         aVrm8k1abcFuKduGm4Vt6+mNKkqu2Q0LzMeMQ=
Received: by 10.50.217.137 with SMTP id oy9mr1567161igc.2.1336426675873;
        Mon, 07 May 2012 14:37:55 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.231.27.25 with SMTP id g25ls3953856ibc.1.gmail; Mon, 07 May
 2012 14:37:54 -0700 (PDT)
Received: by 10.43.53.73 with SMTP id vp9mr12986048icb.0.1336426674830;
        Mon, 07 May 2012 14:37:54 -0700 (PDT)
Received: by 10.43.53.73 with SMTP id vp9mr12986046icb.0.1336426674818;
        Mon, 07 May 2012 14:37:54 -0700 (PDT)
Received: from peff.net (99-108-226-0.lightspeed.iplsin.sbcglobal.net. [99.108.226.0])
        by gmr-mx.google.com with ESMTPS id xn7si2731706igb.1.2012.05.07.14.37.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 May 2012 14:37:54 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff-AdEPDUrAXsQ@public.gmane.org designates 99.108.226.0 as permitted sender) client-ip=99.108.226.0;
Received: (qmail 27726 invoked by uid 107); 7 May 2012 21:38:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 May 2012 17:38:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2012 17:37:52 -0400
In-Reply-To: <7v7gwrc212.fsf-s2KvWo2KEQL18tm6hw+yZpy9Z0UEorGK@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197315>

On Fri, May 04, 2012 at 10:02:49AM -0700, Junio C Hamano wrote:

> Jeff King <peff-AdEPDUrAXsQ@public.gmane.org> writes:
> 
> > This patch flips the rules to:
> >
> >   1. if the user asked for ref@{0}, always show the index
> >
> >   2. if the user asked for ref@{now}, always show the date
> >
> >   3. otherwise, we have just "ref"; show them counted by
> >      default, but respect the presence of "--date" as a clue
> >      that the user wanted them date-based
> 
> The revision.c parser for "git log --date=default -g master" would flip
> the "explicit" bit, revs->date_mode is set to DATE_NORMAL, and that value
> will eventually come as dmode here.
> [...]
> But DATE_NORMAL happens to be zero ;-) "git log --date=default -g master"
> would still show the counted version.

Yeah, I noticed that, but decided not to tackle it, as nobody had really
complained (and you can get the behavior you want with master@{now}).
However, I agree it would be better for "--date=default" to trigger the
date-based selector.

> I personally do not care about that behaviour, but I know that I will
> later later have to deal with people who do care, which is annoying.

Maybe. It has been that way for years and nobody has yet complained. :)

> Probably we would internally need to define two values to ask for the
> DATE_NORMAL output.  Move DATE_NORMAL to non-zero value, introduce a new
> DATE_DEFAULT that is zero, and make their output identical, perhaps
> something like the attached (not even compile tested).

I think that is the right way forward.  I am worried that we will end up
with parts of the code that do not handle the distinction properly (see
below). But maybe it is best to try it and shake the bugs out.

> The implicit comparison to zero in the above is a bad code (but that is
> a problem from the very old days).

It is. The enum at least explicitly starts at 0 for this reason, but I
don't mind at all if it is updated to an explicit '!= DATE_NORMAL'.

> diff --git a/cache.h b/cache.h
> index 58ff054..fe42e80 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -876,7 +876,8 @@ extern struct object *peel_to_type(const char *name, int namelen,
>  				   struct object *o, enum object_type);
>  
>  enum date_mode {
> -	DATE_NORMAL = 0,
> +	DATE_DEFAULT = 0,
> +	DATE_NORMAL,
>  	DATE_RELATIVE,
>  	DATE_SHORT,
>  	DATE_LOCAL,
> diff --git a/reflog-walk.c b/reflog-walk.c
> index b974258..d002516 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -277,7 +277,7 @@ void get_reflog_selector(struct strbuf *sb,
>  
>  	strbuf_addf(sb, "%s@{", printed_ref);
>  	if (commit_reflog->selector == SELECTOR_DATE ||
> -	    (commit_reflog->selector == SELECTOR_NONE && dmode)) {
> +	    (commit_reflog->selector == SELECTOR_NONE && (dmode != DATE_DEFAULT))) {
>  		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
>  		strbuf_addstr(sb, show_date(info->timestamp, info->tz, dmode));
>  	} else {

I think some of the callers set dmode to DATE_NORMAL explicitly. So this
code would be confused into thinking that the user had asked for it
explicitly. Or maybe it happens before the date_mode_explicit check, and
it would be OK. I'd have to do audit the code.

-Peff

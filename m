From: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] reflog-walk: always make HEAD@{0} show indexed
 selectors
Date: Fri, 04 May 2012 10:02:49 -0700
Message-ID: <7v7gwrc212.fsf@alter.siamese.dyndns.org>
References: <20120504052106.GA15970@sigill.intra.peff.net>
 <20120504052725.GD16107@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>,  Yann Hodique <yann.hodique-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 
 Andreas Schwab <schwab-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,  git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 
 magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>
X-From: magit+bncCI3_0YzZExC8l5D9BBoEYrBgNA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri May 04 19:02:57 2012
Return-path: <magit+bncCI3_0YzZExC8l5D9BBoEYrBgNA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-gg0-f186.google.com ([209.85.161.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCI3_0YzZExC8l5D9BBoEYrBgNA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SQLu9-0003FM-B4
	for gcvgm-magit-3@m.gmane.org; Fri, 04 May 2012 19:02:53 +0200
Received: by ggeq3 with SMTP id q3sf239343gge.3
        for <gcvgm-magit-3@m.gmane.org>; Fri, 04 May 2012 10:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=ZDA9AtPFfV0Ohf99LirNm76d3kekaMt/0EpzT/dlco8=;
        b=2kl4ZWANFeRQ2UCn0q8FWKodhonZDspgkMB/BsIK4kn0mIQectxG3vFsJlSIog3imi
         Y7XtWKVR3Pz4FhPkESmfrDZxPTbxCNFYwO8LpFv//Rh2cQL3LuACjHH8IM5II1kQdxkz
         b8Z1fPqhkiRUMnbWkt4SZ/k6Q9IOFhOOptkwU=
Received: by 10.52.36.52 with SMTP id n20mr256480vdj.4.1336150972427;
        Fri, 04 May 2012 10:02:52 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.220.107.81 with SMTP id a17ls1124832vcp.2.gmail; Fri, 04 May
 2012 10:02:52 -0700 (PDT)
Received: by 10.52.88.201 with SMTP id bi9mr9511709vdb.6.1336150972086;
        Fri, 04 May 2012 10:02:52 -0700 (PDT)
Received: by 10.52.88.201 with SMTP id bi9mr9511708vdb.6.1336150972076;
        Fri, 04 May 2012 10:02:52 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id cz20si4344783vdb.0.2012.05.04.10.02.51;
        Fri, 04 May 2012 10:02:51 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio-hrAtEEWgPAZD4dQB+ktFXD1X8v8AiJow@public.gmane.org designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D2EA7738;
	Fri,  4 May 2012 13:02:51 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64BDE7737;
	Fri,  4 May 2012 13:02:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3CA17736; Fri,  4 May 2012
 13:02:50 -0400 (EDT)
In-Reply-To: <20120504052725.GD16107-bBVMEuqLR+SYVEpFpFwlB0AkDMvbqDRI@public.gmane.org> (Jeff King's
 message of "Fri, 4 May 2012 01:27:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB5C3C92-960A-11E1-9A9F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 best guess record for domain of junio-hrAtEEWgPAZD4dQB+ktFXD1X8v8AiJow@public.gmane.org designates
 208.72.237.35 as permitted sender) smtp.mail=junio-hrAtEEWgPAZD4dQB+ktFXD1X8v8AiJow@public.gmane.org;
 dkim=pass header.i=@pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197038>

Jeff King <peff-AdEPDUrAXsQ@public.gmane.org> writes:

> This patch flips the rules to:
>
>   1. if the user asked for ref@{0}, always show the index
>
>   2. if the user asked for ref@{now}, always show the date
>
>   3. otherwise, we have just "ref"; show them counted by
>      default, but respect the presence of "--date" as a clue
>      that the user wanted them date-based

The revision.c parser for "git log --date=default -g master" would flip
the "explicit" bit, revs->date_mode is set to DATE_NORMAL, and that value
will eventually come as dmode here.

> diff --git a/reflog-walk.c b/reflog-walk.c
> index 3549318..b974258 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -276,7 +276,8 @@ void get_reflog_selector(struct strbuf *sb,
>  	}
>  
>  	strbuf_addf(sb, "%s@{", printed_ref);
> -	if (commit_reflog->selector == SELECTOR_DATE || dmode) {
> +	if (commit_reflog->selector == SELECTOR_DATE ||
> +	    (commit_reflog->selector == SELECTOR_NONE && dmode)) {
>  		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
>  		strbuf_addstr(sb, show_date(info->timestamp, info->tz, dmode));

But DATE_NORMAL happens to be zero ;-) "git log --date=default -g master"
would still show the counted version.

I personally do not care about that behaviour, but I know that I will
later later have to deal with people who do care, which is annoying.

Probably we would internally need to define two values to ask for the
DATE_NORMAL output.  Move DATE_NORMAL to non-zero value, introduce a new
DATE_DEFAULT that is zero, and make their output identical, perhaps
something like the attached (not even compile tested).

The implicit comparison to zero in the above is a bad code (but that is
a problem from the very old days).

diff --git a/cache.h b/cache.h
index 58ff054..fe42e80 100644
--- a/cache.h
+++ b/cache.h
@@ -876,7 +876,8 @@ extern struct object *peel_to_type(const char *name, int namelen,
 				   struct object *o, enum object_type);
 
 enum date_mode {
-	DATE_NORMAL = 0,
+	DATE_DEFAULT = 0,
+	DATE_NORMAL,
 	DATE_RELATIVE,
 	DATE_SHORT,
 	DATE_LOCAL,
diff --git a/reflog-walk.c b/reflog-walk.c
index b974258..d002516 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -277,7 +277,7 @@ void get_reflog_selector(struct strbuf *sb,
 
 	strbuf_addf(sb, "%s@{", printed_ref);
 	if (commit_reflog->selector == SELECTOR_DATE ||
-	    (commit_reflog->selector == SELECTOR_NONE && dmode)) {
+	    (commit_reflog->selector == SELECTOR_NONE && (dmode != DATE_DEFAULT))) {
 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
 		strbuf_addstr(sb, show_date(info->timestamp, info->tz, dmode));
 	} else {

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA72D2036C
	for <e@80x24.org>; Wed,  4 Oct 2017 19:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbdJDTV4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 15:21:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:47295 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbdJDTVy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 15:21:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id t69so24750348wmt.2
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 12:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s0Jy7T7CwF0tEyldj4tJfi8GUFHe2WOZwuNw1D73rSM=;
        b=YGvTdn+239N4NWJNedfDsoHSdtMziovarnmtPGnKQtz8Ah86P7HFU167wlPYzpsc8Z
         v6+imvdEt9d0mEOyF0KIw0Di/1S2v93bLboxvj3YySTSr3ekELISWUK5JYL/QYSxxUCa
         +8hL34Xn+Z5iz9iJk72fk3OXM5ILCCu0kiSQ1IpEvaQ6ZpZ3eVqYQOvyoI7O/fqy6jvc
         VcuR/yZ7bRLiV5Znjj9XGYSpwwGte78+ThGVl9XFwiI5S3pk8xD2Wtffy7OMWrn2ttpr
         l9DdGPQ9adD7GL6OdQ9TwwiobR+6ditdmnMOTQYrBTmU/aZXk7GnjGORxlZbIfgp/RSV
         KPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s0Jy7T7CwF0tEyldj4tJfi8GUFHe2WOZwuNw1D73rSM=;
        b=DTFktpRQ4JsUw5wjQLYTNC25l+eEbNA4BLJNEESWjFIhFNPoZdL4j9sTVs7/6t9N3X
         cNe7Cua8fxskvbIZtddga2K+kEeVVWiSxcMc/hUlX8RcIOqfqDETbhrnUI2tg2Z+vj+q
         YFSAxSAaivxyFMI0AfHM7KY9C7UzqW+Le7nQNnPT2YxD2d3sqc8dV2l8FwzysTrXJG/N
         eZaEd9LF+a6Ku2aqTjgGxIJgOy79sfiQhBvwJxMWhQhs40MHSMgQ323AI2Mbn+oVK8eu
         KSL/Bp79wi17OL8nvLwYjTp81RPELr+NqP3i8lcdq8xCLcrUkDmQcb9G+GmqKfEYBA0c
         Zr6Q==
X-Gm-Message-State: AMCzsaUDp7bW1+axqvfJY7eyWus26LHEnkzQVkQ/z1k5HFs5EoE5Am4d
        325KHEaN13nmrEUzifc5i3Y=
X-Google-Smtp-Source: AOwi7QDSbBhv3r75hwEzRjZKH/+ZRqJHbSuiO0ZuM0ALBE7WxN+ykm+btKjIt3Rl6UPeJ6XeW+FGuA==
X-Received: by 10.28.218.207 with SMTP id r198mr8688172wmg.14.1507144912935;
        Wed, 04 Oct 2017 12:21:52 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id k9sm23581845wrk.27.2017.10.04.12.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Oct 2017 12:21:52 -0700 (PDT)
Date:   Wed, 4 Oct 2017 20:22:43 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] path.c: fix uninitialized memory access
Message-ID: <20171004192243.GC30301@hank>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
 <20171003195713.13395-2-t.gummerer@gmail.com>
 <20171003224501.GD19555@aiede.mtv.corp.google.com>
 <20171003233040.2ws6kny3e4kypfub@sigill.intra.peff.net>
 <20171003233706.GH19555@aiede.mtv.corp.google.com>
 <xmqqfuazecym.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfuazecym.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/04, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > Jeff King wrote:
> >> On Tue, Oct 03, 2017 at 03:45:01PM -0700, Jonathan Nieder wrote:
> >
> >>> In other words, an alternative fix would be
> >>> 
> >>> 	if (*path == '.' && path[1] == '/') {
> >>> 		...
> >>> 	}
> >>> 
> >>> which would not require passing in 'len' or switching to index-based
> >>> arithmetic.  I think I prefer it.  What do you think?
> >>
> >> Yes, I think that approach is much nicer. I think you could even use
> >> skip_prefix. Unfortunately you have to play a few games with const-ness,
> >> but I think the resulting signature for cleanup_path() is an
> >> improvement:
> 
> To tie the loose end, here is what I'll queue.

Thanks.  This is much nicer indeed!

> -- >8 --
> From: Jeff King <peff@peff.net>
> Date: Tue, 3 Oct 2017 19:30:40 -0400
> Subject: [PATCH] path.c: fix uninitialized memory access
> 
> In cleanup_path we're passing in a char array, run a memcmp on it, and
> run through it without ever checking if something is in the array in the
> first place.  This can lead us to access uninitialized memory, for
> example in t5541-http-push-smart.sh test 7, when run under valgrind:
> 
> ==4423== Conditional jump or move depends on uninitialised value(s)
> ==4423==    at 0x242FA9: cleanup_path (path.c:35)
> ==4423==    by 0x242FA9: mkpath (path.c:456)
> ==4423==    by 0x256CC7: refname_match (refs.c:364)
> ==4423==    by 0x26C181: count_refspec_match (remote.c:1015)
> ==4423==    by 0x26C181: match_explicit_lhs (remote.c:1126)
> ==4423==    by 0x26C181: check_push_refs (remote.c:1409)
> ==4423==    by 0x2ABB4D: transport_push (transport.c:870)
> ==4423==    by 0x186703: push_with_options (push.c:332)
> ==4423==    by 0x18746D: do_push (push.c:409)
> ==4423==    by 0x18746D: cmd_push (push.c:566)
> ==4423==    by 0x1183E0: run_builtin (git.c:352)
> ==4423==    by 0x11973E: handle_builtin (git.c:539)
> ==4423==    by 0x11973E: run_argv (git.c:593)
> ==4423==    by 0x11973E: main (git.c:698)
> ==4423==  Uninitialised value was created by a heap allocation
> ==4423==    at 0x4C2CD8F: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==4423==    by 0x4C2F195: realloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==4423==    by 0x2C196B: xrealloc (wrapper.c:137)
> ==4423==    by 0x29A30B: strbuf_grow (strbuf.c:66)
> ==4423==    by 0x29A30B: strbuf_vaddf (strbuf.c:277)
> ==4423==    by 0x242F9F: mkpath (path.c:454)
> ==4423==    by 0x256CC7: refname_match (refs.c:364)
> ==4423==    by 0x26C181: count_refspec_match (remote.c:1015)
> ==4423==    by 0x26C181: match_explicit_lhs (remote.c:1126)
> ==4423==    by 0x26C181: check_push_refs (remote.c:1409)
> ==4423==    by 0x2ABB4D: transport_push (transport.c:870)
> ==4423==    by 0x186703: push_with_options (push.c:332)
> ==4423==    by 0x18746D: do_push (push.c:409)
> ==4423==    by 0x18746D: cmd_push (push.c:566)
> ==4423==    by 0x1183E0: run_builtin (git.c:352)
> ==4423==    by 0x11973E: handle_builtin (git.c:539)
> ==4423==    by 0x11973E: run_argv (git.c:593)
> ==4423==    by 0x11973E: main (git.c:698)
> ==4423==
> 
> Avoid this by using skip_prefix(), which knows not to go beyond the
> end of the string.
> 
> Reported-by: Thomas Gummerer <t.gummerer@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  path.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/path.c b/path.c
> index e50d2befcf..2fecf854fe 100644
> --- a/path.c
> +++ b/path.c
> @@ -33,11 +33,10 @@ static struct strbuf *get_pathname(void)
>  	return sb;
>  }
>  
> -static char *cleanup_path(char *path)
> +static const char *cleanup_path(const char *path)
>  {
>  	/* Clean it up */
> -	if (!memcmp(path, "./", 2)) {
> -		path += 2;
> +	if (skip_prefix(path, "./", &path)) {
>  		while (*path == '/')
>  			path++;
>  	}
> @@ -46,7 +45,7 @@ static char *cleanup_path(char *path)
>  
>  static void strbuf_cleanup_path(struct strbuf *sb)
>  {
> -	char *path = cleanup_path(sb->buf);
> +	const char *path = cleanup_path(sb->buf);
>  	if (path > sb->buf)
>  		strbuf_remove(sb, 0, path - sb->buf);
>  }
> @@ -63,7 +62,7 @@ char *mksnpath(char *buf, size_t n, const char *fmt, ...)
>  		strlcpy(buf, bad_path, n);
>  		return buf;
>  	}
> -	return cleanup_path(buf);
> +	return (char *)cleanup_path(buf);
>  }
>  
>  static int dir_prefix(const char *buf, const char *dir)
> -- 
> 2.14.2-889-gd2948f6aa6
> 

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 841CE1FF72
	for <e@80x24.org>; Mon, 23 Oct 2017 09:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbdJWJ5p (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 05:57:45 -0400
Received: from mout.gmx.net ([212.227.15.19]:54355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751200AbdJWJ5o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 05:57:44 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDhba-1dzMMS0XmQ-00H4UN; Mon, 23
 Oct 2017 11:57:34 +0200
Date:   Mon, 23 Oct 2017 11:57:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 4/4] fsmonitor: Delay updating state until after split
 index is merged
In-Reply-To: <20171021033534.pgjtyiwlhvheuueo@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1710231157030.6482@virtualbox>
References: <20171020011136.14170-1-alexmv@dropbox.com> <05670bb6e3c6378119b1649144c80dd6d72bfe29.1508461850.git.alexmv@dropbox.com> <alpine.DEB.2.21.1.1710201503380.40514@virtualbox> <20171021033534.pgjtyiwlhvheuueo@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/V3lekiH2CR6BroP92a20z29QNZhpLwQpbhTzEm3w7iGFmg/nO4
 Fp69LoFnK0Jkabjz5hb3Oq3BI+YXh91ABd4WROIPXnlTCnCMq7oyhJclbr+0hSkKfL7T3rc
 7yDFvq8KRzNUYFWsJ/FUD0fx6gddMsJFcADlBGb1XumnXpR0Hg1EQPFnBVlbdGANaUldaiH
 fok7yApdrDrpi2ohxH8uw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f0VPmTLSgOk=:1C0RxScPEXMY/5/WihPsOe
 dyHvIC5pxxdUDvX0Nu88lqWWpK66do/R029PcLNxAlQj6GkJnsyYxKEkIktA/oTIsrqMJnyzb
 B/5TtbVh5nTh0eJ3hXA7j0E0osJrKrGsEvUcCJtpCKW1Lt0PFEvFysVZjAupxwaTgkX7kJoi/
 G9B03PTe/1DbbEmdfcEKZF+puc+iso0taxxH4MTvltUWtlJHAH5vKDQibk6AJDENWe1V4vVdx
 4O4zf/K0JH51XsMgIoWZ7Z6MU6aGBtr7hopjAmtwyEjD9GFaL0f10lQFR8TytwFd9bM4hI3OE
 muaH97BvuiZpkddzNm3c+EuBRp/agdMhlLp7u7U9uKZWs92SfwNI8gXvBk1J6nqMSOTLBOzHy
 B033N0klb6zgttBQVZgflXB6hw2MNK2jYZ7A5NNnbeTIDWtYL2lEupDeedjqNxSwSMVxHcaMr
 5rEKr8OUCgUE7seap7JyeKpUzS4w9ifkg6aWU5PJd1mvIhouFU+6XHx7Toxo5xOLTEoEplQI2
 G2wMpZFlAOIW3GV1OR9AC3oJz+QUPlqzR+AJHmdZQ1q+h/y9mvKEKXUDaDbwdm9nweK1LhEUv
 xHzhgAwiWcG+G4xeFoRpPBILelQyGTedMwqyKK0nWhRMo1EWbZ1D1nXWmRJrT6lxewJ34VtqR
 nJTeIhcM+oKQt01T8DtwaY7trKLC+tqaDOgrizO/TYCW1e6tNcYJUsqcS/oFzSwd9q+srS15t
 eGy+iSaNTJ8vdRX8KrnhwSw4xcMFI0yS48C5Rn27gwiqxKimBfJPhh0NjrNQiG8mJLdGjEB4r
 JLQrE4drnRmGTAEHU6VeKvS8nqtVChVv8oziPri8ZjzShWOBKuZdfCiGzMBngvZppj2eMBH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 20 Oct 2017, Jeff King wrote:

> On Fri, Oct 20, 2017 at 03:16:20PM +0200, Johannes Schindelin wrote:
> 
> > >  void tweak_fsmonitor(struct index_state *istate)
> > >  {
> > > +	int i;
> > > +
> > > +	if (istate->fsmonitor_dirty) {
> > > +		/* Mark all entries valid */
> > > +		trace_printf_key(&trace_fsmonitor, "fsmonitor is enabled; cache is %d", istate->cache_nr);
> > 
> > Sadly, a call to trace_printf_key() is not really a noop when tracing is
> > disabled. The call to trace_printf_key() hands off to trace_vprintf_fl(),
> > which in turn calls prepare_trace_line() which asks trace_want() whether
> > we need to trace, which finally calls get_trace_fd(). This last function
> > initializes a trace key if needed, and this entire call stack takes time.
> 
> It seems like we could pretty easily turn noop traces into a trivial
> conditional, like:
> 
> diff --git a/trace.h b/trace.h
> index 179b249c59..c46b92cbde 100644
> --- a/trace.h
> +++ b/trace.h
> @@ -80,8 +80,11 @@ extern void trace_performance_since(uint64_t start, const char *format, ...);
>  #define trace_printf(...) \
>  	trace_printf_key_fl(TRACE_CONTEXT, __LINE__, NULL, __VA_ARGS__)
>  
> -#define trace_printf_key(key, ...) \
> -	trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key, __VA_ARGS__)
> +#define trace_printf_key(key, ...) do { \
> +	if (!key->initialized || key->fd) \
> +		trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key, __VA_ARGS__) \
> +} while(0)
> +
>  
>  #define trace_argv_printf(argv, ...) \
>  	trace_argv_printf_fl(TRACE_CONTEXT, __LINE__, argv, __VA_ARGS__)
> 
> 
> (OK, that's got an OR, but if we are really pinching instructions we
> could obviously store a single "I've been initialized and am disabled"
> flag).

I'd really like that.

> I don't have an opinion one way or the other on these particular
> messages, but in general I'd like to see _more_ tracing in Git, not
> less. I've often traced Git with a debugger or other tools like perf,
> but there's real value in the author of code annotating high-level
> logical events.

Yes, I like that idea, too: to add more tracing.

Thanks,
Dscho

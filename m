From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Tue, 31 May 2016 08:21:15 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605310803580.4449@virtualbox>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr> <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr> <alpine.DEB.2.20.1605301326530.4449@virtualbox>
 <953965621.202433.1464614453377.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	matthieu moy <matthieu.moy@grenoble-inp.fr>,
	mhagger@alum.mit.edu
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 31 08:22:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7d45-0000H7-K6
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 08:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756001AbcEaGWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 02:22:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:63359 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755711AbcEaGWC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 02:22:02 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MWBpJ-1b0nT01ztx-00XOnC; Tue, 31 May 2016 08:21:55
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <953965621.202433.1464614453377.JavaMail.zimbra@ensimag.grenoble-inp.fr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:wDbfEx6vOCCfgABhiXrVe5OjI6kI3snrG8QjlaeD8yjPvFMxsVF
 XhWxUX++pDTK3jfunm++kbW4uJPhCNLuU0wIa5RnNqZCTt132nX7ELESuox6BOJPcihtjDu
 emf72eUh56WAouuhChNg9ldwfeTT4+B3uw9iG+pJP/oyRR31QMrygfpQmQEJ4rEQGEBVGzY
 3tWWZtIQ7N1YVX8WgV4dA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A7iKQxGUdfI=:J6J5UxWJPeqws4CR1GK4mX
 YjMOHWoaJ7iQ67utgVitjJaiwRvSHZ884ES6sIK519kLM5HQLK/DcaWKeRgZHsy0SNp8JUuPb
 aLmcSktcuY6vJ4c+hT5pf+ylzpewFKjwXLNXpxG+ib3sB43V1h/UGIrNM6FUMJx0wZTDaxfQY
 d/yDcY5oVYgiwtTctCmbBJ2IhxYo0XCTWRxjYlMUmRm/Dtc/FPX7DURNMskeKB0yW/26uo4Di
 Og0saxXtjIiGybRxJHIWO9j65UKsMILf7Y1CoSRx54rklzt/AI9HA2UMMsLnQ1ClFyOXd3/8o
 KV8A2y2ZvWdQnJnk6wP5hbrNVyHMSUIelERF+eUiSe7ijD+7znGajBXgG2xgvkU1ywnTJMYiz
 P1XOTwDvugydif1bDJy/kt7ppUHT5IMAFopBalafvcb/JWcO+zaXO88Ko7T4P0lAnS4303b1Q
 A4l2QGKAl/S/xsBWXzmZ22OmytMGpTb1wbZSSeaAv6ofpJoTyALDdIl3aYRqZyCkivewFHpbw
 jexlVW+cQ51d6BGJ2tntCdVWbvNBQrcgNx4aWQklDqqrvsTesr5JjJdOzX03K1ooIeq2LP9X/
 TB5huceXG5i/EJfMPMX1mGvy0LQSLSERJnJqKsUTx1gz8xpGRpgdvLTueCYJx34xK5xaz2QG5
 I28DeQbp53IFuooQlLYTc825qNSgVUhpR9tEyt+AkvIB6hzf3IH7rSzsbAtRl1CZ59NH9RGvn
 0dNMqF7HPyZPeLyblzUxl1n2bi3J3CVXDxkYODNrUj4TDOcVkKgaCFL1nqMHclTU+gQx/W0n 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295955>

Hi William,

On Mon, 30 May 2016, William Duclot wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > 	When working e.g. with file paths or with dates, strbuf's
> > 	malloc()/free() dance of strbufs can be easily avoided: as
> > 	a sensible initial buffer size is already known, it can be
> > 	allocated on the heap.
> 
> strbuf already allow to indicate a sensible initial buffer size thanks
> to strbuf_init() second parameter. The main perk of pre-allocation
> is to use stack-allocated memory, and not heap-allocated :)

Sorry, my brain thought about the next point while my fingers typed
"heap". It is "stack" I meant.

> >> +#include <sys/param.h>
> > 
> > Why?
> 
> For the MAX macro. It may be a teeny tiny overkill

Teeny tiny.

You probably assumed that everybody compiles this on Linux, and since it
compiles on your machine, no problem, right?

> >> @@ -38,7 +67,11 @@ char *strbuf_detach(struct strbuf *sb, size_t *sz)
> >>  {
> >>  	char *res;
> >>  	strbuf_grow(sb, 0);
> >> -	res = sb->buf;
> >> +	if (sb->flags & STRBUF_OWNS_MEMORY)
> >> +		res = sb->buf;
> >> +	else
> >> +		res = xmemdupz(sb->buf, sb->alloc - 1);
> > 
> > This looks like a usage to be avoided: if we plan to detach the buffer,
> > anyway, there is no good reason to allocate it on the heap first. I would
> > at least issue a warning here.
> 
> strbuf_detach() guarantees to return heap-allocated memory, that the caller
> can use however he want and that he'll have to free.

First of all, let's stop this "caller == he" thing right here and now. A
better way is to use the "singular they": ... the caller can use however
they want...

> If the strbuf doesn't own the memory, it cannot return the buf attribute
> directly because: [...]

I know that. My point was that it is more elegant to allocate the buffer on
the heap right away, if we already know that we want to detach it.

I'll reply to Michael's comment on this.

> - The memory belong to someone else (so the caller can't use it however
> he want)

s/belong/belongs/ (just because the 's' is often silent in spoken French
does not mean that you can drop it from written English)

> >>  extern char strbuf_slopbuf[];
> >> -#define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
> >> +#define STRBUF_INIT  { 0, 0, 0, strbuf_slopbuf }
> > 
> > If I am not mistaken, to preserve the existing behavior the initial flags
> > should be 1 (own memory).
> 
> strbuf_slopbuf is a buffer that doesn't belong to any strbuf (because it's
> shared between all just-initialized strbufs).

Yet we somehow already have handling for that, right? Makes me wonder why
I did not see that handling converted to the STRBUF_OWNS_MEMORY way...

> > BTW this demonstrates that it may not be a good idea to declare the
> > "flags" field globally but then make the actual flags private.
> 
> I'm not sure what you mean here?

What I meant is that the global _INIT cannot set any flags, because the
constants are not available globally. And that seems odd. If you ever want
to introduce something like STRBUF_INIT_WRAP(buffer), you would *require*
those flag constants to be public.

> > Also: similar use cases in Git used :1 flags (see e.g. the "configured"
> > field in credential.h).
> 
> I think that keeping an obscure `flags` attribute may be better, as they
> should only be useful for internal operations and the user shouldn't mess
> with it. Keeping it a `private` attribute, in a way

This is not C++. To do what you intend to do, you would require C++ style
visibility scopes, where a constructor can use a private enum. If you
truly want to go this way, I fear you will have *a lot more* to do than
this 2-patch series: there are a *ton* of existing header files
disagreeing with this goal.

Ciao,
Johannes

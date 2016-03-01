From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Mark win32's pthread_exit() as NORETURN
Date: Tue, 1 Mar 2016 15:11:50 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603011511050.3152@virtualbox>
References: <69eef72cfc77e62ad7ad17c6df5f2d2396c64991.1456840324.git.johannes.schindelin@gmx.de> <20160301135708.GA29303@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 15:12:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aal28-0005sS-9Q
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 15:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbcCAOMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 09:12:07 -0500
Received: from mout.gmx.net ([212.227.15.18]:56707 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753745AbcCAOMF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 09:12:05 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Mg42v-1aDTQ517gL-00NRkI; Tue, 01 Mar 2016 15:11:52
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160301135708.GA29303@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:r0UsSLRUwTZfyKRPglwuGLbjNPrz4Qw1U08SW7bhnU0lX/bZhnC
 qGZhKJi34MihwrcWJj982zTJ1SRpIcnMcLifYfsGHzHRlKDQ3J7yLBG78hmfPZvaxTa4m7w
 TX2wguXpO+9rKmAbMFsA3naaVrh6AYwdI1om2CsJ/C0/53TZB2U2xBSZhXT+CQ/i98aUrOf
 PHr8XrJsOQ4Kv+ud+B/Sw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lEFYt22ByGA=:30oyKI5ceaSMjqo/XsrpGF
 2JBw5EiqHuNWs5T9AVovvGn8DYBza3a5MRuQtO9WU8dmmZTnqHkPJnNb7Z6iYrtPb7Z+iVtPd
 wepiVVssJjWfTEMVmEynDmzm58ZjSrVs6K3Bm7SqRVOSn80UcUGH0vjH6uVR2XTTSFTPam+aQ
 uk8NbD/tZT6VKJeDxuRo/gcybeOFfZUizwsJtkH0gkic8ChdGxWihvVIRXNkbfGYFIBuMjdAw
 4zMSk3+v8nDMdPJe+5y6SeH0qjy2jAH3PDsDQ2dKi5pPuhlT1MW/lnJX0vF/K68Uy9kIgvPkq
 xpqt2XBkeR7eQGeZJ0p2hbTjPl6iil0WcovnHCBzuEpm+BpmhhVgHiWnMx29WN3iJ/c+Z48kM
 BP7HTYsOflr2b6b7TFpM3NxE3Qk2/Q35hjmF3Qt2ZC5+SbwZ7YTEbfhLxVGcODr+jVmFjqXhM
 a2bzji5zN5mQMHDwUngeUWew0NQNNzFJ7TFXRKUjO5piPQEpE1scsZGuFgp8bMOOcIgZqVfBu
 L+a6mngiIa8IHpyTfxmtlW0tHCFEdz2nNryrgIpTXTPbNOmuY2kj9VD1n0c+cgWMZtA6r+zQQ
 MLuMPqC4K1lL272kLK+RaJxeHVQ7HtF3Sh+941067kufro153AC4iKg6h1lyqkedrzkFrKLTK
 +6vzafDWxB7hZ1SrnNHQgRhB2K4bZB/lwGN6X6K7flp+z9qYqFfUA/+YMn8hVdWyjsuvqPb57
 +eCUJBbDafoqFD8MRQ5/qE4++G3JhVe6tD4Bz69iBePQR3mTAT+7BWaXXsJR1BlZ91ZWovPG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288015>

Hi Peff,

On Tue, 1 Mar 2016, Jeff King wrote:

> On Tue, Mar 01, 2016 at 02:53:04PM +0100, Johannes Schindelin wrote:
> 
> > The pthread_exit() function is not expected to return. Ever.
> > 
> > Pointed out by Jeff King.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  compat/win32/pthread.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
> > index 20b35a2..148db60 100644
> > --- a/compat/win32/pthread.h
> > +++ b/compat/win32/pthread.h
> > @@ -78,7 +78,7 @@ extern int win32_pthread_join(pthread_t *thread, void **value_ptr);
> >  #define pthread_equal(t1, t2) ((t1).tid == (t2).tid)
> >  extern pthread_t pthread_self(void);
> >  
> > -static inline int pthread_exit(void *ret)
> > +static inline int NORETURN pthread_exit(void *ret)
> >  {
> >  	ExitThread((DWORD)(intptr_t)ret);
> >  }
> 
> Looks obviously correct to me (I'll assume Windows isn't so crazy as to
> let ExitThread ever return :) ).

Indeed, you are correct in your implicit assumption that I should have
clarified that in my commit message. I will amend the commit message.

Ciao,
Dscho

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] setup: suppress implicit "." work-tree for bare repos
Date: Fri, 8 Mar 2013 03:43:43 -0500
Message-ID: <20130308084343.GB10963@sigill.intra.peff.net>
References: <CAHREChhuX82ibNEDQnQUeS9TEeyMFGpuNhyXzt1Pn-Tt2BVOQA@mail.gmail.com>
 <20130308054824.GA24429@sigill.intra.peff.net>
 <20130308071554.GB24429@sigill.intra.peff.net>
 <7vboaujphx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Lodato <lodatom@gmail.com>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 09:44:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDsuR-0008Vj-UG
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 09:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933304Ab3CHInq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 03:43:46 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40758 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755553Ab3CHInq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 03:43:46 -0500
Received: (qmail 14776 invoked by uid 107); 8 Mar 2013 08:45:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Mar 2013 03:45:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Mar 2013 03:43:43 -0500
Content-Disposition: inline
In-Reply-To: <7vboaujphx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217648>

On Thu, Mar 07, 2013 at 11:54:18PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/cache.h b/cache.h
> > index e493563..070169a 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -344,6 +344,7 @@ static inline enum object_type object_type(unsigned int mode)
> >  #define GIT_DIR_ENVIRONMENT "GIT_DIR"
> >  #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
> >  #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
> > +#define GIT_IMPLICIT_WORK_TREE_ENVIRONMENT "GIT_IMPLICIT_WORK_TREE"
> >  #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
> >  #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
> >  #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
> 
> Not adding any user documentation is fine (you explained why in the
> log message), but I would really prefer to have some in-code comment
> to clarify its meaning.  Is it "Please do use implicit work tree"
> boolean?  Is it "This is the path to the work tree we have already
> figured out" string?  Is it something else?  What is it used for,
> who sets it, what other codepath that will be invented in the future
> need to be careful to set it (or unset it) and how does one who
> writes that new codepath decides that he needs to do so (or
> shouldn't)?

My intent was that the commit message would be enough to explain it, but
it is a pain for a later reader to have to blame the line back to that
commit to read it. I'll re-roll with a comment.

-Peff

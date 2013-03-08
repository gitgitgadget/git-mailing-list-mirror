From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] setup: suppress implicit "." work-tree for bare repos
Date: Fri, 8 Mar 2013 03:42:25 -0500
Message-ID: <20130308084225.GA10963@sigill.intra.peff.net>
References: <CAHREChhuX82ibNEDQnQUeS9TEeyMFGpuNhyXzt1Pn-Tt2BVOQA@mail.gmail.com>
 <20130308054824.GA24429@sigill.intra.peff.net>
 <20130308071554.GB24429@sigill.intra.peff.net>
 <513996D4.6060009@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 08 09:42:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDstD-0007Pr-3u
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 09:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933934Ab3CHIm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 03:42:28 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40750 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932694Ab3CHIm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 03:42:28 -0500
Received: (qmail 14749 invoked by uid 107); 8 Mar 2013 08:44:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Mar 2013 03:44:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Mar 2013 03:42:25 -0500
Content-Disposition: inline
In-Reply-To: <513996D4.6060009@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217647>

On Fri, Mar 08, 2013 at 08:44:20AM +0100, Johannes Sixt wrote:

> Am 3/8/2013 8:15, schrieb Jeff King:
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
> This new variable needs to be added to environment.c:local_repo_env, right?

It does; I had no idea local_repo_env existed. We should add a comment
to cache.h to that effect, too.

-Peff

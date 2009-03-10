From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH 3/7] git push: New options --matching and --current
Date: Tue, 10 Mar 2009 09:54:33 +0100
Message-ID: <20090310085433.GB11448@pvv.org>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org> <1236638151-6465-4-git-send-email-finnag@pvv.org> <alpine.LNX.1.00.0903091938150.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Mar 10 09:56:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgxkr-0002Mi-UW
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 09:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbZCJIyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 04:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753140AbZCJIyh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 04:54:37 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:50356 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962AbZCJIyg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 04:54:36 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LgxjN-0005FM-No; Tue, 10 Mar 2009 09:54:33 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0903091938150.19665@iabervon.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112795>

On Mon, Mar 09, 2009 at 07:49:47PM -0400, Daniel Barkalow wrote:
> On Mon, 9 Mar 2009, Finn Arne Gangstad wrote:
> 
> > diff --git a/transport.h b/transport.h
> > index 6bbc1a8..b897d0c 100644
> > --- a/transport.h
> > +++ b/transport.h
> > @@ -34,6 +34,15 @@ struct transport {
> >  #define TRANSPORT_PUSH_DRY_RUN 4
> >  #define TRANSPORT_PUSH_MIRROR 8
> >  #define TRANSPORT_PUSH_VERBOSE 16
> > +#define TRANSPORT_PUSH_MATCHING 32
> > +#define TRANSPORT_PUSH_CURRENT 64
> > +/**
> > + * All push flags that imply a certain set of refspecs to be pushed must
> > + * be combined into TRANSPORT_PUSH_MODE_MASK
> > + **/
> > +#define TRANSPORT_PUSH_MODE_MASK \
> > +    (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR | TRANSPORT_PUSH_MATCHING | \
> > +    TRANSPORT_PUSH_CURRENT)
> 
> It's kind of odd that you define these flags as TRANSPORT_PUSH_*, but 
> implement them before entering transport_push(). I'm not sure which is 
> right, but the combination is odd. I think just taking care of it in 
> builtin-push with flags or options defined there is probably the best 
> thing, currently.

True, this was not very beautiful. I will make something better.

- Finn Arne

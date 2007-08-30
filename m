From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Adding rebase merge strategy
Date: Thu, 30 Aug 2007 20:53:10 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708302051090.28586@racer.site>
References: <11885023904126-git-send-email-tom@u2i.com>
 <550f9510708301236y65a9952dofbd69417dc1310ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tom Clarke <tom@u2i.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 21:53:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQq5A-0003Ol-MY
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 21:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbXH3TxR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 15:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757537AbXH3TxR
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 15:53:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:40986 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755033AbXH3TxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 15:53:16 -0400
Received: (qmail invoked by alias); 30 Aug 2007 19:53:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 30 Aug 2007 21:53:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+FRh+kb0+bbbb7PE6H0hExibS+8E6L07aKx1Ww6
	Okgdq8AzmPly8b
X-X-Sender: gene099@racer.site
In-Reply-To: <550f9510708301236y65a9952dofbd69417dc1310ee@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57062>

Hi,

On Thu, 30 Aug 2007, Tom Clarke wrote:

> On 8/30/07, Tom Clarke <tom@u2i.com> wrote:
> > +               ( git log --pretty=format:"%s" ) >actual &&
> > +       (
> > +               echo "onbranch"
> > +               echo "update"
> > +               echo -n "initial"
> > +       ) >expected &&
> > +       git diff -w -u expected actual
> 
> One issue that I'm curious about. Is it expected that the git log
> format above doesn't finish with a new line? I couldn't get this test
> to work otherwise.

Indeed, it does not end in a newline.  However, I'd solve the issue 
differently:

- I'd use --pretty=oneline (and use test_tick before every commit, to 
  guarantee consistent object names).

- If you _have_ to keep your way, please use "printf", since "echo -n" is 
  not portable AFAIK.

- Or just do "echo > actual".  And use "cat << EOF" like in most of the 
  other tests.

Ciao,
Dscho

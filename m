From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [HACK] t/test-lib.sh HACK: Add -s/--show-hack to test suite.
Date: Sun, 13 Jul 2008 00:22:12 +0200
Message-ID: <20080712222212.GC22323@leksak.fem-net>
References: <1215375751-30853-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807062241040.7342@eeepc-johanness> <20080707140841.GB6726@leksak.fem-net> <alpine.DEB.1.00.0807071540310.18205@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 13 00:23:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHnUr-0007SB-9O
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 00:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbYGLWWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 18:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbYGLWWS
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 18:22:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:40268 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751017AbYGLWWR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 18:22:17 -0400
Received: (qmail invoked by alias); 12 Jul 2008 22:22:15 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp051) with SMTP; 13 Jul 2008 00:22:15 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+jllR5ovyjIiEoNgqTQiAhBlR9uBuxCu1pXCK2Lb
	T7I+5Gaq7HFVy/
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KHnTo-0006OU-OI; Sun, 13 Jul 2008 00:22:12 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807071540310.18205@racer>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88270>

Hi,

I'm just cleaning up my inbox and I've seen I've not yet replied to your
mail.

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 7 Jul 2008, Stephan Beyer wrote:
> 
> > > > This option realizes a stupid hack that tries to run the test cases 
> > > > line by line (separated by &&).
> > > 
> > > In what way is that better than "sh -x t????-*.sh"?
> > 
> > Your suggestion is more like "./t????-*.sh -v" instead of -s, at least
> > on bash and dash here.
> 
> No, I meant without "-v".

Me, too.

I've written something different:
"sh -x" is a great thing and does exactly what it should on simple scripts
containing:

	foo &&
	bar &&
	baz

But for a test case in the git test suite it does not work, unfortunately.
(Tested on bash, dash and zsh.)

The information I get from
	sh -x ./t????-*.sh
is like the information I get from invoking
	./t????-*.sh -v
but less eye-pleasing.
And ./t????-*.sh -s (using this patch) shows me something like:

	Testing:
		foo

	Testing:
		bar

	* FAIL: blabla

So that I what *command* of the test case fails.

But perhaps I am just doing something wrong.

> > But I didn't know the -x flag and it seems that this could be used in 
> > test-lib.sh to make the hack faster, more robust and less hacky ;-)
> 
> It would obsolete your hack, I suggest.  Obviously, you haven't tried it 
> yet.

The obvious is wrong.

I would be very happy to obsolete my slow and error-prone hack, but
currently I have not seen a good alternative.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

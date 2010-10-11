From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH 0/4] Re: Undocumented git-diff syntax
Date: Mon, 11 Oct 2010 20:52:50 +0200
Message-ID: <20101011185250.GC4983@home.lan>
References: <20101011150342.292ad725@chalon.bertin.fr>
 <AANLkTinqPiGf1nbo0oOvDD5edgLBdO8xZfjGeFC4q0MU@mail.gmail.com>
 <20101011161721.35940919@chalon.bertin.fr>
 <20101011160224.GA25842@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <dirson@bertin.fr>, Santi B?jar <santi@agolina.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 20:42:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5NKM-0006ZF-OX
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 20:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051Ab0JKSmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 14:42:20 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:59844 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769Ab0JKSmU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 14:42:20 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 4940ED48217;
	Mon, 11 Oct 2010 20:42:12 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P5NUQ-0003Fq-Qk; Mon, 11 Oct 2010 20:52:50 +0200
Content-Disposition: inline
In-Reply-To: <20101011160224.GA25842@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158783>

On Mon, Oct 11, 2010 at 11:02:24AM -0500, Jonathan Nieder wrote:
> Yann Dirson wrote:
> 
> > OTOH, that appears not to be 100% accurate (my tests would have
> > shown me): although --no-index does give me the expected results when
> > one or two of the files are untracked, I have to explicitely add it,
> > which seem to contradict this part of the doc.
> 
> Yep, the doc is out of date.  Luckily I had a series updating it
> rotting in my local tree.
> 
> Patch 5 gives --no-index its own prominent mention in the DESCRIPTION
> section.  I suspect that is a bad idea --- too much to learn for new
> users --- and that the description should go under OPTIONS, but I ran
> out of time.

OTOH, not making it prominent does not help users to realize it is
there.  Keeping it last, or maybe in a "less frequently used" section
looks fine to me - eg. the <commit>...<commit> form could join it into
such a section

> Maybe patches 1-4 can help?

They make things much more clear, thanks.


So it looks like after this doc patch series, we're left with a couple
of bugs:

* the "fatal: '../Makefile' is outside repository" seen by Santi
* the following which should probably complain that the files cannot
  be compared:

$ echo a>a;echo b>b
$ git diff a b; echo $?
0

At least, I can't think of them as meaningful behaviours.

Best regards,
-- 
Yann

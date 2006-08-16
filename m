From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Compression and dictionaries
Date: Wed, 16 Aug 2006 09:09:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608160908070.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910608150755q54757386n13c705b0043e8308@mail.gmail.com>
 <20060816003712.32000.qmail@science.horizon.com>
 <4b73d43f0608152243i15b37036x7aa50aa3afc2b02f@mail.gmail.com>
 <9e4733910608152250h1bcb8bf5qebb29ef84b971abd@mail.gmail.com>
 <Pine.LNX.4.63.0608160832320.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060816065515.GB18778@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, John Rigby <jcrigby@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 09:09:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDFWX-0007GP-Bk
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 09:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWHPHJE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 03:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWHPHJE
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 03:09:04 -0400
Received: from mail.gmx.de ([213.165.64.20]:54445 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750892AbWHPHJC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Aug 2006 03:09:02 -0400
Received: (qmail invoked by alias); 16 Aug 2006 07:09:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 16 Aug 2006 09:09:00 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060816065515.GB18778@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25505>

Hi,

On Wed, 16 Aug 2006, Shawn Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> > 
> > On Wed, 16 Aug 2006, Jon Smirl wrote:
> > 
> > > On 8/16/06, John Rigby <jcrigby@gmail.com> wrote:
> > > > Sorry if this is off topic, but could the dictionary be used to make
> > > > git-grep alot faster?
> > > 
> > > It would be almost instant.
> > 
> > But only if you are not using a regular expression, but a single word.
> 
> Yes and no.  If the inverted index contains terms broken by some
> known pattern (e.g. break on word-type boundaries) and the regex
> in question has constant sections (it should, otherwise it might
> as well just be '.') then you can reduce your search space to a
> fraction of the overall data by looking at the inverted index to
> select likely terms, select the related revisions containing those
> possible terms, then run the regex only on those revisions.
> 
> Sure you would be possibly pulling out a number of false positives
> but if the constant sequence(s) in the regex reduce your search
> space to below 1/2 of the overall data that's probably a lot less
> I/O and CPU required to complete the query, even if you have to
> read the entire dictionary and apply each term in the dictionary
> to the regex to look for those possible matches.

So it would speed up the search, but no, in case of regular expressions, 
particularly any interesting one, the result would not be instantaneous.

Ciao,
Dscho

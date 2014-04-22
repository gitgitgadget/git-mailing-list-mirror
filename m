From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 2/2] mergetool: run prompt only if guessed tool
Date: Tue, 22 Apr 2014 08:30:08 +0100
Message-ID: <20140422073008.GA11584@hashpling.org>
References: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
 <1398039454-31193-3-git-send-email-felipe.contreras@gmail.com>
 <20140422045951.GA60610@gmail.com>
 <20140422060120.GA10198@hashpling.org>
 <53560b09bbe96_2400128531085@nysa.notmuch>
 <20140422065549.GA11224@hashpling.org>
 <535611fac1b7b_268bd0b308f5@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 09:30:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcV9o-0006PH-N2
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 09:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbaDVHaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 03:30:12 -0400
Received: from avasout06.plus.net ([212.159.14.18]:59396 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934AbaDVHaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 03:30:09 -0400
Received: from turing.int.hashpling.org ([212.159.69.125])
	by avasout06 with smtp
	id svW61n0022iA9hg01vW7VE; Tue, 22 Apr 2014 08:30:07 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=Rp1LLUWK c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=Ew9TdX-QAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=FaVzYAwi6lUA:10 a=mSBy96HJJ2wA:10
 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10 a=jFp8oKoNQJyRVbPEhx8A:9 a=CjuIK1q_8ugA:10
Received: from charles by turing.int.hashpling.org with local (Exim 4.82)
	(envelope-from <charles@hashpling.org>)
	id 1WcV9c-00036K-3t; Tue, 22 Apr 2014 08:30:08 +0100
Content-Disposition: inline
In-Reply-To: <535611fac1b7b_268bd0b308f5@nysa.notmuch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246710>

On Tue, Apr 22, 2014 at 01:53:46AM -0500, Felipe Contreras wrote:
> Charles Bailey wrote:
> > On Tue, Apr 22, 2014 at 01:24:09AM -0500, Felipe Contreras wrote:
> > > 
> > > This is what I get when a tool is not working:
> > > 
> > >   Documentation/config.txt seems unchanged.
> > >   Was the merge successful? [y/n]
> > 
> > Does this happen now even with merge tools for which we do trust the
> > exit code? If so, my original concern is addressed.
> 
> Which tools are those?
> 

I didn't remember off hand, but checking the mergetools directory
suggests that kdiff3 is one (there's no call to check_unchanged). I
stopped checking after I found one.

> You don't see anything wrong with asking the user *every single time* he runs
> `git mergetool`, even though he *already told us* which tool to use?
>  
> If so, I'm pretty sure everybody else disagrees with you.

I think that you may have misunderstood me. As I said, I've no
particular objections to changing the default (subject a few concerns
that may or may not still apply).

Having said that, the fact that the user has configured the merge tool
doesn't mean that he necessarily doesn't want to see the prompt. In a
part of my reply which you snipped, I said that it's sometimes the
particular file that's due to be resolved that might prompt a user to
want to skip launching the tool.

Either way, I think we shouldn't unconditionally override an explicitly
set mergetool.prompt and if we are (effectively) changing the default we
should probably update the documentation to say so as well. 

(Yes, I didn't introduce the first "no prompt" option patch and yes, I
have since changed my mind about whether I have it set, but that's just
a personal preference.)

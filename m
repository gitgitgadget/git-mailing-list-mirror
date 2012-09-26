From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 3/7] Extract, test and enhance the logic to collapse
 ../foo paths.
Date: Wed, 26 Sep 2012 13:58:51 -0700
Message-ID: <20120926205851.GA2166@dcvr.yhbt.net>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-4-git-send-email-schwern@pobox.com>
 <20120730195108.GA20137@dcvr.yhbt.net>
 <5016F2A5.1090102@pobox.com>
 <20120926194504.GA5013@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 22:59:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGyhB-0005QE-TT
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 22:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695Ab2IZU6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 16:58:52 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39250 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318Ab2IZU6w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 16:58:52 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB5F21F4E1;
	Wed, 26 Sep 2012 20:58:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20120926194504.GA5013@elie.Belkin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206446>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
> 
> Michael G Schwern wrote:
> > On 2012.7.30 12:51 PM, Eric Wong wrote:
> >> Michael G Schwern wrote:
> 
> >>> _collapse_dotdot() works better than the existing regex did.
> >>
> >> I don't dispute it's better, but it's worth explaining in the commit
> >> message to reviewers why something is "better".
> >
> > Yeah.  I figured the tests covered that.
> 
> Now I'm tripping up on the same thing.  Eric, did you ever find out
> what the motivation for this patch was?  Is SVN 1.7 more persnickety
> about runs of multiple slashes in a row or something, or is it more
> of an aesthetic thing?

I'm not sure about this case specifically, but SVN has (and will likely
become) more persnickety over time.  I haven't had a chance to check SVN
itself, but I think being defensive and giving it prettier paths will
be safer in the future.

That said, I'd favor an implementation that split on m{/+} and
collapsed as Michael mentioned.

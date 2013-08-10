From: Jeff King <peff@peff.net>
Subject: Re: Bug: Pulling remotes into an empty repo deletes the index
Date: Sat, 10 Aug 2013 03:33:43 -0400
Message-ID: <20130810073343.GE30185@sigill.intra.peff.net>
References: <CAJOTJ-AVamimToPo4oQ=O_Pg+mJHQhardO+NfU8b1dvRxg1KMA@mail.gmail.com>
 <CAJOTJ-Cgdg4CQs-3t1CsBkq_feVEpkoASzQSTATiVugjs+LL7w@mail.gmail.com>
 <20130803163915.GB945@analysisandsolutions.com>
 <20130803165728.GB2893@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Convissor <danielc@analysisandsolutions.com>,
	Adam A <hitsthings@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 09:33:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V83gM-0006tr-R8
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 09:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933577Ab3HJHdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 03:33:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:54479 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932175Ab3HJHdq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 03:33:46 -0400
Received: (qmail 29693 invoked by uid 102); 10 Aug 2013 07:33:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Aug 2013 02:33:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Aug 2013 03:33:43 -0400
Content-Disposition: inline
In-Reply-To: <20130803165728.GB2893@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232077>

On Sat, Aug 03, 2013 at 09:57:28AM -0700, Jonathan Nieder wrote:

> > All is not lost.  Your local files should be stored in the repository's
> > reflog.  Examine the output of "git reflog".  You can then reset your
> > working directory to obtain those files by doing something _like_
> > "git reset --hard HEAD@{1}".
> 
> Adam hadn't made a commit, so that wouldn't work in this case.
> 
> "git fsck --lost-found" should be helpful, but yeah, this is a bug.
> See for example [1] for the start of a patch to play with (needs
> tests).

If I understand the situation correctly, this is actually already fixed
in v1.8.3.3 and higher by b4dc085 (pull: merge into unborn by
fast-forwarding from empty tree, 2013-06-20).

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Documentation: --options in man-pages synopsys
Date: Wed, 9 Oct 2013 21:52:55 -0400
Message-ID: <20131010015255.GB15106@sigill.intra.peff.net>
References: <CA+gfSn-o7cH3a-KWx_iggNc4-rYzQysbTj7OGdaggutLu-X-BA@mail.gmail.com>
 <FCEE4469EE8B234199968ECA9B0661E230EC61C0@STNEEX10MB01.stone.ne.gov>
 <AB54BA13FC634F47B15CFE796CECADC4@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Loyall, David" <david.loyall@nebraska.gov>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Oct 10 03:53:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VU5R0-00085O-Nt
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 03:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627Ab3JJBw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 21:52:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:46677 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752957Ab3JJBw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 21:52:58 -0400
Received: (qmail 27716 invoked by uid 102); 10 Oct 2013 01:52:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Oct 2013 20:52:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Oct 2013 21:52:55 -0400
Content-Disposition: inline
In-Reply-To: <AB54BA13FC634F47B15CFE796CECADC4@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235850>

On Wed, Oct 09, 2013 at 11:35:19PM +0100, Philip Oakley wrote:

> >As a unix user I'd expect the SYNOPSIS section at the top of the
> >man page to include all options that the command accepts.  Mutually
> >exclusive options are expected to be in the form [-q | --progress |
> >--all-progress], such is already done.
> >
> >I believe that you'd be safe in following http://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap12.html
> >unless the git-* family of commands and documentation deviate from
> >it in a way that I am not aware of.
> 
> 
> For an example of a command with a long list of options try `git
> rev-parse --help`.
> 
> SYNOPSIS
>    git rev-parse [ --option ] <args>.

The current documentation is quite inconsistent between the two forms.
Personally, I favor the shorter form as I think the longer ones end up
quite unwieldy (see "git help rev-list" for example). But I do think the
synopsis should show the major modes of the command. You can see
examples of both in the GNU pages for "cat" and "sort":

  $ man cat | sed -n '/SYNOPSIS/,${p; /^$/q}'
  SYNOPSIS
         cat [OPTION]... [FILE]...

  $ man sort | sed -n '/SYNOPSIS/,${p; /^$/q}'
  SYNOPSIS
         sort [OPTION]... [FILE]...
         sort [OPTION]... --files0-from=F

A similar example in git would be "git help branch", whose synopsis
should include listing mode, creation mode, deleting mode, etc.

However, I am not sure everyone on the list agrees with me on this. Last
time it came up (which was probably several years now) there was some
discussion but not enough consensus for somebody to actually go through
and standardize it.

-Peff

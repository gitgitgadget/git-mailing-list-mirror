From: Jeff King <peff@peff.net>
Subject: Re: Apple violating git LGPL?
Date: Wed, 6 Aug 2014 14:43:04 -0400
Message-ID: <20140806184304.GB21254@peff.net>
References: <CAC_jL3wO9jkE4HapvJjn-4uW4RtSxubFthrxzQJ87EQ4Gq-9Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robert P Fischer <rpf2116@columbia.edu>
X-From: git-owner@vger.kernel.org Wed Aug 06 20:43:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF6B7-0000Dz-9j
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 20:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbaHFSnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 14:43:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:47149 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756191AbaHFSnH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 14:43:07 -0400
Received: (qmail 6554 invoked by uid 102); 6 Aug 2014 18:43:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Aug 2014 13:43:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Aug 2014 14:43:04 -0400
Content-Disposition: inline
In-Reply-To: <CAC_jL3wO9jkE4HapvJjn-4uW4RtSxubFthrxzQJ87EQ4Gq-9Ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254890>

On Wed, Aug 06, 2014 at 02:10:08PM -0400, Robert P Fischer wrote:

> I ran git on my newly-set-up OS X Mavericks machine, and get:
> 
>         $ git
>          Agreeing to the Xcode/iOS license requires admin privileges,
> please re-run as root via sudo.
> 
> Running 'git --verision' gives the same result.  This seems
> problematic in a few ways, and I am wondering if the git community is
> interested in addressing it:
> 
> 1. Why do I have to agree to Apple's licensing terms to use an LGPL
> program?  Is this appropriate?  Is it allowed under the LGPL?

You are not running the real "git" at all here; Apple ships stubs for
several commands, including git, that are distributed with XCode. When
you run the program, it prompts you to install XCode, which then
actually downloads and installs git, replacing the stub.

You can download XCode separately, of course, but you would still need
to agree to the license. You can download git separately and not need to
bother (though I do not know offhand how to download Apple's git, or
whether they provide a script to replace the stubs).

Also, minor nit, but git is GPL, not LGPL.

> 2. This is a significant problem for me, because I'm using a work
> machine and do not have admin access.

You can always download and install git yourself. There's no need to use
the XCode version. However, XCode is the simplest way to get a compiler
on the machine, AFAIK (I do not use OS X myself).

> 3. The version of git I ran is clearly NOT a plain vanilla "official"
> git, it is a derivative work.  Has Apple provided the source code of
> the special version that I just ran?  If not, that would seem to be a
> violation of the LGPL.

You didn't run a derivative git. You ran their stub.

As it happens, though, they _do_ modify the git that they distribute. I
know at least that they bake-in the osxkeychain helper config in away
that the user cannot turn off. There may be more changes, but I haven't
done a full diff. And they do provide the source:

  https://www.opensource.apple.com/source/Git/

-Peff

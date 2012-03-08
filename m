From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git 1.7.10-rc0
Date: Thu, 8 Mar 2012 01:53:06 -0500
Message-ID: <20120308065306.GA8799@sigill.intra.peff.net>
References: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
 <20120308063054.GD7643@sigill.intra.peff.net>
 <7vk42vfv3c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 07:53:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5XDv-0001Rz-Ml
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 07:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224Ab2CHGxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 01:53:11 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44345
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753880Ab2CHGxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 01:53:09 -0500
Received: (qmail 753 invoked by uid 107); 8 Mar 2012 06:53:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Mar 2012 01:53:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Mar 2012 01:53:06 -0500
Content-Disposition: inline
In-Reply-To: <7vk42vfv3c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192528>

On Wed, Mar 07, 2012 at 10:46:47PM -0800, Junio C Hamano wrote:

> >   * "git log -G" and "git log -S" learned to pay attention to the "-i"
> >     option. When "-i" is given, their patterns will match
> >     case-insensitively.
> 
> I was torn about this item, and indeed my earlier draft read like
> yours but I removed "-S" as it felt it was more confusing than it
> was worth.  The thing is that -S does not take any pattern --- it is
> meant to be given a (typically a multi-line) block of text to find
> where the exact block cease to exist in the file.

Yeah, though I think many people do treat it as a fixed-string pattern
(I typically use "git log -Sfoo" to search for "foo", though perhaps
that is because I trained my fingers long before "-G" existed. "-S" is
also a lot faster).

My initial reaction to your statement was "well, if we can't justify it
in the release notes, then perhaps it is wrong for -S to be respecting
-i". But I don't think that is right. The code is doing the right thing,
and it is merely that "-S" is a little-used and often-misunderstood
tool, and you would naturally want to avoid mentioning it to avoid
complicating the notes and confusing the reader.

>  * "git log -G" and "git log -S" learned to pay attention to the "-i"
>    option.  With "-i", "log -G" finds patch hunks that introduce or
>    remove a string that matches the given pattern ignoring the case.
>    Similarly with "-i", "log -S" finds where the given block of text
>    appears or disappears from the file, but this comparison is done
>    case-insensitively.

I think that's much better.

Though as a minor nit, the thing I had trouble parsing originally was
"...that matches the given pattern ignoring the case". I think "...ignores
the case when finding patch hunks that introduce..." is a little easier
to read.

-Peff

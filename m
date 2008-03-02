From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bug in git-revert
Date: Sun, 2 Mar 2008 07:00:32 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803020659340.22527@racer.site>
References: <20080302064449.GA6334@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 02 08:02:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JViD0-0005FM-1n
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 08:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbYCBHBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 02:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbYCBHBT
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 02:01:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:48778 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751340AbYCBHBS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 02:01:18 -0500
Received: (qmail invoked by alias); 02 Mar 2008 07:01:17 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp024) with SMTP; 02 Mar 2008 08:01:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jCMBOgAmj6NaBa7Yltgzq/TAhX5xGQlklq8vhux
	PYRmHagqXHj81p
X-X-Sender: gene099@racer.site
In-Reply-To: <20080302064449.GA6334@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75732>

Hi,

On Sun, 2 Mar 2008, Jeff King wrote:

> In 9509af6 (Make git-revert & git-cherry-pick a builtin), you introduced
> the following code:
> 
>    252          } else {
>    253                  struct wt_status s;
>    254
>    255                  if (get_sha1("HEAD", head))
>    256                          die ("You do not have a valid HEAD");
>    257                  wt_status_prepare(&s);
>    258                  if (s.commitable || s.workdir_dirty)
>    259                          die ("Dirty index: cannot %s", me);
>    260                  discard_cache();
>    261          }
> 
> (where the die condition was later changed to allow a dirty workdir). Am
> I crazy, or is it impossible to trigger either of those conditions?
> wt_status_prepare is about setting up the object to do the actual diff.
> At that point it hasn't actually looked at the index or file contents,
> and so commitable is _always_ 0.

Well, then this is my mistake.  I haven't looked closely at what 
wt_status_prepare() does (or did).

Ciao,
Dscho


From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] Adding a challenge-response authentication method to git://
Date: Wed, 13 Aug 2008 19:37:57 +0200
Message-ID: <20080813173757.GE12200@cuci.nl>
References: <20080813162644.GC12200@cuci.nl> <20080813164038.GE3782@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 19:39:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTKJK-0007ij-MQ
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 19:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbYHMRh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 13:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbYHMRh7
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 13:37:59 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:44579 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282AbYHMRh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 13:37:58 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id B27285465; Wed, 13 Aug 2008 19:37:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080813164038.GE3782@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92249>

Shawn O. Pearce wrote:
>"Stephen R. van den Berg" <srb@cuci.nl> wrote:
>> What are the opinions on adding a basic challenge-response type
>> authentication mechanism to the native git protocol?

>> SHA1 (surprise ;-) to actually encrypt username/password/salt

>Last time we talked about this we got off onto some tagent about
>using GnuPG public keys to authenticate users, and then how we might
...

That is the feature rich solution.  For those there is ssh/webdav
and possibly other setups.

>Isn't there some authentication frontend that some IMAP servers
>use to handle the authentication for them?  I think last time

There is GSSAPI, which allows plugging in just about anything you like.
Nonetheless, for a lot of small projects, you have a relatively small
number of developers (typically <32) which have commitrights on one or
more source trees in a central repository.

In order to aid them in setting up a simple accesslist, git would do
just fine by simply offering a flat-file like list.  Forcing those
setups to use anything more complicated makes adoption of git for those
kind of projects unreasonably more complicated (IMO).

There are no promises for flexibility, security, whatsoever.
The only things I'm aiming for are:
a. Simplicity (need just git).
b. No cleartext passwords over the wire.
c. No encryption.
d. Highest performance (native git protocol).

Anyone needing more is referred to webdav/ssh and assorted solutions.
This minimises the dependencies on external libs, the only thing we need
is a strong hash-function to implement (b); as it happens, we already
have SHA1..
-- 
Sincerely,
           Stephen R. van den Berg.

"And now for something *completely* different!"

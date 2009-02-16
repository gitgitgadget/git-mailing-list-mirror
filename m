From: Jeff King <peff@peff.net>
Subject: disallowing push to currently checked-out branch
Date: Sun, 15 Feb 2009 19:02:20 -0500
Message-ID: <20090216000220.GA3503@coredump.intra.peff.net>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm> <alpine.DEB.1.00.0902152358330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.10.0902151613110.14911@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Feb 16 01:06:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYr04-0006nY-PE
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 01:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbZBPACX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 19:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753118AbZBPACX
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 19:02:23 -0500
Received: from peff.net ([208.65.91.99]:35202 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752869AbZBPACW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 19:02:22 -0500
Received: (qmail 11352 invoked by uid 107); 16 Feb 2009 00:02:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 19:02:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 19:02:20 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0902151613110.14911@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110095>

On Sun, Feb 15, 2009 at 04:14:20PM -0800, david@lang.hm wrote:

>> Please, please, publicize that if there is somebody who is doing the same
>> as you (which I deem a dangerous workflow; I certainly do not use it
>> myself) that they will have to adjust their receive.denyCurrentBranch
>> variable.
>
> since this repository isn't use for anything other than publishing for  
> public access, what's so dangerous about it?
>
> what do you think that I should be doing instead?

What you are doing is not dangerous, because you are one of the clueful
users who understands that the repo is only for publishing, and has set
up a hook to (or is manually triggering) a checkout of the new contents.

It is the less clueful user who doesn't realize that his working tree
and index in the pushed-to repository contain totally bogus information
which can cause him to create bad commits or even lose work permanently.
Dealing with this is one of the most common FAQ's we see on the list.

So the proposal is about making you, the clueful user, set a config
option that promises you have a clue. Which is sad that this must impact
you, but unfortunately it is not a very good strategy to ask clueless
users to set a variable saying that they are so.

-Peff

From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] git-mergetool: add support for ediff
Date: Fri, 29 Jun 2007 00:03:28 -0400
Message-ID: <20070629040328.GG29279@thunk.org>
References: <11830788163411-git-send-email-sam.vilain@catalyst.net.nz> <31e9dd080706281831vbe24597i9b6a5f6f6db6fec8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 06:03:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I47hw-0000ss-3s
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 06:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbXF2EDm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 00:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbXF2EDm
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 00:03:42 -0400
Received: from THUNK.ORG ([69.25.196.29]:51053 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbXF2EDl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 00:03:41 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I47pV-0003fU-4l; Fri, 29 Jun 2007 00:11:33 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I47hg-00036V-Rc; Fri, 29 Jun 2007 00:03:28 -0400
Content-Disposition: inline
In-Reply-To: <31e9dd080706281831vbe24597i9b6a5f6f6db6fec8@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51146>

On Thu, Jun 28, 2007 at 06:31:50PM -0700, Jason Sewall wrote:
> >     echo "merge tool candidates: $merge_tool_candidates"

This was a debugging echo that slipped by; I had never intended for it
to be kept.

> print out emerge and ediff twice, presumably because we're adding it
> in for both "visual" emacs and "regular" (i.e. -nw) emacs. I suck at
> shell scripts, so I'm probably missing something but what why do we
> have all of that testing for emacs + vim if we just add their tools
> anyway right afterwards?

Some things get added twice but in a different order because the
search order matters.  But in terms of adding emerge and ediff, yes,
there's no point, since they always get added in the same order.  

I'll have to look at the two and see why people like one over the
other, and then we'll have to pick which one should be the default.
Although as I've said, past a certain point people should just put
their personal preference in .gitconfig.

						- Ted

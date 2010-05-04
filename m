From: tytso@mit.edu
Subject: Re: PATCH:  Less fragile lookup of gpg key
Date: Mon, 3 May 2010 22:19:37 -0400
Message-ID: <20100504021937.GY14986@thunk.org>
References: <4BDC45EB.8090305@grant-olson.net>
 <4BDC561B.4030307@gmail.com>
 <7vhbmr5ym4.fsf@alter.siamese.dyndns.org>
 <4BDC63FB.7060202@grant-olson.net>
 <7v7hnn4cun.fsf@alter.siamese.dyndns.org>
 <m1O8k0Z-000kndC@most.weird.com>
 <BA24F2BF-018D-403B-A23B-0F2E57A7C00A@mit.edu>
 <m1O93yz-000kndC@most.weird.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: The Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 04 04:19:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O97je-0000YB-JZ
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 04:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756842Ab0EDCTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 22:19:40 -0400
Received: from thunk.org ([69.25.196.29]:39182 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755682Ab0EDCTj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 22:19:39 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1O97jW-0007Mt-KN; Mon, 03 May 2010 22:19:38 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1O97jW-0003hW-06; Mon, 03 May 2010 22:19:38 -0400
Content-Disposition: inline
In-Reply-To: <m1O93yz-000kndC@most.weird.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146279>

On Mon, May 03, 2010 at 06:19:17PM -0400, Greg A. Woods wrote:
> 
> Normally the only time I've ever seen anyone end up with multiple
> published keys associated with the same e-mail address it has happened
> when they have accidentally lost their private key somehow and therefore
> they were unable to revoke it properly.

Well, I suspect this case happens fairly often.  (And there are other
cases; where you're still gathering enough signatures so you can use
your new key, and the old key hasn't been compromised, but people have
started getting paranoid about the crypto algorithms involved, etc.)
So I'd argue that saying this is only something that Advanced GPG
users will use is probably a bit short-sighted.

> Meanwhile the original problem here appears to me to be that Git
> effectively encourages use of multiple valid keys that may have the same
> e-mail address attached to multiple key-IDs.

Yes, I think that *is* the problem.  If you want to optimize for the
common case, that's fine, but it's also useful to have a way for users
to specify in their gitconfig files that a specific KeyID should be
used if they are signing with a particular e-mail ID.

							- Ted

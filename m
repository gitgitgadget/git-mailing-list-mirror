From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Specifying N revisions after the initial commit
Date: Tue, 22 Sep 2015 16:40:00 -0400
Message-ID: <20150922204000.GC3318@thunk.org>
References: <CA+5PVA40x8bxW63X+b77FDO8btRBaVOg=fq+ZyX=bdJ+uEm9gA@mail.gmail.com>
 <20150922214037.b6b48059f051fcd4060a5a85@domain007.com>
 <CA+5PVA6YWJizRjseeJ4EpRya0Mpyrv3DoNsB3=Gi=dOiAoDfHg@mail.gmail.com>
 <xmqqpp1a2pql.fsf@gitster.mtv.corp.google.com>
 <CA+5PVA6zUXGs2R-MOoj5sBxwUqM7HP=tx-0WZJzPf71MsjH9MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	Git Mailing List <git@vger.kernel.org>
To: Josh Boyer <jwboyer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 22:40:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeUMm-0007Vm-Jf
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 22:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934659AbbIVUkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 16:40:08 -0400
Received: from imap.thunk.org ([74.207.234.97]:37366 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934624AbbIVUkH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 16:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=FDrHb6fyZbOzesUBQFedXTgMri8MUFzVhjFto+vCn4k=;
	b=wT2HEZilgUc4ug9+g6ZDbEdh9ifMWr2q+Gxk2IAXfKasC1ylj2D0b1uRFKHvnJLjIIwa6+2sot0nLNT5LiM5kEZ3tCjRpmsg0KYJSh4GKy4Aqhev1UJ4tAmo7ed4nuxaiiXzB2bm5xVLHX7kncfuutC+Ebor1qjuWeZWOyi0rlE=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84)
	(envelope-from <tytso@thunk.org>)
	id 1ZeUM4-0003K4-V8; Tue, 22 Sep 2015 20:40:01 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 54C4E82CE1B; Tue, 22 Sep 2015 16:40:00 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CA+5PVA6zUXGs2R-MOoj5sBxwUqM7HP=tx-0WZJzPf71MsjH9MA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278433>

On Tue, Sep 22, 2015 at 04:11:23PM -0400, Josh Boyer wrote:
> Oh, context would help, yes.  In the case of the tree I'm parsing, I
> know for a fact that the commit history is entirely linear and will
> (should) always remain so.  E.g.
> 
> A - B - C - D - E - F ... {N}
> 
> So yes, finding e.g. the second commit after the root is complicated
> for something resembling anything like a typical git repo, but this
> isn't like that.  In other words, I can cheat.  Or at least I'm pretty
> sure I can cheat :).

I'd suggest making your script makes sure "git rev-list --merges A..N"
doesn't output any commits, so you know for sure that the commit
history is linear.  That way you'll be certain that you can cheat.  :-)

	   	    	     	    - Ted

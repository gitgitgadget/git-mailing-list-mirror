From: Theodore Tso <tytso@mit.edu>
Subject: Re: receive.denyCurrentBranch
Date: Mon, 9 Feb 2009 00:06:59 -0500
Message-ID: <20090209050659.GA12655@mini-me.lan>
References: <20090208042910.19079.qmail@science.horizon.com> <alpine.DEB.1.00.0902081128420.10279@pacific.mpi-cbg.de> <76718490902080950r798ca02es4e560da35e499046@mail.gmail.com> <alpine.DEB.1.00.0902082149380.10279@pacific.mpi-cbg.de> <76718490902081451xd953e84y33de64cc82c1da42@mail.gmail.com> <alpine.DEB.1.00.0902090038550.10279@pacific.mpi-cbg.de> <76718490902081747s7a1ebe12yaf08665429a594c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	George Spelvin <linux@horizon.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 06:18:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWOWx-0006c7-TU
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 06:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbZBIFMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 00:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbZBIFMs
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 00:12:48 -0500
Received: from thunk.org ([69.25.196.29]:58887 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696AbZBIFMr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 00:12:47 -0500
Received: from tytso authenticated as tytso by thunker.thunk.org with local   (Exim 4.50 #1 (Debian))
	id 1LWORl-0005Js-3b; Mon, 09 Feb 2009 00:12:41 -0500
Content-Disposition: inline
In-Reply-To: <76718490902081747s7a1ebe12yaf08665429a594c6@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109045>

On Sun, Feb 08, 2009 at 08:47:26PM -0500, Jay Soffian wrote:
> I agree that a detached HEAD is a bad idea. The closest parallel that
> I can come up with for git would be for receive-pack to store incoming
> changes into separate branch hierarchy, NOT for it to detach HEAD. A
> toy-patch I played around with earlier allowed this on the non-bare
> upstream repo:
> 
> [receive]
>      prefix = refs/remotes/incoming
> 
> Then a push to refs/heads/master was automatically stored as
> refs/remotes/incoming/master instead.

What happens when the next person pushes to the same remote repo, and
their refs/heads/master push is not a fast-forward merge of the
current refs/remotes/incoming/master?

Do you lose the first user's push at that point?  Or do you refuse the
push?

						- Ted

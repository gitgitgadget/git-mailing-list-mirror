From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: RFC: adding xdelta compression to git
Date: Tue, 3 May 2005 11:52:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0505031151380.32767@cag.csail.mit.edu>
References: <200505030657.38309.alonz@nolaviz.org>
 <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org>
 <Pine.LNX.4.58.0505022215110.21733@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>, Alon Ziv <alonz@nolaviz.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 17:49:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSzcV-0003S2-US
	for gcvg-git@gmane.org; Tue, 03 May 2005 17:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVECPxp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 11:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVECPxp
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 11:53:45 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:19928 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261797AbVECPw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 11:52:56 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DSzhN-0007uC-00; Tue, 03 May 2005 11:52:37 -0400
To: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.58.0505022215110.21733@bigblue.dev.mdolabs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2 May 2005, Davide Libenzi wrote:

> On Mon, 2 May 2005, Linus Torvalds wrote:
>
>> Yes. EXCEPT for one thing. fsck. I'd _really_ like fsck to be able to know
>> something about any xdelta objects, if only because if/when things go

> Linus, xdelta-based algorithms already stores informations regarding the
> object that originated the diff. Since they have no context (like
> text-based diffs) and are simply based on offset-driven copy/insert
> operations, this is a requirement. Libxdiff uses an adler32+size of the
> original object, but you can get as fancy as you like in your own
> implementation. Before a delta patching, the stored information are cross
> checked with the input base object, and the delta patch will fail in the
> eventuality of mismatch. So an fsck is simply a walk backward (or forward,
> depending on your metadata model) of the whole delta chain.

Linus knows this.  His point is just to be sure you actually *code* that 
walk in fsck, and (hopefully) do so w/o complicating the fsck too much.
  --scott

supercomputer BOND quiche SYNCARP Honduras North Korea Qaddafi PANCHO 
SKILLET KUDESK non-violent protest ESQUIRE struggle Saddam Hussein
                          ( http://cscott.net/ )

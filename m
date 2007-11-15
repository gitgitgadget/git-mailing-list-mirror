From: David Kastrup <dak@gnu.org>
Subject: Re: [BUG] t7004 (master) busted on Leopard
Date: Thu, 15 Nov 2007 15:48:33 +0100
Message-ID: <86k5oj36pq.fsf@lola.quinscape.zz>
References: <17E3F66C-4644-4B64-817C-88062727A2D9@wincent.com> <Pine.LNX.4.64.0711151434060.30886@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 15:50:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isg2Z-0003mt-0n
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 15:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164AbXKOOtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 09:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757443AbXKOOtl
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 09:49:41 -0500
Received: from main.gmane.org ([80.91.229.2]:51871 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756996AbXKOOtl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 09:49:41 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Isg1b-00040O-Mn
	for git@vger.kernel.org; Thu, 15 Nov 2007 14:48:59 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 14:48:59 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 14:48:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:UtxVfruZCBArRReMfLfiSHWX2PU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65125>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 15 Nov 2007, Wincent Colaiuta wrote:
>
>> Commit 4d8b1dc850 added a couple of tests to t7004, and my testing reveals
>> that this one has been broken on Leopard since then:
>> 
>> * FAIL 83: message in editor has initial comment
>> GIT_EDITOR=cat git tag -a initial-comment > actual || true &&
>> test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
>
> I think this is our good old friend, MacOSX' sed.  (Wasn't there a 
> question today what's wrong with using sed?  I think this issue 
> qualifies.)

\| is not portable.  $ in groups is not portable.

> I imagine that it is that MacOSX' sed is adding a trailing newline (not 
> the regexp like you suggested).

I imagine it is one of the above.  Most sed's add trailing newlines.

-- 
David Kastrup

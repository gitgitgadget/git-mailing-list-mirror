From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Feature request: git-svn dcommit should send deltas upstream
Date: Sun, 31 Aug 2008 20:41:47 -0700
Message-ID: <20080901034127.GA22120@untitled>
References: <87myj0f3mb.fsf@mid.deneb.enyo.de> <20080829082311.GA7128@yp-box.dyndns.org> <87tzd4p1lt.fsf@mid.deneb.enyo.de> <87y72dkvq4.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Mon Sep 01 05:42:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka0Ja-0004LP-GM
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 05:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbYIADls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 23:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbYIADls
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 23:41:48 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35036 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbYIADlr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 23:41:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 51CA52DC01B;
	Sun, 31 Aug 2008 20:41:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87y72dkvq4.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94526>

Florian Weimer <fw@deneb.enyo.de> wrote:
> * Florian Weimer:
> 
> >> It's been too long since I've looked at the SVN TxDelta API, but I
> >> thought SVN::TxDelta::apply would take care of the delta computation for
> >> us...
> >
> > SVN::Git::Editor::M does not seem to make use of the base text.
> 
> Here's an attempt at delta generation.  I don't know if it is entirely
> correct, but it does work in the sense that it passes "make test" and
> the test cases I reported eariler.

Thanks Florian.

Works for me, here.  I've also tested this editing an audio file and
transmitting it over the wire without any trouble.  I've added one more
patch on top of your series to check the (undef) return value of
send_txstream.

Acked and pushed out to git://git.bogomips.org/git-svn.git along
with Thomas's other patch.

-- 
Eric Wong

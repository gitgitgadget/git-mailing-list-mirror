From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] git-cvsexportcommit can't commit files which have been removed from CVS
Date: Fri, 12 Jun 2009 08:59:32 +0200
Message-ID: <200906120859.33139.robin.rosenberg.lists@dewire.com>
References: <4A1F1CF5.8030002@yahoo.co.uk> <7vr5xqixd1.fsf@alter.siamese.dyndns.org> <7vzlcehfbd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nick Woolley <nickwoolley@yahoo.co.uk>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 08:59:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF0js-0000hK-Fb
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 08:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074AbZFLG7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 02:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbZFLG7i
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 02:59:38 -0400
Received: from mail.dewire.com ([83.140.172.130]:28029 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752933AbZFLG7i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 02:59:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0101E147D5AC;
	Fri, 12 Jun 2009 08:59:35 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A24xPqokPiC1; Fri, 12 Jun 2009 08:59:34 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id 9417B802D26;
	Fri, 12 Jun 2009 08:59:34 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <7vzlcehfbd.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121394>

torsdag 11 juni 2009 19:04:54 skrev Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Nick Woolley <nickwoolley@yahoo.co.uk> writes:
> >> Mike Ralphson wrote:
> >>> cvs commit: Up-to-date check failed for ` space'
> >>> cvs [commit aborted]: correct above errors first!
> >>> * FAIL 15: re-commit a removed filename which remains in CVS attic
> >>> * failed 1 among 15 test(s)
> > But it does seem to be repeatable; I wouldn't rule out a race condition.
> 
> Ehh, sorry, it "does not" seem to be repeatable.  Sometimes and only
> sometimes it fails...

CVS har a timestamp in CVS/Entries that has whole second resolution. In
addition it's built-in method for trying to work around the problem by sleeping
until the next second wraps around is flaky.  cvsexportcommit already has
one sleep for this. Maybe it's not enough.

-- robin

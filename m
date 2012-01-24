From: Jason <git@lakedaemon.net>
Subject: Re: rsync a *bunch* of git repos
Date: Tue, 24 Jan 2012 09:11:52 -0500
Message-ID: <20120124141152.GD23524@titan.lakedaemon.net>
References: <20120110211548.GD10255@titan.lakedaemon.net>
 <201201102124.q0ALOowL026941@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Tue Jan 24 15:12:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rph6P-0008Bv-NH
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 15:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756626Ab2AXOLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 09:11:55 -0500
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38330 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756623Ab2AXOLy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 09:11:54 -0500
Received: from pool-108-39-66-94.nrflva.fios.verizon.net ([108.39.66.94] helo=titan)
	by mho-02-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <git@lakedaemon.net>)
	id 1Rph6H-000JvM-F5; Tue, 24 Jan 2012 14:11:53 +0000
Received: from titan.lakedaemon.net (localhost [127.0.0.1])
	by titan (Postfix) with ESMTP id 6A0D62FA87B;
	Tue, 24 Jan 2012 09:11:52 -0500 (EST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 108.39.66.94
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/NzHaFyyB1uOkUmCwdXP8FH2sYMsTPIuY=
Content-Disposition: inline
In-Reply-To: <201201102124.q0ALOowL026941@no.baka.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189046>

Hi Seth,

On Tue, Jan 10, 2012 at 04:24:50PM -0500, Seth Robertson wrote:
> 
> In message <20120110211548.GD10255@titan.lakedaemon.net>, Jason writes:
> 
>     The nuts and bolts of this aren't difficult, the problem is I don't have
>     a complete understanding of how git stores data.  I've heard in the
>     past that it uses a lot of hardlinks and softlinks.  I need to make
>     sure, that once I transfer the data, and reboot the machine with the new
>     partition mounted under /home, that all my git repos will be okay.
> 
> Under most circumstances, git will do the right thing.  Only if you
> use specific flags on clone (like --shared or --reference) might
> something go wrong, and as the manual page explains, you can use
> git-repack to undo these.
> 
> The real solution is, after you rsync, to:
> 
> for f in */.git; do (cd $f; git fsck >&/dev/null || echo "$f is BAD!!"); done

Okay, I've been using the new system for a week or so now, and
everything looks good.  Thanks!

Before the transfer, I went ahead and did the above to make sure the
repos were good to begin with.  All 279 of them were fine, both before
and after.

thx,

Jason.

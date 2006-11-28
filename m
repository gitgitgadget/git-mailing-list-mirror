X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 13:31:56 -0500
Message-ID: <456C809C.3050503@utoronto.ca>
References: <45357CC3.4040507@utoronto.ca>	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>	<87slhcz8zh.wl%cworth@cworth.org>	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>	<20061026101038.GA13310@coredump.intra.peff.net>	<877iyne4dm.fsf@alplog.fr>	<Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>	<456B7C6A.80104@webdrake.net>	<845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>	<ekhaeg$etk$1@sea.gmane.org>	<Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>	<456C6CBB.70702@utoronto.ca> <ekhrhi$g6t$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 18:32:51 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Debian Thunderbird 1.0.2 (X11/20060926)
X-Accept-Language: en-us, en
In-Reply-To: <ekhrhi$g6t$1@sea.gmane.org>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32561>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp7kd-0007bA-30 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 19:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758733AbWK1ScL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 13:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758734AbWK1ScL
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 13:32:11 -0500
Received: from server4.panoramicfeedback.com ([66.216.124.41]:5052 "EHLO
 server4.panoramicfeedback.com") by vger.kernel.org with ESMTP id
 S1758733AbWK1ScJ (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006
 13:32:09 -0500
Received: from server4.panoramicfeedback.com ([66.216.124.41]
 helo=[192.168.2.19]) by server4.panoramicfeedback.com with esmtp (Exim 3.36
 #1 (Debian)) id 1Gp7kT-00041i-00; Tue, 28 Nov 2006 13:32:06 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jakub Narebski wrote:
>>I notice that blame has an option to limit the annotation to recent
>>history.  I can only assume that is for performance reasons.  bzr
>>annotate doesn't need a feature like that, because annotations are
>>explicit in bzr's storage format. 
> 
> 
> But you don't have content movement tracking.
> 
> 
>>                                  I expect that even if we were to 
>>extend annotate to track content across files, it would still be so fast
>>that we wouldn't need it.
> 
> 
> I think not.

There's no question that determining content movement could involve
opening a lot of revisions, but you wouldn't need to examine:

1. revisions that didn't alter any lines being examined
2. revisions that altered only the file in question
3. revisions with multiple parents, because any lines attributed to that
merge will be the outcome of conflict resolution.  (Other lines will be
attributed to one of the parents)

I'll admit though, that when I was thinking of this, I was thinking of
annotation-based merging, a scenario in which the number of lines being
examined is typically extremely low.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFbICL0F+nu1YWqI0RAhaXAJ9tqw/J17oKDV0nnuPlputs1PHBIgCghs6K
q++u4Z9OFGwziUBsnW08y0U=
=tmqe

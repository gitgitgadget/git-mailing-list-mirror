X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Diffs from CVS keyword expansion
Date: Tue, 5 Dec 2006 21:30:52 +0100
Organization: Dewire
Message-ID: <200612052130.52247.robin.rosenberg.lists@dewire.com>
References: <9e4733910611301956l6f64b01ftee46971a18e3467b@mail.gmail.com> <86k616m8i9.fsf@blue.stonehenge.com> <7v64cqglsm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 20:28:38 +0000 (UTC)
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <7v64cqglsm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33371>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grgu2-0005Ma-Uo for gcvg-git@gmane.org; Tue, 05 Dec
 2006 21:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031303AbWLEU2b (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 15:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031321AbWLEU2b
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 15:28:31 -0500
Received: from [83.140.172.130] ([83.140.172.130]:25404 "EHLO
 torino.dewire.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with
 ESMTP id S1031303AbWLEU2a (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec
 2006 15:28:30 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id AB26B8030CC; Tue,  5 Dec 2006 21:24:40 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 11379-07; Tue,  5 Dec
 2006 21:24:40 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4]) by torino.dewire.com (Postfix)
 with ESMTP id 5A754802AA9; Tue,  5 Dec 2006 21:24:40 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

tisdag 05 december 2006 20:55 skrev Junio C Hamano:
> merlyn@stonehenge.com (Randal L. Schwartz) writes:
> >>>>>> "Uwe" == Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>
> >>>>>> writes:
> >
> > Uwe> 	#! /bin/sh
> > Uwe> 	exec perl -i -p -e 's/\$(Id|Revision):.*?\$/\$$1: \$/' "$@";
> >
> > Ow.  My eyes hurt from that.  How about we rewrite that as a native Perl
> > script:
> >
> >     #!/usr/bin/perl
> >     $^I = ""; # this is -i
> >     while (<>) {
> >       s/\$(Id|Revision):.*?\$/\$$1: \$/;
> >       print;
> >     }
>
> That's kinda surprising coming from the resident Perl guru.
>
> I am so used to the command line "-i -p" that I did not even
> know what $^I does, and I would have lost without your "# this
> is -i" comment.  That alone makes the Uwe's one more readable
> for me ;-).
May I suggest a compromise? : 

#!/usr/bin/perl -i -p
s/\$(Id|Revision):.*?\$/\$$1: \$/;


X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Diffs from CVS keyword expansion
Date: 05 Dec 2006 11:45:50 -0800
Message-ID: <86k616m8i9.fsf@blue.stonehenge.com>
References: <9e4733910611301956l6f64b01ftee46971a18e3467b@mail.gmail.com>
	<20061205121443.GB2428@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 19:46:11 +0000 (UTC)
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.15.12; tzolkin = 6 Eb; haab = 5 Mac
In-Reply-To: <20061205121443.GB2428@cepheus>
Original-Lines: 20
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33367>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrgEn-0007NU-JV for gcvg-git@gmane.org; Tue, 05 Dec
 2006 20:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030572AbWLETpy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 14:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030613AbWLETpy
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 14:45:54 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:35179 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030572AbWLETpx (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 14:45:53 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id D7B378E9AD; Tue,  5 Dec 2006 11:45:50 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 06049-01-19; Tue,  5 Dec 2006 11:45:50 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 62BD08E8A9;
 Tue,  5 Dec 2006 11:45:50 -0800 (PST)
To: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>
Sender: git-owner@vger.kernel.org

>>>>> "Uwe" == Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de> writes:

Uwe> 	#! /bin/sh
Uwe> 	exec perl -i -p -e 's/\$(Id|Revision):.*?\$/\$$1: \$/' "$@";

Ow.  My eyes hurt from that.  How about we rewrite that as a native Perl
script:

    #!/usr/bin/perl
    $^I = ""; # this is -i
    while (<>) {
      s/\$(Id|Revision):.*?\$/\$$1: \$/;
      print;
    }

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.

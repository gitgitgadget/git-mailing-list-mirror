X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: fork0@t-online.de (Alex Riesen)
Subject: Re: Easy shell question: how to make a script killing all his childs when killed?
Date: Sat, 9 Dec 2006 18:37:03 +0100
Message-ID: <20061209173703.GA12373@steel.home>
References: <e5bfff550612090716p215167b9r2277b09c09b18894@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 9 Dec 2006 17:37:24 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <e5bfff550612090716p215167b9r2277b09c09b18894@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-ID: S99OdGZHreH5xZzWPtzlEAXNWzNmq4kxZviUN9n1GN-NreLXK11bQI
X-TOI-MSGID: 3e77c383-8040-4032-9a1d-adda7fb138df
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33823>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt68Y-0007D9-5U for gcvg-git@gmane.org; Sat, 09 Dec
 2006 18:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758356AbWLIRhO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 12:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758473AbWLIRhO
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 12:37:14 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:43241 "EHLO
 mailout06.sul.t-online.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1758398AbWLIRhM (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec
 2006 12:37:12 -0500
Received: from fwd28.aul.t-online.de  by mailout06.sul.t-online.com with smtp
  id 1Gt68M-0000PN-07; Sat, 09 Dec 2006 18:37:10 +0100
Received: from tigra.home
 (S99OdGZHreH5xZzWPtzlEAXNWzNmq4kxZviUN9n1GN-NreLXK11bQI@[84.163.113.204]) by
 fwd28.sul.t-online.de with esmtp id 1Gt68G-13Oc8e0; Sat, 9 Dec 2006 18:37:04
 +0100
Received: from steel.home (steel.home [192.168.1.2]) by tigra.home (Postfix)
 with ESMTP id 8D82C277AF; Sat,  9 Dec 2006 18:37:03 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian)) id
 1Gt68F-0003Ef-5I; Sat, 09 Dec 2006 18:37:03 +0100
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

Marco Costalba, Sat, Dec 09, 2006 16:16:32 +0100:
> So how can I write the script to be sure that when stopped, it will
> kill all his childern?

Strictly speaking: you can't. Anything you'd try will either be not
portable or involve quiet complex dependencies (like perl).
Are you sure you can't control each process independently?

Speaking not so strictly, you can use a script engine which supports
either signal handling or exit notification (i.e. sh has traps and
perl has %SIG and END{}). It's unsafe, ugly and not quiet portable to
that other operating system, but it often works and is (ab)used.

> P.S: I have no way to exec the script in fancy ways, I can just start
> it and get is PID.

Which is "fancy" enough. What do you mean "start"? Starting a new
process usually and notably involves forking and execing (even if the
first thing to exec will be your shell).

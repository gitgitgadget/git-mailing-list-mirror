X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>
Subject: Re: Diffs from CVS keyword expansion
Date: Tue, 5 Dec 2006 13:14:43 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20061205121443.GB2428@cepheus>
References: <9e4733910611301956l6f64b01ftee46971a18e3467b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 12:14:55 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9e4733910611301956l6f64b01ftee46971a18e3467b@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33340>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrZCH-0005M4-4V for gcvg-git@gmane.org; Tue, 05 Dec
 2006 13:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760022AbWLEMOs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 07:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760030AbWLEMOs
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 07:14:48 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:53682 "EHLO
 atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S1760022AbWLEMOr (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5
 Dec 2006 07:14:47 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6]) by
 atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60) (envelope-from
 <zeisberg@informatik.uni-freiburg.de>) id 1GrZCA-0002pl-Ri; Tue, 05 Dec 2006
 13:14:46 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1]) by
 login.informatik.uni-freiburg.de (8.13.6/8.12.11) with ESMTP id
 kB5CEiY8013052; Tue, 5 Dec 2006 13:14:44 +0100 (MET)
Received: (from zeisberg@localhost) by login.informatik.uni-freiburg.de
 (8.13.6/8.12.11/Submit) id kB5CEipj013051; Tue, 5 Dec 2006 13:14:44 +0100
 (MET)
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org

Hello Jon,

Jon Smirl wrote:
> Anyone have a nice script for suppressing diffs caused by CVS keyword
> expansion when someone checked the kernel sources into CVS?
I have a little script (called rmcvsid) in my private path, that just
wraps a Perl oneliner:

	#! /bin/sh
	exec perl -i -p -e 's/\$(Id|Revision):.*?\$/\$$1: \$/' "$@";

This edits inplace all cvs keywords to be not expanded.  If you call it
for all files *before* you throw them into git, you don't need to
suppress the diffs, because there are none.

You may have to add Source, Date and maybe others.

HTH
Uwe

-- 
Uwe Kleine-Koenig


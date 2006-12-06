X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>
Subject: Re: Diffs from CVS keyword expansion
Date: Wed, 6 Dec 2006 11:05:14 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20061206100514.GA7126@informatik.uni-freiburg.de>
References: <9e4733910611301956l6f64b01ftee46971a18e3467b@mail.gmail.com> <20061205121443.GB2428@cepheus> <86k616m8i9.fsf@blue.stonehenge.com> <Pine.LNX.4.63.0612052048230.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 10:05:39 +0000 (UTC)
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612052048230.28348@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33420>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grteg-0008VQ-8q for gcvg-git@gmane.org; Wed, 06 Dec
 2006 11:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760425AbWLFKFW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 05:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760409AbWLFKFW
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 05:05:22 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:62343 "EHLO
 atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S1760426AbWLFKFT (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6
 Dec 2006 05:05:19 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6]) by
 atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60) (envelope-from
 <zeisberg@informatik.uni-freiburg.de>) id 1GrteQ-0003ZN-Ld; Wed, 06 Dec 2006
 11:05:18 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1]) by
 login.informatik.uni-freiburg.de (8.13.6/8.12.11) with ESMTP id
 kB6A5F4u007931; Wed, 6 Dec 2006 11:05:15 +0100 (MET)
Received: (from zeisberg@localhost) by login.informatik.uni-freiburg.de
 (8.13.6/8.12.11/Submit) id kB6A5EZs007930; Wed, 6 Dec 2006 11:05:14 +0100
 (MET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Hi,

Johannes Schindelin wrote:
> On Tue, 5 Dec 2006, Randal L. Schwartz wrote:
> 
> > >>>>> "Uwe" == Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de> writes:
> > 
> > Uwe> 	#! /bin/sh
> > Uwe> 	exec perl -i -p -e 's/\$(Id|Revision):.*?\$/\$$1: \$/' "$@";
> > 
> > Ow.  My eyes hurt from that.  How about we rewrite that as a native Perl
> > script:
I don't like that either, just because it's Perl :-)

> >     #!/usr/bin/perl
> >     $^I = ""; # this is -i
> >     while (<>) {
> >       s/\$(Id|Revision):.*?\$/\$$1: \$/;
> >       print;
> >     }
> 
> Hey, that's better! All of a sudden, I understand everything!
I'm not fluent in Perl, and didn't know $^I.  Actually, that's better,
yes.  (And my script is already rewritten.)

One thing I don't like about both scripts is, that the timestamp of
a file changes with that, even if there are no changes.  Anyone knows
another predefined variable/trick that doesn't hurt performance (and
readability) too much?

timtowtdi
Uwe

-- 
Uwe Kleine-Koenig


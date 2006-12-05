X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: filesystem encodings and gitweb tests, was Re: Moving a directory
 into another fails
Date: Tue, 5 Dec 2006 15:11:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612051507170.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com>
 <Pine.LNX.4.64.0612041317480.3476@woody.osdl.org>
 <Pine.LNX.4.63.0612050831550.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612051036.13645.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 14:11:46 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200612051036.13645.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33342>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grb1J-0003iF-6N for gcvg-git@gmane.org; Tue, 05 Dec
 2006 15:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760053AbWLEOLf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 09:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760042AbWLEOLf
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 09:11:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:33539 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1760030AbWLEOLe
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 09:11:34 -0500
Received: (qmail invoked by alias); 05 Dec 2006 14:11:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp045) with SMTP; 05 Dec 2006 15:11:32 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 5 Dec 2006, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > On Mon, 4 Dec 2006, Linus Torvalds wrote:
> > 
> >> 	[core]
> >> 		escapefilenames = true
> > 
> > I think this goes too far. The problem _only_ showed up with a made-up 
> > test case for gitweb. Let's bite the apple when we _have_ to (which I 
> > doubt will happen, because for the most part, developers understand that 
> > spaces and umlauts have _no_ place in filenames, basically since UNIX was 
> > invented by stupid US Americans who did not know anything about nice 
> > filenames, let alone other languages than English and C).
> 
> No, the problem showed with stupid HFS+ which uses different encoding
> for creating file, and different for readdir.

This is just one of the problems. I described another problem in this 
thread, namely a repo on a usb stick being accessed from different hosts.

> Perhaps we should remove gitweb/test directory, and move testing gitweb 
> to proper place, t/ directory.

If you do that, please make sure that these tests can be disabled (a la 
svn tests), so that people not being interested in gitweb, or lacking the 
programs to test it, do not have to suffer.

> By the way, would it be correct to use external tools (if they exist),
> namely HTMLtidy in gitweb output test to-be-written?

(Yes, they exist. HTMLtidy for example ;-)

IMHO if such a tool is common enough, you should use it. If anybody steps 
forward providing automated HTTP tests, I will not complain, and certainly 
not about testing with things like HTMLtidy.

Ciao,
Dscho

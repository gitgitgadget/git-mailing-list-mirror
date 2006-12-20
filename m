X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Question on rerere
Date: Wed, 20 Dec 2006 02:40:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612200240360.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612200045490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk60no0ua.fsf@assigned-by-dhcp.cox.net> <7vy7p3mk1i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 20 Dec 2006 01:40:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vy7p3mk1i.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34889>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwqRv-0003xl-Kq for gcvg-git@gmane.org; Wed, 20 Dec
 2006 02:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932912AbWLTBkt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 20:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932935AbWLTBkt
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 20:40:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:37405 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932912AbWLTBks
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 20:40:48 -0500
Received: (qmail invoked by alias); 20 Dec 2006 01:40:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp046) with SMTP; 20 Dec 2006 02:40:46 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 19 Dec 2006, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> IIUC then each conflict hunk is handled _separately_ like this: the 
> >> lexicographically smaller between the two file sections is displayed 
> >> first, regardless if a previous hunk had a different order. Not that it 
> >> matters most of the time, but isn't this dangerous?
> >
> > You are probably right.  Probably the right thing would be to
> > use the first hunk to determine the flipping order and stick to
> > that for the rest.
> >
> > Not that I've seen problems with the current behaviour, though.
> 
> Well, come to think of it, I think the current behaviour makes
> more sense.
> 
> Suppose you start from an original file "OO".  You have two
> branches that change it to "AO" and "BO", and another pair of
> branches that change it to "OC" and "OD".  Let's call these
> branches A, B, C, and D.
> 
> By merging A and C, you will get "AC"; you can get "AD", "BC"
> and "BD" the same way.
> 
> Now suppose you are on "AC" and merged "BD".  You would get
> "<A=B><C=D>".
> 
> If you were on "BD" and merged "AC" you would get "<B=A><D=C>".
> If you were on "AD" and merged "BC" you would get "<A=B><D=C>".
> 
> You got the idea?

Yes. Thanks!

Ciao,
Dscho

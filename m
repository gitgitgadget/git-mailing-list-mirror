X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: SEGV when lookup_* returns NULL
Date: Tue, 28 Nov 2006 00:33:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611280032300.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061127211315.GC18810@admingilde.org> <7vu00kftbq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 27 Nov 2006 23:33:44 +0000 (UTC)
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vu00kftbq.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32460>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gopyc-0008G3-CB for gcvg-git@gmane.org; Tue, 28 Nov
 2006 00:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758608AbWK0Xd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 18:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758610AbWK0Xd2
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 18:33:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:34969 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1758608AbWK0Xd1 (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 18:33:27 -0500
Received: (qmail invoked by alias); 27 Nov 2006 23:33:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp039) with SMTP; 28 Nov 2006 00:33:26 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 27 Nov 2006, Junio C Hamano wrote:

> Martin Waitz <tali@admingilde.org> writes:
> 
> > All the lookup_{blob,tree,commit} functions check that the object
> > really is of the requested type and return NULL otherwise.
> > However this NULL pointer is not checked in the calling functions.
> >
> > Should we make lookup_* to just die when invoked on another object-type?
> 
> Making lookup_{specific type} die when they see unexpected type
> would not hurt that much, I think, aside from the possibility
> that some callers may check NULL to see if object already
> exists, but they should be using has_sha1_file() instead.

And it would totally clobber the long term goal of libifying git.

Ciao,
Dscho

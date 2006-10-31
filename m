X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] upload-pack: no longer call rev-list
Date: Tue, 31 Oct 2006 10:56:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0610311054500.26682@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0610302008320.26682@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1woprrwi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 31 Oct 2006 09:56:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v1woprrwi.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30577>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeqME-0004AW-El for gcvg-git@gmane.org; Tue, 31 Oct
 2006 10:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423053AbWJaJ4b (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 04:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423060AbWJaJ4b
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 04:56:31 -0500
Received: from mail.gmx.de ([213.165.64.20]:19353 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1423053AbWJaJ4b (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 04:56:31 -0500
Received: (qmail invoked by alias); 31 Oct 2006 09:56:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp020) with SMTP; 31 Oct 2006 10:56:29 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Mon, 30 Oct 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > It is trivial to do now,...
> 
> May be, but can we do something about these duplicated code?
> 
> > @@ -57,6 +60,40 @@ static ssize_t send_client_data(int fd,
> >  	return safe_write(fd, data, sz);
> >  }
> >  
> > +FILE *pack_pipe = NULL;
> > +static void show_commit(struct commit *commit)
> > [...]

Yes, we could make mark_edges_uninteresting() and traverse_commit_list() 
take a FILE * parameter, which is then passed to the functions. Hmmm?

Except show_commit() should not show "commit " in front of each line. So, 
another parameter?

Ciao,
Dscho

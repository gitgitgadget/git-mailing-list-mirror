Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 24289 invoked by uid 107); 9 Apr 2013 17:41:55 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.84) with ESMTP; Tue, 09 Apr 2013 13:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934529Ab3DIRjz (ORCPT <rfc822;peff@peff.net>);
	Tue, 9 Apr 2013 13:39:55 -0400
Received: from plane.gmane.org ([80.91.229.3]:49523 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934486Ab3DIRjy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 13:39:54 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UPcWM-0007W7-Lv
	for git@vger.kernel.org; Tue, 09 Apr 2013 19:39:50 +0200
Received: from ip68-227-87-145.sb.sd.cox.net ([68.227.87.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 19:39:50 +0200
Received: from richard_hubbe11 by ip68-227-87-145.sb.sd.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 19:39:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
To:	git@vger.kernel.org
From:	rh <richard_hubbe11@lavabit.com>
Subject: Re: segfault in git-remote-http
Date:	Tue, 9 Apr 2013 10:41:34 -0700
Organization: " "
Message-ID: <20130409104134.a9a42b74ec33b3147cd45c81@lavabit.com>
References: <20130407093812.cae0e19123f7b6d2061800aa@lavabit.com>
	<20130409084718.587e99aa7a935296867a84a1@lavabit.com>
	<20130409171623.GE21972@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ip68-227-87-145.sb.sd.cox.net
User-Agent: dsodnetnin
X-Mailer: EZnn0.37p
X-Newsreader: EZnn0.37p
X-Gmane-NNTP-Posting-Host: EZnn0.37p
Original-Received: from slem by 1.1 with local
X-No-Archive: yes
Archive: no
X-Archive: encrypt
X-Operating-System: Barebones_6.1
X-Gmane-NNTP-Posting-Host: 192.168.1.1
X-NNTP-Posting-Host: 192.168.1.1
Mail-Copies-To:	never
X-Archive: expiry=17
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org
X-Status: A

On Tue, 9 Apr 2013 13:16:23 -0400
Jeff King <peff@peff.net> wrote:

> On Tue, Apr 09, 2013 at 08:47:18AM -0700, rh wrote:
> 
> > The symptoms that this patch addresses look similar:
> > 
> > http://article.gmane.org/gmane.mail.postfix.user/217790
> > 
> > Quote from that thread:
> > "This behavior is actually documented (SSL_set_fd() destroys
> > a BIO already on the SSL handle, and creates a new BIO)."
> > 
> > Maybe someone used to looking at git-remote-http code can
> > say anything about this.
> 
> git-remote-http does not touch the openssl code itself at all. We only
> talk to curl, which handles all of the ssl (and may even be built on
> gnutls). So if that is the problem, then I think it may be a libcurl
> bug, not a git one.

Thanks, I see git-remote-{http,https,ftp,ftps} are the same size.
Minor nitpick but shouldn't the error thrown say git-remote-https?


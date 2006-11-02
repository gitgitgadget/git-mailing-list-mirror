X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problem with git-push
Date: Thu, 2 Nov 2006 10:42:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611021041140.1670@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1162306098.41547.4.camel@mayday.esat.net>
 <7v64e0qclo.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611011205340.1670@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4ptj5ghj.fsf@assigned-by-dhcp.cox.net> <7v8xiu3ksl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 2 Nov 2006 09:43:00 +0000 (UTC)
Cc: git@vger.kernel.org, Florent Thoumie <flz@xbsd.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v8xiu3ksl.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30699>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfZ64-0002gl-6C for gcvg-git@gmane.org; Thu, 02 Nov
 2006 10:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752784AbWKBJmt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 04:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752785AbWKBJmt
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 04:42:49 -0500
Received: from mail.gmx.de ([213.165.64.20]:52379 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1752784AbWKBJms (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 04:42:48 -0500
Received: (qmail invoked by alias); 02 Nov 2006 09:42:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp029) with SMTP; 02 Nov 2006 10:42:46 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 1 Nov 2006, Junio C Hamano wrote:

> -	if (chmod(path, mode) < 0)
> +	if (mode != st.st_mode && chmod(path, mode) < 0)

Oops. Somehow I missed this mail before replying. I'd like to point out 
that it's safer to check for (mode & st.st_mode != mode), since we should 
leave broader permissions as are.

Ciao,
Dscho

X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-diff opens too many files?
Date: Mon, 20 Nov 2006 16:48:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611201646480.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <fcaeb9bf0611200212s6ddb0518k24f85223acfed08b@mail.gmail.com> 
 <Pine.LNX.4.63.0611201620070.13772@wbgn013.biozentrum.uni-wuerzburg.de>
 <fcaeb9bf0611200732y777868c5lb9d9061a4522de97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 20 Nov 2006 15:48:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <fcaeb9bf0611200732y777868c5lb9d9061a4522de97@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31918>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmBNn-0004No-Tp for gcvg-git@gmane.org; Mon, 20 Nov
 2006 16:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934250AbWKTPs1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 10:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934251AbWKTPs1
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 10:48:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:48556 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S934250AbWKTPs0 (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 10:48:26 -0500
Received: (qmail invoked by alias); 20 Nov 2006 15:48:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp029) with SMTP; 20 Nov 2006 16:48:25 +0100
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 20 Nov 2006, Nguyen Thai Ngoc Duy wrote:

> git diff |LANG=C grep '^-'|LANG=C grep -v '^--'|LANG=C sort|LANG=C uniq -c

I looked in the code, but nothing jumps into my eyes. There is a place 
where files are mmap()ed, but AFAICT they are unmmap()ed just after 
diffing. Could you run it with strace and find unclosed open calls?

Ciao,
Dscho

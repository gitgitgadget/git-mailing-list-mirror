X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git shortlog: need a range!
Date: Wed, 29 Nov 2006 10:38:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611291034340.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v8xhv2uj1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-14060943-1164793111=:30004"
NNTP-Posting-Date: Wed, 29 Nov 2006 09:38:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v8xhv2uj1.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32626>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpLtk-00059a-Gm for gcvg-git@gmane.org; Wed, 29 Nov
 2006 10:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758806AbWK2Jie (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 04:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758809AbWK2Jid
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 04:38:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:54501 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1758806AbWK2Jid (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 04:38:33 -0500
Received: (qmail invoked by alias); 29 Nov 2006 09:38:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp029) with SMTP; 29 Nov 2006 10:38:31 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-14060943-1164793111=:30004
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 28 Nov 2006, Junio C Hamano wrote:

> I just got this:
> 
>         $ git shortlog --since=Oct.20 --until=Nov.20 master
>         fatal: Need a range!
> 
> Why isn't this a range?

It really is not. Think about this scenario:

A - B - C
  \   /
    D

where both B and D were done after Oct.20, but not A. Then you do not have 
a range, i.e. you cannot represent the same in the form X..Y.

However, this only shows that my reasoning in shortlog was wrong. It was 
meant to prevent accidentally traversing the _whole_ history (which does 
take some time), but maybe even this is something people want to do?

Therefore: Ack on René's patch.

Ciao,
Dscho


X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: fetching packs and storing them as packs
Date: Thu, 26 Oct 2006 23:13:54 -0400
Message-ID: <BAYC1-PASMTP03992F75428088AF83AE39AE040@CEZ.ICE>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
	<4540CA0C.6030300@tromer.org>
	<Pine.LNX.4.64.0610261105200.12418@xanadu.home>
	<45413209.2000905@tromer.org>
	<Pine.LNX.4.64.0610262038320.11384@xanadu.home>
	<20061027014229.GA28407@spearce.org>
	<45417205.6020805@tromer.org>
	<20061027030054.GB28407@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 03:14:16 +0000 (UTC)
Cc: Eran Tromer <git2eran@tromer.org>, Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061026231354.807b1ed0.seanlkml@sympatico.ca>
In-Reply-To: <20061027030054.GB28407@spearce.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Oct 2006 03:13:56.0602 (UTC) FILETIME=[F0610DA0:01C6F975]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdIAc-0004FP-2s for gcvg-git@gmane.org; Fri, 27 Oct
 2006 05:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161477AbWJ0DN6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 23:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161478AbWJ0DN6
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 23:13:58 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:19848 "EHLO
 BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1161477AbWJ0DN5 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006
 23:13:57 -0400
Received: from linux1.attic.local ([65.93.43.81]) by
 BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 26 Oct 2006 20:13:56 -0700
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GdHEI-0004pH-VX; Thu, 26 Oct 2006 22:13:54 -0400
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Thu, 26 Oct 2006 23:00:54 -0400
Shawn Pearce <spearce@spearce.org> wrote:

> What happens when the incoming pack (steps #2 and #3) takes 15
> minutes to upload (slow ADSL modem, lots of objects) and the
> background repack process sees those temporary refs and starts
> trying to include those objects?  It can't walk the DAG that those
> refs point at because the objects aren't in the current repository.

As long as there was standard naming for such temporary refs,
they could be completely ignored by the repack process, no?


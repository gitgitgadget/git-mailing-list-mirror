X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] git-svn: avoid fetching files twice in the same revision
Date: Sun, 03 Dec 2006 17:42:01 +0100
Message-ID: <87fybxgcdi.fsf@mid.deneb.enyo.de>
References: <87psb2ou6f.fsf@mid.deneb.enyo.de>
	<20061202223419.GA7057@localdomain> <20061203001930.GA468@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 3 Dec 2006 16:42:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061203001930.GA468@soma> (Eric Wong's message of "Sat, 2 Dec
	2006 16:19:31 -0800")
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33116>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GquQ2-0006wJ-G7 for gcvg-git@gmane.org; Sun, 03 Dec
 2006 17:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757086AbWLCQmT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 11:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757100AbWLCQmT
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 11:42:19 -0500
Received: from mail.enyo.de ([212.9.189.167]:47624 "EHLO mail.enyo.de") by
 vger.kernel.org with ESMTP id S1757086AbWLCQmS (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 11:42:18 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de) by
 mail.enyo.de with esmtp id 1GquPw-0000TL-ND; Sun, 03 Dec 2006 17:42:16 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.63) (envelope-from
 <fw@deneb.enyo.de>) id 1GquPh-0002MN-87; Sun, 03 Dec 2006 17:42:01 +0100
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

* Eric Wong:

> +	foreach (keys %amr) {
> +		libsvn_get_file($gui, $_, $rev, $amr{$_});

You could throw in a "sort".  Perhaps the improved locality helps the
server a bit.


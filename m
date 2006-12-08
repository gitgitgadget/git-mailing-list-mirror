X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Light-weight checkouts via ".gitlink"
Date: Sat, 9 Dec 2006 00:25:24 +0100
Message-ID: <200612090025.24234.Josef.Weidendorfer@gmx.de>
References: <200612082252.31245.Josef.Weidendorfer@gmx.de> <elco6p$uku$1@sea.gmane.org> <200612082354.34488.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 23:25:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <200612082354.34488.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33767>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsp5w-0005Hh-JO for gcvg-git@gmane.org; Sat, 09 Dec
 2006 00:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758817AbWLHXZa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 18:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758841AbWLHXZa
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 18:25:30 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:36138 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1758817AbWLHXZ3 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 18:25:29 -0500
Received: from dhcp-3s-46.lrr.in.tum.de (dhcp-3s-46.lrr.in.tum.de
 [131.159.35.46]) by mail.in.tum.de (Postfix) with ESMTP id 33D94282A; Sat,  9
 Dec 2006 00:25:28 +0100 (MET)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Friday 08 December 2006 23:54, Josef Weidendorfer wrote:
> > NAME = name

Forgot to mention in the proposal:
If you recursively have light-weight checkouts inside each other,
the real "name" (for .git/external/<name/ and for further submodule
configuration e.g. in .git/modules of the base repository)
should of course be the concatenation of the names in the .gitlink
files while going up to the base repository.

> > Perhaps instead of adding arbitrary number of .. in front of relative
> > path, we better use some magic, like ... for finding somewhere up?

No need. Something like

> 	/home/user/.../linux

is crazy. Do you want to scan all of your home directory everytime this
lookup is needed? So "..." really only makes sense in front of the
relative path, but there, you also can leave it out.


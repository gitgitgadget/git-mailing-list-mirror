X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: weird strncmp usage?
Date: Fri, 03 Nov 2006 22:05:15 +0100
Message-ID: <8764dwb5ro.fsf@mid.deneb.enyo.de>
References: <eibhga$tpg$1@sea.gmane.org> <45494D84.2060402@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 21:05:42 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <45494D84.2060402@shadowen.org> (Andy Whitcroft's message of
	"Thu, 02 Nov 2006 01:44:36 +0000")
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30885>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg6E9-0001Wo-6S for gcvg-git@gmane.org; Fri, 03 Nov
 2006 22:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753528AbWKCVFT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 16:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbWKCVFT
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 16:05:19 -0500
Received: from mail.enyo.de ([212.9.189.167]:3077 "EHLO mail.enyo.de") by
 vger.kernel.org with ESMTP id S1753528AbWKCVFR (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 16:05:17 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de) by
 mail.enyo.de with esmtp id 1Gg6Dz-0003Xc-QF for git@vger.kernel.org; Fri, 03
 Nov 2006 22:05:15 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.63) (envelope-from
 <fw@deneb.enyo.de>) id 1Gg6Dz-0001Zx-Fk for git@vger.kernel.org; Fri, 03 Nov
 2006 22:05:15 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

* Andy Whitcroft:

> If you are doing these a _lot_ then there is a significant additional
> cost to using strlen on a constant string.

strlen has been a GCC builtin for quite some time.  If the wrapper
function is inlined, GCC will optimize it away.  (It also turns the

X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] git-svn: error out when the SVN connection fails during a fetch
Date: Wed, 06 Dec 2006 18:01:48 +0100
Message-ID: <87psax3qmb.fsf@mid.deneb.enyo.de>
References: <20061128220605.GA1253@localdomain>
	<871wnget3b.fsf@mid.deneb.enyo.de> <20061204085253.GA31047@soma>
	<87zma4yr71.fsf@mid.deneb.enyo.de>
	<20061204090549.GB30316@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 17:04:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061204090549.GB30316@hand.yhbt.net> (Eric Wong's message of
	"Mon, 4 Dec 2006 01:05:49 -0800")
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33493>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs0Bk-0002Sp-SS for gcvg-git@gmane.org; Wed, 06 Dec
 2006 18:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936679AbWLFRC2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 12:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936596AbWLFRC1
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 12:02:27 -0500
Received: from mail.enyo.de ([212.9.189.167]:3301 "EHLO mail.enyo.de"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S936919AbWLFRCK
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 12:02:10 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de) by
 mail.enyo.de with esmtp id 1Gs09o-000623-Rg for git@vger.kernel.org; Wed, 06
 Dec 2006 18:02:08 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.63) (envelope-from
 <fw@deneb.enyo.de>) id 1Gs09U-0001Qe-OG for git@vger.kernel.org; Wed, 06 Dec
 2006 18:01:48 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

* Eric Wong:

> Florian Weimer <fw@deneb.enyo.de> wrote:
>> * Eric Wong:
>> 
>> > Does the following patch help?
>> 
>> Don't think so.  The issue is not timing-related.  I've seen a failure
>> every 1000 requests, which suggests to me that it's hitting the
>> MaxKeepAliveRequests limit configured on the server.
>
> Actually, that's exactly what this patch should fix.  git-svn restarts a
> child every 1000 revisions to avoid memory usage from going through the
> roof.


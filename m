X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: weird strncmp usage?
Date: Thu, 02 Nov 2006 02:26:54 +0100
Message-ID: <eibhga$tpg$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 01:31:55 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 19
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30680>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfRQI-0001fb-1v for gcvg-git@gmane.org; Thu, 02 Nov
 2006 02:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751411AbWKBBbK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 20:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWKBBbK
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 20:31:10 -0500
Received: from main.gmane.org ([80.91.229.2]:49076 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1751411AbWKBBbJ (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 20:31:09 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GfRPZ-0001UM-Ad for git@vger.kernel.org; Thu, 02 Nov 2006 02:30:41 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Thu, 02 Nov 2006 02:30:29 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 02 Nov 2006 02:30:29
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Hi,

the git source seems full of calls similar to

   strncmp (x, "constant string", 15)

is there a reason not to use something like

   int
   strxmp (char const *x, char const *y)
   {
     return strncmp (x, y, strlen (y));
   }

everywhere?

-- 
  Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen

X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Rationale for the "Never commit to the right side of a Pull line" rule
Date: Thu, 26 Oct 2006 19:30:15 +0200
Organization: At home
Message-ID: <ehqr9t$9rh$1@sea.gmane.org>
References: <ehqp1u$j4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 26 Oct 2006 17:31:27 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 21
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30249>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd94c-0004oz-PC for gcvg-git@gmane.org; Thu, 26 Oct
 2006 19:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1945909AbWJZRbJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 13:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945913AbWJZRbI
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 13:31:08 -0400
Received: from main.gmane.org ([80.91.229.2]:63200 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1945909AbWJZRbH (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 13:31:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gd93u-0004gI-3N for git@vger.kernel.org; Thu, 26 Oct 2006 19:30:38 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 19:30:38 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 19:30:38 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jerome Lovy wrote:

> Could someone please point me to / give me the rationale for the "Never 
> commit to the right side of a Pull line" rule ?
> 
> I found the rule in the second Note of the git-fetch man-page (eg 
> http://www.kernel.org/pub/software/scm/git/docs/git-fetch.html).

Because git refuses to fetch into branch on top of which there are changes
which are not present in the branch you fetch from (if it is not
fast-forward case). So commitiing to tracking branches breaks the most
typical workflow, i.e. fetch when you want, push when you are ready.

git-clone --use-separate-remotes takes care of that by putting tracking
branches in refs/remotes/, i.e. outside refs/heads/, so you cannot commit
there, at least not by accident.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git


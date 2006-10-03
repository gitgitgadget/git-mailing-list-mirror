From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: start to generate PATH_INFO URLs
Date: Tue, 03 Oct 2006 14:16:05 +0200
Organization: At home
Message-ID: <eftk98$2ii$2@sea.gmane.org>
References: <20060929221641.GC2871@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Oct 03 14:17:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUjCc-0003xG-6S
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 14:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWJCMQr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 08:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWJCMQr
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 08:16:47 -0400
Received: from main.gmane.org ([80.91.229.2]:1441 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750759AbWJCMQq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 08:16:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GUjCB-0003rP-FK
	for git@vger.kernel.org; Tue, 03 Oct 2006 14:16:26 +0200
Received: from host-81-190-17-45.torun.mm.pl ([81.190.17.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 14:16:23 +0200
Received: from jnareb by host-81-190-17-45.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 14:16:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-45.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28267>

Martin Waitz wrote:

> Instead of providing the project as a ?p= parameter it is simply appended
> to the base URI.

I have just modified href() to be able to use it for actions which don't
need the ?p= parameter... and you didn't take into consideration the case
when $params{'project'} is set, but undefined. Undefined params don't get
added, but "unless exists $params{'project'}" in the

        $params{'project'} = $project unless exists $params{'project'};

line prevents of adding 'p' param.

It is important for the project list (and equivalent) views.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

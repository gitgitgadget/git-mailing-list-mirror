From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Sanitize for_each_reflog_ent()
Date: Tue, 09 Jan 2007 01:15:15 +0100
Organization: At home
Message-ID: <enumq8$oa$1@sea.gmane.org>
References: <Pine.LNX.4.63.0701080158500.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vr6u6z3x8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701081316110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jan 09 01:15:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H44eI-0007sl-1b
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 01:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbXAIAP1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 19:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbXAIAP1
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 19:15:27 -0500
Received: from main.gmane.org ([80.91.229.2]:50124 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712AbXAIAP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 19:15:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H44e3-0005sb-9o
	for git@vger.kernel.org; Tue, 09 Jan 2007 01:15:15 +0100
Received: from host-81-190-18-145.torun.mm.pl ([81.190.18.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 01:15:15 +0100
Received: from jnareb by host-81-190-18-145.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 01:15:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-145.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36287>

Johannes Schindelin wrote:

> On Sun, 7 Jan 2007, Junio C Hamano wrote:
> 
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>>> Further, it makes no sense to force the parsing upon the helper
>>> functions; for_each_reflog_ent() now calls the helper function with
>>> old and new sha1, the email, the timestamp & timezone, and the message.
>> 
>> Perhaps.  I did it that way deliberately because all existing
>> users did not have to pay overhead of parsing.
> 
> My reasoning is that invalid entries should rather be ignored than be 
> taken into account. So, to verify that you are not walking invalid data, 
> you have to parse it anyway.

I think that Junio was talking about the fact, that if you for example
do need only refname and sha1, there is no need to parse object at all.
If you don't need to, don't parse.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

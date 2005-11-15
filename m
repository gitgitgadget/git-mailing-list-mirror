From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Small script to patch .spec for Suse
Date: Tue, 15 Nov 2005 22:56:05 +0100
Message-ID: <437A5975.3020705@op5.se>
References: <200511151230.30030.Josef.Weidendorfer@gmx.de> <7vfypxlp8k.fsf@assigned-by-dhcp.cox.net> <437A46E4.5010909@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Nov 15 22:57:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec8mh-0004cD-GL
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 22:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbVKOV4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 16:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbVKOV4H
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 16:56:07 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:7552 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932111AbVKOV4G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 16:56:06 -0500
Received: from vrrx50sn1.teliamobile.net (192.71.148.196) by pne-smtpout2-sn2.hy.skanova.net (7.2.060.1)
        id 4378EBDA00072D97 for git@vger.kernel.org; Tue, 15 Nov 2005 22:56:05 +0100
Received: from [212.181.228.90] (host-n13-90.homerun.telia.com [212.181.228.90])
	by vrrx50sn1.teliamobile.net (8.11.6/8.11.6) with ESMTP id jAFLu5f24064
	for <git@vger.kernel.org>; Tue, 15 Nov 2005 22:56:05 +0100
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <437A46E4.5010909@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11950>

H. Peter Anvin wrote:
> 
> I'd prefer to have just @@OPENSSH_PACKAGE@@ and @@EXPAT_PACKAGE@@ 
> instead of completely virtualizing the dependencies.  Less flexible to 
> be sure, but it makes it less confusing to read and fix.
> 

git doesn't, strictly speaking, require openssh, for two reasons;
a. It's been known to work equally well over rsh.
b. ssh is run as an executed command. ssh can be installed later and the 
previously installed git will start working just like magic.

If you really *want* an openssh requirement, you should just go with
Requires: /usr/bin/ssh
It's the most accurate one after all, since git doesn't really care 
which package it came from so long as it's there.

As for BuildRequires, I think package maintainers can be trusted to 
figure those out for themselves. It's not as if they'll be producing 
flawed RPM's after all.

If you want one for expat anyways, then go with
BuildRequires: expat
since that's true for both dists (and FC maintainers will then happily 
figure out that they need expat-devel to build it).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

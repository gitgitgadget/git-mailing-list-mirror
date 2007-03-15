From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: mercurial to git
Date: Thu, 15 Mar 2007 22:07:05 +0000
Organization: Berlin University of Technology
Message-ID: <20070315220705.GD31087@peter.daprodeges.fqdn.th-h.de>
References: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de> <20070306215459.GI18370@thunk.org> <20070306230802.GA17226@filer.fsl.cs.sunysb.edu> <20070307001105.GJ18370@thunk.org> <20070314111257.GA4526@peter.daprodeges.fqdn.th-h.de> <20070314132951.GE12710@thunk.org> <20070315094434.GA4425@peter.daprodeges.fqdn.th-h.de> <20070315210406.GA8568@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 15 23:07:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRy6T-0007Br-D2
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 23:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbXCOWHL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 18:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753393AbXCOWHL
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 18:07:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:47887 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751795AbXCOWHK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 18:07:10 -0400
Received: (qmail invoked by alias); 15 Mar 2007 22:07:08 -0000
X-Provags-ID: V01U2FsdGVkX1+SH1Zz2zmSB65+SSg14beIwb0EnLyUm4Q0h3AGLk
	PNuGWHO2y067XG
Received: from peter.daprodeges.fqdn.th-h.de (peter [192.168.0.5])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id 617A320F0D
	for <git@vger.kernel.org>; Thu, 15 Mar 2007 22:07:07 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070315210406.GA8568@thunk.org>
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: peter.daprodeges.fqdn.th-h.de (FreeBSD 6.2-STABLE i386)
User-Agent: Mutt/1.5.14 (2007-03-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42301>

Hi,

* Theodore Tso [07-03-15 17:04:07 -0400] wrote:
>Hopefully you won't mind that I'm adding the git list back to the cc
>line, since it would be useful for others to provide some feedback.

Not at all. Just wondering when others would get too bored... :)

>Actually, there *is* an hg-fast-import.  It exists in the hg sources
>in contrib/convert-repo, and it is being used in production to do
>incremental conversion from the Linux kernel git tree to an hg tree.
>So it does handle octopus merges already (it has to, the ACPI folks
>are very ocotpus merge happy :-).

I know convert-repo and like it as a starting point. But it has some 
problems like not properly creating hg branches, can import only one 
branch at a time which must also be checkout out on the git side, etc.

With 'hg-fast-import' I meant something like git-fast-import where 
clients can feed in more raw data instead of preparing each commit on 
its own and comitting it.

[...]

>So more practially, here are some of the things that we would need to
>do, looking at hg-fast-export:

>*) Change the index/marks file to map between hg SHA hash ID's instead
>of the small integer ordinals.  This is useful for enabling multisite
>conversion, but it is also useful for tracking tag changes in .hgtags.

The small numbers are the hg revision numbers which we'll need for 
git-fast-import. Ideally git-fast-import would allow us to use anything 
for a mark we want as long as it's unique. But I'm sure there's a cheap 
way of mapping revision to SHA1 in the hg API.

So, if anybody wants to join in writing up such a hybrid system, I'm for 
it. :)

   bye, Rocco
-- 

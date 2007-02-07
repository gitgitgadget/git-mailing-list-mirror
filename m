From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: describe fails on tagless branch
Date: Wed, 07 Feb 2007 10:08:50 +0100
Organization: At home
Message-ID: <eqc4s4$nm9$1@sea.gmane.org>
References: <eqb660$ft7$1@sea.gmane.org> <eqb73j$hri$1@sea.gmane.org> <45C92918.8010801@xs4all.nl> <7vr6t2g1dt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 10:07:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEimF-0008FP-5z
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 10:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbXBGJHj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 04:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030597AbXBGJHj
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 04:07:39 -0500
Received: from main.gmane.org ([80.91.229.2]:49188 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030224AbXBGJHi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 04:07:38 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HEim0-000347-K8
	for git@vger.kernel.org; Wed, 07 Feb 2007 10:07:28 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 10:07:28 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 10:07:28 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38896>

[Cc: git@vger.kernel.org]

Junio C Hamano wrote:

> Han-Wen Nienhuys <hanwen@xs4all.nl> writes:
> 
>> Jakub Narebski escreveu:
>>> 
>>> _Which_ INIT? In git there can be more than one root commit. In git.git
>>
>> I don't really care, but I would like git-describe to produce something 
>> useful in the absence of tags.  The -g<SHA-1> already makes the commit
>> uniquely identifiable.
> 
> Then you would script like this:
> 
>       #!/bin/sh
>       git describe "$1" 2>/dev/null || git rev-parse --verify "$1"
> 
> I do not think it a good idea to make "git-describe" itself do
> the above, as the user of describe may want to fall back on
> something other than "rev-parse --verify" after ||.

By the way, new git-describe gives us also number of commits since
tag, and it would be nice to have number of commits since init...
but that can be easily obtained using "git rev-list $1 | wc -l".

I guess that some use git-describe with --abbrev=0 to get closest
preceding tag: getting INIT would confuse them.

That said, we could use e.g. INITg2a45ba+10-g4ee2ab
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

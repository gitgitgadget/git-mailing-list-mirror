From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Don't use $author_name undefined when $from contains no /\s</.
Date: Fri, 20 Oct 2006 17:48:21 +0200
Organization: At home
Message-ID: <ehar3v$e73$1@sea.gmane.org>
References: <87vemgn1s2.fsf@rho.meyering.net> <7vbqo8uvkn.fsf@assigned-by-dhcp.cox.net> <878xjckw7x.fsf@rho.meyering.net> <7vk62wruum.fsf@assigned-by-dhcp.cox.net> <87fydkj8q1.fsf@penguin.cs.ucla.edu> <7vr6x4q9b6.fsf@assigned-by-dhcp.cox.net> <87pscnj29t.fsf@penguin.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: bug-gnu-utils@gnu.org
X-From: git-owner@vger.kernel.org Fri Oct 20 17:49:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gawc6-00065S-3R
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 17:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWJTPsq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 11:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWJTPsq
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 11:48:46 -0400
Received: from main.gmane.org ([80.91.229.2]:40102 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932246AbWJTPsp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 11:48:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gawbr-000635-Ew
	for git@vger.kernel.org; Fri, 20 Oct 2006 17:48:35 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 17:48:35 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 17:48:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29496>

Paul Eggert wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
>> If "trailing space" highlighting picks up the first column blank
>> in "diff -u" output, that highlighting feature is *broken*.
> 
> If the buffer contains arbitrary text, some of which is diff -u output
> and some of which is not, then it it isn't possible in general for the
> highlighting mode to distinguish between the diff -u part and the
> other part.

Not true. If GNU patch (and git-apply) can detect where diff begins,
and can detect if diff was truncated, then highlighting mode can
distinguish between diff -u part and rest... well, unless you intermix
diff-u output and arbitrary text (so the patch would not apply, but what
happens when commenting a patch).

Still I'd rather relax highlighting code to not highlight "SPC LF"
than to change diff -u format.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Stupid quoting...
Date: Wed, 20 Jun 2007 10:40:26 +0200
Organization: At home
Message-ID: <f5ap5r$sj7$2@sea.gmane.org>
References: <86ir9sw0pi.fsf@lola.quinscape.zz> <f51irh$shq$1@sea.gmane.org> <86ir9l1ylc.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706190156110.4059@racer.site> <86sl8owfqj.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706191048570.4059@racer.site> <86645kutow.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706200307070.4059@racer.site> <7vd4zrw3k4.fsf@assigned-by-dhcp.pobox.com> <86y7ifoykt.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 10:40:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0vkC-00080u-KV
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 10:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbXFTIkv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 04:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752348AbXFTIkv
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 04:40:51 -0400
Received: from main.gmane.org ([80.91.229.2]:38423 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964AbXFTIku (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 04:40:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I0vk0-00058n-0Z
	for git@vger.kernel.org; Wed, 20 Jun 2007 10:40:40 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jun 2007 10:40:40 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jun 2007 10:40:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50548>

David Kastrup wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>>> I don't see our discourse leading anywhere: the points have been made.
>>>
>>> I would really, really, really like to see a solution. Alas, I
>>> cannot think of one, other than _forcing_ the developers to use
>>> ASCII-only filenames.
>>> Note that there is no convention yet in Git to state which encoding
>>> your filenames are supposed to use. And in fact, we already had a
>>> fine example in git.git why this is particularly difficult. MacOSX
>>> is too clever to be true, in that it gladly takes filenames in one
>>> encoding, but reads those filenames out in _another_
>>> encoding. Thus, a "git add <filename>" can well end up in
>>> git-status saying that a file was deleted, and another file
>>> (actually the same, but in a different encoding) is untracked.
>>
>> Having said that, the absolute minimum that needs to be quoted are
>> double-quote (because it is used by quoting as agreed with GNU
>> diff/patch maintainer), backslash (used to introduce C-like
>> quoting),
>> newline and horizontal tab (makes "patch" confused, as it would make
>> it ambiguous where the pathname ends), so I am not opposed to a
>> patch that introduces a new mode, probably on by default _unless_ we
>> are generating --format=email, that does not quote high byte values.
> 
> I think it would be ok to quote non-graphic characters with octal
> escape sequences.  On ASCII-based systems, those are the characters
> 0x00 to 0x1f.  They don't have a visual representation of their own,
> anyway.  _IF_ they appear in filenames, it is certainly a case
> involved with excessive cleverness and/or garbage.  I'd leave the rest
> alone.

By the way, ls(1) has its --quoting-style=WORD option, why shouldn't
git-diff and friends (including git-format-patch) have the same? And we
could change the default later on...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

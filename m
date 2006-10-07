From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Convert Content-Disposition filenames into qtext
Date: Sat, 07 Oct 2006 12:06:31 +0200
Organization: At home
Message-ID: <eg7u5n$mt9$1@sea.gmane.org>
References: <20061006192006.GW20017@pasky.or.cz> <20061006193059.21334.qmail@web31807.mail.mud.yahoo.com> <7vk63ctq47.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Oct 07 12:06:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW94d-0008Nb-Vu
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 12:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWJGKGT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 06:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWJGKGT
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 06:06:19 -0400
Received: from main.gmane.org ([80.91.229.2]:10893 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750766AbWJGKGS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 06:06:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GW94B-0008Ja-7N
	for git@vger.kernel.org; Sat, 07 Oct 2006 12:05:59 +0200
Received: from host-81-190-22-223.torun.mm.pl ([81.190.22.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 12:05:59 +0200
Received: from jnareb by host-81-190-22-223.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 12:05:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-223.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28468>

Junio C Hamano wrote:

> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
>>>> +# Convert a string (e.g. a filename) into qtext as defined
>>>> +# in RFC 822, from RFC 2183.  To be used by Content-Disposition.
>>>> +sub to_qtext {
>>>> +  my $str = shift;
>>>> +  $str =~ s/\\/\\\\/g;
>>>> +  $str =~ s/\"/\\\"/g;

Here probably it could be
        $str =~ s/"/\\"/g;

>>>> +  $str =~ s/\r/\\r/g;
>>> 
>>> \r? Not \n?
>>
>> Yes, \r, not \n.
> 
> \r to \\r? Not to \\\r?

We want "\r" in suggested filename, not "\
" I think, so it is "\\r".

Otherwise we could use simplier
        $str =~ s/([\\"\r])/\\\1/g;

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb on OpenBSD (-T not supported on filesystems...)
Date: Sun, 17 Sep 2006 11:51:48 +0200
Organization: At home
Message-ID: <eej5qa$i3o$1@sea.gmane.org>
References: <op.tf0k9fdvqpav6l@crystal.sienna.ath.cx> <eej3g3$d9j$1@sea.gmane.org> <op.tf0n3bjjqpav6l@crystal.sienna.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Sep 17 11:51:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOtJD-0007dY-7t
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 11:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWIQJv2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 05:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWIQJv2
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 05:51:28 -0400
Received: from main.gmane.org ([80.91.229.2]:4046 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964805AbWIQJv2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 05:51:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GOtIz-0007aZ-Je
	for git@vger.kernel.org; Sun, 17 Sep 2006 11:51:17 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 11:51:17 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 11:51:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27177>

Andrew Pamment wrote:

> On Sun, 17 Sep 2006 18:42:12 +0930, Jakub Narebski <jnareb@gmail.com>  
> wrote:
> 
>> What Perl version do you use? Does 'perldoc -f -X' has the following  
>> lines?
>>
>>         -X FILEHANDLE
>>
>>         (...) If "-T" or "-B" is used on a filehandle, the current IO  
>> buffer
>>         is examined rather than the first block. (...)
> 
> The version of perl is the one that comes with OpenBSD 3.9, it is v5.8.6.
> 
> I do get the above text when I run 'perldoc -f -X', does this mean it  
> should work? 

I thought that OpenBSD has perhaps distributed some old Perl version that
doesn't have -X tests (including -T/-B) on filehandles.

> When I try the original -T $fd I get: 
> 
> Software error:
> -T and -B not implemented on filehandles at /var/www/htdocs/git/gitweb.cgi  
> line 1598.

So this means that Perl implementation in OpenBSD is flawed.

Does anyone else has problem with gitweb on other systems? (I guess that
gitweb doesn't work with ActivePerl).

>> The solution for you would be to skip -T test.
> 
> That works fine. Thanks.

The -T test is just a fallback for when we cannot derive mimetype. I don't
know if you should default to 'application/octet-stream' or 'text/plain' in
your case; that perhaps depends on the repository.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

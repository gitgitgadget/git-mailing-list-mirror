From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: suggestions for gitweb
Date: Sun, 13 May 2007 02:41:10 +0200
Organization: At home
Message-ID: <f25mic$1b1$2@sea.gmane.org>
References: <20070512205529.GS14859@MichaelsNB> <7v8xbtwtsy.fsf@assigned-by-dhcp.cox.net> <1f3701c794eb$5ff781b0$0200a8c0@AMD2500>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 13 02:39:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn27b-0004LW-Oj
	for gcvg-git@gmane.org; Sun, 13 May 2007 02:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336AbXEMAja (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 20:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755877AbXEMAja
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 20:39:30 -0400
Received: from main.gmane.org ([80.91.229.2]:45835 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754336AbXEMAj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 20:39:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hn25e-00041M-Pd
	for git@vger.kernel.org; Sun, 13 May 2007 02:37:35 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 May 2007 02:37:34 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 May 2007 02:37:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47117>

Aaron Gray wrote:

>>> * the history/log pages could contain some statistics for the commits 
>>>   like the number of files changed and lines added/removed
>>
>> Probably.
>>
>> The three last items should be relatively easy, if somebody is
>> interested.  Pasky, Jakub, what do you think?
> 
> I would like to see lines of code and file sizes too.

Diff statistics for difftree / whatchanged, or diff shortstat is a bit
costly, as it needs to generate and examine diff, and not only compare
trees. Besides --numstat doesn't support renames well now, but that
might not be an obstacle.

Lines of code and file sizes: file size needs additional invocation
per each file for gitweb; it would be easier for cgit. Costly! Counting
LOC is even more costly: take note that 1.) gitweb operates directly
on repository / object database, and does not use working area, 
2.) git is snapshot based and not changeset based.

Of course like in the case of other costly features this migh be enabled
at will using %feature hash...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

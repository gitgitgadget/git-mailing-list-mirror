From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Use File::Find::find in git_get_projects_list
Date: Thu, 14 Sep 2006 19:02:09 +0200
Organization: At home
Message-ID: <eec1tp$9c9$1@sea.gmane.org>
References: <200609140839.56181.jnareb@gmail.com> <200609140959.04061.jnareb@gmail.com> <7vvenq4wgp.fsf@assigned-by-dhcp.cox.net> <200609141201.41711.jnareb@gmail.com> <7vmz924cxy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Sep 14 19:02:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNubY-00040L-FT
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 19:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWINRCU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 13:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWINRCU
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 13:02:20 -0400
Received: from main.gmane.org ([80.91.229.2]:64672 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750751AbWINRCT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Sep 2006 13:02:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GNub7-0003v3-DL
	for git@vger.kernel.org; Thu, 14 Sep 2006 19:01:57 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 19:01:57 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 19:01:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27014>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Sorry, this comment was leftover from before, when no_chdir was not 
>> used. Then $_ was the last part of directory,...
> 
> Ah, thanks.  I missed that difference.  Did you choose to use
> no_chdir for performance reasons or coding convenience (somehow
> I had an impression that no_chdir would be slower)?

First benchmarks showed that no_chdir was some faster. I have rechecked, 
and they are the same within the margin of error, perhaps without
no_chdir is slightly faster. 447 +/- 11 ms vs. 450 +/- 10 ms according
to ApacheBench (ab -n 10).

So it is really the matter of convenience. The default (without no_chdir) is
I think more convenient.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

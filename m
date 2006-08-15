From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 9/9] gitweb: Separate printing difftree in git_commit into git_difftree_body
Date: Tue, 15 Aug 2006 18:45:35 +0200
Organization: At home
Message-ID: <ebstls$3gt$3@sea.gmane.org>
References: <200608140202.46160.jnareb@gmail.com> <200608140218.33872.jnareb@gmail.com> <7vfyfybzlf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 15 18:45:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD22V-0001Rn-MW
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 18:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbWHOQpL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 12:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752112AbWHOQpL
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 12:45:11 -0400
Received: from main.gmane.org ([80.91.229.2]:11447 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1752111AbWHOQpK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 12:45:10 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GD22I-0001P5-S4
	for git@vger.kernel.org; Tue, 15 Aug 2006 18:45:02 +0200
Received: from host-81-190-28-152.torun.mm.pl ([81.190.28.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 18:45:02 +0200
Received: from jnareb by host-81-190-28-152.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 18:45:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-28-152.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25465>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> +            if ($status eq "A") { # created
>>...
>> +            } elsif ($status eq "D") { # deleted
>>...
>> +            } elsif ($status eq "M" || $status eq "T") { # modified, or type changed
>>...
>> +            } elsif ($status eq "R") { # renamed
>>...
>> +            } elsif ($status eq "C") { # copied
>>...
>> +            } # we should not encounter Unmerged (U) or Unknown (X) status
> 
> The body of these still seem to have quite a lot of
> similarities.  Maybe further refactoring is in the works?

Probably. For now I only separated the difftree printing part into separate 
subroutine, and added $status eq "C" case (I don't know if we might encounter
it at all, due to current set of options to diff-tree).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

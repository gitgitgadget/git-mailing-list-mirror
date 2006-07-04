From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Additional merge-base tests
Date: Tue, 04 Jul 2006 13:16:22 +0200
Organization: At home
Message-ID: <e8dim7$8cm$1@sea.gmane.org>
References: <44A9E6AE.10508@gmail.com> <7v3bdhoraa.fsf@assigned-by-dhcp.cox.net> <44AA0DAE.1060308@gmail.com> <7vpsgllsnp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de> <7vsllhhcxr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jul 04 13:16:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxitd-0002p4-JS
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 13:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWGDLQr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 07:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWGDLQq
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 07:16:46 -0400
Received: from main.gmane.org ([80.91.229.2]:37598 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751278AbWGDLQq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 07:16:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FxitM-0002lJ-S9
	for git@vger.kernel.org; Tue, 04 Jul 2006 13:16:33 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 13:16:32 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 13:16:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23283>

Junio C Hamano wrote:


> The problem ALASCM's example demonstrates does rely on clock
> skews.  The timestamps used in the example looked like this:
> 
> 
>    1   1
>   /  \/  \
>  4  -1   4
>  |   |   |
>  3  -2   3
>  |   |   |
>  2  -3   2
>    \ |  /
>      0
> 
> The crucial clock skew the case relies on is that the tip of the
> middle branch (-1) is older than the common commit (0).  But the
> topmost commits with timestamp 1 could be with timestamp 5 to
> correct the clock skew and still make the example "fail".
> 
>    5   5
>   /  \/  \
>  4  -1   4
>  |   |   |
>  3  -2   3
>  |   |   |
>  2  -3   2
>    \ |  /
>      0

So would putting timestamp for merge be MAX(now, parents timestamps)
solve the problem?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-grep: --and to combine patterns with and instead of or
Date: Fri, 30 Jun 2006 20:03:19 +0200
Organization: At home
Message-ID: <e83p0q$dla$1@sea.gmane.org>
References: <7vejx7oa3x.fsf@assigned-by-dhcp.cox.net> <E1Fw8hS-00023y-FY@moooo.ath.cx> <7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net> <E1FwDiI-0007Xp-2s@moooo.ath.cx> <7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net> <E1FwGgm-0006Nc-9a@moooo.ath.cx> <7vejx6k54p.fsf@assigned-by-dhcp.cox.net> <E1FwMPf-0005XA-N9@moooo.ath.cx> <7vpsgqimu7.fsf@assigned-by-dhcp.cox.net> <e83n97$973$1@sea.gmane.org> <E1FwN7M-0007GI-Ng@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jun 30 20:04:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwNLV-0008TJ-05
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 20:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWF3SDk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 14:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWF3SDk
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 14:03:40 -0400
Received: from main.gmane.org ([80.91.229.2]:57021 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964775AbWF3SDj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 14:03:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FwNKu-0008Nm-8C
	for git@vger.kernel.org; Fri, 30 Jun 2006 20:03:24 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 20:03:24 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 20:03:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23007>

Matthias Lederhofer wrote:

> Jakub Narebski wrote:
>> I think --near _has_ to be non-symmetric binary operator, i.e. first
>> argument specifies line to be found, second argument has to be in context
>> for first line if it is found.
>> 
>> So the above expression would be written as:
>> 
>>   -e foo --near \( A --or B \)
> Why is that?
>   -e foo --and --near \( -e A --or -e B \)
> would mean lines containing foo and either A or B in the context and
>   -e foo --or  --near \( -e A --or -e B \)
> would mean lines containing foo or having A or B in the context.

Because --near needs an expression it check context for (context is for
found match of lhs expression). So

  -e foo --near \( -e A --or -e B \)

means lines containing foo and either A or B in the context _for "foo"_.

--and --near could be shorthand for --and-near, and --or --near for
--or-near... except that the second one doesn't have much sense:

What is the difference between
  -e foo --or --near \( -e A --or -e B \)
and
  -e foo --or \( -e A --or -e B \)

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

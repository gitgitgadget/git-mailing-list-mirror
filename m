From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/5] gitweb: Cleanup input validation and error messages
Date: Sat, 05 Aug 2006 02:26:47 +0200
Organization: At home
Message-ID: <eb0oiu$sj1$1@sea.gmane.org>
References: <200608050036.06490.jnareb@gmail.com> <200608050038.20534.jnareb@gmail.com> <7vu04sghr0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 05 02:26:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G99zz-0005Ly-SG
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 02:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669AbWHEA0h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 20:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422672AbWHEA0h
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 20:26:37 -0400
Received: from main.gmane.org ([80.91.229.2]:987 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422669AbWHEA0g (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 20:26:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G99zk-0005KJ-LI
	for git@vger.kernel.org; Sat, 05 Aug 2006 02:26:24 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 02:26:24 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 02:26:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24870>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>  our $action = $cgi->param('a');
>>  if (defined $action) {
>>      if ($action =~ m/[^0-9a-zA-Z\.\-_]/) {
>> -            undef $action;
>> -            die_error(undef, "Invalid action parameter.");
>> +            die_error(undef, "Invalid action parameter $action");
>>      }
> 
> Doesn't this make us parrot what the browser threw at us without
> escaping back for HTML (iow, die_error does not seem to escape
> $error)?

I wanted to know what is the parameter gitweb considers invalid.
Perhaps the execution wasn't the best...

[...]
>> -    $rss_link = "<link rel=\"alternate\" title=\"" . esc_param($project) . " log\" href=\"" .
>> -                "$my_uri?" . esc_param("p=$project;a=rss") . "\" type=\"application/rss+xml\"/>";
> 
> The reason of removal is...?  Ah, you inlined it.  It was not
> clear from the proposed commit log message.

I'm sorry for unrelated changes (the commit could be probably split 
into four).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/6] gitweb: Link to associated tree from a particular log item in full log view
Date: Sat, 23 Sep 2006 10:59:22 +0200
Organization: At home
Message-ID: <ef2t16$bcp$2@sea.gmane.org>
References: <20060922011941.15909.32671.stgit@rover> <20060922011948.15909.59511.stgit@rover> <7vmz8s7cvy.fsf@assigned-by-dhcp.cox.net> <20060922231315.GD8259@pasky.or.cz> <7vodt7xvgu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Sep 23 11:00:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR3Mv-00083J-0O
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 11:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWIWJAN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 05:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWIWJAN
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 05:00:13 -0400
Received: from main.gmane.org ([80.91.229.2]:9388 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751295AbWIWJAL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 05:00:11 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GR3Mf-000807-UU
	for git@vger.kernel.org; Sat, 23 Sep 2006 11:00:01 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Sep 2006 11:00:01 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Sep 2006 11:00:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27572>

Junio C Hamano wrote:

> Petr Baudis <pasky@suse.cz> writes:
> 
>> Oops. It's trivial typo:
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index d2366c7..c5f3810 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -2880,7 +2880,7 @@ sub git_log {
>>                    " | " .
>>                    $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") .
>>                    " | " .
>> -                  $cgi->a({-href => href(action=>"tree", hash=>$commit), hash_base=>$commit}, "tree") .
>> +                  $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree") .
>>                    "<br/>\n" .
>>                    "</div>\n" .
>>                    "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
>>
>>> You do not have the tree object name available in git_log to
>>> generate an URL with both h and hb, and getting to it is an
>>> extra work.
>>
>> Well using commit hash as a tree id works just fine...
> 
> I agree that change is much safer.  Will apply with an
> appropriate log message and attribution.  No need to resend.

I think that hash_base without hash should be enough. But I'm not
sure if it is. Well, commit hash is tree-ish...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

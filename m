From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] gitweb: href() function to generate URLs for CGI
Date: Wed, 23 Aug 2006 00:39:25 +0200
Organization: At home
Message-ID: <ecg12q$3uj$1@sea.gmane.org>
References: <200608211739.32993.jnareb@gmail.com> <7v1wrauex2.fsf@assigned-by-dhcp.cox.net> <eccujr$90h$1@sea.gmane.org> <7vlkphqmac.fsf@assigned-by-dhcp.cox.net> <eceekl$b0l$2@sea.gmane.org> <7vodudno88.fsf@assigned-by-dhcp.cox.net> <ecenc1$b5o$1@sea.gmane.org> <7vveokmmpr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Aug 23 00:40:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFeuX-0003LP-DB
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 00:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWHVWju (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 18:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWHVWju
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 18:39:50 -0400
Received: from main.gmane.org ([80.91.229.2]:24803 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932118AbWHVWjt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 18:39:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GFeuD-0003IU-Ba
	for git@vger.kernel.org; Wed, 23 Aug 2006 00:39:33 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 Aug 2006 00:39:33 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 Aug 2006 00:39:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25880>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> URL for search is created and encoded by browser I think, so search
>> for "a = b" generates
>>
>>         gitweb.cgi?p=git.git&a=search&h=HEAD&s=a+%3D+b
> 
> which means href() should generate something similar when it
> wants to reproduce what the user queried, doesn't it?  I do not
> think quoting after joining does, and that is why I asked that
> question.

Yes, ot should... but first we would have to convert all the
cases of generating URI via esc_param(...) to using href().
That means to extend href() somewhat (-absolute=>1 as special
value in href() parameters, or changing href(%) to href(\%;$)?)
to be able to generate absolute URI (for example for RSS/OPML).

And the case is not that inconceivable: $project can be anything,
and can have ';' and '=' inside. I'm not sure about valid symbolic refs...

Usage of '&' as query parameters separator instead of ';' probably
depend on the browser...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

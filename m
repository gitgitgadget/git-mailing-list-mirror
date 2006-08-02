From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: optionally read config from GITWEB_CONFIG
Date: Wed, 02 Aug 2006 22:36:25 +0200
Organization: At home
Message-ID: <ear2bb$j9p$3@sea.gmane.org>
References: <20060802192333.GA30861@coredump.intra.peff.net> <ear1fp$j9p$2@sea.gmane.org> <E1G8NNl-0006ez-6J@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Aug 02 22:37:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8NSV-0007e2-A2
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 22:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWHBUgs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 16:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWHBUgs
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 16:36:48 -0400
Received: from main.gmane.org ([80.91.229.2]:64736 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751307AbWHBUgr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 16:36:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G8NSB-0007cP-4F
	for git@vger.kernel.org; Wed, 02 Aug 2006 22:36:31 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 22:36:31 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 22:36:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24680>

Matthias Lederhofer wrote:

> Jakub Narebski <jnareb@gmail.com> wrote:
>> Jeff King wrote:
>> > @@ -56,7 +50,7 @@ # URI of GIT logo
>> >  our $logo = "@@GITWEB_LOGO@@";
>> >  
>> >  # source of projects list
>> > -our $projects_list = "@@GITWEB_LIST@@" || "$projectroot";
>> > +our $projects_list = "@@GITWEB_LIST@@";
>> >  
>> >  # default blob_plain mimetype and default charset for text/plain blob
>> >  our $default_blob_plain_mimetype = 'text/plain';
>> 
>> But why that change?
> Earlier this was undef if the user did not change it.  Now this is
> always a string so the second one will probably never come into play
> except the user chooses to set the string to undef again.

Empty string is also false in Perl. Try

  perl -e 'my $var = "" || "other"; print "var = $var\n";'

I'd rather use $projectroot for $projects_list, preferably without needing
to set $projects_list.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

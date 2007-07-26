From: Robert Ewald <robert.ewald@nov.com>
Subject: Re: [PATCH] translate bad characters in refnames during git-svn fetch
Date: Thu, 26 Jul 2007 12:59:42 +0200
Organization: Nobody is responsible but me
Message-ID: <f89uqv$tf2$1@sea.gmane.org>
References: <20070715130548.GA6144@piper.oerlikon.madduck.net> <20070716111509.GC18293@efreet.light.src> <20070716033050.GA29521@muzzle> <20070716174731.GA4792@lapse.madduck.net> <20070717122852.GA21372@mayonaise> <20070717131719.GB19724@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 14:20:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE2K8-000433-Sa
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 14:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbXGZMUG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 08:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752974AbXGZMUF
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 08:20:05 -0400
Received: from main.gmane.org ([80.91.229.2]:41009 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752650AbXGZMUE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 08:20:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IE2K2-0005GM-EE
	for git@vger.kernel.org; Thu, 26 Jul 2007 14:20:02 +0200
Received: from static-213.88.188.4.addr.tdcsong.se ([213.88.188.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 14:20:02 +0200
Received: from robert.ewald by static-213.88.188.4.addr.tdcsong.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 14:20:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: static-213.88.188.4.addr.tdcsong.se
User-Agent: KNode/0.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53821>

Hello,

I am very interested in a functionality like this.

martin f krafft wrote:
>> sub desanitize_ref_name {
>> my ($refname) = @_;
>> $refname =~ s{%(?:([0-9A-F]{2})}{chr hex($1)}g;
>> 
>> $refname;
>> }
> 
> We could make it escape to %25; instead of %25. That's ugly but it
> would make desanitation a little safer.

In my limited knowledge I wonder if that would confuse shell scripts.

>> > On the other hand, we could make the translation regexps
>> > configurable...
>> 
>> Hopefully not needed.  I fear it would just add to confusion.
> 
> I was thinking about something like.
> 
>   git-svn clone ...
>   ...
>   error: remote branch/tagn name includes ~, which git does not
>   allow. please specify a replacement character in .git/config
> 
> and then have config.svn-remote.svn.translations simply be a list of
> pairs in vim pairlist syntax:
> 
>   ~:!,^:#,.:\,
> 

Having the user specify replacements leads to diversion which would not be
desired. Consider the case where two git users clone a svn repo and later
pull from each other. Different replacements would cause confusion in this
case. That can of course be remedied by having the same replacements but
then configuration is not needed.

Is there anybody working on this feature at the moment? Can I pull from
somewhere? I am hard pressed for that feature but my ability to contribute
is only in testing and reporting bugs.

Greetings
-- 
Robert Ewald

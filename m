From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] autoconf: Add checking for BSD-compatibile 'install' program
Date: Thu, 07 Sep 2006 23:39:28 +0200
Organization: At home
Message-ID: <edq3hk$1tm$2@sea.gmane.org>
References: <200609071431.18343.jnareb@gmail.com> <7v8xkvxwa7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Sep 07 23:40:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLRbt-0003Ay-IZ
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 23:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbWIGVka (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 17:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbWIGVka
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 17:40:30 -0400
Received: from main.gmane.org ([80.91.229.2]:47265 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751898AbWIGVk2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 17:40:28 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GLRbO-00032D-Dg
	for git@vger.kernel.org; Thu, 07 Sep 2006 23:40:03 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 23:40:02 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 23:40:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26659>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Uncomment `AC_PROG_INSTALL' macro in configure.ac, and setting
>> `INSTALL' variable in config.mak.in
>>
>> Add `install-sh' shell script (required when using `AC_PROG_INSTALL'
>> macro) scriptversion=2005-11-07.23, taken from KDE SDK 3.5.3.
>>
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>> ---
>> Perhaps `install-sh' script should be replaced by something simplier,
>> for example by script which was sent to git mailing list, but AFAIK
>> not accepted.
> 
> That somehow sounds like whining.  I do not think it was never
> proposed for inclusion but was just offered as a friendly
> "somebody else might find it useful".

Sorry, my mistake. I thought that the install-sh script was proposed as
solution for platforms lacking install program...

> In any case, I have two issues, but one non-issue first.  I am
> not opposed to including install-sh that is maintained somewhere
> upstream and GPLv2 compatible.
> 
>  - I do not particularly like to have too many autoconf related
>    cruft at the toplevel, and I am wondering if we can move it
>    to say compat/install-sh.

We can do this by adding AC_CONFIG_AUX_DIR(DIR) to configure.ac,
where DIR would be for example 'compat/' or 'compat/autoconf/'

>  - I suspect this fall-back would set "INSTALL = ./install-sh"
>    (if you have it in compat, "INSTALL = compat/install-sh").  I
>    wonder if it breaks builds in subdirectories
>    (i.e. Documentation/ and templates/).

Yes, it sets "INSTALL = ./install-sh -c". And it does make problems for
e.g. 'make install-doc'. I don't know how this should be resolved...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

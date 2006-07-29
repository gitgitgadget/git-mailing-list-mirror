From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: Java GIT/Eclipse GIT version 0.1.1
Date: Sat, 29 Jul 2006 18:46:29 +0200
Message-ID: <slrnecn475.i60.Peter.B.Baumann@xp.machine.xx>
References: <20060728063620.GD30783@spearce.org> <slrnecjcsn.8td.Peter.B.Baumann@xp.machine.xx> <20060728030859.n8ks44ck8884ss44@webmail.spamcop.net> <slrnecjeru.bou.Peter.B.Baumann@xp.machine.xx> <1154139012.3154.38.camel@dv>
X-From: git-owner@vger.kernel.org Sat Jul 29 18:47:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6rxu-00052p-81
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 18:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWG2Qq7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 12:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWG2Qq7
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 12:46:59 -0400
Received: from main.gmane.org ([80.91.229.2]:63713 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751213AbWG2Qq7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jul 2006 12:46:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G6rxg-00050y-SV
	for git@vger.kernel.org; Sat, 29 Jul 2006 18:46:48 +0200
Received: from p54aaae9f.dip0.t-ipconnect.de ([84.170.174.159])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Jul 2006 18:46:48 +0200
Received: from Peter.B.Baumann by p54aaae9f.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Jul 2006 18:46:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54aaae9f.dip0.t-ipconnect.de
User-Agent: slrn/0.9.8.0 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24428>

On 2006-07-29, Pavel Roskin <proski@gnu.org> wrote:
> On Fri, 2006-07-28 at 09:23 +0200, Peter Baumann wrote:
>> >> *** glibc detected *** double free or corruption (!prev): 0x080933b0 ***
>> >> /usr/bin/git-clone: line 29: 10712 Aborted                 git-http-fetch -v
>> >> -a -w "$tname" "$name" "$1/"
>> >
>> > I'm not getting that.  I hope you are just using an obsolete version of git.
>> 
>> Not _that_ old, me thinks. I'm using the debian unstable version.
>
> I tried to reproduce it but couldn't.  I tried valgrind (3.2.0 and
> current) on two architectures, I tried _FORTIFY_SOURCE=2 to no avail -
> it just won't crash or report anything suspicious.  It's the current
> master branch of git.
>
> So, it's up to you to debug it.
>

Strange. Running git-clone now works.

devil:~ cd src; git clone http://www.spearce.org/projects/scm/egit.git
error: File ac32c7cc2f7cf87a1ed80d0cdfca2af2a0385bb2
(http://www.spearce.org/projects/scm/egit.git/objects/ac/32c7cc2f7cf87a1ed80d0cdfca2af2a0385bb2)
corrupt
Getting pack list for http://www.spearce.org/projects/scm/egit.git/
error: XML error: not well-formed (invalid token)
Getting index for pack 052a98c5ca30068b8ecda3302198174e4588bab1
Getting pack 052a98c5ca30068b8ecda3302198174e4588bab1
 which contains ac32c7cc2f7cf87a1ed80d0cdfca2af2a0385bb2
walk ac32c7cc2f7cf87a1ed80d0cdfca2af2a0385bb2

[... lots of correct looking walk's ...]

walk c1f287cb19b9910af19756cf29c08b1fda75da8c
Some loose object were found to be corrupt, but they might be just
a false '404 Not Found' error message sent with incorrect HTTP
status code.  Suggest running git fsck-objects.
got eab86de8ac23e2e77878835007724146fdd83796

And git-fsck-objects --full doesn't barf, so it should be ok. Could it
be related that I am not using a proxy today (as last time)?

-Peter

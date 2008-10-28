From: Hannu Koivisto <azure@iki.fi>
Subject: Re: git bisect view's use of DISPLAY environment variable in Cygwin
Date: Tue, 28 Oct 2008 19:51:34 +0200
Organization: NOYB
Message-ID: <83skqg1uc9.fsf@kalahari.s2.org>
References: <83wsfs1y6v.fsf@kalahari.s2.org>
	<c07716ae0810281015s47741fdqec4c3bed3313bb6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 28 18:53:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuskY-0003p3-QK
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 18:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbYJ1Rvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 13:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752683AbYJ1Rvs
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 13:51:48 -0400
Received: from main.gmane.org ([80.91.229.2]:54404 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532AbYJ1Rvr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 13:51:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KusjG-0005dS-48
	for git@vger.kernel.org; Tue, 28 Oct 2008 17:51:42 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 17:51:42 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 17:51:42 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:MlG0UgLEhF6aOlhB1ajhfPd5lRY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99310>

"Christian Couder" <christian.couder@gmail.com> writes:

> Hi,
>
> On Tue, Oct 28, 2008 at 5:28 PM, Hannu Koivisto <azure@iki.fi> wrote:
>> Greetings,
>>
>> git bisect view uses gitk if DISPLAY environment variable is set
>> and git log otherwise.  Since gitk doesn't require X server in
>> Cygwin, that seems like a bit questionable condition in that
>> environment.
>
> Do you know any environment variable that we could use to detect we
> can use gitk in Cygwin?

I looked around and I believe there is no such variable.  I suppose
the only case where you cannot use gitk is when the user is logged
on using ssh, telnet, psexec or similar (well, unless you use some
non-standard Tcl/Tk build which is configured to use X instead of
Windows graphics).  Then again, I don't think typical Windows
programs do any checks for such situations.

So, easy fix: always use gitk unless log is specified.  Harder fix:
figure out a way to test if the login session is such that
graphical applications can be run.

> You can use "git bisect view log" to use "git log" even if DISPLAY is set.

I'd rather not use undocumented functionality ;)

-- 
Hannu

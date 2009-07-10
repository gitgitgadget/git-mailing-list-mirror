From: Graeme Geldenhuys <graemeg@gmail.com>
Subject: Re: 'git svn fetch' keeps giving a error after freezing
Date: Fri, 10 Jul 2009 09:07:13 +0200
Message-ID: <h36pc1$4cv$1@ger.gmane.org>
References: <h31vg6$b38$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 09:08:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPADM-0008Di-NP
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 09:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbZGJHIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 03:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbZGJHID
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 03:08:03 -0400
Received: from main.gmane.org ([80.91.229.2]:36558 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbZGJHIB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 03:08:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MPAD8-0007za-SD
	for git@vger.kernel.org; Fri, 10 Jul 2009 07:07:58 +0000
Received: from 41.177.20.228 ([41.177.20.228])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 07:07:58 +0000
Received: from graemeg by 41.177.20.228 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 07:07:58 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 41.177.20.228
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <h31vg6$b38$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123037>

Graeme Geldenhuys wrote:
> 
> ==============================
> $ git svn fetch
> .....
>          A       fixes_2_0/fv/gadgets.pas
>          A       fixes_2_0/fv/colortxt.pas
>          A       fixes_2_0/fv/outline.pas
> RA layer request failed: REPORT of '/svn/fpc/!svn/vcc/default': Could 
> not read response body: connection was closed by server 
> (http://svn2.freepascal.org) at /usr/local/libexec/git-core/git-svn line 
> 4505
> ==============================

It seems this issue has nothing to do with Git. It's a bug in the TCP 
traffic handling in all SVN clients from Collabnet. Here is a recent bug 
report about this exact issue.

http://sourceforge.net/apps/trac/sourceforge/ticket/1576

The problem gets triggered on slow connections and large revisions 
(commits) or large files.

Our slow connection is probably why I keep getting the issue. Even 
though we have a 4MB ADSL connection, we hardly ever reach that speeds. 
Plus some more research revealed the shaped ADSL connection goes through 
our ISP's transparent proxy, making the connection even more flaky/slow.

Luckily the FPC repository has an alternative port that it listens to as 
well (port 8080) which bypasses the transparent proxy. Using the new 
port, the 'git svn fetch' is flying!!!!  :-)  At Last!

Thanks to all that tried to help me...


Regards,
   - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://opensoft.homeip.net/fpgui/

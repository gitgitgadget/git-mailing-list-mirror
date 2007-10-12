From: Salikh Zakirov <salikh@gmail.com>
Subject: Re: git branch performance problem?
Date: Sat, 13 Oct 2007 02:19:19 +0900
Message-ID: <470FAC97.5070904@gmail.com>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com>	 <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com>	 <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com>	 <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com>	 <f329bf540710101430i63926b25q7d55976af96b891d@mail.gmail.com>	 <alpine.LFD.0.999.0710101610230.20690@woody.linux-foundation.org> <f329bf540710101926vedf8b19p52e3eeb193203d03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 12 19:41:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgOR5-0003Ou-Tl
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 19:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755549AbXJLRgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 13:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbXJLRgW
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 13:36:22 -0400
Received: from main.gmane.org ([80.91.229.2]:52258 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755386AbXJLRgV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 13:36:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IgOKH-0005mA-68
	for git@vger.kernel.org; Fri, 12 Oct 2007 17:29:29 +0000
Received: from 221x115x75x108.ap221.ftth.ucom.ne.jp ([221.115.75.108])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 17:29:29 +0000
Received: from salikh by 221x115x75x108.ap221.ftth.ucom.ne.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 17:29:29 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 221x115x75x108.ap221.ftth.ucom.ne.jp
User-Agent: Thunderbird 2.0.0.6 (X11/20070819)
In-Reply-To: <f329bf540710101926vedf8b19p52e3eeb193203d03@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60699>

Han-Wen Nienhuys wrote:
> For cherrypicking convenience, I would still appreciate it if there
> was a mechanism similar to alternates that would allow me to view
> objects from an alternate repo; objects found through this mechanism
> should never be assumed to be present in the database, of course.

There exist a script contrib/workdir/git-new-workdir,
which creates a new working copy that literally shares the same object store.
It will share both object store and branches, so some care must be taken:
branch which checkout out in one shared working directory must never be updated
(committed or pulled into) from the other shared working directory.

Said that, I personally find this trick very useful for browsing alternate
branch code and quick bug fixing.

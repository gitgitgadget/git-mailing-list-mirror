From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Default remote branch for local branch
Date: Mon, 3 Apr 2006 11:38:29 +0200
Message-ID: <200604031138.29227.Josef.Weidendorfer@gmx.de>
References: <1143856098.3555.48.camel@dv> <200604030128.42680.Josef.Weidendorfer@gmx.de> <4430D517.5020205@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 11:38:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQLWC-0004Cj-VN
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 11:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbWDCJid (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 05:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbWDCJid
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 05:38:33 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:51911 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751705AbWDCJic (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Apr 2006 05:38:32 -0400
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id BBE9322FA;
	Mon,  3 Apr 2006 11:38:30 +0200 (MEST)
To: Andreas Ericsson <ae@op5.se>
User-Agent: KMail/1.9.1
In-Reply-To: <4430D517.5020205@op5.se>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18322>

On Monday 03 April 2006 09:56, Andreas Ericsson wrote:
> Josef Weidendorfer wrote:
> > 
> > Optionally, branching <new> off from <old> could add <new> as
> > topic branch of <old>: Thus, if you are on <old> and do git-pull,
> > you get <new> merged in.
> > 
> 
> This is clearly insane. If I'm on <old> and want to sync with my 
> upstream source that would be impossible without explicitly telling it 
> *not* to merge with <new>. Iow, this change would (possibly) simplify 
> for the one repo maintainer, but make things harder for the 30-odd 
> developers.

Yes.
Therefore I put "optionally" above. But you are right, mixing up
"merge upstream" and "merge downstream" into one config option is insane.

Some idea independent but related:
I still think it is a better UI of a porcelain to try to note metainfo
automatically, ie. storing somewhere that we branched one off another.
What about adding "branch.topic" config option for this?
"git-branch -t newtopic"/"git-checkout -b newtopic -t"
would create a new topic branch, which is remembered in "branch.topic",
and "git-pull -t" merges these topic branches?
To specify that a remote branch is a topic branch of a given local
branch (to be pulled into with "git-pull -t"), we could add
"git-branch --add-topic <refspec>|<remoteURL>".

Josef

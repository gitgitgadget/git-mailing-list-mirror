From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git ready: daily git tips
Date: Tue, 10 Feb 2009 01:20:48 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngp1ljg.cnd.sitaramc@sitaramc.homelinux.net>
References: <1234131508141-2294642.post@n2.nabble.com>
 <alpine.LFD.2.00.0902091524520.30940@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 02:22:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWhKT-0003Ci-M8
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 02:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbZBJBU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 20:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753032AbZBJBU6
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 20:20:58 -0500
Received: from main.gmane.org ([80.91.229.2]:48423 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928AbZBJBU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 20:20:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LWhJ2-0005qf-V3
	for git@vger.kernel.org; Tue, 10 Feb 2009 01:20:57 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 01:20:56 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 01:20:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109172>

On 2009-02-09, Nicolas Pitre <nico@cam.org> wrote:
> On Sun, 8 Feb 2009, Nick Quaranto wrote:
>> http://gitready.com
>
> Well done.
>
> One topic that IMHO you fail to cover, and which is being neglected 
> almost everywhere else too, is the reflog.
>
> The reflog is really your safety net when working with git.  It records 
> everything you do. So even if you screw up a rebase, perform the wrong 
> merge, or any other kind of undesired operation, then you may always go 
> back to a previous state.  Either you use -g with 'git log' to see all 
> those recorded states, or even 'git reflog' without any argument to get 
> a condensed list for HEAD.
>
> The <branch>@{<spec>} notation can be used anywhere a ref is normally 
> required.  The special branch "HEAD" shows every state the HEAD pointer 
> went through, including branch switches.  The <branch< part can be left 
> out to mean "currently checked-out branch".
>
> One thing that I use all the time after a 'git pull' is 'git log @{1}..' 
> where "@{1}" means the first previous tip of the current branch, so 
> effectively showing me the log of what the pull brought in my branch.

Also, the @{now} notation to get a relative timestamp of the
reflog is invaluable.  Seeing reflog lines annotated with
'14 minutes ago' or '17 hours ago' or perhaps '4 days ago',
really helps to focus on the commits you're looking for:

    git reflog show @{now}
    # (the 'show' is not optional in this syntax)

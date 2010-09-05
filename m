From: Stephen Kelly <steveire@gmail.com>
Subject: Re: Additional remote on a local clone. Where do the objects go?
Date: Mon, 06 Sep 2010 01:50:59 +0200
Message-ID: <i61ad4$jq2$1@dough.gmane.org>
References: <i5kudr$dp7$1@dough.gmane.org> <AANLkTi=_uP_zFOV_k=cM8TXH16kTPAoPGpNkz+QUSzb-@mail.gmail.com> <i5len7$dpr$1@dough.gmane.org> <AANLkTik=qeoq67KZa8Bj7Ynrt8O8ija6yeH6_+e4=gOZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 01:51:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsOzf-0008Rk-Ot
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 01:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796Ab0IEXvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 19:51:12 -0400
Received: from lo.gmane.org ([80.91.229.12]:55164 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754270Ab0IEXvL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 19:51:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OsOzO-0008Nz-If
	for git@vger.kernel.org; Mon, 06 Sep 2010 01:51:10 +0200
Received: from dslb-094-223-081-162.pools.arcor-ip.net ([94.223.81.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 01:51:10 +0200
Received: from steveire by dslb-094-223-081-162.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 01:51:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-094-223-081-162.pools.arcor-ip.net
User-Agent: KNode/4.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155499>

Tay Ray Chuan wrote:

> Hi,
> 
> (Please avoid dropping emails from the Cc list. Since you're using
> gmail, you could use "Reply to all".)

Actually I'm posting using GMane through KNode. I'll keep you in the CC but 
there's no need to CC me.

> 
> On Wed, Sep 1, 2010 at 7:51 PM, Stephen Kelly <steveire@gmail.com> wrote:
>> Tay Ray Chuan wrote:
>>> Two improvements: shared objects, and configuring git-pull:
>>
>> I'm confused. I thought the local clone already used shared objects?
> 
> You'd have to use "-s/--shared" with git clone; I don't think it's
> done by default.

Indeed, --local is default, which sets up hard links, so they are shared in 
that sense. So it looks like the suggestion is I should remove the --local 
clones and start again with --shared so that the objects directory is 
symlinked? Is that better than hard links?

> 
> (On hindsight, I should have used this instead of setting it up
> manually by writing to .git/objects/info/alternates.)
> 
>> So this will pull from the gitorious remote and store the objects in the
>> parent git from where they are shared with this local clone?
> 
> No, you'd have to first pull from gitorious in your parent directory,
> before going into the local repo/branch (eg. qt46) and then pulling
> again.

Right. That's what I do currently, but it's not optimally convenient. I'd 
like to just go to the qt46 clone, set it up with the correct remote url and 
pull there, with the result being that the objects I pull are still shared 
across all the local clones.

> 
>> Which is the better solution between this and git-new-workdir given that
>> these are permanent branches, not temporary, and I'll want to push and
>> pull various clones and share the objects. It looks like the
>> git-new-workdir option creates symlinks, whereas the local clone creates
>> hard links, and this solution creates a redirect of sorts.
> 
> I haven't used git-new-workdir comprehensively, so I'll avoid
> commenting too much, but I'd like to know if you've looked at
> branches? You can just switch between each and do your qt 4.6- and
> 4.7-specific work.

Switching between branches costs time and I often need to work with more 
than one at a time, and I need separate build directories for them, so I'm 
trying to get these 'permanent checked-out branch directories' set up 
conveniently.

> 
> I say that, because what you're doing sounds like what a hg user would
> do to emulate git branches.
> 

I only used hg for the first time on Friday to clone a repo. Not sure what 
the workflow with that SCM is.

Thanks for the pointers,

Steve.

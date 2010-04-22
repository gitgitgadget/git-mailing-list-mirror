From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Thu, 22 Apr 2010 17:25:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004221651590.7232@xanadu.home>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <20100422155806.GC4801@progeny.tock> <87wrvzs590.fsf@frosties.localdomain>
 <alpine.LFD.2.00.1004221445310.7232@xanadu.home>
 <87sk6n4426.fsf@frosties.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Goswin von Brederlow <goswin-v-b@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 22 23:25:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O53td-0001vx-PG
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 23:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756998Ab0DVVZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 17:25:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61981 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756917Ab0DVVZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 17:25:09 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L1A005W5RHVMG20@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 22 Apr 2010 17:25:07 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <87sk6n4426.fsf@frosties.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145565>

On Thu, 22 Apr 2010, Goswin von Brederlow wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > On Thu, 22 Apr 2010, Goswin von Brederlow wrote:
> >
> >> I do commit often and commit early and I start and finish one thing
> >> before I start another. Also I keep my files small so they do one thing
> >> and do it well. Overall that means I don't end up with multiple changes
> >> in a single file so I never need to cherry pick changes for a commit.
> >
> > Good for you.  I'm not that disciplined. Hence I often end up working on 
> > more than one thing in parallel.  The index is just so incredibly useful 
> > in that case.  I'm also a big fan of 'git add -e'.
> 
> As soon as you do 'git add -e' then you have an index. In that case a
> 'git commit' would use the index. There would be no change in worflow or
> behaviour for you.

But the point is if I did not use 'git add'.

> >> So I don't think people should be forced to utilize the index. Imho that
> >> is a matter of the workflow people use. Some people work better with the
> >> index and some people (or projects) don't need it.
> >
> > Exact.  It is therefore not progress to impose some inconvenience to one 
> > work flow in order to make another one easier.  And in this case we're 
> > talking about the difference between having to type an additional -a vs 
> > the risk of creating a commit with unexpected content.
> 
> Is there a risk? You do get an editor with all the files affected listed
> giving you a big fat warning what you are about to commit. Yes I
> sometimes do start to commit wrongly too (no matter what RCS used) but
> then I just close the editor to abort and commit the things seperately.

Yes, but this is a much greater burden to 1) not forget to empty the 
editor, and 2) actually save the empty file.  Simply exiting the editor 
will cause unwanted commit.

Compare that with simply adding -a to your commit command when told so.

> >> Alternatively an option to take all changes but only if the index is
> >> empty would be helpfull. Then people could define an alias for that or
> >> set the option in the config. Other than setting -a that would allow
> >> using an index when needed and commit everything in the normal case
> >> without having to change the command used to commit.
> >
> > But you're proposing to change the semantics for that command.  And I 
> > also suspect that you're trying to make the index more hidden while what 
> > we're actually trying to do is to promote it.
> 
> Yes, it would hide the index. But you are not just promoting it. You are
> forcing people to always use it, even if only through the -a option.

Well, sure.

And you might be glad that the -a option is there at all.  When this was 
debated, the concensus was that the index is what makes Git so 
different, and actually *better* than the alternatives.

Concerns were raised about natural human resistance to change and the 
fact that some people would have problem adapting to a different model.  
So the -a argument was added as a compromize, although the concensus was 
much less strong in that case.

And experience so far has shown that the vast majority of new Git users 
started to really appreciate the index once they've past the initial 
hurdle of getting used to a different concept.

So we can say that Git's index is one of its major feature.  You should 
learn to use it or stick to -a, but please don't try to make Git into 
what it was meant to be different from.

> > What _you_ can do though, is this:
> >
> > 	git config --global alias.ci "commit -a"
> 
> But then when I accidentally use 'git ci' while having an index the
> index gets ignored and all changed files get commited in one big mess.

Not at all.  You will end up in the same text editor with the same 
opportunity to abort the messed up commit as you are claiming above.  
Except now this is your own burden instead of mine.  See?  One's gain is 
another one's loss.

However in this case this would happen because you mixed up an 
index-using workflow with a non-index-using workflow.  While with your 
suggested change the messed up commit could occur without mixing up 
workflows.

So either you use the index or you don't.  And of course I'd strongly 
suggest you truly consider using it.

> Given how seldom I need an index (so far never) the risk of using 'git
> ci' accidentally is way to high. Same with typing -a. I do it so often
> that when I actualy don't want it I will probably type it anyway out of
> habbit.

This is a strawman.  If you do not use the index and never used it so 
far, why are you so afraid of this ci alias?  Please get over it.


Nicolas

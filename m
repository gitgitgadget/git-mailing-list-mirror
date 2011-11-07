From: Jonathan Fine <jfine@pytex.org>
Subject: Re: A Python script to put CTAN into git (from DVDs)
Date: Mon, 07 Nov 2011 20:21:49 +0000
Message-ID: <4EB83DDD.1080103@pytex.org>
References: <4EB6A522.3020909@pytex.org>	<mailman.2464.1320597747.27778.python-list@python.org>	<4EB6CFBB.2090901@pytex.org> <m3zkg92dxq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-4; format=flowed
Content-Transfer-Encoding: 7bit
Cc: python-list@python.org, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 21:24:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNVjx-0007ZL-4q
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 21:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469Ab1KGUYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 15:24:16 -0500
Received: from avasout01.plus.net ([84.93.230.227]:36193 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab1KGUYP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 15:24:15 -0500
Received: from [192.168.1.4] ([91.125.193.208])
	by avasout01.plus.net with smtp
	id uLQ91h0024WEYdn01LQAuc; Mon, 07 Nov 2011 20:24:11 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.0 cv=H4xZMpki c=1 sm=1 a=IScl633ZHowHAm5euRxHow==:17
 a=drkSDUSQfzAA:10 a=sjtYlV3t_a8A:10 a=2-jFaxeq-9kA:10 a=evIkNGOUjnIA:10
 a=bZdGXqoGs2vnu05zy-sA:9 a=gJoACgfOXQQNPbB8KqwA:7 a=ebS1H2NBVeoA:10
 a=IScl633ZHowHAm5euRxHow==:117
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Thunderbird/3.1.15
Newsgroups: comp.lang.python,comp.text.tex
In-Reply-To: <m3zkg92dxq.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185022>

On 06/11/11 20:28, Jakub Narebski wrote:

> Note that for gitPAN each "distribution" (usually but not always
> corresponding to single Perl module) is in separate repository.
> The dependencies are handled by CPAN / CPANPLUS / cpanm client
> (i.e. during install).

Thank you for your interest, Jakub, and also for this information.  With 
TeX there's a difficult which Perl, I think, does not have.  With TeX we 
process documents, which may demand specific versions of packages. 
LaTeX users are concerned that move on to a later version will cause 
documents to break.

> Putting all DVD (is it "TeX Live" DVD by the way?) into single
> repository would put quite a bit of stress to git; it was created for
> software development (although admittedly of large project like Linux
> kernel), not 4GB+ trees.

I'm impressed by how well git manages it.  It took about 15 minutes to 
build the 4GB tree, and it was disk speed rather than CPU which was the 
bottleneck.

>> Once you've done that, it is then possible and sensible to select
>> suitable interesting subsets, such as releases of a particular
>> package. Users could even define their own subsets, such as "all
>> resources needed to process this file, exactly as it processes on my
>> machine".
>
> This could be handled using submodules, by having superrepository that
> consist solely of references to other repositories by the way of
> submodules... plus perhaps some administrativa files (like README for
> whole CTAN, or search tool, or DVD install, etc.)
>
> This could be the used to get for example contents of DVD from 2010.

We may be at cross purposes.  My first task is get the DVD tree into 
git, performing necessary transformations such as expanding zip files 
along the way.  Breaking the content into submodules can, I believe, be 
done afterwards.

With DVDs from several years it could take several hours to load 
everything into git.  For myself, I'd like to do that once, more or less 
as a batch process, and then move on to the more interesting topics. 
Getting the DVD contents into git is already a significant piece of work.

Once done, I can them move on to what you're interested in, which is 
organising the material.  And I hope that others in the TeX community 
will get involved with that, because I'm not building this repository 
just for myself.

> But even though submodules (c.f. Subversion svn:external, Mecurial
> forest extension, etc.) are in Git for quite a bit of time, it doesn't
> have best user interface.
>
>> In addition, many TeX users have a TeX DVD.  If they import it into a
>> git repository (using for example my script) then the update from 2011
>> to 2012 would require much less bandwidth.
>
> ???

A quick way to bring your TeX distribution up to date is to do a delta 
with a later distribution, and download the difference.  That's what git 
does, and it does it well.  So I'm keen to convert a TeX DVD into a git 
repository, and then differences can be downloaded.

>> Finally, I'd rather be working within git that modified copy of the
>> ISO when doing the subsetting.  I'm pretty sure that I can manage to
>> pull the small repositories from the big git-CTAN repository.
>
> No you cannot.  It is all or nothing; there is no support for partial
> _clone_ (yet), and it looks like it is a hard problem.
>
> Nb. there is support for partial _checkout_, but this is something
> different.

 From what I know, I'm confident that I can achieve what I want using 
git.  I'm also confident that my approach is not closing off any 
possible approached.  But if I'm wrong you'll be able to say: I told you so.

> Commit = tree + parent + metadata.

Actually, any number of parents, including none.  What metadata do I 
have to provide?  At this time nothing, I think, beyond that provided by 
the name of a reference (to the root of a tree).

> I think you would very much want to have linear sequence of trees,
> ordered via DAG of commits.  "Naked" trees are rather bad idea, I think.
>
>> As I recall the first 'commit' to the git repository for the Linux
>> kernel was just a tree, with a reference to that tree as a tag.  But
>> no commit.
>
> That was a bad accident that there is a tag that points directly to a
> tree of _initial import_, not something to copy.

Because git is a distributed version control system, anyone who wants to 
can create such a directed acyclic graph of commits.  And if it's useful 
I'll gladly add it to my copy of the repository.

best regards


Jonathan

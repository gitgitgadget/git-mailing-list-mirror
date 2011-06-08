From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Wed, 8 Jun 2011 20:56:37 +0200
Message-ID: <201106082056.38774.jnareb@gmail.com>
References: <201106051311.00951.jnareb@gmail.com> <201106072233.28244.jnareb@gmail.com> <4DEF7378.20307@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:56:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNvy-00038x-4o
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250Ab1FHS4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:56:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64492 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576Ab1FHS4t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:56:49 -0400
Received: by bwz15 with SMTP id 15so686177bwz.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=JE6X9fV01lIjvJ0oaoDCedq9wDXh45/9hknAPW4TFSw=;
        b=xAbNrOL9Wj1MQu4IUR2IB5f/T0tW11B0pQbZA/+GHrPPeKi1nQMZWz/9fErBTNQoMY
         KVrq+npOUExIvzW8LT5Dy3+2reV6aBfVF5e4jqrjjOctuYoS/6kIj+tZdf5s5Q+Ln4wi
         mJ0p8evhgdLypqdYwpG6gS1kJ5KJpd66Bfsrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=nWqKOujk/wgIxjhbntAOCJ8g1qQjwDVMdRRgSh2N6YyvCEM91PNO6Me8ZXkdg8zIMA
         qujlcH4rKSRh3DG/pK1l+MTQqQy+dCHpMhiI8b6wTvAb8PtmNdW0s29VC352PeYKl7mX
         YtXFChtr/uFNQiQMe6o1cxSP1HIbfMmvxqrwY=
Received: by 10.204.141.15 with SMTP id k15mr1461689bku.50.1307559407743;
        Wed, 08 Jun 2011 11:56:47 -0700 (PDT)
Received: from [192.168.1.15] (abvo166.neoplus.adsl.tpnet.pl [83.8.212.166])
        by mx.google.com with ESMTPS id ag6sm823635bkc.18.2011.06.08.11.56.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:56:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4DEF7378.20307@ira.uka.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175442>

On Wed, 8 Jun 2011, Holger Hellmuth wrote:
> On 07.06.2011 22:33, Jakub Narebski wrote:

> > To reiterate; perhaps it is not stated clearly in documentation:
> >
> > 1. "git diff" is about examining _your_ changes.  This short form is the
> >     same in every SCM.
> 
> you are right, more explicit mention in the docs would help about this.
> 
> But other SCMs don't have the additional target 'index'. Much easier to 
> reason there. Also, wouldn't Joe User then conclude that 'git diff' must 
> be comparing working area against HEAD ?

Well, actually it should be that "git diff" is about examining _your_
*remaining* changes.

If Joe User doesn't use index, then "git diff" and "git diff HEAD" shows
the same contents (modulo "git add" / "git add -N" trouble).  So Joe
doesn't need to worry if it is worktree versus index, or versus HEAD;
it is enought to know when it is used.
 
> >     Because of explicit index (cache, staging area) one needs to know if
> >     it is working area against index, or working area against HEAD.
> >     Thinking about merge conflict case helps to remember; in such case
> >     you want your changes against partially resolved merge.
> 
> This is far from a straightforward reasoning that would pop up in 
> anyones mind. In truth, I can't follow that reasoning even now. In case 
> of a merge conflict the working area doesn't concern me at all, I would 
> want a diff between 'ours' and 'theirs'.

What you want is irrelevant ;-)  Because in the case of merge conflict
entries in index is populated automatically, *your* changes are changes
agains index.  So there.

And what "git diff" would show in that case is --cc diff of file with
merge markers against stages '1' and '2' in index, which is quite useful.
Which is 3-way diff between 'ours' and 'theirs'.


Nb. I don't know how to get _remaining_ diff between 'ours' and 'theirs',
but the NEXT proposal doesn't address it either...

> 
> Since perl has been brought up as example of this DWIM philosophy: In 
> perl commands have their defaults, but you always can specify exactly 
> what you want if you are not sure or want to make it explicit. You can 
> use 'chomp' or you can use 'chomp $_'.

By TIMTOWTDI I rather meant here that you can write

  if (...) {
     ...
  }

or

  ... if (...);

or

  ... or ...;


I wasn't saying anything about DWIM-mery, just TIMTOWTDI and context...

> But I can't make it explicit which two targets I want to compare with
> 'git diff'. 

For me it looks XY problem; instead of wanting to compare two explicit
targets, you should specify what you want to see ;-).
 
> >     Also advanced users can use index to hide fully cooked changes from
> >     having to browse during review.

What is where "remaining" in 'examining your remaining changes' come
from.  Advanced users can "git add <file>" (or "git add -p" even) when
some change is fully cooked and ready to be included, to reduce size of
diff when reviewing remaining changes.

> >     Novice users which do not use index (and use "git commit -a") would
> >     never notice the difference, if not for the complication of newly
> >     added files: in other SCM you would see on "<scm>  diff" creation
> >     diff (well, there is "git add -N").  Same with removal if one uses
> >     "git rm" and not simply "rm".
> 
> > 2. "git diff --cached" is about cached (staged) changes, therefore
> >     it is index against HEAD.
> 
> We use three words to talk about the index: cache, stage, index. So 
> apart from having an additional target for diff that target also is 
> diffused by three words. Sure, index is the real designation and cached 
> and staged are used as verbs, but that is just one more confusing bit. 
> Also 'cache' in computer science is a transparent buffer to access data 
> faster (wikipedia definition). Not what I would think of the index.

At the very beginning it was named 'dircache'... ;-)))

There was an attempt to introduce 'to stage', 'staged contents' and
'staging area', and you can use "git diff --staged" instead... but
support might be incomplete.


The area is called 'the index', but you examine 'cached' contents,
not 'indexed' contents.  One of resons for the index is making git
faster, so it is the cache as well (keeps e.g. cached stats info to
make it possible for git to swiftly find which files changed).
 
> Probably there are good reasons to not use "git diff --index" and 
> probably they have been discussed a few times, but it doesn't make using 
> diff easier. But that's a side issue.

The issue is with "git apply" and "git stash", where --index means
'use staging area in addition to working directory' and not like
--cached for "git apply" 'use staging area _instead_ of working
directory" (though _instead_ is not very precise here).
 
> If someone sees 'git diff --cached' he might know one target, the index. 
> But how does he get the other? By reasoning that 'git diff' alone is 
> already index against working area? But for that he would have first to 
> conclude that 'git diff' is not working area against HEAD (as it is in 
> other SCMs), see above.

"git diff --cached" / "git diff --staged" is about 'what changes are
in index' (are 'staged'), i.e. what you "git add"-ed / "git stage"-d.
Because changes always go working directory -> staging area -> repository
(commit) it is abvious that those are "staging area -> repository"
changes.
 
> > 3. "git diff<commit>" in general, and "git diff HEAD" in particular,
> >     is about your changes (worktree), compared to given commit.
> >
> > At in no place I _have_ to explain what is compared with what to explain
> > when and what for to use "git diff", "git diff --cached" and "git diff
> > HEAD".
> 
> I'm sure every part of the user interface of gimp can be rationalized in 
> the same way by someone deeply involved in the concepts and the 
> structure of gimp, but still it is perceived as difficult by nearly 
> everyone else. You look at it from inside and it looks logical. Others 
> just don't have all the pieces to make that reasoning really work.

What I wanted to say here that instead of teaching / trying to teach
new people something like the following:

  There is working area, index and current commit (HEAD).  To compare
  workdir with index use this, to compare index with HEAD use that, to
  compare workdir with HEAD use this one.

we better do explaining higher level concepts

  To examine your remaining changes, i.e. what you can "git stage",
  use "git diff".  To examine staged changes, i.e. what you 
  "git stage"-d, use "git diff --staged"; that is what "git commit"
  will create.  To compare working version with given older version,
  use "git diff <revision>", in particular to compare with last version
  use "git diff HEAD"; that is what "git commit --all" would create.


The "git diff NEXT WTREE" looks like training wheels to me.  And like
training wheels they could become obstacles and not help to learning
git.  Neverthemind they can snag on sharp corners^W corner-cases. ;-)))

-- 
Jakub Narebski
Poland

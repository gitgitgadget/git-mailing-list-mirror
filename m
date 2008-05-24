From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PYRITE] Status update and call for information.
Date: Sun, 25 May 2008 01:27:09 +0200
Message-ID: <200805250127.09506.jnareb@gmail.com>
References: <5d46db230805222318j25657c10t2955fbdf1aa5c003@mail.gmail.com> <m3r6bs2ixn.fsf@localhost.localdomain> <5d46db230805241043u7222be34w7dd8cfcb188ef005@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Govind Salinas" <blix@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Sun May 25 01:28:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K039l-0002si-Uk
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 01:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbYEXX1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 19:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbYEXX1S
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 19:27:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:28803 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbYEXX1R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 19:27:17 -0400
Received: by ug-out-1314.google.com with SMTP id h2so148193ugf.16
        for <git@vger.kernel.org>; Sat, 24 May 2008 16:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=/WrER/10eG/Lo5Hz11L0nnZl+859E5NtRf5D6wdMh6o=;
        b=l4bbtH2wLHLGQXOOY6mbJSpLlZxUYXakJXNYviCYktok2/dLSQa7klIvxvJvE+pm4Fqi+krulLw+nMQQ6KjoXes4SlLxFsRpJ6J7Jv7BCJIY80lTvqozVJVebxqh/SpmlQLXvllRu/rKmsmxkZU+dLf+lFuAn2+C3CW32hDKv+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Gz0uTTF+nChWZx29KrD+RuQqEitO/jm5gWh/S0fXCuG5FrKXpSFKEsgwHZodcwDpeRrmAxNzfasMO17HfaSUpxu9RTCeNjKxejghoRVMDj08It5DiuKn3a5RjHDDx8/9pHF5s/8+9+pkcDMmhI2JftnvB3RQheSZOfrA7SAd4xw=
Received: by 10.67.115.17 with SMTP id s17mr227258ugm.56.1211671635406;
        Sat, 24 May 2008 16:27:15 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.233.1])
        by mx.google.com with ESMTPS id k28sm5853684ugd.41.2008.05.24.16.27.12
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 May 2008 16:27:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <5d46db230805241043u7222be34w7dd8cfcb188ef005@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82841>

On Sat, 24 May 2008, Govind Salinas wrote:
> On Sat, May 24, 2008 at 3:41 AM, Jakub Narebski wrote:
>> "Govind Salinas" <blix@sophiasuchtig.com> writes:

>>>>> 1) Reduce the number of commands.
>> [...]
>> I think you should start not with "minimal number of commands" as a
>> goal, but rather with set of distinct tasks ordinary (not scripting)
>> user might need, and how to map them into commands.
>>
>> To heavily overloaded commands are as much if not worse than having
>> too many commands to choose from.
> 
> This is true.  This idea is fairly new and I am still deciding exactly
> how things would get broken up.  After thinking about it, "checkout"
> probably should not be combined with the fetch/pull/merge command
> because they are too different.  Here is how I am thinking of
> combining things, perhaps you and others can give some pointers on
> what is crazy and what might work. 
> 
> The ones prefixed with * are the ones that would show up in the short
> help, the ones that would be the most typically used.
> 
>   bisect = bisect
>   blame = blame
> * commit = commit + push + stash + init
>           push:  This is here because it fits the traditional notion
>           of what a commit does, which is to send a commit to the
>           central server.  I think of it as "I am committing my
>           changes to the remote repository.

That I'm not sure about. One of advantages of _distributed_ SCM is
separation of the act of committing (saving state to repository) and 
publishing (making those changes public, which stops changing history).
So I'd rather left commit and push separate, although I can agree that
local / public commit would be not so bad alternate interface.

>           stash:  What is stash but a temporary commit (not on the
>           branch)?

I think that is (might be) a good idea, _BUT_ with the caveat that after 
stash working repository is in state _before_ changes.  But that might 
work.

>           init: This can be done a couple of ways, either your initial
>                   commit is combined with the init or --init is a flag
>                   passed to commit to set up the NULL commit.  At
>                   least thats how I think of it conceptually.

Bad, bad idea.  First, init is _very_ separate thing from commit.  
Second, you would lose I think much of error detection.  And last, 
sometimes yoy initialize repository (usually bare repository) to 
propagate changes not using commit (local commit), but using push 
(remote commit).

> * checkout = checkout + clone + branch + remote

No.  'clone' = 'init' + 'remote', or 'clone' ~= 'import'.
Overloading 'checkout' to do all the work of 'branch' is
IMHO not a good idea.

Here it looks like you want to cram too much into single command.
You have fewer commands, but only superficially; you have actually have 
them, but disguised as options and special cases and DWIM-mery.

> * config = config
>   cherry = cherry + cherry-pick

Errr... cherry has nothing to do with cherry-pick.  I'd think
that cherry could be an option to git-log instead, and cherry-pick
be joined with revert.

> * diff = diff

>   gc = clean + gc + prune + repack
>          I plan to make full use of gc --auto to avoid having the
>          user run this command, but everyone knows there
>          are reasons to run these commands even with --auto.

git-gc already is meant to be porcelain for prune and repack,
so you should need run only this command.

>          "Clean" seems to me to be the working directory version
>          of gc.

git-clean is potentially dangerous.  It is _not_ garbage collecting.
Besides "git-clean" apes "make clean"... actually this (the possibility 
of mistake) migh be a good argument for making git-clean to be special 
case of git-gc.

> * gui = gui
> * help = help

>   import = apply + cvsimport + <scm>import + am
>          Here the import strategies would be provided by addons
>          and such with apply/am as standard.

It is one on wishlist from some time to be able to fetch / clone from 
other SCMs just by providing URL to foreign SCM, i.e. unified foreign 
SCM import and foreign SCM interaction support.

>   mail = format-patch + send-mail

I'm not that sure.  Perhaps.  Or perhaps format-patch should be special 
case of git-log (or option to git-log).

>   move = move

> * pull = pull, fetch, merge

Merge is separate from pull because it is inherently local.  Pull might 
get data from remote repository.  And I guess it would play merry hell 
with remotes (shortcuts for remote repositories URLs and refspecs), and 
remote branches names.

>   rebase = rebase
>   remove = remove

> * resolve = mergetool

>   revert = reset + reflog
>           I was thinking of calling this command "recover" instead of
>           revert, which I still think might describe what I want to do
>           and might tell you why I think that reflog is something to
>           combine here.  "revert --what-can-i-revert-to" would show
>           the output of reflog.  That wouldn't be the actual name
>           of the flag, but it gives you the idea.

Mercurial if I remember correctly uses "backout" for git-revert 
equivalent.  Perhaps "rewind" would be better name for git-reset.

> * serve

> * show = show + ls + log + grep + rev-list + rev-parse + describe
>           Combining all this may raise a few eye-brows, but I think
>           it makes sense.  Really this command is git log + ls-files +
>           describe and the ability of showing files from other
>           revisions from git show, the rest can be reduced to
>           functionality already available in git log.

I think that having git-log to show series of commits, and git-show for 
individual, _single_ objects (be it tree, working area, blob, commit, 
tag, current revision name = git-describe) would be better idea.

git-rev-list and git-rev-parse are deep plumbing, not usually to be used 
by end user.

> * status = status 
>   submodule
>   tag

> * track = add/addremove

Ehhh? I'd leave add/rm/mv/cp as is.  Having those commands do not add
(much) to complexity.

>   verify = fsck
[...]

>>>>> 5) One stop shop.
> [snip windows + webserver headaches]
>>>> BTW. there always is git-instaweb.
>>>
>>> Yeah, but I still need the webserver, thats what I want to get rid
>>> of.  If you want to do some ad-hoc sharing it is a huge problem and
>>> you may not have permissions/time to install software.
>>>
>>>> But having git-serve would be nice...
>>>>
>>>
>>> Indeed.
>>
>> And with Python AFAIK you can quite easily set up _simple_ web server
>> for HTTP access and browsing repository...
>>
>> BTW. there was at some time git web interface in Python (old wit),
>> but it lost to gitweb; nowadays Ruby, eRuby or Ruby on Rails seems to
>> be the rage (new Wit (from XMMS2), Gitarella, Gitorious, GitHub).
>>
> I was thinking of using Django so that I could reuse the stuff that
> the review-board folks are doing.  I like their side-by-side diffs
> etc.  

It would be nice to have yet another web interface...

> But here is the kicker, I want to use this to do what the hg 
> people have done.  They built their remote push-pull functionality
> into their built-in webserver.  If we do this then the pyrite http
> protocol can be a smart transport.  I believe that bzr has a similar
> feature in theirs. 

I think that git dumb HTTP/HTTPS transport would conflict with pyt-serve 
smart http transport / tunnelling of git protocol over http.

Besides, HTTP as protocol has its disadvantages, for example it is 
sessionless if I remember correctly...

-- 
Jakub Narebski
Poland

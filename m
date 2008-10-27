From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 13:48:38 +0100
Message-ID: <200810271348.39373.jnareb@gmail.com>
References: <ge0rla$mce$1@ger.gmane.org> <200810271041.54511.jnareb@gmail.com> <200810271114.03406.arne_bab@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com, SLONIK.AZ@gmail.com, git@vger.kernel.org
To: "Arne Babenhauserheide" <arne_bab@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 27 13:50:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuRXm-0002u9-P6
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 13:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbYJ0Mst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 08:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbYJ0Mss
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 08:48:48 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:27623 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbYJ0Msr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 08:48:47 -0400
Received: by ey-out-2122.google.com with SMTP id 6so799968eyi.37
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 05:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Z06a6RxivEJGJe51oRilZKw4fH+2SH3pPzwM7u7uqcE=;
        b=sC0bylE+WJDeVOActUen5G4LVaYIdX1DVaTuQCP+qaTZTgeDZWGbrwmAdC2s5VEjpR
         himlE7yNCKweCNA+XNxJEqSMAKtL3igCZcYaYGkofd1njbN8l9bO09bYBcdYngz/sOyK
         Nsyrskyl/uxIc0FlgSM94PbLhiK4gXcoP6Ji4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=In9Yzs7E0dgLqI5twtGHsMj0g+juFxigIqot3JrHiuSasLsBp1U9c9iWMijRr6sTGq
         myGhKhscFc6LtRUgcply65QMkA516JJvcCkjbkh8NCiFfPaQrzJWbvaFM1nNEEBeGYWt
         R0IxGGuLYQ4+hzd9MHLWq/AZ5/uBiquK7EdPM=
Received: by 10.210.46.12 with SMTP id t12mr6617339ebt.114.1225111725280;
        Mon, 27 Oct 2008 05:48:45 -0700 (PDT)
Received: from ?192.168.1.11? (abvq236.neoplus.adsl.tpnet.pl [83.8.214.236])
        by mx.google.com with ESMTPS id 5sm5883958eyf.8.2008.10.27.05.48.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Oct 2008 05:48:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200810271114.03406.arne_bab@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99229>

On Mon, 27 Oct 2008, Arne Babenhauserheide wrote:
> Am Montag 27 Oktober 2008 10:41:53 schrieb Jakub Narebski:
>>>
>>> If you tell a disk "give me files a, b, c, d, e, f (of the whole abc)",
>>> it is faster then if you tell it "give me files a k p q s t", because the
>>> filesystem can easier optimize that call.
>>
>> I would expect _good_ filesystem to be able to optimize this call as
>> well. As I said it looks like Mercurial and Git are optimized for
>> different cases: Git relies on filesystem for caching, and optimizes
>> for warm cache performance.
> 
> The problem is by which knowledge the filesystem should optimize this call 
> when it is storing the files in the first place. 

Well, that is a question for filesystem designer, and VFS designer...

What I want to emphasize that perhaps Mercurial is optimized for 
"streaming access", but fully packed Git repository requires only
single (well, up to details) mmap, which I think is even better.

>>> relying on crontab which might not be available in all systems (I only
>>> use GNU/Linux, but what about friends of mine who have to use Windows?)
>>
>> But that doesn't matter in the context of this discussion, which is
>> DragonflyBSD; worse or better support for MS Windows doesn't matter
>> here, does it?
> 
> It only matters, if some developers are forced to work on Windows
> machines at times. 

DragonFly BSD developers? I think they would work on DragonFly BSD
(eating one's own dogfood and all that...).

Sidenote: I don't know if DragonFly BSD is more like Linux kernel, or
as Linux distribution. It would be in my opinion good idea to ask
similar projects about the impressions about SCM they use (Linux kernel,
Android, ALT Linux distribution, Debian (build tools etc.), CRUX Linux
distribution, Exherbo, grml, Source Mage GNU/Linux for impressions
on their Git usage; OpenSolaris, Conary, Heretix, Linux HA, perhaps
Mozilla for impressions on their Mercurial usage; 

IIRC ALSA moved from Mercurial to Git, so they could be of help there.

[...]
>> Git just uses different way to keep operations atomic, different way
>> of implementing transactions.

>> And probably requires transactions and locks for that. Git simply uses
>> atomic write solution for atomic update of references.
> 
> Doesn't atomic write also need locks, though on a lower level (to ensure 
> atomicity)? 

No, you can use create then rename to final place trick, making use
of the fact (assumption) that renames are atomic. And Git first write
data, then write references which are used to access this data (this
relies on pruning dangling objects).
 
I'm not saying that git does not use locks at all, because it does,
for example to edit config file, or update branch and its reflog as
atomic operation. But it needs locking in very few places.

>> Behind the scenes, at a lower level, Git does necessary delta resolving.
>> Delta chains in packs have limited length (as they have in Mercurial).
> 
> So both do snapshots - they seem more and more similar to me :) 

There are differences: Mercurial from what I understand uses forward
deltas (from older to never) while Git prefers recency order; delta
chains in Git doesn't need to form single line, but can be forest of
delta chains; Git searches for good delta basis from large range of
objects (see pack.window); there is pack index which allow for random
access as if objects were in loose format (resolving deltas behind the
scenes).

I also don't know how Mercurial deals with binary files; in Git pack
format uses binary delta from LibXDiff by Davide Libenzi (File
Differential Library), heavy modified.

>> The answer usually is: did you have this repository packed? I admit
>> that it might be considered one of disadvantages of git, this having
>> to do garbage collection from time to time... just like in C ;-)
> 
> I cloned from the official repositories. 
> 
> I hope Linus had his repository packed :) 

Well, that also depends on _when_ did you try this. In older versions
of Git pack file got from network (git:// and ssh:// protocols) was
exploded into loose objects; now is kept if it is large enough, only
expanding it to make it thick, self contained pack file.

Unless you used http:// protocol, which I think kept packs as they were,
and as dumb protocol (along ftp:// and rsync://) depends on remote
repository being well packed.

>> Well, understanding "git checkout ." doesn't require understanding
>> inner workings of git. Your friend was incorrect here. I'll agree
>> though that it is a bit of quirk in UI[1] (but I use usually
>> "git reset --hard" to reset to last committed state).
> 
> Damn - one more way how I could have archieved what I wanted...
> one more way I  didn't find. 

Well, there is a difference between "git checkout ." and
"git reset --hard", but it does not matter here.

By the way, the design of Git allowed to add lately new feature:
"git checkout --merge <file>..." to recreate conflicted merge in
specified paths. For example if you completely borked merge resolution,
and want to start from scratch.

>> Just Google for "Worse is Better". But what I actually mean that Git
>> feature set and UI has evolved from very bare-bones plumbing, adding
>> features and UI _as needed_, instead of being designed according to
>> what designer thought it was needed.
> 
> And that's how it feels to me. 
> 
> A great testing ground, but it developed too many stumbling blocks
> which keep me from trying things. 

Well, as shown in "Worse is better", evolved design wins (Lisp machines
versus Unix) :-)

> When I now use git, I only do the most basic operations: clone, pull, push, 
> add, commit, checkout. When anything else arises, I check if it is worth the 
> risk of having to read up for hours - and since that wasn't the case for the 
> last few months, I then just ignore the problem or ask someone else if he can 
> fix it. 

Understanding Git "mental model" certainly helps.

[...]
> All in all it's a UI issue - while the git UI bit me quite often, the 
> Mercurial UI just works. 

But _that_ might be because you are used to Mercurial UI, isn't it?

-- 
Jakub Narebski
Poland

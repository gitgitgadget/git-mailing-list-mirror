From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: Feature request: fetch --prune by default
Date: Thu, 19 Jul 2012 23:20:10 +0200
Message-ID: <E94B0D74-2BB8-4B3E-BFB9-A2CFE9C2A7BB@gmail.com>
References: <2C63E314-2EF5-4B8E-B96A-5306E317E045@gmail.com> <20120719115558.GC29774@sigill.intra.peff.net> <88300470-AB41-4317-8B97-81DC18FD5899@gmail.com> <20120719213438.1cc7ca77a9cb3367a3be0539@domain007.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Jul 19 23:20:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sry9X-0000ad-1h
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 23:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646Ab2GSVUu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jul 2012 17:20:50 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58703 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab2GSVUs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2012 17:20:48 -0400
Received: by wgbdr13 with SMTP id dr13so2895517wgb.1
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=rvGTVSjIO/DcTks8GX0CDByT2AvHUTMRZwM/vLf4iXI=;
        b=Vm1UXblFMots1NWfsvPgIGnZXUNf2RLtVuG6AViPUkZaQNGllELDJw2ZLNvsOR+lDp
         TWPrfAPs0wFkXxpdCl9b37SP0HZnJCK5f3qU6tFpd1Tl1AHO589jRxIx6voQiOuejZzv
         sQN24YtaQhsXMmN1k7vohTMHXMetTM+If4wBkUZh3QMPOWhN2ndB6Q8OoQAeL77JjVnr
         ntm1dmGA+YYw7mliEoQ/Hi1gykLA0J1fTafhMr9KEUkrDV5AKdJrSsP33tvNMVfP+vuS
         fDhVQ/iZCWsRUZQFWwBiZWPvqLrXVnxt7hFl13g/OSNh6hLACTWbVWdHPTZib+82dsu4
         r4Kw==
Received: by 10.216.163.196 with SMTP id a46mr2099355wel.212.1342732812888;
        Thu, 19 Jul 2012 14:20:12 -0700 (PDT)
Received: from [192.168.6.127] (bi1.roaming.dfn.de. [195.37.234.61])
        by mx.google.com with ESMTPS id fb20sm9116950wid.1.2012.07.19.14.20.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 14:20:12 -0700 (PDT)
In-Reply-To: <20120719213438.1cc7ca77a9cb3367a3be0539@domain007.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201751>

On 19 Jul 2012, at 19:34, Konstantin Khomoutov wrote:

> On Thu, 19 Jul 2012 18:21:21 +0200
> Alexey Muranov <alexey.muranov@gmail.com> wrote:
>=20
> [...]
>> I do not still understand very well some aspects of Git, like the
>> exact purpose of "remote tracking branches" (are they for pull or fo=
r
>> push?), so i may be wrong.
> This is wery well explained in the Pro Git book, for instance.
> And in numerous blog posts etc.

I have read the Pro Gut book and numerous blog posts, but i keep forget=
ting the explanation because it does not make much sense to me:

"Tracking branches are local branches that have a direct relationship t=
o a remote branch.  If you=92re on a tracking branch and type git push,=
 Git automatically knows which server and branch to push to.  Also, run=
ning git pull while on one of these branches fetches all the remote ref=
erences and then automatically merges in the corresponding remote branc=
h." etc.

Why the same "direct relationship" for push and pull?  What happens if =
one of the branches was reset (yes, i know, "push -f").  Most important=
ly, what is the purpose of it? It is natural to expect that you might b=
e pushing to and pulling from different remotes, i can even imagine pul=
ling from more than one.

>> However, i thought that a user was not
>> expected to follow the moves of a remote branch of which the user is
>> not an owner: if the user needs to follow the brach and not lose its
>> commits, he/she should create a remote tracking branch.
> This would present another namespacing issue: how would you name the
> branches you're interested in so that they don't clash with your own
> personal local branches?  You'd have to invent a scheme which would
> encode the remote's name in a branch name.  But remote branches alrea=
dy
> do just this.  So you create a remote tracking branch when you intend
> to actually *develop* something on that branch with the final intenti=
on
> to push that work back.

But i am not interested in remote branches, they are just fetched autom=
atically when i do "git fetch".  You cannot commit to a remote branch, =
and i think it is not common to checkout them without a "-b" option.  I=
f i am interested in them, i name them somehow.  I think this is the on=
ly practical way if i do not want to chase reflogs, because the owner o=
f the branch can reset or rebase it anytime.  I do not develop on track=
ing branches.  In fact, i am not even using "git pull".

>>> So I think it would be a lot more palatable if we kept reflogs on
>>> deleted branches. That, in turn, has a few open issues, such as how
>>> to manage namespace conflicts (e.g., the fact that a deleted "foo"
>>> branch can conflict with a new "foo/bar" branch).
>>=20
>> I prefer to think of a remote branch and its local copy as the same
>> thing, which are physically different only because of current real
>> world/hardware/software limitations, which make it necessary to keep
>> a local cache of remote data.  With this approach, reflogs should be
>> deleted with the branch, and there will be no namespace conflicts.
> It appears, the distributed nature of a DVCS did not fully sink into
> your mindset yet. ;-)
> Looks like you mentally treat a Git remote as a thing being used to
> access a centralized "reference" server which maintains a master copy
> of a repository, of which you happen to also have a local copy.
> Then it's quite logically to think that if someone deleted a branch i=
n
> the master copy, everyone "downstream" should have the same
> remote branch deleted to be in sync with that master copy.
> But this is not the only way to organize your work.
> You could fetch from someone else's repository and be interested in
> their branch "foo", but think what happens when you fetch next time f=
rom
> that repo and see Git happily deleting your local branch thatremote/f=
oo
> simply because someone with push access deleted that branch from the
> repo.  This might *not* be what you really want or expect.

But this is true that the object store of Git can be viewed as a single=
 centralized repository.  The fact that not everybody has access to eve=
ry object in Git is a limitation and not a benefit.  These are the bran=
ches which are individual, and i do not think it is a good habit to tre=
at every reference that was ever fetched with "git fetch" as your own, =
and put reflogs of all fetched remote branches under Git version contro=
l :D.

If i care about "thatremote/foo" branch, i "track" it, i do not plan to=
 go through reflogs if it is rebased.

Alexey.
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Wed, 8 Jun 2011 15:10:02 +0200
Message-ID: <201106081510.02701.jnareb@gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <201106061419.34599.jnareb@gmail.com> <4DECD406.2010009@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 15:10:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUIWa-0004qh-OZ
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 15:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916Ab1FHNKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 09:10:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38310 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab1FHNKM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 09:10:12 -0400
Received: by bwz15 with SMTP id 15so399820bwz.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 06:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=OsvLV2g5/Hrg+SnIiRM6fAdeMfgWEODnvbgvRJO2VkE=;
        b=MEvGCKCE9h1XKsk3hDaAjuBwvAL0zIVQuVmPYeEEC0fQVG+EqpbhoZOpALyV+2DDfH
         Xw0MNH8p7DCYc3V/SMALuAGVyxLl5Vod1qyIjx669zLfcCkL2iP7xnF9lS4rVrIM9log
         fhDWn2L1nAQqWGMFHbwYtYebbF2o3tkmFBstI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OOPB40d8S8AGGix7ebkfRsoLef4H+UB1L9NWvLD1rO6tLicwODzheBX1z6y3qdBDGk
         IAcN6k0x/XuXTI/H1nelTjWf/9v6cEQ3cx/9WZ4TPpTvGcGrNJ3TESSuyW5XsUd36Rfy
         i5f7DhghSMn4Tbax3f94GpvY8g1zHvPn2jtMk=
Received: by 10.204.233.14 with SMTP id jw14mr575345bkb.40.1307538611014;
        Wed, 08 Jun 2011 06:10:11 -0700 (PDT)
Received: from [192.168.1.15] (abvu41.neoplus.adsl.tpnet.pl [83.8.218.41])
        by mx.google.com with ESMTPS id k16sm547181bks.13.2011.06.08.06.10.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 06:10:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4DECD406.2010009@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175367>

On Mon, 6 Jun 2011, Michael J Gruber wrote:
> Jakub Narebski venit, vidit, dixit 06.06.2011 14:19:
>> On Mon, 6 June 2011, Michael J Gruber wrote:
>>> Junio C Hamano venit, vidit, dixit 06.06.2011 08:16:
>>>> Scott Chacon <schacon@gmail.com> writes:

[...]
>>> That is why the other Michael suggested "NEXT" as opposed to "INDEX":
>>> The index has many aspects, only one of which is "the contents of the
>>> next commit if I would issue 'git commit' right now". (I would even go
>>> so far as using "STAGE".) Now, it's hard to argue that "the result of a
>>> commit" is not tree-like, isn't it? And there's no question what "git
>>> show NEXT" would do. Yes, if you repeat that command, you get a
>>> different sha1 each time (because of the time field).
>>>
>>> I don't think anyone is seriously suggesting to replace the index by a
>>> pseudo commit; but the one aspect which people use most could be well
>>> represented like that, and this might even help emphasizing the
>>> different aspects of the index. Give the index an identity as an
>>> "object" (no, no new type, not in the object db, but as a ui object),
>>> not something mysterious behind the scenes!
>> 
>> So what you suggest would make
>> 
>>   $ git diff NEXT WTREE
>> 
>> behave differently from
>> 
>>   $ git diff
>> 
>> and
>> 
>>   $ git diff HEAD NEXT
>> 
>> behave differently from
>> 
>>   $ git diff --cached
>> 
>> Do you really think that it is good idea?
> 
> I don't know where you're getting from that someone is suggesting to
> make them different. (And even if, it's new UI, not changed.) Everyone's
> been suggesting to make these more accessible.

Here:

  That is why the other Michael suggested "NEXT" as opposed to "INDEX":

It was in response to question how "git diff NEXT WTREE" etc. and
"git show NEXT" would look like _in presence of merge conflicts_, as
compared to "git diff" etc. and "git ls-files" / "git ls-files --stage".

>>> As for WTREE: git diff against work tree does not look at non-tracked
>>> ignored files, so why should WTREE?
>> 
>> So we tailor WTREE do diff behavior?
> 
> There is no WTREE and nothing to tailer. We create it so that it is most
> useful and consistent, whatever that may be.

But what if "most useful" contradicts "consistent" (and "user friendly")
and vice versa?  That is the problem with designing this UI.

>> Besides, isn't this exercise a bit academic?  New to git wouldn't use
>> index, and would use 'git commit -a' and 'git diff'... and that would
>> be enough... well, perhaps except 'git add' + 'git diff'...
> 
> But we want them to grasp and use the git concepts! That is why some of
> us want to make them more accessible.

I don't think that making stage/index and working area look like tree-ish
(which they ain't), or using tree-ish like keyword for some ways of 
accessing/addressing index and worktree would make them grasp git concepts.
 
All the corner cases of proposed UI must be addressed in detail, and
examined to tell if it would make git [concepts] more accessible, or if
it would just move difficulty in other place.

>>> Full disclosure: I love the index but hate the way we make it difficult
>>> to use sometimes, and even have to lookup myself what command and option
>>> to actually use if all I want to do is diff A against B, or take the
>>> version of a file from A and write it to B, when A and B are a commit,
>>> the index or the worktree (with a commit being the nonwritable, of course).
>> 
>> Note that in case of saving to worktree you can always use
>> 
>>   $ git show HEAD:./foo>foo
>>   $ git show :0:./foo  >foo     # or just :./foo
> 
> Exactly, yet another command to add to the list below, and it's not even
> all git (because of the shell redirection).

Orthogonality is good in theory, but having more than one way to do
something (like Perl's TIMTOWTDI) is a good thing, especially for UI.
 
>>> I mean, this is really crazy: We have 4 commands ("add", "rm
>>> [--cached]", "checkout [<commit>] --", "reset [<commit>] --") which you
>>> need to be aware of if all you want to do is moving file contents
>>> (content at a path) between a commit, the index and the worktree! And
>>> this is actually worse than having 6 for the 6 cases.
> 
> Add to this craziness the fact that "checkout -- <path>" reads from
> index and writes to worktree, but "checkout <commit> -- path" does not
> read from commit and write to worktree - it reads from commit and writes
> to index+worktree.
> 
> Note that I'm not suggesting to change any of the beloved
> reset/checkout/whatever variants.
> 
> But the more I look at the commit - index - worktree triangle and the
> commands we have the more I realize how messed up the ui is, simply
> because it is determined by the underlying mechanics (e.g.: checkout
> writes the index to the worktree, possibly after updating the index from
> a commit) rather than by the concepts.

Actually it is not determined by underlying mechanics, but by requiring
sane behavior.  Updating worktree from HEAD without updating index is
usually something that you do not want, generating unexpected result.

Also, IMVHO the concepts are simple to understand / remember.  All
checkout variants check out to working area; all reset variants reset
from HEAD / commit:

                 checkout    reset
                  /--^--\   /--^--\

  HEAD              |         ||v
                    |         ||
  index             ||        |v
                    ||        |
  working area      vv        v

And all those update intermediate stages.

> And the bad thing is that even when you look at a single command like
> reset or checkout, you can get confused easily because of the multiple
> different functions they overload (e.g. checkout can change HEAD, the
> index and/or the worktree), and also because of some different defaults
> (HEAD vs. index). I think we lost consistency here because over time
> "useful defaults" grew in the wild.
> 
> That is why I'm suggesting concept based variants (move this content
> from A to B, show me the difference between A and B).

Like "git put" proposal by Jeff King (Peff)?

  [RFC/PATCH] git put: an alternative to add/reset/checkout
  http://thread.gmane.org/gmane.comp.version-control.git/175262

-- 
Jakub Narebski
Poland

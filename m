From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Fri, 10 Jun 2011 12:19:17 +0200
Message-ID: <201106101219.18497.jnareb@gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <201106100004.58040.jnareb@gmail.com> <4DF150FB.9070304@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 10 12:19:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUyoT-00085K-S7
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 12:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273Ab1FJKTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 06:19:32 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48655 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169Ab1FJKTa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 06:19:30 -0400
Received: by bwz15 with SMTP id 15so2057209bwz.19
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 03:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        bh=jvsdJxw6mX9UyP3SUtpe1rZKtbaSiwwVTsze/oZG/Io=;
        b=NdIivcs/sfM6BdVxfNuypfSWD8pBnRZ+w88F03ewWGmgaKNDeinWEBz2CCG9/D4eCE
         26x73Hag9Zv7+c55lEkEDtgfMskuozjpBkf9lNEx2nLXFu9NDqhiGueunExUTb2oCvgS
         vx1yvXPai6NfJynxglwZHxsgW5Fg0t9ydCKZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=j67U2IL1+2d1zZdvqgZeQ6pNPnw7yCsDyjXQYfVKLb/SW61GM6CzxSStYQtEo+cK6n
         oCaTDFRhQE7kbmX6EzIv2hmC1pjgsx1QMGNTMJeadaQkkeyN+Kc7AP7lN2e68aCSUoRw
         jjuWflQ7mkD4L6PsClHD9Wee1ee6KFD3/de8Y=
Received: by 10.204.20.70 with SMTP id e6mr1765762bkb.145.1307701168683;
        Fri, 10 Jun 2011 03:19:28 -0700 (PDT)
Received: from [192.168.1.15] (abvk161.neoplus.adsl.tpnet.pl [83.8.208.161])
        by mx.google.com with ESMTPS id k10sm2418181bkq.22.2011.06.10.03.19.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Jun 2011 03:19:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4DF150FB.9070304@alum.mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175601>

On Fri, 10 Jun 2011, Michael Haggerty wrote:
> On 06/10/2011 12:04 AM, Jakub Narebski wrote:
>> On Thu, 9 Jan 2011, Michael Haggerty wrote:
>>> On 06/09/2011 10:04 PM, Jeff King wrote:
>>>> I'm less sure about these new tokens, for a few reasons:
>>>>
>>>>   1. You get less useful answers in some situations by treating each
>>>>      stage as a separate tree (e.g., lack of combined diff). So why
>>>>      would I want to use them?
>>>
>>> Wouldn't it be nice to be able to do a combined diff between *any* two
>>> trees?  Then the nonuniform merge behavior of "git diff" would be a
>>> special case of a general concept:
>>>
>>>     git diff3 OURS NEXT THEIRS
>>                ^^^^^^^^^^^^^^^^ -- ???
[...]

>> Second, for files with merge conflicts "git diff" is the same as
>> "git diff3 OURS THEIRS WTREE", not "git diff3 OURS NEXT THEIRS".
>> As you can see it is very easy to construct wrong options to git-diff,
>> and end up with nonsense!
> 
> Since there is currently no "git diff3" command, I decided to orient the
> hypothetical "git diff3" command based on diff3(1), which uses
> 
>     diff3 [OPTION]... MYFILE OLDFILE YOURFILE
> 
> By using a new command (diff3) that is somewhat familiar to some users,
> we could reduce the amount of overloading of "git diff".

But here, by using "git diff3" which does not work at all like diff3, and
which output is very different from "git diff --cc" combined diff format,
you increase confusion, not decrease it.  By using somewhat familiar name
that behaves differently from said familiar tool, you make user's life
unnecessary harder.

Let me explain how "git diff --cc" is diferent from "diff3".

First, "git diff --cc" works differently than "diff3";

 * "git diff --cc" can do combined diff of arbitrary number of 3 things
   or more; "diff3" is limited to 3.

 * "git diff --cc" is about comparing merge results with its sources
   (parents) and the like; "diff3" is about comparing two divergent
   versions with their ancestor (merge base) -- opposite direction of
   following parent links.

 * therefore natural ordering for "git diff --cc" is 'PARENT^1 PARENT^2
   MERGE' (like 'FROM TO'), while "diff3" uses arbitrary ordering of
   'MYFILE OLDFILE YOURFILE'... which I always have to check in docs.

Second, "diff3" output is different from "git diff --cc" output... and
as you see above rightly so.

Third, it was still a mistake to write

  git diff3 OURS NEXT THEIRS

In result of combined diff that "git diff" shows in case of merge conflict
differences between OURS, THEIRS, and WTREE version; NEXT isn't there,
and you didn't mention WTREE though it is here.  But see also the next point.

Fourth, with "git diff3 OURS NEXT THEIRS" / "git diff3 OURS THEIRS WTREE"
you either introduce interface inefficiency, or UI inconsistency, or UI
complication.

In the case of conflict "git diff" shows 3-way combined diff for files
with conflict (OURS, THEIRS, WTREE), but it shows ordinary diff from
stage '0' (NEXT, WTREE) for files which resolved cleanly; the fact that
file resolved cleanly doesn't necessarily mean that it resolved correctly...

So you either make "git diff3 OURS NEXT THEIRS" show only 3-way combined
diff part, consistent with 'diff3' name, but making for an *inefficient*
user interface -- now you have to use two commands for single piece of
information.

Or you make "git diff3 OURS NEXT THEIRS" behave like current "git diff",
i.e. show the whole diff from index, be it conflict or a fixup, which is
efficient but *inconsistent*.

Or you make "git diff3 OURS NEXT THEIRS" compare stage 0 (NEXT?) with
worktree if there is no conflict, and stages 'ours' and 'theirs' with
worktree if there is conflict... which is *weird*, especially that you
defined OURS as "'ours' or stage 0" (union of stage 'ours' and stage 0),
covering all resolved and unresolved files.

> I, for one, 
> was surprised and confused the first few times I typed "git diff" during
> a merge and got a three-way diff rather than what I expected, namely the
> two-way diff that is called "git diff NEXT WTREE" in the proposed notation.

This three way diff is more useful...
 
>> I won't repear the THIRD time simple and around *three times shorter*
>> explanation on _when_ to use which form: "git diff" for your own remaining
>> changes that can be "git add"-ef, "git diff --staged" for which changes
>> are staged i.e. what you have "git add"-ed, and "git diff HEAD" to compare
>> current with last.
> 
> You don't need to repeat for my benefit the existing version of the
> commands; I knew them long before this discussion started.  And
> repeating them does not make them more obvious.
> 
> For a beginner, the main goal is not brevity.  It is discoverability and
> memorability.  Obviously our priorities and tastes differ and we will
> not come to agreement.  I would be very interested what people with a
> fresh memory of struggling to learn the git CLI think would have been
> easier to learn.

You say that user would think something like that:

  "I need to compare staged contents and working area.  To do that I use
   'git diff NEXT WTREE' / have to look up documentation to find that it
   is 'git diff'".

I say that I guess user would think something like that:

  "I want to check if and what remaining changes are.  To do that I use
   'git diff' / have to look up documentation which stages I have to
   compare to find that it is 'git diff NEXT WTREE'".

'git diff' / 'git diff --cached' / 'git diff HEAD' is about use cases
(or "user stories").  'git diff NEXT WTREE' / 'git diff HEAD NEXT' /
/ 'git diff HEAD WTREE' are about mechanism.

-- 
Jakub Narebski
Poland

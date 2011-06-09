From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Thu, 9 Jun 2011 07:44:18 -0400
Message-ID: <BANLkTimir5nQYJk+GuNQOzmTWMEXb2kWqQ@mail.gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
	<20110608150537.GC7805@sigill.intra.peff.net>
	<BANLkTinibF0xmibeuJ6f9FUjaMmxavMJig@mail.gmail.com>
	<201106091148.35114.jnareb@gmail.com>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 13:44:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUdf0-0006tu-9O
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 13:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756326Ab1FILoV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 07:44:21 -0400
Received: from mail-bw0-f52.google.com ([209.85.214.52]:33101 "EHLO
	mail-bw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab1FILoU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 07:44:20 -0400
Received: by bwj24 with SMTP id 24so1877714bwj.11
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 04:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UjOsL6BtEM5zMLSrDbTC2o5nTDg5O2UCyr0VFUDk32w=;
        b=d9U6DLQpAhk3tLFeHYrUW+ZBM3US5uqP/PQXBi0lNUKElhAWj3pSUNF2s8STD6Wyps
         /rycHsJtAUyq1uH7MlNfFRMYVMX25ovItFVHyaCKvfzsuJ3o9LGysod9tlVJgJzy7+hN
         1TWzTwCDFyCPewuuX3NAz9aQlFsoYJQFE99HM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=Ph2uNmZdwp9j08bnWtqiR4fX9eYv07P8LS5IfEvQPnK18O9TCbJYQjyBe6k6zf40FM
         IUOvWm+OMDmSwNeER3p646ibMjNpC+13fHYS/eiLNF3n9lRpuNPyBEimQZEYuRuQVfQr
         EomwgHbW0JCCG3HjOTRLIQxrgOKoed+52r8uE=
Received: by 10.204.26.132 with SMTP id e4mr642637bkc.142.1307619858820; Thu,
 09 Jun 2011 04:44:18 -0700 (PDT)
Received: by 10.204.100.80 with HTTP; Thu, 9 Jun 2011 04:44:18 -0700 (PDT)
In-Reply-To: <201106091148.35114.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175517>

On Thu, Jun 9, 2011 at 5:48 AM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> On Wed, 8 June 2011, Michael Nahas wrote:
>> On Wed, Jun 8, 2011 at 11:05 AM, Jeff King <peff@peff.net> wrote:
>>> On Wed, Jun 08, 2011 at 07:39:16AM -0400, Michael Nahas wrote:
>>>
>>>> On Wed, Jun 8, 2011 at 7:12 AM, Jakub Narebski <jnareb@gmail.com> =
wrote:
>>>>> I don't quite think that we need "git diff NEXT WTREE"; the short
>>>>> and sweet "git diff" is short for a reason,
>>>>
>>>> To be clear, I'm not advocating and have never advocated getting r=
id
>>>> of zero-argument "git diff". =A0I've advocated that every (whole
>>>> project) diff command should be expressible by a "git diff TREE1
>>>> TREE2". =A0I'm fine with defaults if one or zero trees are specifi=
ed.
>>>
>>> I agree with this, but...
>>>
>>>> So "git diff" would default to "git diff NEXT WTREE".
>>>
>>> Isn't this going to be behavior change, since your NEXT is not quit=
e the
>>> same as the index? How do I now get an n-way combined diff of the
>>> unmerged files in the index?
>>
>> The index is a file in .git/ that serves many purposes. =A0NEXT is a=
n
>> image of the whole project. =A0NEXT can be computed from the index a=
nd
>> HEAD.
>>
>> During a conflicted merge, stage 0 of the index holds the resolved
>> files.
>
> It is simply not true. =A0During a conflicted merge, for conflicted f=
iles
> there is _no_ stage 0!!! =A0Conflicted files have stage 1 =3D=3D base=
, 2 =3D=3D ours
> and 3 =3D=3D theirs, where those stages have all conflicts that can b=
e resolved
> automatically resolved, and places where there is conflict replaced b=
y
> merge-base ('base'), current branch into which we merge ('ours') and
> merged branch ('theirs').

"resolved files" means "NOT conflicted files".  The merge conflicts if
any one file conflicts, but there may be other files that resolve
immediately.  And any conflicted files can be resolved by the user
running "git add" or "git rm"

If a file is resolved - either immediately or by user action - it
exists only in stage 0.

>> WTREE holds all merge files: the resolved and the unresolved
>> (which have <<<< =3D=3D=3D=3D >>>> blocks in them).
>
> Worktree version has files with conflict merge markers added in place
> where there is conflict.

I assumed most people knew what I meant by <<<<=3D=3D=3D=3D>>>> blocks.=
  But,
yes, I meant that the working tree has both versions present at
locations of conflicts.

>> I propose that during a
>> conflicted merge, that NEXT be computed as HEAD plus the resolved
>> files, that is, the files in stage 0 of the index.
>
> Why _HEAD_?

Because we merged changed from another branch into HEAD.
Or we pull changes from a remote branch into HEAD.

When a commit is written, it will be part of the branch referenced by H=
EAD.

>> "git diff HEAD NEXT" would print the resolved changes.
>> "git diff NEXT WTREE" would print the unresolved changes
>> "git diff HEAD WTREE" would print all changes.
>>
>> I believe that is the same behaviour as "git diff", "git diff
>> --cached" and "git diff HEAD" during a conflicted merge.
>
> "git diff NEXT WTREE" would not behave (with your proposal) like
> "git diff", but like "git diff --ours".

OURS and HEAD are the same thing, so I doubt a command that does not
involve "HEAD" would behave like "--ours"

> "git diff HEAD NEXT" would not behave like "git diff --cached"
> (which shows only '*Unmerged path foo').
>
> "git diff HEAD WTREE" would be the same as "git diff HEAD" (just
> longer to write), only because it doesn't involve index at all.

I refer you to any of my previous emails to which I kindly replied.
YES, "git diff HEAD" and "git diff HEAD WTREE" would be equivalent.
I, myself, would probably use "git diff HEAD" most of the time.
Nonetheless, saying "git diff" ALWAYS takes two arguments and saying
that if an argument is unspecified that there is a default is much
clearer and more regular interface than special casing everything and
using command-line options to say what you want, which is what we have
now.


>> I do not know how "n-way" merge works. =A0I saw somewhere that indic=
ated
>> that it was a series of N-1 two-way merges.
>
> Where this "n-way merge" came from? =A0Peff wrote about "n-way combin=
ed
> diff", which is something different.

N-way merge exists.  It would be bad to say that I was answering a
question about conflicted merges if I didn't produce an answer for
N-way merges.  Unfortunately, I don't have enough information about
N-way merges to answer the question so I decided it was best to
acknowledge my ignorance and that I was giving an incomplete answer.



> --
> Jakub Narebski
> Poland
>

From: John Medema <john.medema@uniteddrugs.com>
Subject: Re: Feature Request: enhance Git-GUI's Checkout Branch screen
Date: Fri, 4 Sep 2015 11:40:14 -0700
Message-ID: <CALsXy+2N++xDXiiX2q1p43Sk7hW1Uh7oeQQO25Fp23H21JJpxg@mail.gmail.com>
References: <CALsXy+0FN1A-E-GF-chPrOpZSt-Wg8afL8BReqaUnBHDj=3NXA@mail.gmail.com>
 <20150904044224.GA20164@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, IT Dev2 <john.kobinski@uniteddrugs.com>,
	SysAdmin <sysadmin@uniteddrugs.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 20:40:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXvuh-000627-WC
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 20:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759208AbbIDSkg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Sep 2015 14:40:36 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:33794 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601AbbIDSkf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2015 14:40:35 -0400
Received: by iofb144 with SMTP id b144so33837081iof.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 11:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=7+wc0BwCrVDVM20jGVvCmi8Y4Q3dpopC1UROZiMG5u8=;
        b=Nr4afIaB5VnHIdSMLOOLlpEfm/0Q61dlQi5YdQi6b9AZGtdrv4IVTUWap9ABKioPc6
         NNzrVEJLjQiKGTxqn4ITUYJJP01WorCeawOAzcEKWKchtE6lmqU6vViL7ro4tn4PufAL
         jRkMnz3BDPYx1U7PE9xU5x/RA4HSeGjT3FDXdRGc4sEIZUBdPKCldBMrPmi+vQkM3tX5
         6Enc2wEuox7gIqFnlYzjZrK2EJz/aGxqausbEkpkJz7RZDc0wtuyd4UsL8sEm6lCEsQ7
         94LcSX4cqxhWqBBOtRuaUKsqDuiLuL7ZNGggf+ECbKP9L6TRTcEC1vNAJQDJHhbJz/Jz
         Fd5A==
X-Gm-Message-State: ALoCoQkuwJcgWSbeQU9V7ILg5+G3etMOwliAovC2i/bFvNNC44mSagRTdgQFYdPZbH21FmoXAdGMnW5kQ1EQkF0LXNbeaDjGaqaTHjDmbi2kWBhy28fGJGqnR7zKEFNAm05X6oqsjJCl
X-Received: by 10.107.18.231 with SMTP id 100mr9554731ios.15.1441392034213;
 Fri, 04 Sep 2015 11:40:34 -0700 (PDT)
Received: by 10.107.135.155 with HTTP; Fri, 4 Sep 2015 11:40:14 -0700 (PDT)
In-Reply-To: <20150904044224.GA20164@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277329>

David,

Option C - when you say "[in git-cola] when the remote branch is
selected it strips of the remote part and automatically fills in the
name field with that", are you referring to the Branch Create screen
or the Branch Checkout screen?  Your description matches the Create
screen.  And for what its worth, that description is accurate and I
agree that cola does a good job of making the branch creation process
easy, and the branch creation process would definitely be improved by
your suggestion.

But as the company's unofficial git admin, I get new git users coming
to me frequently for help and the single most frequent new user
mistake is that the users don't know that they need to create a local
branch in the first place.  They assume a clone really means cloning
and that all the branches from upstream have been created locally on a
clone.  The bash users don't even realize they're creating a branch
when the run "git checkout myNewBranch" - they think they're checking
out an existing branch.  The gui users don't have that shortcut
currently; they can only checkout existing local branches or remote
branches as a detached head.  I'm trying to point out here that in
this (single) use case its actually easier to use the command line
than the gui.

Granted, an argument can made that the new users should know what
they're doing before they dive into things like an SCM.  While in
general I agree, there's also something to be said for making things
easier when it does not impact functionality.  For example, git-cola's
Branch Checkout UI allows you to type in the name of a tracked branch
that doesn't exist yet locally.  If you type in "origin/myBranch" you
get a detached head.  If you type in "myBranch", cola will create the
local branch off of origin/myBranch (as you and I would expect).  Of
course, this cola UI can still be improved too - it doesn't show you
that potential branch in the checkout dropdown list, requiring you to
type it in.  And to make matters worse, if you type it in wrong the
branch checkout silently fails and you stay in your starting branch.
But that isn't your problem.

So I'm not a fan of Option C, where the user is still forced to use
Branch Create.  So what do you think of Option D?

=46or both the GUI and the command line, during Git Clone operation,
after the existing process completes, the clone action also creates
each remote branch locally.  This bypasses all the problems above, and
has the added benefit of making a clone operation more clone-like
(i.e. it makes the local repository exactly like the upstream
repository).  The starting local branch can still use the upstream's
"default branch" setting.  I've never understood why git didn't do
this since its just adding a pointer to a commit (for each branch).
Is it an attempt to prune the old branch clutter when a repo is cloned
from another repo that is itself cloned (i.e. to remove unused
branches from the grandfather repo)?

Option D has the downside that it changes the behavior of more code
(cmdline and gui), which is why I didn't suggest it before.  It also
has the downside of making the branch list longer.  But that's the
nature of cloning; if I copy a full directory of files to a new
directory I expect to get a full set of files.  If I plan on only
using a small subset of files its up to me to remove them after I've
copied them (I'm assuming that I don't know what files/branches I want
beforehand, which is why I'm copying everything).

Sorry if I overloaded your monitor with all these characters, I'm
trying to anticipate responses.  Thanks for your time,


John Medema
Systems Administrator
United Drugs, a Subsidiary of AAP (American Associated Pharmacies)
john.medema@uniteddrugs.com
7243 N 16th Street, Phoenix, AZ 85020
Office:  602-678-1179 x126
=46ax:  602-639-4631


On Thu, Sep 3, 2015 at 9:42 PM, David Aguilar <davvid@gmail.com> wrote:
> On Thu, Sep 03, 2015 at 10:08:24AM -0700, John Medema wrote:
>> Git gurus, throw this one on your to-do list:
>>
>> This is a feature request to enhance the Git GUI to make it easier t=
o
>> checkout non-existing branches that exist upstream. Apologies if thi=
s
>> is not the correct place for feature requests.
>>
>> Scenario: Upstream repo has 4 branches - master, develop, maint, tes=
t.
>> Local repo has only a master branch. In the command line, to switch =
to
>> a local copy of the test branch, it is a simple "git checkout test".
>> The git command automatically realizes your requested branch doesn't
>> exist but origin does have a branch named test, so it a) creates a
>> local branch off of origin/develop, b) sets the appropriate pull lin=
k,
>> and c) sets the appropriate push link. In effect, the git command li=
ne
>> hides the fact that the user doesn't know the branch doesn't exist a=
nd
>> creates it as the user was expecting it to exist as. The Git GUI has
>> no shortcut like this.
>>
>> For reference, from the man page for git-checkout:
>> "If <branch> is not found but there does exist a tracking branch in
>> exactly one remote (call it <remote>) with a matching name, treat as
>> equivalent to "git checkout -b <branch> --track <remote>/<branch>".
>>
>> Currently, in order to checkout a non-existing branch in the GUI you
>> must go to the Branch Menu, click Create, select the "Tracking Branc=
h"
>> radio, select the branch, then go back up and name the branch the
>> exact same name (to ease new user confusion). For a new user who jus=
t
>> wants a copy of the remote branch, it is very unintuitive to create =
a
>> new branch.
>>
>> Fortunately, you already have some explicit warning messages after t=
he
>> Checkout Branch screen if the user intuitively tries to checkout the
>> tracking branch, but even then a new user rarely realizes what they
>> have gotten themselves into. At best, they know that they must find
>> help (just for trying to checkout a branch).
>>
>> In order to implement this feature effectively, I suggest that the
>> Checkout Branch screen be modified in one of two ways (exclusive):
>>
>> Option A:
>> Merge the Local and Tracking Branch lists into one box keeping their
>> entries separate by their full name ("master" and "origin/master"). =
If
>> a user selects a remote branch, ask the user whether to create the
>> local branch or move to the detached HEAD state (current
>> functionality).
>>
>> Option B (preferred):
>> Keep the Local and Tracking Branch lists separate (as they are now),
>> and keep the Tracking Branch list as-is. However, on the Local Branc=
h
>> screen, select include the existing branches in normal font but also
>> include potential local branches based off of the remote in italics
>> (or greyed-out, or asterisked, etc). Selecting an italicized entry
>> creates the new branch from the tracking branch, without user
>> interaction.
>
> How about Option C?
>
> What git-cola[1] has done for the longest time is when the
> remote branch is selected it strips of the remote part and
> automatically fills in the name field with that.  e.g. it fills
> in "todo" when "origin/todo" is selected.
>
> Mixing remote branches with pseudo-branches in the UI would
> complicate it, so that seems like it could be made simpler.
> Italics, asterisks, those are all signs that they shouldn't
> be displayed next to each other.
>
> I think the UI is fine as-is.  If it were just tweaked to
> automatically fill in that field, like git-cola does, then it
> can stay simple and make this use case easier.
>
> If you're looking for other interesting usability things that
> could be improved about git-gui, take a look at the
> keyboard-driven user interface features in git-cola.  It's
> optimized for keyboard-centric use.
>
> [1] https://github.com/git-cola/git-cola
> --
> David

--=20
HIPAA NOTICE:  It is against United Drugs=E2=80=99 policy to receive or=
 send=20
un-encrypted or non-secured email correspondence containing Protected=20
Health Information (PHI) as defined by HIPAA law.
=20
Please use fax or phone for correspondence containing PHI.

--=20
This email message is for the sole use of the intended recipient(s) and=
 may=20
contain confidential and privileged information. Any unauthorized revie=
w,=20
use, disclosure or distribution is prohibited. If you are not the inten=
ded=20
recipient, contact the sender by reply email, and destroy all copies of=
 the=20
original message.=20

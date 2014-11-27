From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Our cumbersome mailing list workflow
Date: Thu, 27 Nov 2014 18:46:15 +0100
Message-ID: <54776367.1010104@web.de>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>	<1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>	<546F4B5B.2060508@alum.mit.edu> <xmqq61e81ljq.fsf@gitster.dls.corp.google.com> <5473CD28.5020405@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 27 18:46:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xu39J-0007Hr-Kn
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 18:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbaK0RqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 12:46:25 -0500
Received: from mout.web.de ([212.227.15.4]:51492 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbaK0RqY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 12:46:24 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Mcnuz-1Xc6cX3luD-00HudQ; Thu, 27 Nov 2014 18:46:21
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <5473CD28.5020405@alum.mit.edu>
X-Provags-ID: V03:K0:YH61WJSxnepT2D5rK9TSoFKDXO8OJD+cfFayZlpmzEjVyfwGtCR
 zzLOPA9awWN7fuf8AXbAY6xf43YAy64RjleEtbsAGu9hjEAE7uW+oi02rz+MXiTL/uJt4X8
 BkITSWNzV7btMX5GOClncXukJUzXiQ1MkUi6LuL7lGydztEeyMTslIRundmlWlt/g7sDpDU
 6CdxOHc/x2KuqVC6sLP2w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260349>

On 2014-11-25 01.28, Michael Haggerty wrote:
[]
> Let me list the aspects of our mailing list workflow that I find
> cumbersome as a contributor and reviewer:
> 
> * Submitting patches to the mailing list is an ordeal of configuring
> format-patch and send-email and getting everything just right, using
> instructions that depend on the local environment.
Typically everything fits into ~/.gitconfig,
which can be carried around on a USB-Stick.
Is there any details which I miss, or howtows we can improve ?
> We saw that hardly
> any GSoC applicants were able to get it right on their first attempt.
> Submitting a patch series should be as simple as "git push".
> 
> * Once patches are submitted, there is no assurance that you (Junio)
> will apply them to your tree at the same point that the submitter
> developed and tested them.
> 
> * The branch name that you choose for a patch series is not easily
> derivable from the patches as they appeared in the mailing list. Trying
> to figure out whether/where the patches exist in your tree is a largely
> manual task. The reverse mapping, from in-tree commit to the email where
> it was proposed, is even more difficult to infer.
> 
> * Your tree has no indication of which version of a patch series (v1,
> v2, etc) is currently applied.

> 
> The previous three points combine to make it awkward to get patches into
> my local repository to review or test. There are two alternatives, both
> cumbersome and imprecise:
> 
>   * I do "git fetch gitster", then try to figure out whether the branch
> I'm interested in is present, what its name is, and whether the version
> in your tree is the latest version, then "git checkout xy/foobar".
There are 12 branches from mh/, so it should be possible to find the name,
und run git log gitster/xy/fix_this_bug or so.
Even more important, this branch is the "single point of truth", because
this branch may be merged eventually, and nothing else.
> 
>   * Or I save the emails to a temporary directory (awkward because, Oh
> Horror, I use Thunderbird and not mutt as email client), hope that I've
> guessed the right place to apply them, run "git am", and later try to
> remember to clean up the temporary directory.
Is there a "mutt howto" somewhere?
> 
> * Once I've done that, the "supplemental" comments from the emails (the
> cover letter and the text under the "---") are nowhere available in the
> Git repository. So if I want to see the changes in context plus the
> supplemental comments, I have to jump back and forth between email
> client and Git repo. Plus I have to jump around the rest of the email
> thread to see what comments other reviewers have already made about the
> series.
> 
> * Following patch series across iterations is also awkward. To compare
> two versions, I have to first get both patch series into my repo, which
> involves digging through the ML history to find older versions, followed
> by the "git am" steps. Often submitters are nice enough to put links to
> previous versions of their patch series in their cover letters, but the
> links are to a web-based email archive, from which it is even more
> awkward to grab and apply patches. So in practice I then go back to my
> email client and search my local archive for my copy of the same email
> that was referenced in the archive, and apply the patch from there.
> Finding comments about old versions of a patch series is nearly as much
> work.
In short:
We can ask every contributor, if the patch send to the mailing list
is available on a public Git-repo, and what the branch name is,
like _V2.. Does this makes sense ?

As an alternative, you can save the branches locally, after running
git-am once, just keep the branch.
[]

> 
> I did enjoy the variety of reviewing some patch series using Gerrit. It
> is nice that it tracks the evolution of a patch from version to version,
> and that the comments made on all versions of a patch are summarized in
> a single place. This makes it easier to avoid commenting on issues that
> other reviewers have already noted and easier to check that your own
> comments have been addressed by later versions of the patch. On the
> other hand, Gerrit seems strongly focused on individual patches rather
> than on patch series (which might not match our workflow so well), the
> UI is overwhelming (though I think one could get quite productive with
> it if one used it every day), and the notification emails come in blizzards.
> 
> Michael
> 
> [1] Disclaimer: I work for GitHub.
> 
I like Gerrit as well.
But it is less efficient to use, a WEB browser is slower (often), and
you need to use the mouse...
However, if you put your patches on Gerrit, and add the link in your cover-letter,
it may be worth a trial.

But there is another thing:
Once a patch is send out, I would ask the sender to wait and collect comments
at least 24 hours before sending a V2.
We all living in different time zones, so please let the world spin once.

My feeling is that a patch > 5 commits should have
a waiting time > 5 days, otherwise I start reviewing V1, then V2 comes,
then V3 before I am finished with V1. That is not ideal.

What does it cost to push your branch to a public repo and
include that information in the email ?

And how feasable/nice/useful is it to ask contributers for a wait
time between re-rolling ?
 

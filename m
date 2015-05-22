From: Stefan Beller <sbeller@google.com>
Subject: Re: [Announce] submitGit for patch submission (was "Diffing submodule
 does not yield complete logs")
Date: Fri, 22 May 2015 09:53:26 -0700
Message-ID: <CAGZ79kbeATbzSGHd5ub-NphB8=hxKfzv40Z1HucsC_EtEotv2Q@mail.gmail.com>
References: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Robert Dailey <rcdailey.lists@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	emma@gitforteams.com
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 18:53:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvqCT-0001vo-I2
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 18:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946021AbbEVQx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 12:53:28 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:32775 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945995AbbEVQx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 12:53:27 -0400
Received: by qgfa63 with SMTP id a63so11746767qgf.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 09:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=E3T0Uwl85oRUvWmCYY3GdygF4mhJs3aX84MNxST3zK8=;
        b=n2oqloZ8zuftme0XHDUBBcfdPBpZ6gL+CothhjmRIPfgWthmMD1QSbpDtdfsPogxcN
         CT6Ed2eQmsN/sqhHF48zLcfSxahMiXwI8BpuHy7n1enw+PBnGQKVdxbWitJDDOAMrrlC
         kvUw5NJOFpLECM8o6D+uMHKBKwdVYTsqIicaeVlPeSNpx7OmzAGVmJse1jI/LRCHmcew
         m80rLGpdbJVY4y0uu11XmEvquN2QMSZfHcVcyt5QIVLL9dqBcbWCipuBrNDMcAsdHZDG
         VX7qNmjhOaujiiciCuMyesn/KXOBagkXbPy/7us9kjMXxNT40Elvu9qOurED5p8ZyMr1
         5pFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=E3T0Uwl85oRUvWmCYY3GdygF4mhJs3aX84MNxST3zK8=;
        b=f8G7zkHm4F2PKZuuXhJL1cInpZEi3Yb9e13JSBhzD/GF5osJ5geme+ce7tI3fdXp4v
         /zndxLt1g44UFuzUjCSWKpVJUcYct89GykM4X8043Z/sTyDbFLoaIbJdVTno2KL3TtfH
         zbcf/fWWg7a43xhQTnZATP0MU8jVMlFtQwOcj03x/er9F/NBTsdgqCC/wZFvWmFNx2Lp
         3f4/AZPhnK8s9l0ppjKANXuVHDB3CtQ7rk631RAFXDWCPyNhTCqX2e7PqkiIPYC/iINl
         Zflt4tkp9mbBiMO1sSNTpSdv68ZVN5JoLoUPBLF446zorQglHeBHl2H/RpCLR8h7NgIc
         pH1A==
X-Gm-Message-State: ALoCoQnuy7rvZYQQfsgWOW+VzUv/GuXx1UqsGMvvaSZkgOz9H5EghpoQ7kkgIeXdmEysjNBSQAHM
X-Received: by 10.140.89.200 with SMTP id v66mr11916161qgd.50.1432313606523;
 Fri, 22 May 2015 09:53:26 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Fri, 22 May 2015 09:53:26 -0700 (PDT)
In-Reply-To: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269736>

On Fri, May 22, 2015 at 1:33 AM, Roberto Tyley <roberto.tyley@gmail.com> wrote:
> On Tuesday, 19 May 2015, Stefan Beller <sbeller@google.com> wrote:
>> On Tue, May 19, 2015 at 12:29 PM, Robert Dailey
>> <rcdailey.lists@gmail.com> wrote:
>> > How do you send your patches inline?
> [snip]
>> This workflow discussion was a topic at the GitMerge2015 conference,
>> and there are essentially 2 groups, those who know how to send email
>> and those who complain about it. A solution was agreed on by nearly all
>> of the contributors. It would be awesome to have a git-to-email proxy,
>> such that you could do a git push <proxy> master:refs/for/mailinglist
>> and this proxy would convert the push into sending patch series to the
>> mailing list. It could even convert the following discussion back into
>> comments (on Github?) but as a first step we'd want to try out a one
>> way proxy.
>>
>> Unfortunately nobody stepped up to actually do the work, yet :(
>
>
> Hello, I'm stepping up to do that work :) Or at least, I'm implementing a
> one-way GitHub PR -> Mailing list tool, called submitGit:

Cool!
I will try that with the next patch I want to submit.

>
> https://submitgit.herokuapp.com/
>
> Here's what a user does:
>
> * create a PR on https://github.com/git/git

When looking at https://github.com/git/git

    Git Source Code Mirror - This is a publish-only repository and all
    pull requests are ignored. Please follow Documentation/SubmittingPatches
    procedure for any of your improvements.

Once this tool has proven to be usable (in a few days?), we want to reword that.

    Guidelines for submitting patches to Git. Half this document covers how
    to send a patch via email without it getting corrupted - which submitGit
    will do for you - but the other half is very useful, giving guidance on what
    good patches for the Git project should look like.

If it turns out this tool is widely used we may want to consider splitting up
SubmittingPatches inside git.git into two files, one dealing with the contents
i.e. How to write good, reviewable commits, following the coding guide lines
and having a proper sign off, and another document on how to get your
contributions
upstream (email, pull request, ...)

> * logs into https://submitgit.herokuapp.com/ with GitHub auth
> * selects their PR on https://submitgit.herokuapp.com/git/git/pulls
> * gets submitGit to email the PR as patches to themselves, in order to
> check it looks ok
> * when they're ready, get submitGit to send it to the mailing list on
> their behalf
>
> All discussion of the patch *stays* on the mailing list - I'm not
> attempting to change
> anything about the Git community process, other than make it easier
> for a wider group
> people to submit patches to the list.
>
> For hard-core contributors to Git, I'd imagine that git format-patch &
> send-email
> remain the fastest way to do their work. But those tools are _unfamiliar to the
> majority of Git users_ - so submitGit aims to cater to those users, because they
> definitely have valuable contributions to make, which would be tragic
> to throw away.
>
> I've been working on submitGit in my spare time for the past few
> weeks, and there
> are still features I plan to add (like guiding the user to more
> 'correct' word wrapping,
> sign-off, etc), but given this discussion, I wanted to chime in and
> let people know
> what's here so far. It would be great if people could take the time to
> explore the tool
> (you don't have to raise a git/git PR in order to try sending one *to
> yourself*, for
> instance) and give feedback on list, or in GitHub issues:
>
> https://github.com/rtyley/submitgit/issues
>
> I've been lucky enough to discuss the ideas around submitGit with a
> few people at
> the Git-Merge conf, so thanks to Peff, Thomas Ferris Nicolaisen, and Emma Jane
> Hogbin Westby for listening to me (not to imply their endorsement of
> what I've done,
> just thanks for talking about it!).

Wow!
Thanks for doing this,
Stefan

>
> Roberto

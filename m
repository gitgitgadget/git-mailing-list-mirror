From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 08:00:13 +0530
Message-ID: <535DBD35.4080507@gmail.com>
References: <535C47BF.2070805@game-point.net>	<CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>	<535D4085.4040707@game-point.net> <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>,
	Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 04:30:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WebKt-0004JP-4z
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 04:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbaD1CaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 22:30:22 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:49989 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746AbaD1CaU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 22:30:20 -0400
Received: by mail-pd0-f179.google.com with SMTP id y10so203107pdj.24
        for <git@vger.kernel.org>; Sun, 27 Apr 2014 19:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=QpKOpTCJ+Y03rwDbL2k4c9tjAYSX3kFMtXCshv8YDm4=;
        b=GhA9KM4Mtai4UOjgMNFBCDpQRn8ha57Mv/YX3uAL/r3ZuTek+IFTk0LqERGvN7Ba3g
         8QX8cSW97MBmsCviN2QVRN8T66Rp5u2ayS0hAtn3oV+WEDXUe4UBPhW/5dUrgJ7WhGQL
         RH/rVbCPv78qdkJtN+whWpy3f/AWQjGYXdFoc1J9F1JYeyFshB8kZb3Ld4WHZbwwvHIR
         7ZN7xSy25eStuODKoE/p86NkIn4LrYUQlFbeAOUwy93Kz8WJT038tG6ans9V+sX6G9nV
         m0IxDAOrqb/38Ou1qkIJGvDLW5YnQxsnPTfckcwS3BDssT5EmcQcww6A0wsJaCNTRYbc
         5Z0w==
X-Received: by 10.69.17.230 with SMTP id gh6mr26254175pbd.0.1398652219642;
        Sun, 27 Apr 2014 19:30:19 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.216.215.162])
        by mx.google.com with ESMTPSA id ja8sm31312804pbd.3.2014.04.27.19.30.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Apr 2014 19:30:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247232>

On 04/28/2014 01:03 AM, Johan Herland wrote:
> On Sun, Apr 27, 2014 at 7:38 PM, Jeremy Morton <admin@game-point.net> wrote:
>> On 27/04/2014 10:09, Johan Herland wrote:
>>> On Sun, Apr 27, 2014 at 1:56 AM, Jeremy Morton<admin@game-point.net>
>>> wrote:
>>>> Currently, git records a checksum, author, commit date/time, and commit
>>>> message with every commit (as get be seen from 'git log').  I think it
>>>> would
>>>> be useful if, along with the Author and Date, git recorded the name of
>>>> the
>>>> current branch on each commit.
>>>
>>> This has been discussed multiple times in the past. One example here:
>>> http://thread.gmane.org/gmane.comp.version-control.git/229422
>>>
>>> I believe the current conclusion (if any) is that encoding such
>>> information as a _structural_ part of the commit object is not useful.
>>> See the old thread(s) for the actual pro/con arguments.
>>
>> As far as I can tell from that discussion, the general opposition to
>> encoding the branch name as a structural part of the commit object is that,
>> for some people's workflows, it would be unhelpful and/or misleading. Well
>> fair enough then - why don't we make it a setting that is off by default,
>> and can easily be switched on?  That way the people for whom tagging the
>> branch name would be useful have a very easy way to switch it on.
>
> Obviously, the feature would necessarily have to be optional, simply
> because Git would have to keep understanding the old commit object
> format for a LONG time (probably indefinitely), and there's nothing
> you can do to prevent others from creating old-style commit objects.
>
> Which brings us to another big con at this point: The cost of changing
> the commit object format. One can argue for or against a new commit
> object format, but the simple truth at this point is that changing the
> structure of the commit object is expensive. Even if we were all in
> agreement about the change (and so far we are not), there are multiple
> Git implementations (libgit2, jgit, dulwich, etc.) that would all have
> to learn the new commit object, not to mention that bumping
> core.repositoryformatversion would probably make your git repo
> incompatible with a huge number of existing deployments for the
> foreseeable future.
>
> Therefore, the most pragmatic and constructive thing to do at this
> point, is IMHO to work within the confines of the existing commit
> object structure. I actually believe using commit message trailers
> like "Made-on-branch: frotz" in addition to some helpful
> infrastructure (hooks, templates, git-interpret-trailers, etc.) should
> get you pretty much exactly what you want. And if this feature turns
> out to be extremely useful for a lot of users, we can certainly
> consider changing the commit object format in the future.
>
>> I know
>> that for the workflows I personally have used in the past, such tagging
>> would be very useful.  Quite often I have been looking through the Git log
>> and wondered what feature a commit was "part of", because I have feature
>> branches.  Just knowing that branch name would be really useful, but the
>> branch has since been deleted... and in the case of a ff-merge (which I
>> thought was recommended in Git if possible), the branch name is completely
>> gone.
>
> True. The branch name is - for better or worse - simply not considered
> very important by Git, and a Git commit is simply not considered (by
> Git at least) to "be part of" or otherwise "belong to" any branch.
> Instead the commit history/graph is what Git considers important, and
> the branch names are really just more-or-less ephemeral pointers into
> that graph.
>
> AFAIK, recording the current branch name in commits was not considered
> to the worth including in Linus' original design, and since then it
> seems to only have come up a few times on the mailing list. This is
> quite central to Git's design, and changing it at this point should
> not be done lightly.
>
> IINM, Mercurial does this differently, so that may be a better fit for
> the workflows where keeping track of branch names is very important.
>
>>> That said, you are of course free to add this information to your own
>>> commit messages, by appending something like "Made-on-branch: frotz".
>>> In a company setting, you can even create a commit message template or
>>> (prepare-)commit-msg hook to have this line created automatically for
>>> you and your co-workers. You could even append such information
>>> retroactively to existing commits with "git notes". There is also the
>>> current interpret-trailers effort by Christian Couder [1] that should
>>> be useful in creating and managing such lines.
>>>
>>> [1]: http://thread.gmane.org/gmane.comp.version-control.git/245874
>>
>> Well I guess that's another way of doing it.  So, why aren't Author and Date
>> trailers?  They don't seem any more fundamental to me than branch name.  I
>> mean the only checkin information you really *need* is the checksum, and
>> commit's parents.  The Author and Date are just extra pieces of information
>> you might find useful sometimes, right?  A bit like some people might find
>> branch checkin name useful sometimes...?
>
> Yeah, sure. Author and Date (and Committer, for that matter) is just
> metadata, and the current branch name is simply just another kind of
> metadata. All of them are more-or-less free-form text fields, and off

no they're not.  In strictly controlled environments they form part of
the audit record for the source code.

Yes they can be faked (explicitly), but -- again in strictly controlled
environments -- that can be limited to "before it was first pushed".

From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 11/15] diff: ignore submodules excluded by groups
Date: Thu, 5 May 2016 15:50:54 -0700
Message-ID: <CAGZ79kYKbef7DTkmE3Vf3C=PLfgB3xf0ikVKHFUfQ8+KkgGHPg@mail.gmail.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-12-git-send-email-sbeller@google.com>
	<xmqqlh3wxnuq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaOXxqDEqVnf5K3QjXg5bfmKW2XkmPT-mqJ93+RF5N40g@mail.gmail.com>
	<CAGZ79ka37jWYDJrAWy5KLhaaJmrLRbmTzRC6A5DneuE63+XCeQ@mail.gmail.com>
	<xmqqy47o9s1h.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYGbjOKPQk8A-ag+JgvybW4Kf5=g8azVAOoMq79oXc5-Q@mail.gmail.com>
	<xmqqfutw9mfs.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 00:51:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayS6q-00035N-1X
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 00:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757822AbcEEWvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 18:51:00 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:33004 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757474AbcEEWu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 18:50:56 -0400
Received: by mail-io0-f172.google.com with SMTP id f89so99024591ioi.0
        for <git@vger.kernel.org>; Thu, 05 May 2016 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=AxNL6DUQabrF4NGlipIo7qgtcJ12nCVl/NQJn4Nab1Q=;
        b=M5v7dQXJRwpQ82+oYRTbfsk5+Hh2XKvoGS+syxJ79XRgCZc/f26tUiC/JhPtptZ6b/
         8AyT5oGAKP31a1PxySEkvfyHaxqu2Lw3fslUyewSp/P7LgqMxa4sBCL+0+jVfx0CaO6b
         Kbb5U/5Asrwg8II4JOdTuo79sv7Eg+GAKc5TIm+QnSaZ5cUuQsu2PBkVpfmrvB4323IU
         e1PXHadyo/aSvrugmipdp6SPz3mQ1vLmyPrdYQBmMd8g5zHEZXbYOHnIoONIU6kiB08G
         Dz/OZme+p3RFqmHRA0DlpsgwrjIuLHwEgJJMurEXJAX6XBSd3661eUPupeYwr7Psdbk6
         oa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=AxNL6DUQabrF4NGlipIo7qgtcJ12nCVl/NQJn4Nab1Q=;
        b=br5nfN2IEq0lXWmDpccJrg0oSTEpbpGCMw9YwnNAy5pqPR3pkKLzIo8AFkYqHoALDx
         gLzQSk0JjO79Kv7y3G/ipj4XFYaO6XNAitOLdvjva4mfTkQzxwzHiVMh05+YsdoLe+0s
         M/09v7aJZyuegkjdze76yL2Z27UGjb28WgLAMpRWY3D5B4niLOVqsgZGfFSLAFla0lIY
         6uF9IdHXzvG7X5BUJdAdOl/NA14IQZyLgH6rnO7/RQZ9LfsStmJBColYJDkhj2Mekv2o
         1GX6PNAzFIQTYUmr2NvYJ/oDv2LKnDvOPQrjlNiPlkripgEjTOZa964ERMsinISoAnUQ
         vokQ==
X-Gm-Message-State: AOPr4FXNlgjRj8PjytUYAf1dgNA8tGC/S7THYK7hH7zdsqGZrBN+7PlNDqWkglXNHnIUdNKXBfKBMaX/xLMU1zN1
X-Received: by 10.107.53.204 with SMTP id k73mr19829840ioo.174.1462488655057;
 Thu, 05 May 2016 15:50:55 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 5 May 2016 15:50:54 -0700 (PDT)
In-Reply-To: <xmqqfutw9mfs.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293719>

On Thu, May 5, 2016 at 3:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The first option is giving nothing:
>>
>>      git config submodule.defaultGroup "*SomeLabel"
>>      git -C submodule-not-labeled reset --hard HEAD^
>>      git status
>>      # all good, no report about  submodule-not-labeled
>>      # because it is not in the default group.
>>      # (This is implemented in the series)
>>
>> The "second option" is some sort of reporting. Either what I or you proposed.
>
> OK, although I didn't propose anything ;-).
>
>>
>>>
>>>>> If we want to go with the second option, the design described in 0/15
>>>>> is broken. Going one step further:
>>>>>
>>>>> ...
>>>>>     # But what about subC which is not in the default group? It was
>>>>> changed as well.
>>>
>>> So why not show it?  Is there anything controversial?
>>
>> The user made clear to not be interested in subC by setting
>> up the default group.
>
> I wonder if that is a valid argument.  Git's position has always
> been very clear after doing this:
>
>     git add -f foo.bin && echo \*.bin >>.gitignore
>
> What the user might have said in the "configuration" is the default
> suggestion, that is much weaker than what has been done to the
> repository data.  I think "the path is recorded in the index" in the
> ignore/exclude situation is similar to "the submodule is initialized
> in the working tree" in this context.
>
>> Well it can get out of sync by not touching it as well, because others
>> changed the submodule pointer who are interested in that though.
>
> Which "others" are mucking with your working tree?  (don't respond:
> I'll come to the answer a few lines below).
>
>>
>>     # in the superproject
>>     git checkout new-version
>>     git submodule update
>>     # checks out submodules to their version
>>
>>     git checkout some-ancient-version

I think here is when the conceptual bug happens.
We would want a

    git checkout --keep-submodules-to-pristine-default-group

(intentionally long bad name)
that option would init new submodules and deinit old submodules
which were clean before. Here we can compare it to a file,
i.e. after checkout some files are newly there, some are deleted.
(And that's totally expected)

If we had this `checkout --treat-submodules-as-files-for-defaultGroup`,
then the following command `git submodule update` would not be
required.

I think long term this is a far better approach.

I just wonder what the `checkout --recurse-submodules` should do when
there is no defaultGroup configured. (i.e. should that delete submodules
which were there before and delete them if they were clean? Just like files.)


>>     git submodule update
>>     # this would only update the submodules in the defaultGroup,
>>     # not those which are initialized but "uninteresting"
>>     # the labeling may have changed between the different versions
>
> I see.  I think that is where the conceptual bug lies.  Thanks for
> an illustration.

Yes.

>
> If we take an approach similar to ignore/exclude, then yes the
> "default" action should be done to "defaultGroup" specified plus
> what the user instantiated in the working tree already.  And that
> is not limited to "update" operation.
>
> Just like "git diff" is not the only thing that would show
> difference in foo.bin in the working tree even when *.bin is
> ignored, but we consistently treat foo.bin as tracked.
>
>> The state of a submodule (un-initialized, initialized, checked out)
>> doesn't change the index or anything. Only the working tree is affected.
>>
>> And by flipping between the initialized and checked-out state we do not
>> lose any information (such as user configured remote urls) nor does it
>> affect the "state" (index, recorded tree, history) of the repository.
>
> Users want to initialize a module and keep it checked out even if
> they do intend to keep it pristine and not making any changes
> themselves, only so that other parts of the tree that depends on the
> module can be built.

The `submodule init` command could learn to just add that path of the
extra submodule to the defaultGroup, such that it persists between
different checkouts.

> So "removing a tracked and unmodified thing
> from the working tree does not hurt users" is a nonsense argument,
> isn't it?  I would be very unhappy if "git status" removed pristine
> paths from the working tree and toggle assume-unchanged bit in my
> index automatically.

No, `checkout` did it for you. Assume we had a "defaultGroup for files",
(others call it "narrow clones")

    # in git.git
    git set-file-default-group Documentation/RelNotes
    git checkout v2.6.0

    ls Documentation/RelNotes |grep v2.7
    # no files! But this is uncontroversial as it's current behavior
    # even with fictional "files default group" set to "all files ever"

    ls builtin/
    # does it exist? No because set-file-default-group
    # did restrict out interest here.

>
> I am afraid you are focused too much on "version control" and losing
> sight of those who use the data stored in "version control", perhaps
> because you worked in submodule area too long and too hard?

Not sure what you mean here. (Neither did I work long nor hard in that area.)

I am aware that other operations such as a build system would be glad to
have the contents of the submodules there. But those would not use a
restrictive default group?

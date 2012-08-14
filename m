From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Your branch and 'origin/master' have diverged
Date: Tue, 14 Aug 2012 11:32:54 -0700
Message-ID: <CAE1pOi2DZNkYYwkH1MFh0m708T=DEdJawZCQgvk1HTGrqjkz2w@mail.gmail.com>
References: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
 <87zk5x6fox.fsf@thomas.inf.ethz.ch> <CAE1pOi1YFe9GB1L_==RTecEAipdTKj2-ixpwTnrmOgkkV8rkYw@mail.gmail.com>
 <7v628lbdcw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 20:33:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Lvf-0007fL-Jh
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 20:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757126Ab2HNSdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 14:33:18 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36726 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757055Ab2HNSdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 14:33:16 -0400
Received: by bkwj10 with SMTP id j10so251061bkw.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 11:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cIM8l6UqB0+eSUSSM79gw0y/GY1O1uoGTd4Y2YPIuf8=;
        b=ETXYC2S482hVnROKRd4uBX6xuq0eJ609pGusossvY5AlyIG4Ucsj/Il+6ixDoqHm6D
         WDNXFLmlO4cyufX/6nf8x9ITU4QR8CTJ/d5YaefP7LOhLpPvWC4nPuRG9KoBXGSWet2L
         GCWvNXAV8Dw1gpJqMnTgLgfCvk/Ds6DRoYoY9G0pVRjITFA08cDpmsbrN4qJhBL9pLwQ
         hgftL4+l8PO9lRnicrGMMMcH4H17I+oP5ikMGgwM2BdMNzy9J9Osx+FlaeIMdxW2o+CV
         Eqc9WzvaZn0PfDJ+7ouMmw2NbX1jmBBQ8ExNO+PQwfW8kcXw21KmJYPD0u7OlQKTWyMC
         khDg==
Received: by 10.204.155.146 with SMTP id s18mr6755065bkw.23.1344969195164;
 Tue, 14 Aug 2012 11:33:15 -0700 (PDT)
Received: by 10.204.132.72 with HTTP; Tue, 14 Aug 2012 11:32:54 -0700 (PDT)
In-Reply-To: <7v628lbdcw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203420>

On 14 August 2012 10:19, Junio C Hamano <gitster@pobox.com> wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>
>> On 14 August 2012 01:27, Thomas Rast <trast@student.ethz.ch> wrote:
>>> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>>>
>>>> # On branch master
>>>> # Your branch and 'origin/master' have diverged,
>>>> # and have 250 and 19 different commit(s) each, respectively.
>>>> #
>>>> nothing to commit (working directory clean)
>>>>
>>>> He asked me what to do and I told him to do what has always worked for
>>>> me in the past when something like this happened: gitk, "reset master
>>>> branch to here" (to a commit before the divergence and using --hard),
>>>> git pull origin master. Problem solved.
>>>
>>> There are several layers of pitfalls and misunderstandings here.
>>>
>>> * Is your work origin/master..master (that is, anything in master but
>>>   not origin/master) really so worthless as to make "scrap it all!" the
>>>   normal course of resolution?
>>
>> Of course, it's master. Nobody should be working on master directly.
>
> What a strange thing to say.  When will 'master' ever be updated
> then and how?

Well, yes, just before pushing, you'd work on master for a few
seconds. That doesn't really count. :-)

> If you mean 'master' as the integration branch for everybody to meet
> and make progress, it would be more common for everybody to be
> working on his own topic branch until perfection of the topic,
> concluded by merging the completed topic to master and pushing the
> master out to update it, no?

That's what I should have said. I assumed way too much context. I
don't think all neurons are firing yet. :-(

>>> * pull = fetch + merge!  Repeat this a few times until it sinks in.
>>>   Then print it on A0 and stick it up in your office or something.
>>
>> Yes, I know.
>>
>>>   For your case this means that the pull command is roughly equivalent
>>>   to
>>>
>>>     git fetch origin master
>>>     git merge FETCH_HEAD
>>>
>>>   The two-arg form of fetch does *not* update origin/master.  Assuming
>>>   you got the reset right, the merge will fast-forward to whatever
>>>   origin's master points to -- but origin/master is still the old state!
>>
>> Ah, now we're getting to something I did *not* know. :-) So FETCH_HEAD
>> != origin/master?
>>
>  I tried to find out more information about
>> FETCH_HEAD but there doesn't seem to be much. I have seen "FETCH_HEAD"
>> show up in the terminal but always just ignored it as a Git
>> implementation detail. When/how does origin/master get set then? I
>> always assumed that was part of git fetch and then git merge would
>> actually move master to origin/master.
>
> It could be "git fetch --help" is failing for you, but I am
> reasonably sure most if not all of the above are answered there;
> another thing something you may not have known :-).

I was actually looking at "git help merge" since "git help fetch"
would be a far too logical place for FETCH_HEAD information. ;-) As I
said, not all neurons seem to be firing yet.

Apparently, my understanding is mostly correct, though. FETCH_HEAD is
indeed origin/master (I mean the SHA1 in master's HEAD on origin) and
the "git merge" part of "git pull" eventually sets "my" origin/master.

>>> Taking all of this together, I think you should stop using two-arg
>>> pull[*] or fetch, and replace your error-prone recipe with simply
>>>
>>>   git fetch
>>>   git reset --hard origin/master
>>>
>>> Assuming, as before, that your local work is worthless.  Is it?
>>> Otherwise it would be better to run something like
>>>
>>>   git fetch
>>>   git rebase origin/master
>
> Yeah, the latter makes sense, and I think it is a safer superset of
> the former.  If there is nothing of value on 'master', the rebase
> might stop and give control back to the user, but the user can tell
> it to skip the cruft that came from the old 'master'.
>
>>> [*] it's ok if you use it with an URL instead of a remote nickname
>>
>> Why would that be okay? What is the difference? Isn't the nickname
>> just an alias for a URL?
>
> As long as you tell what refspecs to use on the command line, the
> remote nickname behaves as "just an alias for a URL", so yes,
> because Thomas is discussing "two-arg pull or fetch", one arg being
> either nickname or URL and the other is an explicit refspec on the
> command line, it would be okay because there is no difference in
> that case.

I suppose I'm not entirely clear on how this two step process is
"safer". Doing "git fetch" would seem to be harmless, right? So the
problem is with "git merge" but master should always be "behind"
origin/master so that "git merge" should just FF to origin/master
which *should* be completely safe. Does that make sense? Especially
given our use of master as an integration branch?

[Given the trouble I have with getting people to use Git properly, I
prefer things as simple as possible. :-) ]

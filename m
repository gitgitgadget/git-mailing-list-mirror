From: Stefan Beller <sbeller@google.com>
Subject: Re: An idea for the "Leftover Bits": rebase -x to imply -i
Date: Wed, 16 Mar 2016 16:18:10 -0700
Message-ID: <CAGZ79kZC0AAz=cm59ys1L_Axj1_HLvcTqrMrfNrOHoA3Ef7a5A@mail.gmail.com>
References: <CAGZ79kZg3QkfjB1hwZKRS9Hqg-1H=kQwuwByX_rAMzveXtnp7Q@mail.gmail.com>
	<xmqqy49i2hhe.fsf@gitster.mtv.corp.google.com>
	<xmqqlh5i2g0y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 00:18:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agKhk-0007Og-Uz
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 00:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935310AbcCPXSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 19:18:13 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:33845 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbcCPXSL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 19:18:11 -0400
Received: by mail-io0-f178.google.com with SMTP id m184so78587979iof.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 16:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=6OhJL4n8wV46yvV9Cdni4SysKVxrExWaLpM4v5yWT5I=;
        b=kPh0K2ZZq8/KQA69J9W4z9e0zUsHRwVA1xAd6DWdVbCe3aZ0Mf5OPWkk2A9mf10IKI
         xAOgOM3TOw022SII3RYUwGNZgZn3yUBKlloNQpMHHuHAJZLL9BfUaGd3MLZmMSrv8pdF
         9ymDlRFqBAzHF0ByBKR2QjvTz210G/frnVwGHuvid2UpjE6hi7FOY4/UbQfnth8GqNrT
         luRhIkgt8jJv6H3sZJa2/PEIJ9T6gLUHwG4/QPvM1yVY9Kbj+usm9+1AMEoBhePZGAn0
         d5ji3Kqe0+bmYBD9ZFNJeTNSPhcuP0oUzdyXEEsYY0+nUyqmtSSe+jREXkNxJQKLZzvs
         lS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=6OhJL4n8wV46yvV9Cdni4SysKVxrExWaLpM4v5yWT5I=;
        b=Yn/SjLKl2imgVR4gskmN31ViCZmwnQtvCn1Wf7vTqbuxUDBWpZpNoR1gOq5XrVqoad
         WJlFgBMXv1qzbOvkLxSexMhRLKbeR42NIKVzEE3yp6ZnN6rlVtC4BpofmWBtJ+EFGY+b
         C9Fspi7/S1uanQry49Z7c8DpurVnLtVUBwc477kkfmUc2KyScEHer5F+HpAPBB+NAE4Q
         XzdDKqNpNaI1nB7JL2aWEwsQjuvoXpupLyq5jTUs/m4HoACdTO/BBvEd0DIAciq+LrUG
         5O//pizPdVmUUFduejko5s2kZmFtQqMHQBaVdM16I1BfTkBHfMa1WF4SHmWU9GlJ/053
         pzCw==
X-Gm-Message-State: AD7BkJIZr1yniArAoN3G0ceFqGx3D59zLaeYE73jYhsq2YmIpDuvsLfwHF+7kH1iYH+HP3dro+VGJXUK0WfZHqZd
X-Received: by 10.107.135.96 with SMTP id j93mr6436775iod.96.1458170290542;
 Wed, 16 Mar 2016 16:18:10 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Wed, 16 Mar 2016 16:18:10 -0700 (PDT)
In-Reply-To: <xmqqlh5i2g0y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289059>

On Wed, Mar 16, 2016 at 3:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> The list is my personal collection of "leftover" things, i.e. topics
>> that were raised on the list, perhaps already discussed or perhaps
>> nobody thought them interesting, that I found when re-reading the
>> past list traffic that did not reach a useful conclusion to result
>> in a patch (or resolution, a shared understanding, that it is not a
>> good idea).  Getting added to the list should not be a goal.

Well it was my goal partially at least. I tripped over that behavior and found
it strange to error out instead of just implying the interactive mode.

So I thought I had found a small wart in the UI, which can easily be fixed.
But I had no intention to fix it myself as I do not intent to trip over that
behavior again. This may be a good beginner project similar
to the GSoC micro projects which are partially taken from the left
over bits, so my mental shortcut was to get it added such that it
comes up again next year as micro project.

Now that you proposed the code (and me having rewritten
the tests, I only need to find a convincing commit message), I
can take ownership of this issue.

>>
>> Your message is perhaps the least effective way to add an item to
>> the list.  It hasn't been discussed here, nobody seems to have felt
>> it is a good idea, and I didn't think it is particularly interesting
>> myself (at least not yet).

I did not find it interesting for *me* as well (I don't need that problem
solved by tonight nor tomorrow); It is just a nice beginners project,
and your leftover bits are the only collection for general Git that I
know of. Other people may have private notes somewhere, but
I am too messy and chaotic to have these notes in a year when
we'd need this potential idea.

>
> Having said that, I could use help in maintaining the collection.
>
> A few "characteristics" of that list, that cannot be updated by
> anybody but me (because it is just my personal collection after all)
> are:
>
>  * I do not have to worry about useless new entries that do not
>    align the overall system design getting added by clueless people.

As it is your personall collection and you're the maintainer, I thought
of this as a collection with maintainers blessing, i.e. if the code&tests
are not too shoddy a patch will get accepted (read as: On that list there
are no bullet points with fundamental design issues). Why would you
add things to that list if you'd not agree with them?

>
>  * Adding new entry after scanning past list traffic and finding a
>    still unresolved topic that "died down" is relatively easy.

As the notes in Documentation/howto/maintain-git.txt indicate, you're
scanning the list anyway, so offering help in this point may be moot.

>
>  * Removing existing entries because the topic was revived on the
>    list and completed is _hard_, as that is merely an administrative
>    overhead to me.

This may be solved by having this list as part of git.git in an ideas/
directory. The closer the reported issue is to the actual code, the higher
the chances that they are kept in sync, I'd assume. This is similar to
the discussion we had about a year ago, where to document methods.
(Documentation/technical vs in header files). Another example would
be the NEEDSWORK comments which are best kept as close to the
offending code as well.

>
> Moving it to a public wiki would lose the first point, which is a
> benefit.

I would have assumed this is the opposite, i.e. By having a public
wiki, you cannot assume any idea is valid and thoughtful. You would
need a lot more reasoning, why an idea is good and lots of text may
make that wiki unclear. A potential contributor would need to filter through
a lot of (outdated) text.

>
> Merely making it public does not guarantee that the third point
> (i.e. clean-up) would happen more easily unless we have volunteers.
> It is likely that the "leftover bits" list would go stale just like
> other people's wikis or bug trackers.

I see. By having ownership, you offer a certain quality of that list
as your name is attached to it.

>
> On the other hand, if we do have volunteers who are scanning for
> "stale" items in the "leftover bits" list to tell me "that item was
> done with commit c0ffee1eaf" and that would help me quite a bit
> without being it a public wiki/bug tracker.

Ok, that is an actionable item I can follow up on. I'll try to check that list
regularly pointing out stale entrees.

Thanks for the explanation/thoughts,
Stefan

>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

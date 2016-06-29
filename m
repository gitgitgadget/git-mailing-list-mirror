Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877C820FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 21:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbcF2VA4 (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 17:00:56 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:37897 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbcF2VAz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 17:00:55 -0400
Received: by mail-it0-f43.google.com with SMTP id h190so54001447ith.1
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 14:00:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Sihzs+Hi5o/SamkYV6NjG+lvrt60JORcW15DePB9AXE=;
        b=NwEPwMAKH4bV0AfVYTIW5VNu9MbWI63trvjW2WC1tgEg5xF1VCMZc/A/N7vmkT659n
         WIyRFNU394r5lnJC5LO1tj9uRxRlmGBl28LOjl7epBeoMxNoxPjtz6Ds6wDur/loTu1t
         dtEBVm62uZ0UHY4fOlGLDwcrtiMTD+LbZu0c4PBweke2lXarxlecFPfjXRQMPy0cpiak
         S9qsOhw2NblgXo0Iw3mV3y3OVXqabO0dLfoUxUh8nanIYubCI9EUgr+zpfotC3H4jw7o
         e7uSMfPumDxQ7SWygtfFBOcyOvXT1jc1/labXRLufq1hGlS03oA1tO6OGl7rRE+Y84j3
         kiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Sihzs+Hi5o/SamkYV6NjG+lvrt60JORcW15DePB9AXE=;
        b=i/f/seYwNQhGauSoVTmAwPk8V/9ZLEb9KxDgxngJJGBKrWRY+QVmt3lD2Sc4tfd41V
         5os35zUpt2Bxrdtms5Z32lESunoueA95y7V1ipVvtyyjb60UmdsUhXv3takhNcJ8EPqh
         U4hHdE9WGvrAp4JwA2tomCUbQG293LO4ig2OCjrq3PQ/l3qyzFrp2aUZ1c8O+ksEGrrp
         0TpJSf4A+EnZ8PExTRnVOQPp2/XhrIgTyyJGjshIttFJ+SNenVHx1fkiLx2AfBnHKTcV
         olSZ9vCLib4Pquh52XBFkoe44MAkMEZ9uLZbE09Ire1nDnKSgBBhRtj/OGDx477ri1co
         w5fg==
X-Gm-Message-State: ALyK8tKI2G7ayXZfLolT6CrRohtSftWjGc2NWOYxUI+CfjDKidfeFf3OzAVXS8mDV4nCJuKGMsRplEo2Ygno47If
X-Received: by 10.36.254.195 with SMTP id w186mr11519362ith.49.1467233641950;
 Wed, 29 Jun 2016 13:54:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Wed, 29 Jun 2016 13:54:01 -0700 (PDT)
In-Reply-To: <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com> <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 29 Jun 2016 13:54:01 -0700
Message-ID: <CAGZ79kZNnbrKFaKGchZ0r5wKCs7pz4RcyYq=0rnD5qSd8XDKXw@mail.gmail.com>
Subject: Re: topological index field for commit objects
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 1:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Wed, Jun 29, 2016 at 11:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> On Wed, Jun 29, 2016 at 11:31 AM, Marc Strapetz
>>> <marc.strapetz@syntevo.com> wrote:
>>>> This is no RFE but rather recurring thoughts whenever I'm working with
>>>> commit graphs: a topological index attribute for commit objects would be
>>>> incredible useful. By "topological index" I mean a simple integer for which
>>>> following condition holds true:
>>>
>>> Look for "generation numbers" in the list archive, perhaps?
>>
>> Thanks for the pointer to the interesting discussions.
>>
>> In http://www.spinics.net/lists/git/msg161363.html
>> Linus wrote in a discussion with Jeff:
>>
>>> Right now, we do *have* a "generation number". It's just that it's
>>> very easy to corrupt even by mistake. It's called "committer date". We
>>> could improve on it.
>>
>> Would it make sense to refuse creating commits that have a commit date
>> prior to its parents commit date (except when the user gives a
>> `--dammit-I-know-I-break-a-wildy-used-heuristic`)?
>
> I think that has also been discussed in the past.

I should have guessed that and tried to find it.

> I do not think it
> would help very much in practice, as projects already have up to 10
> years (and the ones migrated from CVS, even more) worth of commits
> they cannot rewrite that may record incorrect committer dates.

Chances are that the 10 years of history may be correct time wise as long
as people don't introduce a bad date malevolently.

> You'd need something like "you can trust committer dates that are
> newer that this date" per project

and git version as old versions of git can still be used later.

> to switch between slow path and
> fast path, with an updated fsck that knows how to compute that
> number after you pulled from somebody who used that overriding
> option.

Well you could have a project setting (`config.sortedDates`)
that is automatically computed once when cloning a project and
depending on that setting you can go the fast path.

Additionally when that setting is set, you'd enforce the correct
dates in committing and merging (read pulling) to carry it on to
be true.

>
> If the use of generation number can somehow be limited narrowly, we
> may be able to incrementally introduce it only for new commits, but
> I haven't thought things through, so let me do so aloud here ;-)

I think of it as "committer date == generation number", i.e. just a
special form of noting the generation number with gaps in between.
This loses the ability to know how many commits there are at maximum
between 2 given "numbers" though, which I think is minor.

>
> Suppose we use it only for this purpose:
>
>  * When we have two commits, C1 and C2, with generation numbers G1
>    and G2, we can say "C1 cannot possibly be an ancestor of C2" if
>    G1 > G2.  We cannot say anything else based on generation
>    numbers (or lack thereof).
>
> then I think we could just say "A newly created commit must record
> generation number G that is larger than generation numbers of its
> parent commits; ignore parents that lack generation number for the
> purpose of this sentence".
>
> I am not sure if that limited use is all that useful, though.

I did *not* propose to introduce the generation number, but
rather meant:
* we already have committer date
* it works pretty well
* only a tiny patch is required to tighten the heuristic to work even better
  (going forward) by avoiding accidents in the history that have
  a committer date earlier than their parents.
* we postpone drastic changes (i.e. introduction of generation
  numbers or change of algorithms) for now.

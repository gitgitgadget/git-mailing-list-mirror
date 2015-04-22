From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] RFC/Add documentation for version protocol 2
Date: Wed, 22 Apr 2015 12:43:20 -0700
Message-ID: <CAGZ79kZN9nBrJ_7skrSQ4kor+p=DM8RnSC2bFZ6TX=SxdMdqcA@mail.gmail.com>
References: <1429658342-5295-1-git-send-email-sbeller@google.com>
	<xmqqd22wdl88.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Martin Fick <mfick@codeaurora.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:43:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0YW-0005XW-VT
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758206AbbDVTn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 15:43:27 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35205 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758039AbbDVTnV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 15:43:21 -0400
Received: by igbyr2 with SMTP id yr2so6246914igb.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 12:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uX1hYLfzwBJSQ8elS0zJ3gm9C/hF7w9ztvZbFDoxCWk=;
        b=CHxwlBRYGC+QCmjTZ9oRsB0Vave+WUMY7bjQqL6ZpGVyU8sSXPhp+6ML8F+5vVy6/f
         6Lwp+QTQOExA8nNCfpDCUbMrj/zsUzHrHGpyrN//KNCbsxZFeseRMmhH+4GIvJUrpqg6
         dB3EDrjcb2q3AQeWM5+fQ4SFpEyigAgYjbYhY2nnjpdOYMh0klApTWIEuBNDMyQTaOwT
         cyQ40N3AVvg3fH5bdYZFf/a+T0sMpZNgYCjtMJOgy0+TRzNzacgLO8y4AhJIMXBvnvU+
         68kyagG/0ekALf1xTX/TbopykBKZvF18k0U0IrYk+g0xEwXnBlM04RMPSKQ+o1UppxYi
         stjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=uX1hYLfzwBJSQ8elS0zJ3gm9C/hF7w9ztvZbFDoxCWk=;
        b=OkEcsaMMrerO6PPJBs/XRFpX2AsS1uZoLQk2TXzXWCwdf2H4xrUXFxL+W4LNMeHPK5
         tWiN/6BLVNbL2rsn1UqvPyn8ZMTmyEcsmB2VQFrBTTN+ov+nHdUK35+BMnigFspfvQqh
         C8GC/cZU1tkucODTL+Vm37ftdCprcqQwtZxVF4E3FA6kXJ7NW53ng4nD++lYeYGccspo
         ihDnWzdFmq99eMuEUEEDJhZQYGzYUxTzjNHp6leAI0l1HT77acEZ9NMPSI/2YpffdYVd
         e68ZTHbLLpm5Zw/sBnOsCi2bAToy2BmSa3WsAn22LH/B64C4fxu0Qgdywf0rttJe4Hbq
         pQMw==
X-Gm-Message-State: ALoCoQnQq4q3w+MLxU0WFczk8MKeuUi6StjSlDdJYwfjAVSnfi9W2uwv7La3Cn4yi0ZcdksK4MAL
X-Received: by 10.107.132.223 with SMTP id o92mr39392719ioi.49.1429731800894;
 Wed, 22 Apr 2015 12:43:20 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Wed, 22 Apr 2015 12:43:20 -0700 (PDT)
In-Reply-To: <xmqqd22wdl88.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267623>

On Wed, Apr 22, 2015 at 12:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This adds the design document for protocol version 2.
>> It's better to rewrite the design document instead of trying to
>> squash it into the existing pack-protocol.txt and then differentiating
>> between version 1 and 2 all the time.
>
> Just a handful of random thoughts, without expressing agreement or
> objection at this point.
>
>> diff --git a/Documentation/technical/pack-protocol-2.txt
>
> I wonder, if we are really revamping, if we want this to be limited
> to "pack" protocol (see more below).
>
>> +General structure
>> +=================
>> +
>> +There are four phases involved in the protocol, which are described below:
>> +
>> +1) capability negotiation
>> +2) goal annoncement
>> +3) reference advertisement
>> +4) pack transfer
>> +
>> +
>> +1) Capability negotiation
>> +-------------------------
>> +
>> +In this phase both client and server send their capabilities to the other side
>> +using the following protocol:
>> +
>> +---
>> +list-of-capabilities = *capability flush-pkt
>> +capability           =  PKT-LINE(1*(LC_ALPHA / DIGIT / "-" / "_"))
>> +----
>> +
>> +The capabilities itself are described in protocol-capabilities.txt
>> +Sending the capabilities to the other side MAY happen concurrently or
>> +one after another. There is no order who sends first.
>
> Doesn't that set us up for an easy deadlock (i.e. both sides fill
> their outgoing pipe because they are not listening)?

I did not think of it that way, but rather was focused on wall clock
time spent waiting for the protocol to be finished. And then we want to have
as much concurrent as possible. I don't know if we ever want to touch threads
in git.

>
>> +2) Goal annoncement
>> +-------------------
>> +
>> +The goal of this phase is for the client to tell the server what
>> +outcome it expects from this communication, such as pushing or
>> +pulling data from the server.
>> +
>> +---
>> +list-of-goals    = *goal
>> +goal             = PKT-LINE(action-line)
>> +action-line      = action *(SP action-parameter)
>> +action           = "noop" / "ls-remote" / "fetch" / "push" / "fetch-shallow"
>
> This is interesting, in that it implies that you can connect to a
> service and after learning what is running on the other hand then
> decide you would be fetching or pushing.  Which is *never* be
> possible with v1 where you first connect to a specific service that
> knows how to handle "fetch".

I originally thought about it as an optimisation. Say you only want to do
a ls-remote, you don't need to start pack file creation (possibly in a
background thread?), but you know what is coming and don't need to
prepare for unknown things.

>
> If we are going in this "in-protocol message switches the service"
> route, we should also support "archive" as one of the actions, no?
> Yes, I know you named the document "pack-protocol" and "archive"
> does not give you packs, but "ls-remote" does not transfer pack data,
> either.

I'll add that. Also I need to incorporate shallow in one way or another.

>
> And when we add "archive" (and later "refer to bundle on CDN" to
> help initial clone), it would become clear that steps #3 and #4 are
> optional components that are shared by majority of the protocol
> users (i.e. fetch, push, ls-remote uses #3, fetch, push uses #4.),
> and other services that also use the protocol need their own
> equivalents for steps #3 and #4.

That is my thinking as well, #3 and following are completely dependent
on the action we negotiated. Just thinking about that we could do that
also with the current protocol by invoking not just {receive, upload}-pack
but any other program on the server side.

>
> Of course, we do not have to do it this way and stick to "one 'goal'
> per service is pre-arranged before the protocol exchange happens,
> either via git-daemon or ssh shell command line interactiosn" way of
> doing things we have always done in v1 protocol.
>
> I have to wonder what role, if any, should "git daemon" (and its
> equivalent, "the shell command line", if the transport is over ssh)
> play in this new world order.

So I guess you can still use a daemon to fetch from, and by now
you could also do the authentication with git daemon (with push
certificates)

What I did not talk about in the proposal is the receiving end point.
So I think there may be a git-protocol-2 binary similar to
git-{receive, upload}-pack which you then invoke via ssh?

>
> Note again that I am not objecting. I am trying to fathom the
> ramifications of what you wrote here.

Thanks for pointing out ramifications I did not think of yet!
What this new protocol is all about is the future flexibility,
so I think it is good to have lots of possibilities available.

(So for example with having 2 "goals" as above inside one
protocol exchange, you could also do a partially narrow/shallow
clone. So shallow for the whole repository, but deepened for
a narrow directory you're really interested in. I am not saying
this comes live in the near future, but it is possible to implement
using this protocol and still have a good compression with the
packfile format as of now?)

My biggest concern is to get the phase 1 somewhat right this time
(an exchange which doesn't grow as large as the current refs
advertisement but still has enough information to be able to change
the protocol 2 years down the road without this upgrade pain of old
and new programs talking to each other, still working without a failure).

Thanks for any input!
Stefan

>
>> +3) Ref advertisement
>> +--------------------
>> +3) and 4) are highly dependant on the mode for fetch and push. As currently
>> +only mode "version1" is supported, the these phases follow the ref advertisement
>> +in pack protocol version 1 without capabilities on the first line of the refs.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31A0C1FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 16:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbdFGQxO (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 12:53:14 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35094 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbdFGQxM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 12:53:12 -0400
Received: by mail-pf0-f177.google.com with SMTP id l89so7644739pfi.2
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jfsicvDcHXd23rhDUTPK3dWf6XuvGFtJ1LLRtE/UEXY=;
        b=GmjcLMP3jcpw9JbvjXJ4jhggt/1OvwSaGo6bDr1+a5wASdaAIKW2a3lCarQp0xEAQ+
         EVveLUcisRuHE3oeWwYOarSPyBAbDO+4snKbB84awwNh3fdbwiediC1/lwYhaJN2gg/f
         nR2MFr7wGvy7FT31Qd5VYK9kBKmsPBaXCUbt7nib9NkHx1YG0SQ2U4FzuMS+3ecmoGCK
         TcCh/E4GQ7jrJQxtLO077DnIr16dXgCn4pEwtn3CbfeaXHb5XAWDTp3mUHXuEqExZUDE
         Av762SRv3hHu6npz6ZYuP1cUqwn/3l3GZ+A7Hv2lhRHzuiTZfSdSY6TwzdpmYODfmBTH
         x59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jfsicvDcHXd23rhDUTPK3dWf6XuvGFtJ1LLRtE/UEXY=;
        b=ZUA2vmcNopRYinmp0mSh5KjT55gnOyCVV/yxBhyn7sWS3ZwOKjSpupucbgxhQqOF+v
         3fEEpaV81ta5vxZnO7u7QTk2zFukCv3Zlnolm12xNJkIn5YJZAdvhrV2EyZaoAND2Mrw
         sTBnK2IQPMn/bAWED/BHA3aac1z+T3AZ9nRoDIan8Z9UiDZ8ZEIR+9nSybf28DtiUzcK
         SOxBunsOU8Em3xn7YxCT9b3g2uMJ+PFrJ0Ebkr3GNnokSfBFVvychzNcjd06F25NV0va
         FaEr+RMiJpWlpHAl1ENKMwPybkZc1kLyf0wyBSTzZQP5Yrey/iVgtU0YD6jBb/m20+y9
         oj4A==
X-Gm-Message-State: AODbwcBlGaU21jf7QRlurZntVnEWajJuOxCPqe17X905tFbpUwLlbPvK
        6EutMQzAAdUx5eRCT/pNGdH8Rh06JcmW
X-Received: by 10.98.63.10 with SMTP id m10mr21795072pfa.19.1496854391829;
 Wed, 07 Jun 2017 09:53:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Wed, 7 Jun 2017 09:53:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1706071520280.171564@virtualbox>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170531104213.16944-3-phillip.wood@talktalk.net> <alpine.DEB.2.21.1.1706011329350.3610@virtualbox>
 <xmqq7f0v46q3.fsf@gitster.mtv.corp.google.com> <CAGZ79kaM9ryT1gWx=L6S90HPCaDPNZ6H124HAJscpeJCQFDN8Q@mail.gmail.com>
 <alpine.DEB.2.21.1.1706021442190.171564@virtualbox> <20170602175455.GA30988@aiede.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1706070008440.171564@virtualbox> <CAGZ79kaYMR9uB0G911yRPXeZjbCeef2LHz4J2FLDOEj+mYkmqQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1706071520280.171564@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 7 Jun 2017 09:53:11 -0700
Message-ID: <CAGZ79ka5VnfvidpsWCe5py6uW2Yp0y9gHfdZt+aZSdyfEi8Fsg@mail.gmail.com>
Subject: Re: pushing for a new hash, was Re: [PATCH 2/3] rebase: Add tests for
 console output
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 7, 2017 at 7:47 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On Tue, 6 Jun 2017, Stefan Beller wrote:
>
>> On Tue, Jun 6, 2017 at 3:22 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > 3) the only person who could make that call is Junio
>>
>> Occasionally I think the same, but in fact it is not true.
>
> Again my poor English skillz make sure I get misunderstood. So bear with
> me, please, and let me try again.

I don't think it is a language thing, but a matter of perspective.

>
> The current What's cooking mails are full of stuff other than the
> transition from SHA-1 to a new function.

True, but there is also

    * bw/object-id (2017-06-05) 33 commits
    ...

     Conversion from uchar[20] to struct object_id continues.

     Will merge to 'next'.


>  In fact, every once in a while I
> see brian carlson's patch series with the remark "Needs review" while
> other patch series get reviewed even by Junio.

So are you trying to impose priorities on what Junio has to review?
(It sounds like so, but maybe you are just stating an observation,
and a conclusion with an actionable item comes next)

Sometimes I disagree with what Junio does and in which order, too.
But he has more experience in how to guide a successful community,
so I respect what he does even if I would have done it differently (such
as a different order).

>
> In my mind, this sends a message.

In the simplest form the message could be understood as a call for help
to review the patches Brian sent.

And the fact that YOU are not reviewing the patches, tells me that
you have more important things to do, such as running a fork of Git.

In my perception the conversion is picking up speed. It used to be Brian
who decided to start this years ago as a one-man show, but now we
have multiple people working on it
* Brian sending out more patches, as more review happens:
https://public-inbox.org/git/5973919a-e282-a02e-9b04-d313c77e250d@google.co=
m/
https://public-inbox.org/git/20170509221322.GA106700@google.com/
* Brandon picking up one part of the conversion series (mentioned before, s=
ee
current cooking email)
* A potential migration plan has been made
  "Git hash function transition" (https://goo.gl/gh2Mzc).
  See the note atop the document "Note: this draft is somewhat out
  of date and is being reworked (in particular to use a different hash
function).
  See public-inbox.org/git for more current discussion."
* There are not a lot of patches, which do not have written
  "SHA1 CONVERISON" all over their face. (This one has, I made it last nigh=
t
  as a one off response to this thread:
https://public-inbox.org/git/20170607021805.11849-1-sbeller@google.com/)

>
> If, hypothetically, a couple of What's cooking mails would have in their
> header some language to the extent that we need to focus on transitioning
> away from SHA-1,  and maybe even have the promise that Junio would not
> review other patch series as long as there are patches to review that
> prepare the tests for the transition, that convert more 20 and 40
> constants, that convert more users to object_ids (and maybe strongly
> encourage to coordinate with brian so as not to trip over each others'
> toes), to implement a command to convert a SHA-1 based repository to a
> repository based on a different hash, to implement caching of legacy SHA-=
1
> <=3D> new hash mapping, then that would send a wholly different message.

That message sent there would be "Junio thinks the SHA1 conversion is
the most important thing now, so he does the work (the work a maintainer
does to guide the project)".

You could send the same message "Johannes thinks the SHA1 conversion
is the most important thing and do the work (Johannes being a well respecte=
d
contributor would send patches, and that would attract a lot of
reviews for sure.
-- I don't mean this snarky, please don't read any snark in this.)

> And in my mind, if anybody else than Junio sent this message, it would
> sound ludicrous.

Yes I have seen a couple of these messages (unrelated topics).
"Git should do X. Git should not do Y. k, thx bye!" and I ignored them,
because these one-offs do not convince me to invest my own time
in it to produce a reasonable ROI.

If there are patches attached, it is not ludicrous any more as the "proof
of work done" shows that the voice raised is more than just hot talk, but
actual a genuine interest in moving things towards the right direction.

Another big one: "Move Git away from global state all over the place".
If you think about all subsystems, it may even reach the order of
magnitude to the sha1 conversion, but the way the message was sent
it did not seem ludicrous to me:
https://public-inbox.org/git/20170530171217.GB2798@google.com/

Or the other big project "Protocol v2, that scales and serves large
repos well (number of refs, large binary files omitted, refs in wants
and so on)" took a different approach, and mostly discussed design
(I recall emails both from Microsoft as well as Google discussing the
design, most of them having RFC patches attached, such that it very
much looked like "proof of work done, so it is not ludicrous")

> For example, if I sent a mail to that extent, I would
> find it ridiculous myself, in particular since I am a very unprolific
> reviewer, and the promise to focus on favoring reviews of SHA-1 transitio=
n
> related patches would sound very unsincere from somebody like me.

If you were to actually follow through after such an announcement,
and in fact review the sha1 conversion patches thoroughly and in a timely
manner, I would think such a call up front would be well received.

I thought about doing that myself, but I dread my future commitment.
Specifically as my $DAY_JOBs wants me to work on submodules
instead of the sha1 conversion. ("Submodules are more important
than the SHA1 conversion [for me] ", if I were to trust the infinite wisdom
of our management process. )


>
>> As said above, Junio has strong veto power for things going off rails,
>> but in his role as a maintainer he does not coordinate people. (He
>> occasionally asks them to coordinate between themselves, though)
>
> I never had in mind that Junio would coordinate people or distribute
> tasks.

Coordinate is a strong word here. Most recent observed examples:
https://public-inbox.org/git/xmqq60gpfvqj.fsf@gitster.mtv.corp.google.com/
(My patch series conflicted with =C3=86vars series, so we had to figure
out how to fix it)

https://public-inbox.org/git/20170602182215.GA57260@google.com/
(Aforementioned object id conversion series having merge conflicts)

Note that this is only about coordination "You should talk to person Y
so we can figure out how to make these 2 patches work well together,
not about distributing tasks, as in "You must do X".

> Instead, I had in mind that a certain time period could be called out as
> focusing on that pretty important direction.

As remarked in an earlier email, if such a thing is called out, I would ver=
y
much prefer it in the next quarter, as then I can convince my manager to
have more time following such a goal. Otherwise *I* would ignore it.
The community at large may be different and jump on it like crazy.

> That would be mostly symbolic, of course. And encouraging. In a positive
> way. With a direction.

So you want a project roadmap?

As hinted at before the best would be to lead a good example here
and show *your* roadmap such that others see how valuable of a tool
it is to have a roadmap in the open.

>> > 4) we still have the problem that there is no cryptography expert amon=
g
>> > those who in the Git project are listened to
>>
>> I can assure you that Jonathan listened to crypto experts. It just did
>> not happen on the mailing list, which is sad regarding openness and
>> transparency.
>
> True. Same goes for me, of course. I just felt pretty uncomfortable
> sharing the contents of my private conversation publicly, when I tried
> very hard to convince my conversation partner to join the discussion on
> this mailing list, and they refused.
>
> The gist of it was: SHA-256 should be preferred to SHA3-256 because we
> will soon have good hardware support (and performance is really, really
> important when you need to work on the largest Git repository on this
> planet). And if there is no consensus about that, BLAKE should be
> considered over other algorithms because it has been studied pretty well.

BLAKE is what we're currently leaning on. (we=3Dauthors of "Git hash functi=
on
transition"; Leaning in the sense: If nobody ever speaks up until all work =
is
done, we'd just go with that. As soon as someone comes up with any
reasonable argument either publicly or privately on why other hashes are
better, we're easily persuaded to go with that)

> Again my poor English skillz make sure I get misunderstood. So bear with
> me, please, and let me try again.

Same for me, if I misunderstood you please point out.

tl;dr: Discussions are nice, but someone has to do the actual work, too.

Thanks,
Stefan

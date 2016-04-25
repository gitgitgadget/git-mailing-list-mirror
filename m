From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 00/83] libify apply and use lib in am
Date: Mon, 25 Apr 2016 11:57:44 +0200
Message-ID: <CAP8UFD05Cpsms8Tf_VmMeemoerfMm0E8fUqL3o0n_9d1hu7VMg@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<CACsJy8AAQJhX+b1UUhVxC_vV_4r=XjDSbtDDd5MLkgwKri8dEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 11:57:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1audH4-0006Hr-9z
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 11:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104AbcDYJ5q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 05:57:46 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38650 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946AbcDYJ5p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 05:57:45 -0400
Received: by mail-wm0-f43.google.com with SMTP id u206so118256447wme.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 02:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=mwL7swrKmno/4YTQVx4Ij+7slCuuE7ZSmwYzJw/smtg=;
        b=yGEpDTY9csc2iCPsTsUnbJRcY2h/I6pTZvOJoNmzxgA5RC9jw3Y2D2UzjZEUEyhxIn
         YTHv3J+VSJfOvnDld8EYUzqBmE8vvhsNKk1cs/L8LSF9NtVp//VKwaRlyxeg7VmS7o9n
         Wxi1B0ELQS1zVs9mYVA3apwmVSE3YIcHL6UENfUfc3ZcHKedyuOPC7+4n6Locsvd2lFq
         54d1bLNsoMg1NAkG6kl+1e7DhsSUZx/kLUFfYA3RzF9HnPJygxNFVqiGeqRXR74yDy82
         5fkxDMih6FBZS8JZS7BEodGJhm/lAWx1oUXuo4BTIHMfhMFeCj9NPfRM6m0lRPzYrZej
         kPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=mwL7swrKmno/4YTQVx4Ij+7slCuuE7ZSmwYzJw/smtg=;
        b=O86SCFpp/AyS8alufNShYFeVAR+N4Ak0fRMubpr3ZfKtHixRESO2iGCbPxxYwHagmr
         bM8bQrgkJyebKMDu4T/C54Eu9t4n8a/dMhcDhfRkMWJ5jq3DbHIT2kR7zaNsVY8oaSd/
         uX5t3erglsJuZG3tL/V5o2XaXSwnr9NvQfSGeNwhr3SIpC6SeRxsbRh/jSSMm5LXIM65
         CNnlyRKNxGWSE1TpVZ7BDxlRk+7+UnXCFfdGjob0AyKdqgIDwEDl4EDZs0vwPhRQRcs+
         4cWVbP8MXjGPlaUmANztQknEu2auNbOjkJAryw1JBBUiFS6WuBRKjeelbxR5K2luDpLR
         PUwg==
X-Gm-Message-State: AOPr4FVDtCvz0AVoIg2LgQDdgSle3u+BmLPd84l5nFY7DwHSnb4plR249UxA6FDF+L1dTO79BvPVGK8t7NqGpA==
X-Received: by 10.194.235.39 with SMTP id uj7mr32973376wjc.78.1461578264215;
 Mon, 25 Apr 2016 02:57:44 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Mon, 25 Apr 2016 02:57:44 -0700 (PDT)
In-Reply-To: <CACsJy8AAQJhX+b1UUhVxC_vV_4r=XjDSbtDDd5MLkgwKri8dEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292464>

On Mon, Apr 25, 2016 at 11:02 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Apr 24, 2016 at 8:33 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Sorry if this patch series is a bit long. I can split it into two or
>> more series if it is prefered.
>
> I suspect you deliberately made the series long just to show off how
> good new git-rebase is ;-)

Yeah, and `git am` too :-)

>> Performance numbers:
>>
>>   - A few days ago =C3=86var did a huge many-hundred commit rebase o=
n the
>>     kernel with untracked cache.
>>
>> command: git rebase --onto 1993b17 52bef0c 29dde7c
>>
>> Vanilla "next" without split index:                1m54.953s
>> Vanilla "next" with split index:                   1m22.476s
>> This series on top of "next" without split index:  1m12.034s
>> This series on top of "next" with split index:     0m15.678s
>
> I was a bit puzzled why split-index helped so much. It shouldn't have
> in my opinion unless you paired it with index-helper, to cut down bot=
h
> read and write time. So I ran some tests. Long story short, I think w=
e
> can achieve this gain (and a little more) even without split-index.

Yeah, perhaps. For now though =C3=86var and myself would be happy to ju=
st
have a config option for split-index :-)

The other performance numbers I mentioned show that now the `git am`
part of a 13 commit long rebase is reduced from 58% to 19% of the
whole rebase time. So further improvements in speeding up `git am`
could only make such a rebase at most 19% faster.

> I ran my measurement patch [1] with and without your series used this
> series as rebase material. Without the series, the picture is not so
> surprising. We run git-apply 80+ times, each consists of this sequenc=
e
>
> read index
> write index (cache tree updates only)
> read index again
> optionally initialize name hash (when new entries are added, I guess)
> read packed-refs
> write index
>
> With this series, we run a single git-apply which does
>
> read index (and sharedindex too if in split-index mode)
> initialize name hash
> write index 80+ times
>
> This explains why I guessed it wrong: when you write only, not read
> back, of course index-helper is not required. And with split-index yo=
u
> only write as many entries as you touch (which is usually a small
> number compared to worktree's size), so writing 80+ times with
> split-index is a lot faster than write 80+ times with whole index.

Yeah, I tried to explain in the cover letter and in the last patch why
this series enables split-index to give great results, but I think you
are much better at explaining it.

> But why write so many times when nobody reads it? We only need to
> write before git-apply exits,

You mean `git am` here I think.

> either after successfully applying the
> whole series, or after it stops at conflicts, and maybe even at die()
> and SIGINT. Yes if git-apply segfaults,

Here too.

> then the index update is lost,
> but in such a case, it's usually a good idea to restart fresh anyway.
> When you only write index once (or twice) it won't matter if
> split-index is used.

Yeah I agree, but it would need further work, that can be done after
this series is merged.
And I am not sure if the potential gains on a typical rebase would be w=
orth it.

Thanks,
Christian.

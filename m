From: Jason Paller-Rzepka <jasonpr@google.com>
Subject: Re: Multiple fetches when unshallowing a shallow clone
Date: Mon, 7 Dec 2015 14:57:55 -0500
Message-ID: <CACs8u9TvUKiPN9Brgym_zDea+_-MWWP9r4wZDa_qib6QxJ6YcA@mail.gmail.com>
References: <CACs8u9STLLHr3c3O9kQKGEN52DLfJ2LatjWkeaeeLA-xP=gC5Q@mail.gmail.com>
	<CAGZ79ka=RxVZ49D0wkqTRqspKb=Ce5Ay01muBt_Gk6_rDbH6KA@mail.gmail.com>
	<20151204212712.GA22493@sigill.intra.peff.net>
	<CACs8u9Qvqn4KDMKo+RHsQaf+dw+CGtWrOpoUJzaZAqD1rFRiuw@mail.gmail.com>
	<20151204215158.GA27987@sigill.intra.peff.net>
	<xmqqh9jxrfy5.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BSNm6=E6Mo6etv_Lvdd2kpqQ7EEMBAoP-AQraYy3xU8w@mail.gmail.com>
	<xmqqmvtons4j.fsf@gitster.mtv.corp.google.com>
	<20151206063718.GA549@sigill.intra.peff.net>
	<20151206070144.GA17902@sigill.intra.peff.net>
	<CACsJy8DA2Xg9bRmudsRgwy9k=BCawTRU=7bm+rEXv2KoZgoXJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 20:58:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a61v7-0006Dp-BV
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 20:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbbLGT55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 14:57:57 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35128 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932359AbbLGT54 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 14:57:56 -0500
Received: by igl9 with SMTP id 9so81714851igl.0
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 11:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RhF3qfJJj3A3vWtAGliYyQvYR/nESR/F6b7HmhhiMIo=;
        b=cgjCjp02mFZYgZDFPLOd5x6P4gyxPquBBcR1jlaVPQlDhD+Dznn0OzezqLn+wfropr
         c6faOzcnTwO5RiURps5IwKuuXAbT+TLw5/qxj0ban5DyjqVOjtX9MHtzNp5ic6konNK5
         v1p+evpTPXT2RpDwKkQZiwUsymBPWwukbo+i5o0Riq0y1P8C2+N4TB/fa31UfkkMmk1z
         AmEEAsUWCL66S8LXIjQlnMDtew+2uVfUemgztaDv+c8QuSLnlPVic4b5kFFc9wBPcXsw
         DCWN06hFlx1KB8naqMHH17iWW3q83dSsa0lHC95ODDyNnlkonG2g2hQ9QwyZLZMuCEYA
         On3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=RhF3qfJJj3A3vWtAGliYyQvYR/nESR/F6b7HmhhiMIo=;
        b=VIxIRf2DtVsv6gdNYTBRjYaWXf+AMFBMJvCKrq4UZdN7r/aHNi2Dt9OJCUnYdtJbDq
         JlseyxoasTO15VVaNkHVS42f/fte21P4gwhs/IjwzjJ4f2W8vNkA6hDlXHTbdl6pOz/b
         xwnbPH8cj3IqQxIU4R/U9xGSEaoEReIPeMJLi48JXypykAIEkCAi3a9AVlLyQp9EAFRQ
         bXD8HQ7ZUmjqtc3ULJ4hyM9v26E7/IfMc0/2PDYWafmd99CcFNCktFZOEjfGz+sL5erc
         NEEcnn+tIPUkBbH0qez4hxyD57VScehaFHqDBK2hzIf0OqygL0tOdaFvz1HG751yS0Ml
         tYtQ==
X-Gm-Message-State: ALoCoQlaLAA6bb/qHzSF/JOQc2htl2Zu4xSBdVkSJje3Gpz4As8+UgURXtZwqv27o1ToG3dT/+zB1Bc6pSyTZ5xj/D4NLH4HxAKz6N/7kcLflXoazGiE20E=
X-Received: by 10.50.164.131 with SMTP id yq3mr11121261igb.74.1449518275820;
 Mon, 07 Dec 2015 11:57:55 -0800 (PST)
Received: by 10.36.19.74 with HTTP; Mon, 7 Dec 2015 11:57:55 -0800 (PST)
In-Reply-To: <CACsJy8DA2Xg9bRmudsRgwy9k=BCawTRU=7bm+rEXv2KoZgoXJw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282113>

I should point out that I never saw a "deepen 0" line.  Rather, I saw
git send "option depth 0" to the remote helper.
Duy, you mentioned that depth=0 means "do not change depth".  I assume
that means the server should use exactly the shallows that the client
sent, and it does not need to traverse the tree or modify the shallow
or unshallow sets at all.  Right?
Duy, you also mentioned that "those lines should be rejected any way".
You just mean that a "deepen 0" line should be rejected, right? And
that's because the right way to tell git-upload-pack not to change the
depth is to omit the "deepen" line after the "shallow" lines, so
there's never a need to send "deepen 0"?

Thanks!

On Sun, Dec 6, 2015 at 5:46 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Dec 6, 2015 at 8:01 AM, Jeff King <peff@peff.net> wrote:
>> On Sun, Dec 06, 2015 at 01:37:18AM -0500, Jeff King wrote:
>>
>>> And indeed, replacing the logic with what I wrote does make the backfill
>>> go away in my test case. But it's so far from what is there that I feel
>>> like I must be missing something.
>>
>> I think one thing I was missing is that we need to just grab the
>> _object_, but we need to realize that the ref needs updating[1]. So we
>> cannot skip backfill of any tag that we do not already have, even if we
>> already have the tag object.
>
> It's probably worth adding a few comment lines about this. I did
> search back commit history but did not get this.
>
>> Which made me wonder why this:
>>
>>   git init parent &&
>>   git -C parent commit --allow-empty -m one &&
>>   git clone parent child &&
>>   git -C parent commit --allow-empty -m two &&
>>   git -C parent tag -m mytag foo &&
>>   git -C parent commit --allow-empty -m three &&
>>   git -C child fetch
>>
>> does not appear to need to backfill to pick up refs/tags/foo. But it
>> does. It's just that it hits the quickfetch() code path and does not
>> have to ask the other side for a pack. And that explains why it does hit
>> in the --shallow case: we explicitly disable quickfetch in such cases.
>>
>> For the unshallow case, of course we could use it (but only for the
>> second, backfill fetch). Something like this seems to work for me:
>>
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index ed84963..b33b90f 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -881,6 +881,8 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
>>
>>         transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
>>         transport_set_option(transport, TRANS_OPT_DEPTH, "0");
>> +       if (unshallow)
>> +               depth = NULL;
>>         fetch_refs(transport, ref_map);
>>
>>         if (gsecondary) {
>>
>> But I admit I am not at all confident that it doesn't cause other
>> problems, or that it covers all cases. Even in a shallow repo, we should
>> be able to quickfetch individual tags, shouldn't we?
>
> Yes. depth is only non-NULL when you pass --depth (or --unshallow).
> quickfetch should happen when you fetch without those options.
>
>> I wonder if we could just always set "depth = NULL" here.
>
> --unshallow is essentially --depth=<max>, so I don't see why
> --unshallow should be singled out here. We probably want to restore
> depth back (or pass a flag to explicitly ignore the "depth" exception
> in quickfetch). For multiple fetches, we spawn new commands so depth
> being NULL does not harm. Just in case somebody tries to fetch a
> couple more times in the same process in future.
> --
> Duy

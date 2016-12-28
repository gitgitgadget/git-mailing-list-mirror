Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2491920441
	for <e@80x24.org>; Wed, 28 Dec 2016 19:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbcL1TYZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 14:24:25 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:32972 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbcL1TYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 14:24:25 -0500
Received: by mail-qt0-f170.google.com with SMTP id p16so354279635qta.0
        for <git@vger.kernel.org>; Wed, 28 Dec 2016 11:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RJodXi3mYE8o5ZYZi9JjAIHR6g2NT154zR+0tEu7tMU=;
        b=hd7hnAlhWoFyike+EU0/EeJTv9T7DOp9KV3xWqN5QfnqjTdi4CiH6oBe0vu41PhY0n
         S4f/Q9bGIpUByDXUuWlLZyMsISnwqrI4a8zO8V+A3A2fCgpuhPsG0xlsyyf8gpAtYCNA
         IooMtaEeAff/YWrCiF7V57IygBfwfP5G6z6lHK8ldv5SceThwvWdtlGdacIpqddnGek2
         31PScuJMr6qnjMKLOt83u3plTSe93LtqRbqOFmYr9zCO+eegk5cKbHPSqRZ9ps3JKVoP
         1RNq9fixsn/fSA4KYNiy8t0YiYs3ue37MM33eJJIkKYAgOkuOIAF0NETaA9drgjTZKRj
         yDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RJodXi3mYE8o5ZYZi9JjAIHR6g2NT154zR+0tEu7tMU=;
        b=lrzQw3w+YbbN4Y4BIW5RS1pQsozvqbIEwgvBg0ACJ+fBsxGPnA3WHJePP0od1oFHHw
         BRvwr/e0i8jl6t+HhNWPok6XiNpqQBH4WSdNK1WJaVKlG+/LBuQ3BjNSfh12CHMQoMFg
         0SyGQoaPuhEl1V0z6dCVz/UArjjfnhKrGjiXKAOV4OnTGp84NsDfAak6be3V2x3yizZF
         rfJJGDL6fZEqvI8XcdvFG23KZoNHe5cLffyWTzEIl3EIzGPdNgak/iCvUK4MpJtNa+DS
         Yyyo7pVW+y/PhjZV98b7b4KUrMdYwVMiOqkmHvSwkVKmLxUmPkyPcA3VTJSX8FgyrpH0
         f8qw==
X-Gm-Message-State: AIkVDXK5owGhrO4AXHU0N2C0LVCpYjbhO0oor5tt8dFtLeOHbFiubk3n6gLS57aWe8iW0hOGC0yEZXmoiU6SRR5i
X-Received: by 10.200.50.147 with SMTP id z19mr30463731qta.207.1482953053853;
 Wed, 28 Dec 2016 11:24:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Wed, 28 Dec 2016 11:24:13 -0800 (PST)
In-Reply-To: <20161228191928.GH3441@thinpad.lan.raisama.net>
References: <20161228183501.15068-1-ehabkost@redhat.com> <CAGZ79kaBpC5ym2N_fMZHDmL4gGpU8pFAsupCE4aTdENh+=z72g@mail.gmail.com>
 <20161228191142.GF3441@thinpad.lan.raisama.net> <20161228191928.GH3441@thinpad.lan.raisama.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Dec 2016 11:24:13 -0800
Message-ID: <CAGZ79kaNd2EAjRC=U3_mXB2Deo4oBcUfBHWXPSDfa-vUtBogkg@mail.gmail.com>
Subject: Re: [PATCH v2] am: add am.signoff add config variable
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Tan <pyokagan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2016 at 11:19 AM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Wed, Dec 28, 2016 at 05:11:42PM -0200, Eduardo Habkost wrote:
>> On Wed, Dec 28, 2016 at 10:51:28AM -0800, Stefan Beller wrote:
>> > On Wed, Dec 28, 2016 at 10:35 AM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> [...]
>> > > +       test $(git cat-file commit HEAD | grep -c "Signed-off-by:") -eq 0
>> >
>> > and then we check if the top most commit has zero occurrences
>> > for lines grepped for sign off. That certainly works, but took me a
>> > while to understand (TIL about -c in grep :).
>> >
>> > Another way that to write this check, that Git regulars may be more used to is:
>> >
>> >     git cat-file commit HEAD | grep "Signed-off-by:" >actual
>> >     test_must_be_empty actual
>>
>> test_must_be_empty is what I was looking for. But if I do this:
>>
>> test_expect_success '--no-signoff overrides am.signoff' '
>>       rm -fr .git/rebase-apply &&
>>       git reset --hard first &&
>>       test_config am.signoff true &&
>>       git am --no-signoff <patch2 &&
>>       printf "%s\n" "$signoff" >expected &&
>>       git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
>>       test_cmp expected actual &&
>>       git cat-file commit HEAD | grep "Signed-off-by:" >actual &&
>>       test_must_be_empty actual
>> '
>>
>> The test fails because the second "grep" command returns a
>> non-zero exit code. Any suggestions to avoid that problem in a
>> more idiomatic way?
>
> I just found out that "test_must_fail grep ..." is a common
> idiom, so what about:

Uh, no please.

test_must_fail is supposed to be used for commands to be tested, i.e.
git commands as this is the git test suite. :)
test_must_fail checks, e.g. that the failing command "properly" fails
instead of bye-bye-segfault. And grep would never do this. (In this
world we assume everything to be perfect except git itself)

For grep just use !

    git cat-file commit HEAD >actual &&
    ! grep "Signed-off-by:" actual

$ git grep "test_must_fail grep" returns 20 occurrences, so in case you're
that would be a good cleanup patch (if you're interested in such things).

Thanks,
Stefan

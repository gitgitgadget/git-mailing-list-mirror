Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FF8C1F404
	for <e@80x24.org>; Thu, 12 Apr 2018 12:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbeDLMTZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 08:19:25 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36836 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeDLMTY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 08:19:24 -0400
Received: by mail-ot0-f195.google.com with SMTP id n40-v6so5727284otd.3
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 05:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J5dV0f6LdIIksmidnpm2dVV3FYFryt9ZSboAqy5m4Cw=;
        b=AvC+egMx2CFDrDhjaBqzg7UVkna0+ECBDqGGYc44QAI3DCFENoVq+f8/jh34cQVatf
         oJUcDwfHVvlMmaSu0b3LikBdYSJA8DoPItA00JI5uZ/WaV7wL4HtYAcX/0aZMujJNfGy
         Y5VRFrx9D0070rlbxcSJ9Uij/Y2YIm7L9pzco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J5dV0f6LdIIksmidnpm2dVV3FYFryt9ZSboAqy5m4Cw=;
        b=bldc0TP/Zblvw/d96k/O+FhNNx1IY1stKUo70I1agiMsCOOxQu8vrSX9Rqb1GkTvOw
         YNf68xhKjv481cXLLg0vRNMK4LCf0pedcUpC8q6K8zJpx82x5kzAm5njvw3mEL0PK161
         vC3waMvuSKIJS3x+MlskUzZAcpOWTFhw78/FYl0JVIyMYIpPb2RpjT2Ke3b2uDobKiKW
         7aIN82afFHXv/uLR412p2kpOfHkqOeKPvt/mYeTJA/7HLT0rSnJSnSWnDN3xjqCK1HgS
         mup40XlA+5vrMJDyxmBTgCvoLnfOfr0/PlVRKVYIn89EQhO2aFKtyrFraNznOU0jBnpk
         BeRQ==
X-Gm-Message-State: ALQs6tCcg+yHcgkFgEfIEiS6pQoZqoZ5Lxjtp99N1Hv5gbGS+GpJrSI6
        +2gVs6Dd4CJ3sPjSRXocEI+YnPvWfAU4lR3RWiW+ig==
X-Google-Smtp-Source: AIpwx48uypoY7ISSiuIech1M6bufL0WYmEL/4gYaIVDS5ibP/jyJU6pOPD4pKUaAf6IPvYlSv6vFtDgDoeSFK8KAu+A=
X-Received: by 2002:a9d:2564:: with SMTP id j33-v6mr479312otd.398.1523535563653;
 Thu, 12 Apr 2018 05:19:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.200.2 with HTTP; Thu, 12 Apr 2018 05:19:23 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804121341590.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180411225534.48658-1-haraldnordgren@gmail.com>
 <CAGZ79kbt=J5SHsHJTfOZYhgSdn9_gOjVBC3qp_oL0sC-b3ZRmw@mail.gmail.com>
 <CAHwyqnVg83xSQHRnDVz+aMxPPMj-3bWF4P8YUxEjurxnpDhFEQ@mail.gmail.com>
 <CAP8UFD3j-MGY7jHQK52zVLYMB=1vhCSFKxrvQ1JsRW-Rmnn8Qg@mail.gmail.com>
 <CAF2Guqum5dak4us_HJtiW_gL0xgsihgUpidFEJzBgw-tEMunkQ@mail.gmail.com> <nycvar.QRO.7.76.6.1804121341590.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Tiago Botelho <tiago@gitlab.com>
Date:   Thu, 12 Apr 2018 13:19:23 +0100
Message-ID: <CAF2GuqtooOo0P3nGXNEEu=j2XSuNZ2KRwEOAz82mMC3t3v7bXQ@mail.gmail.com>
Subject: Re: [PATCH] Create '--merges-only' option for 'git bisect'
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 12, 2018 at 12:53 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Tiago,
>
> On Thu, 12 Apr 2018, Tiago Botelho wrote:
>
>> On Thu, Apr 12, 2018 at 9:58 AM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>> > On Thu, Apr 12, 2018 at 9:49 AM, Harald Nordgren
>> > <haraldnordgren@gmail.com> wrote:
>> >> I think it looks similar. But if I'm reading that thread correctly
>> >> then there was never a patch created, right?
>> >
>> > (It is customary on this mailing list to reply after the sentences we
>> > reply to. We don't "top post".)
>> >
>> > On the GSoC idea pages (like https://git.github.io/SoC-2018-Ideas/) we
>> > have been suggesting "Implement git bisect --first-parent" and there
>> > are the following related links:
>> >
>> > https://public-inbox.org/git/20150304053333.GA9584@peff.net/
>> > https://public-inbox.org/git/4D3CDDF9.6080405@intel.com/
>> >
>> > Tiago in Cc also tried at a recent London hackathon to implement it
>> > and came up with the following:
>> >
>> > https://github.com/tiagonbotelho/git/pull/1/files
>> >
>> > I tried to help him by reworking his commit in the following branch:
>> >
>> > https://github.com/chriscool/git/commits/myfirstparent
>>
>> Thank you for the cc Christian, I=E2=80=99ve been quite busy and was not=
 able
>> to work on the PR for quite some time.
>>
>> I intended to pick it back up again next week. If it is ok with Harald
>> I would love to finish the PR that I started,
>> since it is quite close to being finished (I think it was just specs
>> missing if I am not mistaken).
>
> That looks promising. Just like I suggested to Harald in another reply
> [*1*] on this thread, you probably want to use `int flags` instead, and
> turn `find_all` into BISECT_FIND_ALL in a preparatory commit.
>
> Also, you will definitely want to add a test. Again, my reply to Harald
> [*1*] should give you a head start there... You will want to imitate the
> test case I outlined there, maybe something like:
>
> # A - B - C - F
> #   \   \   /   \
> #     D - E - G - H
>
> [... 'setup' as in my mail to Harald ...]
>
> test_expect_success '--first-parent' '
>         write_script find-e.sh <<-\EOF &&
>         case "$(git show --format=3D%s -s)" in
>         B|C|F) ;; # first parent lineage: okay
>         *) git show -s --oneline HEAD >unexpected;;
>         esac
>         # detect whether we are "before" or "after" E
>         test ! -f E.t
>         EOF
>
>         git bisect start --first-parent HEAD A &&
>         git bisect run ./find-e.sh >actual &&
>         test_path_is_missing unexpected &&
>         grep "$(git rev-parse F) is the first bad commit" actual
> '
>
> Also, Tiago, reading through your patch (as on chriscool/git; do you have
> your own fork? That would make it much easier to collaborate with you by
> offering PRs), it looks more straight-forward than editing the commit_lis=
t
> after the fact and adding magic weights ;-)
>
> Except for one thing. I wonder why `bisect_next_all()` does not set
> revs.first_parent_only after calling `bisect_rev_setup()`? You would stil=
l
> need the changes in `count_distance()`, as it performs its own commit
> graph traversal, but there is no need to enumerate too many commits in th=
e
> first place, right?
>
> Harald, maybe --merges-only can be implemented on top of --first-parent,
> with the `int flags` change I suggested?
>
> Ciao,
> Johannes
>
> Footnote *1*:
> https://public-inbox.org/git/nycvar.QRO.7.76.6.1804121143120.65@ZVAVAG-6O=
XH6DA.rhebcr.pbec.zvpebfbsg.pbz/

Hi Johannes,

Thank you for the pointers!

I do have my own fork, you can see it here:
https://github.com/tiagonbotelho/git/pull/1/commits
which applies the changes Chris made to my first draft of the solution.

I still have to add him as co-author of that commit.

Cheers,
Tiago Botelho

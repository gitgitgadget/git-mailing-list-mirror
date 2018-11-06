Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E0EF1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 08:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbeKFSAt (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 13:00:49 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43922 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbeKFSAt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 13:00:49 -0500
Received: by mail-ed1-f66.google.com with SMTP id e4so685924edv.10
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 00:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=VqgmtQb8yMaug8rNgVLe8tUFtw+O9e3ypT8kWjLXOSA=;
        b=fskxHEYXHU+KDjjlj/dKweBJQEGdnyt3LrqTpLZTxDg1SOLR5mG8p4XljomuclaKNR
         Tm0dAgnGNC7np87WnEXG3WT5oyICQT47GJoXwAv37Z7ynue+YJLS25ez7aztuPCXYOho
         nDTydWF9T/AwU82oy6uXY/XLuHtaNxUsDj0/EPUmdB27KehTQk2crIdm4zoLdn+JtYsV
         9H0Ki5/mSG0PF55Bo1BHQGBmkYzEzfhce4Gm47UjlwV+pvpsn1QIe10Vhz7vRA5g5h9l
         otKggquWZXew8P3cdU8km1p0a7egdcDGjmuWVxgktakYSnBtvxihVHGAciCIb/Smi9Ey
         p/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=VqgmtQb8yMaug8rNgVLe8tUFtw+O9e3ypT8kWjLXOSA=;
        b=TUjB5L6JljBXISmjXa7rhVGBdTlToUHg/BkycsHeBuJrUQ6Bt365c0q8X7YocqA1Dn
         CymSpwCVWzpFncuEhiWqLOOx+hVrQmUcZPxF9oMVN3qDWIaJL+8QXWxB+t4RlfJ76BQF
         pfb3HAMPj1E2yWIhsfGj9j//zcrXsQ6t7l+fQCL4QJ+LW6BFMolzDJIZAHVqwgogI4Sv
         Py4G1jlfqdi5Cmrs10VrH40vt89m7YIMCt3i6fMKqsjbSzQ3QD1AEMA3FmsiCeFawWJ4
         9Qp5M1oIvtzoZEJsUnS1PrQFsm9ErgpQMqoedEGgpIvPoDtbtGgFtcm3xo2NOjOLPqXn
         FGFA==
X-Gm-Message-State: AGRZ1gI4oTVVfGB1ow7K0H+06HLjANIwx14mxLKlcgXRSD35kfFue584
        yrhVKRIgvzcRFmgpFYhFJdE=
X-Google-Smtp-Source: AJdET5cGqPFawkDKdvd1HpRmW0aarYAetPfV9vliUFaaqAQvCNo5rMG+nPZbO3MN9QZDLos70roaVA==
X-Received: by 2002:a50:fe12:: with SMTP id f18-v6mr19779326edt.116.1541493401786;
        Tue, 06 Nov 2018 00:36:41 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id o31-v6sm4476733eda.72.2018.11.06.00.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 00:36:40 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        lucas.demarchi@intel.com, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] range-diff: add a --no-patch option to show a summary
References: <20181105200650.31177-1-avarab@gmail.com> <xmqqva5aet72.fsf@gitster-ct.c.googlers.com> <CAPig+cR85-7wMYCGGFoRT3jSQzQmda_84Ox1kF6roa5j-1XZ0Q@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAPig+cR85-7wMYCGGFoRT3jSQzQmda_84Ox1kF6roa5j-1XZ0Q@mail.gmail.com>
Date:   Tue, 06 Nov 2018 09:36:39 +0100
Message-ID: <87d0ri7gbs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 06 2018, Eric Sunshine wrote:

> On Mon, Nov 5, 2018 at 11:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>> > This change doesn't update git-format-patch with a --no-patch
>> > option. That can be added later similar to how format-patch first
>> > learned --range-diff, and then --creation-factor in
>> > 8631bf1cdd ("format-patch: add --creation-factor tweak for
>> > --range-diff", 2018-07-22). I don't see why anyone would want this for
>> > format-patch, it pretty much defeats the point of range-diff.
>>
>> Does it defeats the point of range-diff to omit the patch part in
>> the context of the cover letter?  How?
>>
>> I think the output with this option is a good addition to the cover
>> letter as an abbreviated form (as opposed to the full range-diff,
>> whose support was added earlier) that gives an overview.
>
> I had the same response when reading the commit message but didn't
> vocalize it. I could see people wanting to suppress the 'patch' part
> of the embedded range-diff in a cover letter (though probably not as
> commentary in a single-patch).
>
>> Calling this --[no-]patch might make it harder to integrate it to
>> format-patch later, though.  I suspect that people would expect
>> "format-patch --no-patch ..." to omit both the patch part of the
>> range-diff output *AND* the patch that should be applied to the
>> codebase (it of course would defeat the point of format-patch, so
>> today's format-patch would not pay attention to --no-patch, of
>> course).  We need to be careful not to break that when it happens.
>
> Same concern on my side, which is why I was thinking of other, less
> confusing, names, such as --summarize or such, though even that is too
> general against the full set of git-format-patch options. It could,
> perhaps be a separate option, say, "git format-patch
> --range-changes=<prev>" or something, which would embed the equivalent
> of "git range-diff --no-patch <prev>...<current>" in the cover letter.

Maybe this was discussed more when this range-diff format-patch
integration was submitted, I wasn't following that closely:

Looking at this more carefully it seems like quite a design limitation
that we're conflating the options for format-patch itself and for the
range-diff invocation it makes.

Wouldn't it be better to make all these options
e.g. --range-diff-creation-factor=*, --range-diff-no-patch,
--range-diff-U1 etc. Now there's no way to say supply a different
-U<ctx> for the range-diff & the patches themselves which seems like a
semi-common use-case.

Doing that seems to be a matter of teaching setup_revisions() to
accumulate unknown options, then parsing those into their own diffopts
with the "range-diff-" prefix stripped and handing that data off to the
range-diff machinery, not the parsed options for range-diff itself as
happens now.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A61741F576
	for <e@80x24.org>; Fri,  2 Feb 2018 09:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751043AbeBBJy1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 04:54:27 -0500
Received: from mail-oi0-f44.google.com ([209.85.218.44]:43733 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeBBJyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 04:54:25 -0500
Received: by mail-oi0-f44.google.com with SMTP id 4so15603543ois.10
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 01:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+sfnNpBTHRs/C3EZygqcBZDJOWSOpzBJrwhaOpTW/pU=;
        b=THYjAwCu3rPrvWvMTXisiXjiBtMyfMQqtBgD1viE0u1Cq+RNO5Vi4wfAEKH5u/ryix
         c6jY/2lR4UBtn9yB30gogFqFEhvlgyvmWY7QEQRwFB6++dNmePT3ehCDiIZTFdgbORft
         LTpNWN354U+OpQ7ljLYwlvAZNceFTAsPFXwq9WY8ijaOoyNO6NLEruBJ2LOQD5nXotpx
         O09ABwvFvuehDARihHTMEGAEjWJP65R/Y4DY7A5M3ULVJiBJTfzBP44pjPR+CXrDgxtb
         YOx2SWMSzh3+ZPvc0C3EZuIGsWUe6RWxScapxcj0qgXCAeXjteyb3W6AejhK7kUKYPt3
         ujuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+sfnNpBTHRs/C3EZygqcBZDJOWSOpzBJrwhaOpTW/pU=;
        b=me7+IC5fiWlWH2RoZ+USqAnTXIqL7k7EJXhmlbyNd1QfTZkmUY3qd96/MiiJbD87l9
         o95f6p2/mWkoQmJnE+dpucikYIp9btgmLoHc9vNQTiIArbWVHAPIzoJTrO/H22PZJ0aI
         EIEIurRWNV5wwyNGQVOekmH7MTz6u7r67dAWf267CzjH/k7ywH+oMan6iETskJE8Wf6B
         FHZMnliyztKcjVXiGuCMxOgsYocq6bfC17EmZUgAnbee7JylxRC1iZN/jP1eFFXxTyvD
         MhWr2ePpXE+eo0Z+AUdIF9THpNkLTDsFwsO9pAnYL+EQ6Yfu9FqkSlHQpkJm7Tl41Tag
         m/MA==
X-Gm-Message-State: AKwxyteYtrKCK3g2/tGInEjCP6cDbiFHbck5/vXq2hPm0XPXvM9KnDuz
        0xwHg/IBaQUnNqFZeURKW38SPsCyLwogJ29/OPc=
X-Google-Smtp-Source: AH8x2247MSmvJfOS63GLnDBsNypEVPLGeDl8xCuWhphb4LvouHWvmGo5+CGr4/Q8yc4jIrToIeUG7kT50MWRlFbvmZ8=
X-Received: by 10.202.49.73 with SMTP id x70mr11197511oix.351.1517565264667;
 Fri, 02 Feb 2018 01:54:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Fri, 2 Feb 2018 01:53:54 -0800 (PST)
In-Reply-To: <CAPig+cQKMxwadf9aGyC5ESa-vxDy9PzrYo+m+JaVQ3S=12PyQQ@mail.gmail.com>
References: <20180126095520.919-1-pclouds@gmail.com> <20180131093051.15525-1-pclouds@gmail.com>
 <20180131093051.15525-2-pclouds@gmail.com> <CAPig+cR24=0_NPekYaF+oG9OovDkv1Et-RpNvAHqE7Qd7g7QQA@mail.gmail.com>
 <xmqqpo5pr5wr.fsf@gitster-ct.c.googlers.com> <20180202092511.GA28946@ash> <CAPig+cQKMxwadf9aGyC5ESa-vxDy9PzrYo+m+JaVQ3S=12PyQQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 2 Feb 2018 16:53:54 +0700
Message-ID: <CACsJy8Cg35sqeEtmLJo2vrHvB4fD0uzZwYubgXOcZxUHMwcpqQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] am: add --show-current-patch
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tim Landscheidt <tim@tim-landscheidt.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 2, 2018 at 4:46 PM, Eric Sunshine <sunshine@sunshineco.com> wro=
te:
> On Fri, Feb 2, 2018 at 4:25 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Wed, Jan 31, 2018 at 02:59:32PM -0800, Junio C Hamano wrote:
>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> > On Wed, Jan 31, 2018 at 4:30 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>> >> +       len =3D strbuf_read_file(&sb, am_path(state, msgnum(state)),=
 0);
>>> >> +       if (len < 0)
>>> >> +               die_errno(_("failed to read '%s'"),
>>> >> +                         am_path(state, msgnum(state)));
>>> >
>>> > Isn't this am_path() invocation inside die_errno() likely to clobber
>>> > the 'errno' from strbuf_read_file() which you want to be reporting?
>>> True.
>>
>> Thanks both. Good catch. Of course I will fix this in the re-roll, but
>> should we also do something for the current code base with the
>> following patch?
>>
>> -       die_errno(_("could not read '%s'"), am_path(state, file));
>> +       saved_errno =3D errno;
>> +       path =3D am_path(state, file);
>> +       errno =3D saved_errno;
>> +       die_errno(_("could not read '%s'"), path);
>
> Rather than worrying about catching these at review time, I had been
> thinking about a solution which automates it using variadic macros.
> Something like:
>
>     #define die_errno(...) do { \
>         int saved_errno_ =3D errno; \
>         die_errno_(saved_errno_, __VA_ARGS__); \
>         } while (0);

That would be best. Unfortunately we have HAVE_VARIADIC_MACROS so we
need to deal with no variadic macro support too.
--=20
Duy

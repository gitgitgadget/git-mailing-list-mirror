Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54A2A1F404
	for <e@80x24.org>; Thu, 18 Jan 2018 08:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755099AbeARIpV (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 03:45:21 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:35802 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754930AbeARIpH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 03:45:07 -0500
Received: by mail-it0-f48.google.com with SMTP id e1so12589883ita.0
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 00:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qK6+Rd1wUaCiX4GZDLX9KqX350cIwfhklQat8WqbGhU=;
        b=TAobTo6rD/M1V8UhgzdsNcxrZszXUliotR4PprhRJO5v+//hsorkF1HY2kPz/We7DR
         ndedirUCKx4/QsJUXWu8/wYR30xv9fjxPjjkC1YEFa57opuDPlNdf/YlHftzMWS3sg8w
         kQelgJKrAti/Iok7PKuga25/ktF2GbkfOOQ0o24HOOAX+UX+EU2d+ucrhclEkwqaQpzP
         FCBYzts7zhdgEWr2Asvg/nOp/2V52mC8i1XxMR9x+9YkLRB6mhUnZx1z7T+EwxVV43RG
         Ui75GMZWMsHTgir96PBQR/9rQAgalauDR/2vIxjrFCcJT8E0bltRENYbuKxXWFj3CO9x
         jLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qK6+Rd1wUaCiX4GZDLX9KqX350cIwfhklQat8WqbGhU=;
        b=fCRfBWI1dz6bgRERUYercuU49P4eSKsVYBHz1hg444Qp9NrGx1Yr/N2XnF3mAVjPeg
         s089kbH56VeMMACnoyfcwfcXmkPMwaBDC08jXMHUWaU+OENNkdXEuXawUp55BHWAeAcf
         4wYB6WbM06S+u0TTs0zC+cI+OLTFyGUcN8zCJMbKjXDQ7PYBIN83u83ctkONp8qNUowI
         kq3Z4ZqqsDIqemklYmrCYvQ1hIkwIyvR1J0Of9Ohn1mJLb3rDCE5k9GkaKKcpAiRjnpF
         +tJR+Pr+X2EtDpSKO5V5RDuFDEfA1DwEVfqNnv0DW01tn5iaPTELxhZh5P29qm6BcVZ+
         tDTA==
X-Gm-Message-State: AKwxyteahbh9Qobd9Z9VU5trjPXzPqu7dMGwFIG2RCFHihgdJNV/QHYH
        n08dqVfl8qoaL6SQX8TAqaz60GjNeOi9w7FgoFX71g==
X-Google-Smtp-Source: ACJfBot478dfHJEjNshc821KHx/sE9Bxy5VK6brmquKAv37PdugsYSUBm1oQKCbA1yUQ0f6otAGvP3mLPCESQscwdYU=
X-Received: by 10.36.249.196 with SMTP id l187mr15577068ith.63.1516265106867;
 Thu, 18 Jan 2018 00:45:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.113.199 with HTTP; Thu, 18 Jan 2018 00:45:06 -0800 (PST)
In-Reply-To: <CAL21Bmm9P7p90GRRk4y9N5R6Gd3prEx53KyD3Cu1si6FHZAvkQ@mail.gmail.com>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
 <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <20180115213335.GB4778@sigill.intra.peff.net> <20180115220946.GF4778@sigill.intra.peff.net>
 <CAL21BmmmX5-uisj+_=sDHwJO=fpXc41Wriw+uuxtR=gOio-HZQ@mail.gmail.com>
 <20180117214906.GC13128@sigill.intra.peff.net> <CAP8UFD1hnP3yab-qDKPkNcj5VadUD_HW5+V1e2nwPAB8r31zoQ@mail.gmail.com>
 <CAL21Bmm9P7p90GRRk4y9N5R6Gd3prEx53KyD3Cu1si6FHZAvkQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 18 Jan 2018 09:45:06 +0100
Message-ID: <CAP8UFD00caGRWZZ1jdmuwtBH92tbqHoebfT+Lkp1NctKrxwFAQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] cat-file: split expand_atom into 2 functions
To:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 7:22 AM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=
=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
> 2018-01-18 2:04 GMT+03:00 Christian Couder <christian.couder@gmail.com>:
>> On Wed, Jan 17, 2018 at 10:49 PM, Jeff King <peff@peff.net> wrote:
>>> On Tue, Jan 16, 2018 at 10:22:23AM +0300, =D0=9E=D0=BB=D1=8F =D0=A2=D0=
=B5=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F wrote:
>>>
>>>> >> In other words, I think the endgame is that expand_atom() isn't the=
re at
>>>> >> all, and we're calling the equivalent of format_ref_item() for each
>>>> >> object (except that in a unified formatting world, it probably does=
n't
>>>> >> have the word "ref" in it, since that's just one of the items a cal=
ler
>>>> >> might pass in).
>>>>
>>>> Agree! I want to merge current edits, then create format.h file and
>>>> make some renames, then finish migrating process to new format.h and
>>>> support all new meaningful tags.
>>>
>>> I think we have a little bit of chicken and egg there, though. I'm
>>> having trouble reviewing the current work, because it's hard to evaluat=
e
>>> whether it's doing the right thing without seeing the end state.
>>
>> Yeah, to me it feels like you are at a middle point and there are many
>> ways to go forward.
>
> OK. Maybe I misunderstood you and Jeff in our call, I thought that was
> your idea to make a merge now, sorry. I will continue my work here.

If you think you can now prepare a patch series that looks like it is
going in the right direction, then yes you can do that. But after
looking at the current patch series I agree with Peff that, as it
doesn't look finished, it's difficult to tell if all the steps are
good.

In general it is a good idea to try to merge things as soon possible,
but for that to be possible the state of the code that we want to be
merged should look quite stable, and it doesn't look very stable to
me.

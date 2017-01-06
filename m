Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 031321FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 20:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937952AbdAFUF1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 15:05:27 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:33716 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937950AbdAFUF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 15:05:26 -0500
Received: by mail-vk0-f49.google.com with SMTP id 137so318365469vkl.0
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 12:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rv4F8Pd1B0OZhqZCGcbwsouwwJvnrWDx2HtTLcJiXG8=;
        b=QzPkHke8WQ6A8kKh+qjc2PjJ0YeRsgKasgA+S68eFNdt8mSpxrzA2qcFshIXzgnJG5
         lWkSb2cQRxWdnMA/RmNk+cfhBp8Ttnjtp6ywY/AzNK+jAVbQmQwzDkgAy+gCv6IIrBNh
         GxMTaig42/dR8ygjyK/BVl/c8pI3+DHpz2e0bhTuHbfc6Ugwc+iYWlAvkTV0SQ1Ug+kO
         97SOA/FczvLvy4JwxQ0KX59uAnvSwMk6FU0fVQEmHxNqPJOGOJk4+egsK2TaYorP0PxD
         5JBdNGWqGW1XrG/bktBkQ3/bgNqSkpPrUpT8KGNk+Ugyl0UC4nJLhkJ+BIhlJYWBq0uk
         Y6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rv4F8Pd1B0OZhqZCGcbwsouwwJvnrWDx2HtTLcJiXG8=;
        b=IYiZ1iI3lJyKFehO+TZR432aomF7KWX6TERl7Srat/X4kJwf1W0DJv0w50+xmEpMiB
         e8ezVNGlrSZ9qsCt5JbCxTvLg1mGyVRtgGdCBtGYZQsVff4wbq5Il/jjNv8+pzoWA5J1
         hh7e9uFivEkQljDuRfqBr2zsQatMmrDQ3VkyZMya5CzgPfkskTGRk2R7XoyOFRq89gtv
         Wjv0INXqE29U9l9uxKPXum8cXC0n7NfmaTheUwrjCP2uc/OrlBZbAyLcyD48ad/otK6x
         jkngaz572PXxm8j5cGzle/kZfyp/tIBojwRnmADBxDZR8i/fM7E0si0Pr+3jfkT1cl62
         gChQ==
X-Gm-Message-State: AIkVDXLfaWQCTMp5Nx67qnkc8S9TeWg1kGIGKHCNXnKM1cQabtktWYsxt+uVtvzWPJe6mFiB7UX4Ixy0Lboldg==
X-Received: by 10.31.149.138 with SMTP id x132mr27135055vkd.86.1483733125257;
 Fri, 06 Jan 2017 12:05:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.32.42 with HTTP; Fri, 6 Jan 2017 12:05:24 -0800 (PST)
In-Reply-To: <CAGZ79kZOfHWP_pQGN1QcmR71Ft6ib0aPwNKX80YMT7KcK0_Stg@mail.gmail.com>
References: <MWHPR19MB11357994E6C43DBCC0931CD7BC630@MWHPR19MB1135.namprd19.prod.outlook.com>
 <CAGZ79kaz_hS9P7vqV9EhZazM_g0OUdRfMtFPJ7gFu-h-ku=NKw@mail.gmail.com>
 <CAN0XMO+zzYOXF2gwr=0Tu-7T5BH7f_L+FhfD8RUenDeq3xFHjA@mail.gmail.com> <CAGZ79kZOfHWP_pQGN1QcmR71Ft6ib0aPwNKX80YMT7KcK0_Stg@mail.gmail.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Fri, 6 Jan 2017 21:05:24 +0100
Message-ID: <CAN0XMOKzd-nuFaJdOYndexCNWFVWDJKKinc7-Ox19K4sgXF7YQ@mail.gmail.com>
Subject: Re: git branch --editdescription fatal error
To:     Stefan Beller <sbeller@google.com>
Cc:     Jake Lambert <jake@onahill.co>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-01-06 20:43 GMT+01:00 Stefan Beller <sbeller@google.com>:
> On Fri, Jan 6, 2017 at 11:31 AM, Ralf Thielow <ralf.thielow@gmail.com> wr=
ote:
>> 2017-01-06 18:55 GMT+01:00 Stefan Beller <sbeller@google.com>:
>>> On Fri, Jan 6, 2017 at 9:25 AM, Jake Lambert <jake@onahill.co> wrote:
>>>> Hello,
>>>>
>>>> When executing "git branch <branch> --edit-description" on a branch wi=
th no description set, I get "fatal: could not unset 'branch.<branch>.descr=
iption". It would seem that the unsetting piece should occur only after che=
cking if it was set in the first place.
>>>
>>> That seems strange. Is it possible that your config is not writable?
>>> (.git/config, ~/gitconfig, you'd need to find out where the <branch>
>>> is configured already via git config --global/--system/--local --list)
>>>
>>
>> Have you actually tried to reproduce this issue? I'm on current next
>> and can reproduce the problem.
>
> eh, I was on $random_version that I currently have installed
> (with messed up submodule code, but otherwise close to master).
>
> this gives hope that a bisect between master..next will give us a culprit=
?
>

Hm.
I can confirm it appears on current master (e05806da9).

>>
>> I think removing things that don't exist should behave the same like
>> removing things that do exist, with
>> a success.
>
> I am not sure. Consider the tool "rm"
>
>     $ rm no_exist
>     rm: cannot remove =E2=80=98no_exist=E2=80=99: No such file or directo=
ry
>     $ echo $?
>     1
>
> You have to use the --force.
>
> For this specific use case I agree we should then set the force flag
> to let the the removal of the config option succeed no matter if it
> existed before.
>
> Stefan

Can you think of a case where this flag should be set to false?

Ralf

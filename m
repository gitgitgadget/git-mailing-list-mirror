Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 252751F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758273AbcHCUbJ (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:31:09 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34251 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757476AbcHCUbH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:31:07 -0400
Received: by mail-yw0-f196.google.com with SMTP id j12so17553270ywb.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 13:29:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gOD80UYP4dnd+2YkuO9hjbhliekJ4mc6i+qxyKb2JJY=;
        b=KSyNiVX63Ypeb8z+oJl5knyEUFH1ujD6aSBOiPUo1Ezv3GtFHqlnZ1KkEhnxs9aILB
         cw7JD51nl07wla7issfUQ64AXRRVHA9bEcxIL2h/YWPWviOg/pyYDm5sE6Gzi8RdEVaL
         29NAsR2qSJqeqcFrsveKDXNPqCNT2T9ryEuGxlNb7Bmqhbq3qiP4s+Md4gt10h5h7rjT
         JnS4lEcTnlzPs5j+0UKtPFUod4eqyVe1JrfX6OP4SBNbKSdPkJE+RA7VxNN7C0LvDwYV
         GtNhcTxlVJCdNfNK90pyh85V0ucSzXHgnakB00Ct8qRLiGNqw42k+QQznWyRQ2bfr7qw
         X59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gOD80UYP4dnd+2YkuO9hjbhliekJ4mc6i+qxyKb2JJY=;
        b=O8q/QEWeiPvpGxEXLUsCaGchNd3+AY+JhzaoTGVjGFoRJI73QrPEAp6We5nt4sxGvy
         CGv4GzFUMlGTO87xLxsEwdo0g0DzXSaSXFnvw4AZJiZcz0dlqNqMAJ/vGr7wh3c170WR
         YVZeguBwRFb6gtwvVOOwpVYCeFGv7bM7YPlvQOgiGu70yu7ikoEK9bLrDjhN+4cGrlco
         ySxXYPs354W76fyvIm3GAQ4ufy/9sw4IN6+gTe6sviteKP8QLHRFPC0hNkdiyrUivWAq
         R4KhNrja8lNsNEi8wW3zW5pc0Rgp/5na85iZvfZNm/NZJuKYoTpzaKZEOm59ri8j0NPo
         BkRQ==
X-Gm-Message-State: AEkoouuAT3PGz/873hjOANdVXbEIwu05XpO3HHgPsGvpq/CBkQMuDc3XXjgDU790nSNCsdVfqsm91bCiTINeQQ==
X-Received: by 10.13.212.139 with SMTP id w133mr56132119ywd.49.1470256180217;
 Wed, 03 Aug 2016 13:29:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Wed, 3 Aug 2016 13:29:39 -0700 (PDT)
In-Reply-To: <xmqqa8gvdmtx.fsf@gitster.mtv.corp.google.com>
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
 <0102015640423cfd-dbacb682-b6fe-4417-a3f2-2c2c6673263c-000000@eu-west-1.amazonses.com>
 <xmqqa8gvdmtx.fsf@gitster.mtv.corp.google.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Thu, 4 Aug 2016 01:59:39 +0530
Message-ID: <CAFZEwPOERUocOiRvWR6fj1KZm7wcVrp41FVFbhWpdZBMAabUpA@mail.gmail.com>
Subject: Re: [RFC/PATCH v11 10/13] bisect--helper: `check_and_set_terms` shell
 function in C
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Junio,

On Wed, Aug 3, 2016 at 12:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> Reimplement the `check_and_set_terms` shell function in C and add
>> `check-and-set-terms` subcommand to `git bisect--helper` to call it from
>> git-bisect.sh
>>
>> Using `--check-and-set-terms` subcommand is a temporary measure to port
>> shell function in C so as to use the existing test suite. As more
>> functions are ported, this subcommand will be retired and will be called
>> by some other methods.
>
> I think "this subcommand will be retired but its implementation will
> be called by ..." would clarify the direction.

Sure. That seems better.

>> +     if (!no_term_file &&
>> +         strcmp(cmd, terms->term_bad.buf) &&
>> +         strcmp(cmd, terms->term_good.buf))
>> +             return error(_("Invalid command: you're currently in a "
>> +                             "'%s' '%s' bisect"), terms->term_bad.buf,
>
> This changes a message text, switching from "... good/bad bisect."
> to "... 'good' 'bad' bisect".  Intended?

Nope its not intended but its a mistake from my side. Will rectify.

Regards,
Pranit Bauva

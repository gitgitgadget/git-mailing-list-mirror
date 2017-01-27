Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3439A1F437
	for <e@80x24.org>; Fri, 27 Jan 2017 18:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750729AbdA0SYZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 13:24:25 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:36794 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbdA0SYT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 13:24:19 -0500
Received: by mail-io0-f182.google.com with SMTP id j13so66744048iod.3
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 10:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bYqOU/sCXVBoG8psErowOgLk8bft3J4USs1bbsTKrhY=;
        b=mqs0rD4mMi7jDT7m2iUB3JZH5FNJmNZFyuoKQScq8olky3zbD8vakMiehX4WayuK3H
         qz7s82TC6wfWmTEAfjv/wQvOSwZD64BgH2aZziTIYBuClimjkpmXa/6PhHpkJHf0KebY
         Mcd75O1vq0Nb5GwyLe8fSduhYMVrhVJEuf0sKfECUP+f5IOtLZcGUMfrptA+ZgU+LPXL
         DnR8GZkgYQsf7bWaXMRN3Wfs6LVqq7BkRvt3S6LFWKvK3GyarL4my5ps71nrwWR+VzSn
         crV9516gJi6jxB09SBVaKPOXqBA+Rgkh53fXzGFa+hqYTI6Q5MGwAnqbnsvzPaJ/vD+T
         NPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bYqOU/sCXVBoG8psErowOgLk8bft3J4USs1bbsTKrhY=;
        b=TgXGiq7RJqcTI9rdeu/QbHMx3AHevIifdEVaW3maBPHsUAFBJBSgxurt7j/2uccKH9
         /ODTUE1ZJ3TVPPOU/uh5wN9b7rzBtR6tfHrewTuh1PVcT2/DT9a6PnnxKlizoX8RqWSU
         OX5Tx5Fn+JDT2VdWUE0MnTH009xf6RqATZk3ogr/6a9jmyuzLRKmBSzEK01vhMQpB4xr
         WjYfMcm9h8Aji5aQK83RLC5I4lct3oF1U2kytuf+SQX8CSB7IVuLOHjHiXiEQFXNE4oF
         ON/wnbVgvIk9iHFYAbvxABAE79vd2eHjJiU/alp1klwao675/sQuKHKqxRcM8U9S6sy2
         KWaw==
X-Gm-Message-State: AIkVDXKJX/1bLK9XqRGqq9+F8Lq3BASSsd15PPPoQum3C00x4E70OyKqNR/7aWkvngbiQf54qKKpXsCNdjWQGMSi
X-Received: by 10.107.3.160 with SMTP id e32mr8574554ioi.52.1485541458213;
 Fri, 27 Jan 2017 10:24:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Fri, 27 Jan 2017 10:24:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1701271127520.3469@virtualbox>
References: <dc388b2df3baee83972f007cd77a57410553a411.1485362812.git.johannes.schindelin@gmx.de>
 <20170125211529.jq4halip4ndbff5k@sigill.intra.peff.net> <alpine.DEB.2.20.1701261321010.3469@virtualbox>
 <xmqq4m0l64pg.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1701271127520.3469@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 27 Jan 2017 10:24:17 -0800
Message-ID: <CAGZ79kaa5WJmZkyFROfkfNb3++t37qAuAebKJTon2iD2bh+sWw@mail.gmail.com>
Subject: Re: [PATCH] mingw: allow hooks to be .exe files
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 27, 2017 at 2:29 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Junio,
>
> On Thu, 26 Jan 2017, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > On Wed, 25 Jan 2017, Jeff King wrote:
>> >
>> >> On Wed, Jan 25, 2017 at 05:58:42PM +0100, Johannes Schindelin wrote:
>> >>
>> >> > -        if (access(path.buf, X_OK) < 0)
>> >> > +        if (access(path.buf, X_OK) < 0) {
>> >> > +#ifdef STRIP_EXTENSION
>> >> > +                strbuf_addstr(&path, ".exe");
>> >>
>> >> I think STRIP_EXTENSION is a string.  Should this line be:
>> >>
>> >>   strbuf_addstr(&path, STRIP_EXTENSION);
>> >
>> > Yep.
>> >
>> > v2 coming,
>> > Johannes
>>
>> I think I've already tweaked it out when I queued the original one.
>
> After digging, I found your SQUASH commit. I had not known about that.
>
> In any case, I much rather prefer to have the final version of any patch
> or patch series I contribute to be identical between what you commit and
> what I sent to the mailing list. We do disagree from time to time, and I
> would like to have the opportunity of reviewing how you tweak my changes.
>
> Ciao,
> Johannes

I saw the queued up commit and that lead me to this thread here.
The commit message, while technically correct, seems a bit off. This is because
the commit message only talks about .exe extensions, but the change in code
doesn't even have the string "exe" mentioned once.

With this discussion here, it is easy for me to connect the dots, but
it would be nice
to have the full picture in the commit message. This is what I would write:

    mingw: allow hooks to be .exe files

    Executable files in Windows need to have the extension '.exe', otherwise
    they do not work. Extend the hooks to not just look at the hard coded names,
    but also at the extended names via the custom STRIP_EXTENSION, which
    is defined as '.exe' in Windows.

Stefan

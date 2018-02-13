Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86A911F404
	for <e@80x24.org>; Tue, 13 Feb 2018 18:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965477AbeBMSZ6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 13:25:58 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36299 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965217AbeBMSZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 13:25:57 -0500
Received: by mail-wm0-f49.google.com with SMTP id f3so17724619wmc.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 10:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CvjOra7UvqslHsc6UG6TrI9h4oXxE1aY+jTUYlddl4Y=;
        b=RuaFeBnD0GS0ozhdj7MeQxKeG8WDMfDXIT75mNnKqglIPCxD67UTSFDYbUdDI+fGYl
         CN0ncUWMHM+xd6gBPxnBgWwL34zosaBW+QMG3gCdBReoUUj89hSr6r/qbk462A4GORav
         /L9VRX0eIb1snRjTTlQPGE30l5ad1yfi6iXnNVh/fMii6/5IcRjvgc3kqnozvcmKR/8v
         WymtfN3x8vK6NV37iT0wq4SiFwzx5+u/cdXsY5fMunPZ84nzjImfsV5pzM9xd2+pojMG
         mZmqqkfPtRmPSjZBz83EKIdzLA7KW50irvyrg78eyky9QDHTmpKIRU3xgnNUB7rvR7UG
         BEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CvjOra7UvqslHsc6UG6TrI9h4oXxE1aY+jTUYlddl4Y=;
        b=canTwPXyPTcW+ltZ5PqrrrwafVxrVrQljhqCh3BMvA3Vr0KUbPBWYkmEIAzJ4bHTYT
         M22Dyp9wKnH9xCbUtIbp2uKw7FwTpkNAXOOIALDIJm43sOtTpVQ4t23YnKGwAbPVEVBT
         vp7FPpY70ISg+4ixA3VmtW5BsAYPOP/mWx/gbcRQXUMudbiglQgCTJWKphpREBmNHqvQ
         5oB4QbiBuqEoVgq2rLKYz9a9etet6aUB48fZxK9Oojo3WQ6Xgc+SLrDqrgUtW3PNDwAL
         BM1+tEgIHySGAOJSKpxC7tCBiYbhCAA9onxdWNXzY/0+QVuzEDqDW6EZFFcHPG0qBL7E
         vaZg==
X-Gm-Message-State: APf1xPBuTHRuOWuzF2QGyhagBtk/NHBIP7Un0WzA7Y6fodJriusxp0OY
        J7VZUruw7esk3aIO/DGeljD8NcGLUtBaFd/bwqQ=
X-Google-Smtp-Source: AH8x227Mh+DjjfdUWwDPB4rec9fO83G0gBZTS1i9lvv0nHAN2Ah+pfQt298ss1gOAT+hJQEVVRUfhIGNyZ9oT8XGFx0=
X-Received: by 10.28.239.19 with SMTP id n19mr2042963wmh.20.1518546356015;
 Tue, 13 Feb 2018 10:25:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.197.5 with HTTP; Tue, 13 Feb 2018 10:25:55 -0800 (PST)
In-Reply-To: <CAGZ79kYXStMQCxnVjpV7n7miZEDAw4moR+0JksgTaRqHJwgSqw@mail.gmail.com>
References: <CAOmC-AncOZfAwowXLjwDbL9Bdx1+=RbXsrd72LzEBd2W-=LAQg@mail.gmail.com>
 <20180213160824.GA5203@sigill.intra.peff.net> <CAGZ79kYXStMQCxnVjpV7n7miZEDAw4moR+0JksgTaRqHJwgSqw@mail.gmail.com>
From:   =?UTF-8?B?zqPPgM+Nz4HOv8+CIM6SzrHOts6xzq/Ov8+C?= 
        <sbazaios@gmail.com>
Date:   Tue, 13 Feb 2018 20:25:55 +0200
Message-ID: <CAOmC-AnXD=eSphS=TK4v72tSYDYEV2cgu_EsP4kgNGR=7yre8w@mail.gmail.com>
Subject: Re: make git diff output easier to read - use better diff heuristics
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi guys,

While I din't have the experience to express an opinion on this
matter, I have to say that the --no-indent-heuristic that Jeff
suggested worked great.
There were more than a handful of cases that this issue happened in my
diff file (all were the same: #endif followed by #ifdef).
Oh, and the language is C indeed.

Thanks for the great support!

On Tue, Feb 13, 2018 at 8:11 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Feb 13, 2018 at 8:08 AM, Jeff King <peff@peff.net> wrote:
>> On Tue, Feb 13, 2018 at 05:06:15PM +0200, =CE=A3=CF=80=CF=8D=CF=81=CE=BF=
=CF=82 =CE=92=CE=B1=CE=B6=CE=B1=CE=AF=CE=BF=CF=82 wrote:
>>
>>> Hi, I've came across an issue when using the git diff command. In
>>> particular the diff is different to what the svn diff produces. While
>>> both being correct the output of the svn diff is easier to understand
>>> than the git diff one. See the following issue on github where I
>>> initially reported the issue:
>>>
>>> https://github.com/git-for-windows/git/issues/1494
>>>
>>> I have Included a picture to better illustrate the problem. What do
>>> you think? Is it possible to make git diff output similar to svn diff
>>> regarding this issue?
>>
>> Try "git diff --no-indent-heuristic", which makes your example look
>> better. Here's a quick reproduction:
>>
>> -- >8 --
>> cat >foo.c <<\EOF
>> static struct foo bar[] =3D {
>> #ifdef SOMETHING
>>         { "stats.info", MNU_GBX_FSTAINF, etc },
>>         { "expired.info", MNU_GBX_FSTAINF, etc },
>>         { "info.log", MNU_GBX_INFOLOG, etc },
>> #endif
>>         { NULL, 0, 0 },
>> };
>> EOF
>>
>> sed '6a\
>> #ifdef WITH_EMU\
>>         { "SoftCam.Key", MNU_CFG_FSOFTCAMKEY, etc },\
>> #endif
>> ' <foo.c >bar.c
>> -- 8< --
>>
>> Now this looks ugly:
>>
>>   git diff --no-index foo.c bar.c
>>
>> but this does not:
>>
>>   git diff --no-index --no-indent-heuristic foo.c bar.c
>>
>> That heuristic is described in 433860f3d0 (diff: improve positioning of
>> add/delete blocks in diffs, 2016-09-05). I'm not sure exactly why it
>> does the wrong thing here, or if it would be possible to tweak the
>> weighting factors to make it work.
>
> https://github.com/git/git/commit/433860f3d0
>
> I would think that the long lines at the shift boundaries[1] have
> bad impact on the algorithm as they are of different length
> and influence the backstepping value. (vague theory)
>
> I wonder if we want to add language specifics to the heuristic,
> such that '}' or 'end' in a given line have a strong signal that the
> cut should be right after that line? i.e. that would decrease the
> badness score.
>
> While this is not a general solution (but quite language specific),
> I would think this is still a good idea to look at.
> (When coming up with the heuristic, most people thought the bad
> examples would come from exotic languages, but not C, which we
> are all so familiar with such that we thought we had a good grasp
> how to make a heuristic that works with C. Note that the example
> looks like C, though).
>
> [1]
> { "info.log", MNU_GBX_INFOLOG, etc },
> vs
> { "SoftCam.Key", MNU_CFG_FSOFTCAMKEY, etc },\
>
>
> (slightly unrelated tangent on better diffs in general:)
> A couple days ago I had another discussion on how
> diffs are best presented to users. That discussion was
> focused on a slightly higher layer, the diff algorithm itself,
> instead of a post-algorithm boost-fixup.
>
> It is usually easier to both write as well as review code that
> adds completely new features or projects instead of squashing
> bugs or integrating subtle new features in an existing code base.
>
> This observation lead to the conclusion that reviewing large
> locks of adjacent new lines is easier than reviewing blocks
> where deletions as well as additions are found. So we theorized
> that deletions should have more impact than additions when
> computing the diff itself. The case presented here has no deletions
> so this is not applicable, but most examples that came up once
> 2477ab2ea8 (diff: support anchoring line(s), 2017-11-27)
> was discussed would be likely to have better diffs.
>
> Stefan

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DC9B1F4B6
	for <e@80x24.org>; Sun, 23 Jun 2019 15:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfFWPi7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 11:38:59 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:40472 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFWPi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 11:38:59 -0400
Received: by mail-oi1-f170.google.com with SMTP id w196so7958690oie.7
        for <git@vger.kernel.org>; Sun, 23 Jun 2019 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xa5wP8TwJkZ1Q1yEFUnynsLtjX/+qzFIwfT+VKo1D+c=;
        b=O2bVZ1D1CF7fN6Ayt9unjye9Ncmc4lwUca0Hwn4pKfssPE7l+kq8jqMJTUtgtkl3+R
         oz5Y5osCn32LVa+EI+xIOOiwmFuEvmb9h38MuKRbswa+wi/yNH82FTLNmPr0drMn0O6Z
         DA8FR8ze1wRNP8pSTS7mw/AH4QkfxJwGqmWAWXvF6aClXY7wymb7R3NUmKUeMJlgv256
         zDjyZftCNCbNxlORPImeffnqRUPXTSv0DyJaKFspyeJaPsVH3C0NNj4psKWiaWdDDFK1
         8+MV74sG+yIwFZmS0wq3Am4X0+Df2GjvBmM43Xo9B7HhH3ImXlqezjgO6HVmdf9spKdt
         m4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xa5wP8TwJkZ1Q1yEFUnynsLtjX/+qzFIwfT+VKo1D+c=;
        b=JPK0lvZhOZ0auAwiordndKW1/KnsGh+YfX5y9UYXppbndOOtQoVfvYHz8ICiK5dFuv
         2NTCgaBBYbrlO44W7C2MvED9EFbOli/s4sNBIYGtsg8hAqvA/bLoa5+w9AjQzy/j5CMc
         HaBmdFzdkvOmFevMkaqmsUZFxs1YbUjem3Lmh46T9x9HE3MH3aj3JJ18TUKtYbY0SU//
         Ug0fkJL9p5onsP+vFBKzhNzoYICZcMP/lY1EuaR1N7LgLTpjPIHXBCNShp2T/387/5eb
         0ygeR8vGAiT67roQUeN//B7SOqQaMKno4xRF7VXe4WVrdC+wmCFw9GfTxcDe/crFEOmR
         1HPA==
X-Gm-Message-State: APjAAAWL8pB/gB86ZUlJryIIFdRIJ+g9iCcRLems8L7otHH9xuqKoxkN
        6wZpMXgqV27qyPugb4ihnQI1/y7biZudzUQUTXVfU4hgH1A=
X-Google-Smtp-Source: APXvYqz8XAJHUxhN02nJJnpcqyIk2rJAq/P/oqBUvC07XunfPcoY6DEFXXQBVQLiLwWj65SyGQ5ZnRBN2tRWxyGuEXw=
X-Received: by 2002:aca:b808:: with SMTP id i8mr8150530oif.160.1561304338210;
 Sun, 23 Jun 2019 08:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXt3sqno7RAtuwQ_OpD3aLkEORLaf6aNeNKGQL0BKezD+wWTw@mail.gmail.com>
 <875zow8i85.fsf@evledraar.gmail.com>
In-Reply-To: <875zow8i85.fsf@evledraar.gmail.com>
From:   Janos Farkas <chexum@gmail.com>
Date:   Sun, 23 Jun 2019 16:38:46 +0100
Message-ID: <CAEXt3srf-9O8GbDEFwa5ELHRfwZ7LWYqqm6DxEjnegRUMcECnA@mail.gmail.com>
Subject: Re: 2.22.0 repack -a duplicating pack contents
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for looking at this, yes, it seems it's purely the .bitmap
writing.  With disabled repack.writeBitmaps, it all behaves as before
(and yes, these are bare repros for keeping an intermediate backup).

With the easy workaround in place, I'm back at 2.22 for now, thanks!

On Sun, Jun 23, 2019 at 3:54 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sun, Jun 23 2019, Janos Farkas wrote:
>
> > I'm using .keep files to... well.. keep packs to avoid some CPU time
> > spent on repacking huge packs and make the process somewhat more
> > incremental.
> >
> > Something changed with 22.2.0.  Now .bitmap files are also created,
> > and no simple repacks re-create the pack data in a completely new
> > file, wasting quite some storage:
> >
> > 02d03::master> find objects/pack/pack* -type f|xargs ls -sht
> > 108K objects/pack/pack-879f2c28d15e57d353eb8e0ddbcb540655c844c9.bitmap
> > 524K objects/pack/pack-879f2c28d15e57d353eb8e0ddbcb540655c844c9.idx
> > 4.7M objects/pack/pack-879f2c28d15e57d353eb8e0ddbcb540655c844c9.pack
> > 108K objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.bitmap
> > 524K objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.idx
> > 4.6M objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.pack
> > 116K objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.bitmap
> > 524K objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.idx
> > 4.6M objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.pack
> >    0 objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.keep
> > 108K objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.bitmap
> > 524K objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.idx
> > 4.6M objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.pack
> > 02d03::master > git repack -af
> > Enumerating objects: 19001, done.
> > Counting objects: 100% (19001/19001), done.
> > Delta compression using up to 2 threads
> > Compressing objects: 100% (18952/18952), done.
> > Writing objects: 100% (19001/19001), done.
> > warning: ignoring extra bitmap file:
> > ./objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.pack
> > warning: ignoring extra bitmap file:
> > ./objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.pack
> > warning: ignoring extra bitmap file:
> > ./objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.pack
> > Reusing bitmaps: 104, done.
> > Selecting bitmap commits: 2550, done.
> > Building bitmaps: 100% (130/130), done.
> > Total 19001 (delta 14837), reused 4162 (delta 0)
> > 02d03::master > find objects/pack/pack* -type f|xargs ls -sht
> > 108K objects/pack/pack-8702a2550b7e29940af8bc62bc6fca011ccbd455.bitmap
> > 524K objects/pack/pack-8702a2550b7e29940af8bc62bc6fca011ccbd455.idx
> > 4.6M objects/pack/pack-8702a2550b7e29940af8bc62bc6fca011ccbd455.pack   =
<=3D ????
> > 108K objects/pack/pack-879f2c28d15e57d353eb8e0ddbcb540655c844c9.bitmap
> > 524K objects/pack/pack-879f2c28d15e57d353eb8e0ddbcb540655c844c9.idx
> > 4.7M objects/pack/pack-879f2c28d15e57d353eb8e0ddbcb540655c844c9.pack
> > 108K objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.bitmap
> > 524K objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.idx
> > 4.6M objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.pack
> > 116K objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.bitmap
> > 524K objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.idx
> > 4.6M objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.pack
> >    0 objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.keep
> > 108K objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.bitmap
> > 524K objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.idx
> > 4.6M objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.pack
> >
> > The ccbd455 pack and its metadata seem quite pointless to be
> > containing apparently all the data based on the size.
> >
> > If I use -ad, a new pack is still created,which, judging by the size,
> > is essentially everything again, (but at least the extra packs are
> > removed)
> >
> > 02d03::master> git repack -ad
> > Enumerating objects: 19001, done.
> > Counting objects: 100% (19001/19001), done.
> > Delta compression using up to 2 threads
> > Compressing objects: 100% (4114/4114), done.
> > Writing objects: 100% (19001/19001), done.
> > warning: ignoring extra bitmap file:
> > ./objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.pack
> > Reusing bitmaps: 104, done.
> > Selecting bitmap commits: 2550, done.
> > Building bitmaps: 100% (130/130), done.
> > Total 19001 (delta 14838), reused 19001 (delta 14838)
> > 02d03::master 9060> find objects/pack/pack* -type f|xargs ls -sht
> > 116K objects/pack/pack-46ab64716d4220aac8d53b380d90a264d5293d3d.bitmap
> > 524K objects/pack/pack-46ab64716d4220aac8d53b380d90a264d5293d3d.idx
> > 4.6M objects/pack/pack-46ab64716d4220aac8d53b380d90a264d5293d3d.pack   =
<=3D ????
> >    0 objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.keep
> > 108K objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.bitmap
> > 524K objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.idx
> > 4.6M objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.pack
> >
> > Previously, the kept pack would be kept, and no additional packs would
> > be created if no new objects were born in the repro.
> >
> > With the .keep placeholder removed, the duplication does not happen,
> > but all the repro is rewritten into a new pack, which does not look
> > correct.  Am I doing something unexpected?
>
> I haven't looked at this for more than a couple of minutes (and don't
> have more time now), but this is almost certainly due to 36eba0323d
> ("repack: enable bitmaps by default on bare repos", 2019-03-14). Can you
> confirm when you re-run with repack.writeBitmaps=3Dfalse in the config?
>
> I.e. something in the "yes I want bitmaps" code implies "*.keep"
> semantics changing from "keep" to "replace", which is obvious in
> retrospect, since we can only have one *.bitmap per-repo.

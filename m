Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B0561F406
	for <e@80x24.org>; Wed, 16 May 2018 21:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbeEPVUq (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 17:20:46 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35747 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbeEPVUp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 17:20:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id o78-v6so5307987wmg.0
        for <git@vger.kernel.org>; Wed, 16 May 2018 14:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pyYIH1lUshKgPk6IuaVWJpiUsS2xUlGuqPDQZGTuFhk=;
        b=eTR5gHw/Iuy3yk6/0t0uRUcQ+lyLcWDNuzmD88xppbTSgRgOoK328DAhtKEnPPMxZJ
         on1WKltJ0BtxGbJ3fc6rb2+S5Q05ol6b8gw4uTEkwd7mut/rtbpkS804xUmWDDLe8gaN
         mmhv7B/2DqDjAn8NfB2hZfbDbwTWcjq4BdaM0cqtGCIFh9fM8BRuW6QFuiecm+CxWBMZ
         Lla8ExN4mJ26I3MZPlKDU/uu6+2Ipz4xPtF3BcNFjsDRi0juGnB9Ulyfw4sRvLbHU0fB
         1kGX21v48omNChZIBXP2uWoxJOrJPgGDmBsPJW+1fZOcOuSH7jVMewJDmXtPKa2KiYA6
         Qf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pyYIH1lUshKgPk6IuaVWJpiUsS2xUlGuqPDQZGTuFhk=;
        b=q/KMK07oSOA8DBEta4ufGFK1lDt3GqFe03BinxlDStvK+TM0u0NYp5tJ0F/+09J94b
         mkU3xB9gLo44VJn6zwCQwxjTSLMk5FveSn2fQiLLjqe0zzEZ1bdirjljhviHYkWrKwqG
         EfLUh+EzOLk/macN8H4S0OogRmS3Rf/OwLBpp/f6jaW6gDUa4BkVD6HcIKJhn6w65xiV
         Cs4QE7622XkqE5b6j3f+Iquyd1Mo+OrWSk5pF8+c0v/kqOeCfdfnTifQ9sC8lGRcJlXe
         A2Qx3kQpERNgx53Gqog4LHJwtynwmVXrwgdJFZLbOsSMRVFvHl9qB9sPl3MHWFDUt6G2
         h/sQ==
X-Gm-Message-State: ALKqPwczy+Q8hbRHXS2sZJcePAszK6D42rzkPS6C9Wf3ge+zcarcjIGD
        L99Dv0GEldIR63czyx1W1TdSFo4RU5pr2CA8rh4=
X-Google-Smtp-Source: AB8JxZqzJ0+q7LW61MwMqTPfTwtyqaz2hUT0l0Xea3A8jJET9IE9MSQC6PiDIXdRzOH2E9n4mKw73HnoH7poSzfs4q0=
X-Received: by 2002:a50:c944:: with SMTP id p4-v6mr3257254edh.236.1526505643782;
 Wed, 16 May 2018 14:20:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.234.135 with HTTP; Wed, 16 May 2018 14:20:22 -0700 (PDT)
In-Reply-To: <CAGZ79kYBykcbzKxc_FHiL6dt=jkmK2Khe-e5aSxFephe=RsBFA@mail.gmail.com>
References: <CABPp-BHm4B5vXZGHn_i6Aycvc_PDNWSFxLFo9s-ijb511VY9RA@mail.gmail.com>
 <cover.1526488122.git.martin.agren@gmail.com> <0b7440f21e9ff7a066802fe1e7cb3078cf4ed2b8.1526488122.git.martin.agren@gmail.com>
 <CAGZ79kYBykcbzKxc_FHiL6dt=jkmK2Khe-e5aSxFephe=RsBFA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 16 May 2018 14:20:22 -0700
Message-ID: <CA+P7+xpDMz+Drqk0MoC0y1nQgjK_rtqow2rshPotR3EGaOB2bw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] merge: setup `opts` later in `checkout_fast_forward()`
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 16, 2018 at 9:41 AM, Stefan Beller <sbeller@google.com> wrote:
> + Jonathan Tan for a side discussion on anchoring.
>
> On Wed, May 16, 2018 at 9:30 AM, Martin =C3=85gren <martin.agren@gmail.co=
m> wrote:
>>
>> This patch is best viewed using something like this (note the tab!):
>> --color-moved --anchored=3D"      trees[nr_trees] =3D parse_tree_indirec=
t"
>
> Heh! Having a "is best viewed" paragraph is the new shiny thing in
> commit messages as 'git log origin/pu --grep "is best viewed"' tells me.
>
> Regarding the anchoring, I wonder if we can improve it by ignoring
> whitespaces or just looking for substrings, or by allowing regexes or ...
>
> Thanks,
> Stefan

I think expanding it to be regexp would be nicest. To be honest, I
already thought it was substring based....

It'd be *really* cool if we had a way for a commit messages (or maybe
notes?) to indicate the anchor so that git show could (optionally)
figure out the anchor automatically. It's been REALLY useful for me
when showing diffs to be able to provide a better idea of what a human
*actually* did vs what the smallest diff was.

Thanks,
Jake

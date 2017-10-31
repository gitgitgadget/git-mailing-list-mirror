Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ED33202A0
	for <e@80x24.org>; Tue, 31 Oct 2017 08:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbdJaIN0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 04:13:26 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:54927 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbdJaINY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 04:13:24 -0400
Received: by mail-pf0-f196.google.com with SMTP id n89so13159467pfk.11
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 01:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=mgsBfk42wFAQRCIaIsa2PNegFHKT5A/46voMTdZYbG8=;
        b=RJACRIHShd/ikD2H8Fn7VSzhYPjWGgdDyFRylgMJoK2fTbzHE4Uiz0llBZieVeZlL2
         9j6fRkWz9DUPcVmB33UsvS9VUR7KthwsuH8U2e6ys6rv3NvJAYD8cw/CJdWAauM9PNUn
         Dp6/u0QHQzVp6Nl9xjC1pI+y1vE6Nyc0frh+LXajR5eRxvvhqYwRO4TOkZmeNFLLBt1u
         waRPR3YxBbz4Vtip7LbhMO1pjgWlo4YCj7sYVz6PfPNikaLJJynQl93Sk39ZwVgIMSsE
         /5VkYG2KMvet6u8YN0xIjod5fA6TgRhRKb4m+e493TxgwPKsjqgMAXmeVoav21GnGhn/
         IApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=mgsBfk42wFAQRCIaIsa2PNegFHKT5A/46voMTdZYbG8=;
        b=AQVaKX1Wzf6O47Tq58TJUY03tIxKIgtvwlP2cTcs6iKTCUlS1Hx0R1f2h7zk/tdWjF
         BXzLyTmOZWSGxqdWsO3TXUbRf4pwBhSTKb6YEIMzAxhUv/4LtwDbjZrVwTsHBucIiFyY
         V7oaYUwOw7Vl5D4oa4JcIg/u3GVc6EGsFDlu8nBjyypUXzrGZCCd7F3QknBNFBZI6fIT
         svEphkU957pLPI91kqydaluCd+QERIvb6Hd+KYeBiIl7+98Res5TZMM7kIPhOavjCu/9
         tlfpX2ZkuELfPviLB9a93Th2WwR6YlC5sCp26jY20ndN8Hjdg/Mfl7edvQ8Joko1Qe59
         jo5Q==
X-Gm-Message-State: AMCzsaUj7YgoulWtdzRlO+cgNAbl7gMaoeVEcfExRPXWFZv96sUgTlvE
        ZjwBUYusSdHgOdG4ojUCHKs=
X-Google-Smtp-Source: ABhQp+SnNACUj6ceJkaWOjLwa0x1QYySEi30EKFhd9/x4PChv+9OvR9W9hy+JEATDJdYdRJve9b0WA==
X-Received: by 10.84.245.145 with SMTP id j17mr1116368pll.163.1509437603244;
        Tue, 31 Oct 2017 01:13:23 -0700 (PDT)
Received: from [192.168.1.126] (50-39-169-152.bvtn.or.frontiernet.net. [50.39.169.152])
        by smtp.gmail.com with ESMTPSA id j1sm1882467pfj.108.2017.10.31.01.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Oct 2017 01:13:21 -0700 (PDT)
Date:   Tue, 31 Oct 2017 01:13:18 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.2.21.1.1710301343000.6482@virtualbox>
References: <20171028000152.2760-1-jacob.e.keller@intel.com> <alpine.DEB.2.21.1.1710281740070.6482@virtualbox> <4150d979-f653-e79b-563a-1dc43f12468d@talktalk.net> <xmqq1sll8j6f.fsf@gitster.mtv.corp.google.com> <CA+P7+xrXLcTQpPWgzLwt_yZo=QdfetF36jrc_TtXfqMKR2Hh3w@mail.gmail.com> <xmqqo9op71d8.fsf@gitster.mtv.corp.google.com> <CA+P7+xo5UgUPQCYU-LaXn+HZZ1qe++KOevTMh2C1sgnzK0SAQA@mail.gmail.com> <7026e5be-bbf0-9d55-8901-f920a775879b@talktalk.net> <alpine.DEB.2.21.1.1710301343000.6482@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] rebase: exec leaks GIT_DIR to environment
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
CC:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
From:   Jacob Keller <jacob.keller@gmail.com>
Message-ID: <A0F486F0-DDA3-4E99-9C0F-371387093C51@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On October 30, 2017 5:46:36 AM PDT, Johannes Schindelin <Johannes=2ESchind=
elin@gmx=2Ede> wrote:
>Hi Phillip,
>
>On Mon, 30 Oct 2017, Phillip Wood wrote:
>
>> On 30/10/17 06:26, Jacob Keller wrote:
>> > On Sun, Oct 29, 2017 at 8:36 PM, Junio C Hamano <gitster@pobox=2Ecom>
>wrote:
>> >> Jacob Keller <jacob=2Ekeller@gmail=2Ecom> writes:
>> >>
>> >>> I am pretty confident we can fix it=2E=2E=2E=2E
>> >>
>> >> I am sure we can eventually, but 3 hours is not enough soak time=2E
>> >>
>> >> I am inclined to leave the fix for 2=2E15=2E1/2=2E16=2E0 instead of
>delaying
>> >> the release by 10 more days=2E
>> >=20
>> > That's fair=2E I'm not even sure it was introduced since the last
>> > release (I tried 2=2E12, but not 2=2E13 or 2=2E14 manually)=2E Thus, =
it
>likely
>> > wasn't noticed for at least a release, meaning it's less important
>(to
>> > me at least) that we provide a fix immediately, since it went
>> > unnoticed this long, likely that means few people will be impacted=2E
>>=20
>> It is in 2=2E14=2E3, I haven't bisected but I suspect it was introduced
>by
>> 311af5266b sequencer (rebase -i): implement the 'exec' command
>>=20
>> Running
>> git rebase -x'perl -e '\''$,=3D$\=3D"\n"; print  grep { /^GIT_/ } sort
>keys
>> %ENV'\' @
>> Shows that the rebase--helper version also sets GIT_PREFIX as well as
>> GIT_DIR, I suspect the difference is coming from differences in the
>> setup for builtin commands vs external commands=2E The shell version
>and
>> the rebase--helper version set GIT_CHERRY_PICK_HELP, GIT_EDITOR,
>> GIT_INTERNAL_GETTEXT_SH_SCHEME, GIT_REFLOG_ACTION
>
>Indeed, when you look at git_dir_init in git-sh-setup, you will see
>that
>Unix shell scripts explicitly get their GIT_DIR turned into an absolute
>path=2E
>
>So my suggested patch is wrong, and it should be more along the lines
>of
>
>	struct strbuf buf =3D STRBUF_INIT;
>	const char *child_env[] =3D { NULL, NULL };
>
>	strbuf_addf(&buf, "GIT_DIR=3D%s", absolute_path(get_git_dir()));
>	child_env[0] =3D buf=2Ebuf;
>
>	=2E=2E=2E
>
>	strbuf_release(&buf);
>
>Jake, can I still take you up on taking it from here?
>
>Ciao,
>Dscho

Yes, I will clean this up and submit something tomorrow once I get to a co=
mputer=2E I didn't end up having time to work on Git today=2E

Thanks,
Jake

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

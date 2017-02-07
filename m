Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3DF11FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 15:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754838AbdBGPeG (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 10:34:06 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:35543 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753840AbdBGPeF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 10:34:05 -0500
Received: by mail-it0-f47.google.com with SMTP id 203so79310130ith.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 07:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Rhq3J5by/iTJLR4XOxcPqDyFPyvkDaBKvOYSKIMSHrs=;
        b=sdvgbrUrwvPQpEkAljBl3C6TIYdt55MjyNY3ZUlb0nPDMQm18OJcD2ju+IGWuvs6yL
         TXq1vl/0PUHKx5cY85Hvt0M/2KgmH43ZFNJRW2CpkuOmFY6YCNmJVri8TZio+w2WYj0N
         JADDYmSjmCWoYTzrjbrNL2Z5psggTkJmJsj7cHduknch6hkKrWhkiWwNXif64LI0Kz+O
         JFwYVP5TVYqaQszxnHlP2eJ4HPjUF2d4ulHg+2ycLxKsXVmDAhuf0BgtqJ6iBGZcX9pi
         2k9m4hduwm5YObR7SFdUJGCG17rTgEEGTDFt65zYXULzx2mRVY5dEoeTRnG1t3HQIVyr
         48lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Rhq3J5by/iTJLR4XOxcPqDyFPyvkDaBKvOYSKIMSHrs=;
        b=JWwUDflZkxjuSYuFMLXN4vbwsVSh9V7lS7gg2tP4Edpba9GUommhrYmkVJ1w6c/ZDe
         aXtRRz41ZAKsNhgGaOJ8VE/fSp2ktMy/5kYi40ZUzTtrtkBjQVM6hf0zPvJpRtUE4YYl
         qV5jY5SRpRDdiERdG7ugFVYUejbvQT+6etGh66AqJT5ccvs1zwzNW7y35tP5BdLfMmSS
         K9XQJ0xeBhlcLESpQLKtCT6apr+qZPj78ZzSTsd3EltzBE86FAT5CxVq3/zEr4OI7UhF
         W/W1tNdOQ2XNmZIMdOSal15OdEz6E5LkMHXlxpW0UsAh/rfxKCcL50cZ7uSCuZRz3Jaj
         6NOg==
X-Gm-Message-State: AIkVDXKIYqOtUgARNqiSHYee5QpP0Xtjvtx8QfNOigXJTlBGrupby2iAnjiBpuQeqQOeOm9RxsS+k5wOL3PA15ah
X-Received: by 10.36.65.4 with SMTP id x4mr12426785ita.69.1486481644972; Tue,
 07 Feb 2017 07:34:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 7 Feb 2017 07:34:04 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1702071303370.3496@virtualbox>
References: <CADoxLGPFgF7W4XJzt0X+xFJDoN6RmfFGx_96MO9GPSSOjDK0EQ@mail.gmail.com>
 <CAJo=hJsS6FmL9iNScaXqkWJumALfGr8Od5QkbfZ+ZG3osxkp7Q@mail.gmail.com>
 <CAP8UFD2ffeHr0-z3xPFFODqRTTgVnrrWcYRbASpUOrp0QGnp6g@mail.gmail.com>
 <xmqq4m070xua.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702071303370.3496@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 7 Feb 2017 07:34:04 -0800
Message-ID: <CAGZ79kYPx9_z9x86BwC4bW4D9fPNwzjvPsW8mAsnkk94wtmQSw@mail.gmail.com>
Subject: Re: Git clonebundles
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shawn Pearce <spearce@spearce.org>,
        Stefan Saasen <ssaasen@atlassian.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 7, 2017 at 4:04 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Junio,
>
> On Mon, 6 Feb 2017, Junio C Hamano wrote:
>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>> > There is also Junio's work on Bundle v3 that was unfortunately
>> > recently discarded.  Look for "jc/bundle" in:
>> >
>> > http://public-inbox.org/git/xmqq4m0cry60.fsf@gitster.mtv.corp.google.com/
>> >
>> > and previous "What's cooking in git.git" emails.
>>
>> If people think it might be useful to have it around to experiment, I
>> can resurrect and keep that in 'pu' (or rather 'jch'), as long as it
>> does not overlap and conflict with other topics in flight.  Let me try
>> that in today's integration cycle.
>
> I would like to remind you of my suggestion to make this more publicly
> visible and substantially easier to play with, by adding it as an
> experimental feature (possibly guarded via an explicit opt-in config
> setting).
>
> Ciao,
> Johannes

For making this more publicly visible, I want to look into publishing
the cooking reports on the git-scm.com. Maybe we can have a "dev"
section there, that has
* a "getting started" section
  linking to
    Documentation/SubmittingPatches
    How to setup your travis
* "current state of development" section
  e.g. the cooking reports, the
  release calender, description of the workflow
  (which branches do exist and serve which purpose),

Most of the static information is already covered quite
well in Documentation/ so there is definitively overlap,
hence lots of links to the ground truth.

The dynamic information however (release calender,
cooking reports) are not described well enough in
Documentation/ so I think we'd want to focus on these
in that dev section.

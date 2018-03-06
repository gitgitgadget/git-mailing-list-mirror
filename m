Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF19E1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 19:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753898AbeCFT2G (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 14:28:06 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:51161 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbeCFT2E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 14:28:04 -0500
Received: by mail-wm0-f42.google.com with SMTP id w128so385563wmw.0
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 11:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SzWKe04pQpYPTzUzvmfcMgTjOJDfYxdxei7eAK+NO3A=;
        b=f5rHxGEXZC/9Z2YhjuxztTeajgeylXzQvxeLFhK90ZL8gngjJX39/H18N7vtfk9wHw
         1jqnZ1s2Ny3c+Hp/F1WrqQK704TuP1SygZMuseu8ZqfTD8TETMrcaA+E+oKvY3xvEUJL
         DutwrVDr32EP+IB2GqKXVqnwgobMhCbUeiUj207vEZkoBwSoReU/Wu19wBM4jeZh7vlo
         jbcaFlIT0vDXJ/rsPoj+NI+gugCF2vB92eU0CuHPBIk/HL9otTZODUmJTtm4sfWHf6YE
         WCUE7zawDYQ3+UJvTaV3EnMijLC128KG7qDm36yooH2bM8VGxlJsHrx+VowPt6Wm4niA
         ixCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SzWKe04pQpYPTzUzvmfcMgTjOJDfYxdxei7eAK+NO3A=;
        b=Utdh7YNKFjWNlEsX1ATVmsclPJ4Yyb9BnGho7kR2LNyLyOwv/UWjnebjTlZph6D3it
         Eqrm8Mu1lxHX9QIY37/tyadxWSpbgHfvHjnqvEecxdimIZa3RaTuRfSGKTKvnq2uXcXr
         s7z5I/3UZSXmt3u94LngvcVPj/2TUMFuxZvg9/1A+NH41kNjn79fFHdrq2IymujnHDlZ
         HzWsu7TaMxNuB/q/JPW0/vy9gkSzwujQdHa0m6BQB4sfUIm3xcdd7LMkei12sxBelfGg
         m2JKEjHD3rqNBu2c2V9c9o7ZBUwUuhq+0I30oO47ceF33QuRthglHKnpuLUrhbDZHn9+
         jdyw==
X-Gm-Message-State: AElRT7E101Yc3S/5Bu7BsaWP3IDuDFChETii7WkOCZQ0bfLKKT5fIlUZ
        E2yK40PuL5kq2pzcoRAF5WxjhmNn
X-Google-Smtp-Source: AG47ELsVyu24PGT489//NBle5ZIAdhcJWLmi9ygcmabUFgGKkq3C7FJHTvbDRDV0TIWIZO7PhQrpTg==
X-Received: by 10.28.31.215 with SMTP id f206mr3823095wmf.68.1520364482429;
        Tue, 06 Mar 2018 11:28:02 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a1sm15970515wra.41.2018.03.06.11.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 11:28:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Birger Skogeng Pedersen <birgersp@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] git-gui: Add hotkeys to change focus between ui widgets
References: <CAGr--=LZ9TSM9v0SZOi_mj1t8se0Ck-nDHkwum3kC8uz9HKW6A@mail.gmail.com>
        <20180228121052.10642-1-birgersp@gmail.com>
        <nycvar.QRO.7.76.6.1803051749060.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CAGr--=+cAbd=8NDu5M8dbeWn=uoevhJjSvN+bgfDPWjA=V0KnQ@mail.gmail.com>
Date:   Tue, 06 Mar 2018 11:28:01 -0800
In-Reply-To: <CAGr--=+cAbd=8NDu5M8dbeWn=uoevhJjSvN+bgfDPWjA=V0KnQ@mail.gmail.com>
        (Birger Skogeng Pedersen's message of "Tue, 6 Mar 2018 15:35:21
        +0100")
Message-ID: <xmqqbmg13sxq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Birger Skogeng Pedersen <birgersp@gmail.com> writes:

> Thanks for the feedback.
>
> On Mon, Mar 5, 2018 at 5:55 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Do you think there is a way to focus on the last-selected path? That would
>> make this feature even more convenient, I think.
>
> Yes, good idea. I'll implement it and create a second version.

Please make it a patch against the main git-gui project, not against
our tree.  That is, your patch text would look like this:

    diff --git a/git-gui.sh b/git-gui.sh
    index 5bc21b878d..39e80ebafa 100755
    --- a/git-gui.sh
    +++ b/git-gui.sh
    @@ -3843,6 +3843,7 @@ bind .   <$M1B-Key-equal> {show_more_context;break}
     bind .   <$M1B-Key-plus> {show_more_context;break}
     bind .   <$M1B-Key-KP_Add> {show_more_context;break}
     bind .   <$M1B-Key-Return> do_commit
    +bind .   <$M1B-Key-KP_Enter> do_commit
     foreach i [list $ui_index $ui_workdir] {
            bind $i <Button-1>       { toggle_or_diff click %W %x %y; break }
            bind $i <$M1B-Button-1>  { add_one_to_selection %W %x %y; break }

We've seen three patches to git-gui from three different people in
the past week.  The project seems to be abandoned and we need to
find a volunteer (or a few) to take it over, it seems.  In the
meantime I have blindly been picking and queuing git-gui changes
but because I am not even a casual user of it, I know I will not do
a good job maintaining it in the longer term.

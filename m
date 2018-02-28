Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2CBD1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 19:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932950AbeB1Tmj (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 14:42:39 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:43196 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932778AbeB1Tmi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 14:42:38 -0500
Received: by mail-wr0-f178.google.com with SMTP id u49so3658842wrc.10
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 11:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=84N5srFJ9XamA1BmXbNUPHGl+4JA68jHqQHaT0uHmz8=;
        b=XGeV3BSRyBwIHoXDitxFxg8CGf2e9S3vN10/qB86ZO2Ul0Vjd7n8vJSF5hwKwFJ1MK
         Ajw123Aj/oSvqlPBYCh7XEjarSReDxxmXf0VkHevPfr7kkc2pcgl8GIOvzINUNNXzT6f
         td6mzh+BPz24u84pZvpnkjmQWQHXhHiDCmUv3XunHzdt88vS/LpBdgtureKkj2vO4G5Y
         RoeB2CVy+CvAgz+h92sFSAbIGCFjcYBs0CucO0vcNA1k80RsqBucBGIJgEwAhDisfTi1
         HsVMxhHBoYlLIM34laU99tXKN+haWNEjV9mtTjIKPBSpxxfZLYRPnQqPYqjkuuMPk7xG
         /PTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=84N5srFJ9XamA1BmXbNUPHGl+4JA68jHqQHaT0uHmz8=;
        b=gbE6zq5lFmrNVFi8Yr9p45EUN6zfAeHaN+TqbTxtYJpqNI1ILXp6tkuS0BEqvdItBA
         BlDqD4tdM8hMA6Na9BUCUZP5QFtLi0FL9r4ZFODX+4xjSTZ467BzeKF54KCvCD5fJdDj
         WrMec0N8nFnt1tDm3TBXEvvCa+k3b2Uxkycw3eIMDn6RVxOxEydCHav7fAY0Asnn+PA9
         M/tuGaXmBe3+/WcnphhhcCmRQqUs7isIORL5B/Y3qG5PR5z7AmbpxAtFKb6fEuzqex+M
         3Yx2bYgC7uRJv79v69Ql6c/fivYIVhIhxdBvz9fqMmVF4DU6mEk8BDeSE6hYA9Fp0woY
         6vbA==
X-Gm-Message-State: APf1xPDYeqbPyJl5aX71CmPoONb1jYV+SWhBSrnJSht22bBr5qbJDUl8
        7+PErNTAbpO525l0PpmTW/A=
X-Google-Smtp-Source: AG47ELtabL+55AQK4NIBsT0J2sNxuaDm8LVevjXbpm+8uSyNO1LFmdmBfFyKYq8zM+gDK10a4v7CbA==
X-Received: by 10.223.139.130 with SMTP id o2mr13106923wra.147.1519846956990;
        Wed, 28 Feb 2018 11:42:36 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id 32sm2074592wrm.14.2018.02.28.11.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2018 11:42:36 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Sergey Organov <sorganov@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <nycvar.QRO.7.76.6.1802272330290.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87sh9lmzwy.fsf@javad.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <99fdde36-f616-7947-faa0-1b369d0bec97@gmail.com>
Date:   Wed, 28 Feb 2018 20:42:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87sh9lmzwy.fsf@javad.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On 28/02/2018 06:44, Sergey Organov wrote:
> 
> > > Here`s our starting position:
> > >
> > > (0) ---X1---o---o---o---o---o---X2 (master)
> > >        |\
> > >        | A1---A2---A3
> > >        |             \
> > >        |              M (topic)
> > >        |             /
> > >        \-B1---B2---B3
> > >
> > >
> > > Now, we want to rebase merge commit M from X1 onto X2. First, rebase
> > > merge commit parents as usual:
> > >
> > > (1) ---X1---o---o---o---o---o---X2
> > >        |\                       |\
> > >        | A1---A2---A3           | A1'--A2'--A3'
> > >        |             \          |
> > >        |              M         |
> > >        |             /          |
> > >        \-B1---B2---B3           \-B1'--B2'--B3'
> > >
> > >
> > > That was commonly understandable part.
> >
> > Good. Let's assume that I want to do this interactively (because let's
> > face it, rebase is boring unless we shake up things a little). And let's
> > assume that A1 is my only change to the README, and that I realized that
> > it was incorrect and I do not want the world to see it, so I drop A1'.
> >
> > Let's see how things go from here:
> >
> > > Now, for "rebasing" the merge commit (keeping possible amendments), we
> > > do some extra work. First, we make two temporary commits on top of old
> > > merge parents, by using exact tree (snapshot) of commit M:
> > >
> > > (2) ---X1---o---o---o---o---o---X2
> > >        |\                       |\
> > >        | A1---A2---A3---U1      | A1'--A2'--A3'
> > >        |             \          |
> > >        |              M         |
> > >        |             /          |
> > >        \-B1---B2---B3---U2      \-B1'--B2'--B3'
> >
> > Okay, everything would still be the same except that I still have dropped
> > A1'.
> >
> > > So here, in terms of _snapshots_ (trees, not diffs), U1 = U2 = M.
> > >
> > > Now, we rebase these temporary commits, too:
> > >
> > > (3) ---X1---o---o---o---o---o---X2
> > >        |\                       |\
> > >        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
> > >        |             \          |
> > >        |              M         |
> > >        |             /          |
> > >        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'
> >
> > I still want to drop A1 in this rebase, so A1' is still missing.
> >
> > And now it starts to get interesting.
> >
> > The diff between A3 and U1 does not touch the README, of course, as I said
> > that only A1 changed the README.  But the diff between B3 and U2 does
> > change the README, thanks to M containing A1 change.
> >
> > Therefore, the diff between B3' and U2' will also have this change to the
> > README. That change that I wanted to drop.
> >
> > > As a next step, we merge these temporary commits to produce our
> > > "rebased" merged commit M:
> > >
> > > (4) ---X1---o---o---o---o---o---X2
> > >        |\                       |\
> > >        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
> > >        |             \          |                  \
> > >        |              M         |                   M'
> > >        |             /          |                  /
> > >        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'
> >
> > And here, thanks to B3'..U2' changing the README, M' will also have that
> > change that I wanted to see dropped.
> >
> > Note that A1' is still dropped in my example.
> >
> > > Finally, we drop temporary commits, and record rebased commits A3' 
> > > and B3' as our "rebased" merge commit parents instead (merge commit 
> > > M' keeps its same tree/snapshot state, just gets parents replaced):
> > >
> > > (5) ---X1---o---o---o---o---o---X2
> > >        |\                       |\
> > >        | A1---A2---A3---U1      | A1'--A2'--A3'
> > >        |             \          |             \
> > >        |              M         |              M'
> > >        |             /          |             /
> > >        \-B1---B2---B3---U2      \-B1'--B2'--B3'
> >
> > Now, thanks to U2' being dropped (and A1' *still* being dropped), the
> > change in the README that is still in M' is really only in M'. No other
> > rebased commit has it. That makes it look as if M' introduced this change
> > in addition to the changes that were merged between the merge parents.
> 
> Except that original proposal suggests to cosider this a conflict and
> to stop for amendment, as U1' and U2' now differ.

Thanks for bringing this one up again - I focused on a mere example 
of how the approach could work, not stressing enough the simplicity 
of recognizing when it really doesn`t, which is an important aspect 
to know as well, indeed, supporting much needed trust that no bad 
things could happen behind our back.

Either work as expected, or fail loudly, yes.

Regards, Buga

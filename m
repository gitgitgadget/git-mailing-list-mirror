Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B00EF1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 22:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeHWCTo (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 22:19:44 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:54944 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeHWCTo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 22:19:44 -0400
Received: by mail-wm0-f54.google.com with SMTP id c14-v6so3374278wmb.4
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 15:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XXX8cAKIA2Z9QW7ZpzK96bB7MXJXnKvZt1rCxzzWNPk=;
        b=jZ7PRJ97d45BkYl5OqqeiA9ePfAJIecUatHALTwNASZXV5soz+1ESK2EOynL6ifcFg
         GnAzzfDGBLve4Eu/AwUequJgZ2bphpxJpi+d6IxfkmLfCaqP69UUqIBUbip8tOfhX/QF
         76B08svxn6duCpXwVMa+zDDCxPMzZMh9W2to3grzAHGonA4IPPMj6o8WAotTxohp6wsA
         S7+zVOngv81tmleEbMoRJtZevw0SL/3IWzPOerZET4D5dvz6cS1nSzQ6cfRVDd5JYyNw
         IatSdHu0P/sVjDDl22q+mKu9JFD0kKSKxU8Kk0cMUD8tIRRxkjFsGw2qO5BMr5rJREob
         Y4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XXX8cAKIA2Z9QW7ZpzK96bB7MXJXnKvZt1rCxzzWNPk=;
        b=gASEKLxpDT+e0x5kfwq8OodB5c7JLMDqCFV+lUOBk3iV2Xenqiv0yD4aJGlxgC17bU
         2ZzHqVEfcfWpjfrrf4XJ/T8TGdCGJoqij8celdWLdERU32L+crIw4KBrowOusoiKcz1l
         HIenuZO0G6hs7VXpdOdEB/odqKDW3arK1oeQ0gimJMm9wcjDTY8G9v51Ket3YbbA9epP
         dhI1UpgN3paGooFzrbQ2pE0b2OeBPDkZvxcm3i4yJG57IHdMBYfYk+HEqI1RtFglGa8t
         6ujxYd1U1HcvZo3+/HwaCW+CzAAC2eTphbo/N8PRHsvr2zuNHX3OUZ+b2nTXtP1WIclc
         S7Uw==
X-Gm-Message-State: APzg51DZ5fqEVmQwvnCQadpc+by3+WP4e+irrqLAD00ijdxANFXs9LMq
        gdVEze+ewg/UD6Y4qMaq/Gg=
X-Google-Smtp-Source: ANB0VdYUnFbCweDpllLcLr3RZwtSuNllWHLxu7q1OIsjbU5P8ftCDDQbkYop2eqpQjX06HajdCgrqw==
X-Received: by 2002:a1c:5f82:: with SMTP id t124-v6mr3626097wmb.14.1534978375127;
        Wed, 22 Aug 2018 15:52:55 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b144-v6sm4108644wmd.23.2018.08.22.15.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 15:52:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2018, #05; Mon, 20)
References: <xmqqsh38admf.fsf@gitster-ct.c.googlers.com>
        <xmqqo9dumh9z.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1808222339490.73@tvgsbejvaqbjf.bet>
Date:   Wed, 22 Aug 2018 15:52:53 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1808222339490.73@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 22 Aug 2018 23:44:17 +0200 (DST)")
Message-ID: <xmqqin42ko8q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> FWIW I am a lot more bold about these builtins, and want to get them into
> Git for Windows v2.19.0, either as full replacements, or like I did with
> the difftool: by offering them as experimental options in the installer.
>
> Maybe this will remain a dream, but maybe, just maybe, I will manage to do
> this, with your help.

Heh, I do not think you need much help from me to cut GfW releases.

In any case, thanks for a quick "last mile" patch, which unblocked
'pu' that has been in sorry state for about a week or so.  I've
inserted a new topic branch between -5 and -6 that (1) merges the
other track into -5 and (2) applies your "call it in a new way"
patch, and then rebased -6 on top of the result.  If you have a
chance, it is appreciated if you can give a quick eyeballing near
the tip of 'pu' today.

Thanks.

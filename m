Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16191206FB
	for <e@80x24.org>; Fri,  8 Jul 2016 22:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756241AbcGHWvH (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 18:51:07 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38680 "EHLO
	mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756172AbcGHWvF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 18:51:05 -0400
Received: by mail-it0-f49.google.com with SMTP id h190so20970495ith.1
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 15:51:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A5uTyovxsXYoEMd5RlX0i38pOAAxXjnVhYMfPj2ARfY=;
        b=DiUiYk6alZC7A3v+CxL1xbA4qfYXLPKafrzCplEZ2SHc2YyQbicuRVs+YkBpuxLyQH
         HKoH/jMi7Uz90LvIGhpcuniKXY1pmpjG1v9PExcfZ3/BEBDkhIOczVZZKZ0uoED1Q+cM
         jbnfXDBTZ+7kwBp8pvJ5mSGEHmUFYMOrVktA3NRTvOkaz6E2+/oTugR7XMKkSsPs5fdk
         af4WsTmAzWnQFHSXO1gfBV+tLOMyzJte9nPoDLSlLSbk0OWrfMK6+IdMIeoTzQcHRzC4
         PuyZYEoCqOp8ZMJ1m9FgqED6mjGNOWLw9aMQ0ESnX/blYFf4m2gIT4w/F6sQYAk8hvpI
         d4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A5uTyovxsXYoEMd5RlX0i38pOAAxXjnVhYMfPj2ARfY=;
        b=IiI17kz8Uvmgm+6jzvoiR1efFETlNcDpwVkW0nFnnEUKNIL8k4/DZK5HCeysqRxkAo
         GBILdFvwEe2KF02Ro0qWBdkfHp/S+9D4i+zYyTtaXymwvzQLl3FjY6BHe6EdXrGQGOYT
         BLpasFe3//MhiplZOizlnErlXge9yfvLG0vzpYuMlKYVDyXul+gMc8RnH80ZCBxVFiOS
         jnUNAn25j4CyYP6HGEUUYf9MuwPbgx6/mM/tLkKXh4A3a2E9I2CDqztL1WDQCo5xhisP
         noX+c3e+LsgxtzuxoWnOoFYTV/6P4l/q570qbSpHUVNGrhURuSBiBjRbYp0HMG8CwPCu
         rQnQ==
X-Gm-Message-State: ALyK8tIbaFVeKGNYXsbNVhpSFSoeqta5wgqGPF76MCg7RU0u0EBB/BCMp0TxFcw0FtUaBTBSrfRG54UBBK4y9hDR
X-Received: by 10.36.120.71 with SMTP id p68mr5965632itc.46.1468018261751;
 Fri, 08 Jul 2016 15:51:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Fri, 8 Jul 2016 15:51:01 -0700 (PDT)
In-Reply-To: <20160708224601.GA11389@sigill.intra.peff.net>
References: <xmqqh9c1nlvm.fsf@gitster.mtv.corp.google.com> <20160708175821.GA29326@google.com>
 <xmqqshvkkm86.fsf@gitster.mtv.corp.google.com> <CAGZ79ka8eHOx28Ja+S6DOGEOrV_ijUvi_NnjprhuzQ+3O9BAoQ@mail.gmail.com>
 <20160708214637.GB9820@sigill.intra.peff.net> <CAGZ79kZOdcJwd0ePMquhfJTv=xZGP_+w4BRV=GyTy3ejb79yrQ@mail.gmail.com>
 <20160708222127.GA10756@sigill.intra.peff.net> <CAGZ79kbu1ec-8LiFrvnXqFqsjFnEofhjZnxcENa1aA1K56m9Fg@mail.gmail.com>
 <20160708223533.GA11056@sigill.intra.peff.net> <CAGZ79kbj8tGb9BsTo_CGqOdfsinJrafHAY5HhQEQDCtAXQqKgw@mail.gmail.com>
 <20160708224601.GA11389@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 8 Jul 2016 15:51:01 -0700
Message-ID: <CAGZ79kbgbuFWni49z5nZuhmPGtkEYkaGYnZonByyhUYJ9=j1+Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 8, 2016 at 3:46 PM, Jeff King <peff@peff.net> wrote:
> Sorry, I meant converting die() into:
>
>   rp_error(...);
>   die(...);
>
> possibly via an rp_die() helper.  The existing rp_error() cases would
> remain untouched.

Oh I see!
That makes a lot of sense.

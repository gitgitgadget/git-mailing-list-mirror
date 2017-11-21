Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32BEC2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 22:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbdKUWMN (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 17:12:13 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44506 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbdKUWMM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 17:12:12 -0500
Received: by mail-wr0-f196.google.com with SMTP id l22so12680749wrc.11
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 14:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e35y6ur99RgJgK3+C+gKsYNX9QOmlWF80gnfw6qRcWs=;
        b=DCiH+N/m3q8iPKu/U9nhfvqpJS41cEELItUOE295R6ziYHQYWeeqqAYeBFiChXIfjM
         G+OQywDaPMneDRhCgEbWB64uSKRDStZ3Zy9yQnWSfqtrVVUfrIrCNjkrJPQSsY/1WMK2
         KcUqRQ9AYVhLF9UyzfwqGCv4kUidYEfQ/5SDuY/SpUB1uvs5t9JpI/GQCebMXcXijFMq
         QlimVDxOmJ2r2lhqFWCMiBVd/noadjFSlLUQmKUzIwc5z8LF7OE0SNf2xo25JKCI3yqA
         /XhMqNbxXPIdaKGToONu472F4vn0PKMZ53+hIUZDCd7Dz1Xe3KFbRpuAvH9bKw4vDnjT
         3ZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e35y6ur99RgJgK3+C+gKsYNX9QOmlWF80gnfw6qRcWs=;
        b=i/I4uI7Z9tJoTWk3s0SV2p1tAo8Ytu7cO5q+2KFtSI0Z/TyQSC53lTEkd5Uy+8RvCf
         GMk5ocq4uc8jmoxsM46QbqE35N2Np+b/16NnzV87V8I0Ti+oO/wz018KhoTXDymxBiZ/
         zajZgjR0oAK4BZFAX9myHQ0F0VTgLjJYC3CGmEmA+Tv0BYkdMPA+rG1M9EWxvarcOKQX
         gSPEvLQg98Ll8h8OJ+EOJk22yjwKA+/y3KHncVa8j78KviVgx46+iEPGAZeCxKrjyz3s
         +z88t4HrML+Jsj0lvTAvFwWeC4dxxy1GPAw9C2wwppsqqwZxGDFFq0cicLBnxX7ndR1f
         IO/Q==
X-Gm-Message-State: AJaThX7WuZQvHWT1YyRyGAJz8l6qa3tC6ieOXt14y/YI89NgC8PbwMrS
        E84wW9c+xTGf9aLC2KuSEI0=
X-Google-Smtp-Source: AGs4zMYdQTTrIWCwiFSFecjytlLqFDPyVgmXPzy6kwW6b6i12OzPNRLj7xVE+54iIUgRtf05c8toMA==
X-Received: by 10.223.189.11 with SMTP id j11mr11074879wrh.265.1511302330953;
        Tue, 21 Nov 2017 14:12:10 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id j125sm4028914wmf.24.2017.11.21.14.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 14:12:10 -0800 (PST)
Date:   Tue, 21 Nov 2017 22:13:39 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] worktree: make add <path> dwim
Message-ID: <20171121221339.GA4047@hank>
References: <20171118181103.28354-1-t.gummerer@gmail.com>
 <20171118224706.13810-1-t.gummerer@gmail.com>
 <20171118224706.13810-4-t.gummerer@gmail.com>
 <CAPig+cQqbvuZg0Y8ZMObZc7mYXzohooVBFj0-o+CGGXrgGLp5w@mail.gmail.com>
 <CAPig+cTmqHt5s+C1vTFA7S4ZBwjqnzkn-2wA6i3jVeLw7i1_Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTmqHt5s+C1vTFA7S4ZBwjqnzkn-2wA6i3jVeLw7i1_Lg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/19, Eric Sunshine wrote:
> On Sun, Nov 19, 2017 at 2:04 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Sat, Nov 18, 2017 at 5:47 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >> +To disable the behaviour of trying to match the basename of <path> to
> >> +a remote, and always create a new branch from HEAD, the `--no-track`
> >
> > Does --[no-]track deserve to be documented in the OPTIONS section like
> > the other options are?
> 
> One other question: Since this is re-using the well-known option name
> --no-track, should it also get applied to the "git worktree add -b foo
> dir origin/foo" case, as well, which you pointed out (in the patch 2/3
> thread) already DWIMs tracking automatically? (I can easily see
> someone reporting it as a bug if "git worktree add --no-track -b foo
> dir origin/foo" does not suppress tracking.)

I didn't consider that, I think you are right, and the flag should
apply in that case as well.  I think at that point we may as well pass
this flag through to the 'git branch' call, and let users set up
tracking if they want to, the same way it works in 'git branch'.  Thanks!

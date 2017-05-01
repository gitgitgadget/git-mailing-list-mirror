Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7812D1F829
	for <e@80x24.org>; Mon,  1 May 2017 01:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S638332AbdEABrc (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 21:47:32 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34396 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165089AbdEABrb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 21:47:31 -0400
Received: by mail-pg0-f68.google.com with SMTP id t7so14225579pgt.1
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 18:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iH1RwdpEDUn8f5hJhNyNh2xja2UPnAsESRkaHp6vInE=;
        b=Zx/ANKIofFQbwD7ZEh85paU8HGc+wBrAb2BUW5aoMAzB65Uq85/jDO/JXaNFqdPrhA
         hAuWVIX6ZNogqrXk0Mctr+gMkoIlrlCbqrKgv5wIIoYAs1Pambyok16G5FuiLZzIfjHV
         147V/g7+myhAZHWWqDi5coCvoHPq6rVCIeSQe3sXTHH+eLTxa7tdK64ZZWZbAGd4M/OI
         nWnqwvnMk8KO81flLNCNCUICpTzgN7t6vxIxjLRkv2Szs26Pjw3W/9/n62s0Qdt1IfQW
         QnsThHwx2iyrpPe3uXjdLvNGeL1/1EM3LhEU3cTofyd3jcUkVIY8rI3pyUW6g/rDJJnN
         6+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iH1RwdpEDUn8f5hJhNyNh2xja2UPnAsESRkaHp6vInE=;
        b=qRnDXfgBvhw+KrdPo1lVFOPhECSba7TnNwoOMlO4cq04r6i47DGjhVMIuT21dFTWm9
         rwV4IWlJH8WH9FQkbRs5xuf9WULezABf12YP66U5ZQzNAcn39zlSC6fern798r78BCr6
         pHGs8jtaeI/NoO7v6r8H54njryNFzSmN0Mi7a0o9N1Limhv23E4UGaiH2CpCMINn5kX7
         juPvln6RioYS8aa+Q7K9CVIlY0kaHRKej9K01kNoNbqpLkh9cy//8rTYEYX2UuX4X9KH
         qxs6rYM8ZU6r20BFX6LnmkL8hW8ucNMEmVMZ1Onpvlg8rT+Pc799/m/I84bz9gLiKBk4
         ql+A==
X-Gm-Message-State: AN3rC/4kfFULvJI/N2gwgsOb0lWMZWWEq71CkQfNldx4DrmbMp2dw2Oa
        HWfmbDyhPhqv6TX/EkA=
X-Received: by 10.98.166.197 with SMTP id r66mr24130304pfl.5.1493603250875;
        Sun, 30 Apr 2017 18:47:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id t18sm21451892pfg.31.2017.04.30.18.47.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 18:47:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     Robert Eisele <robert@xarg.org>, git@vger.kernel.org
Subject: Re: Bug: Git rename does not work if folder naming was changed from lower to upper case on OSX
References: <10d4f73b-b4bd-4cf8-5727-cdaf10ab713a@xarg.org>
        <20170429201813.GA19256@alpha.vpn.ikke.info>
Date:   Sun, 30 Apr 2017 18:47:29 -0700
In-Reply-To: <20170429201813.GA19256@alpha.vpn.ikke.info> (Kevin Daudt's
        message of "Sat, 29 Apr 2017 22:18:13 +0200")
Message-ID: <xmqqshkpic0e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> Note that git does not store that files are renamed. So a remove + add
> is the same as a rename in git. Only git status shows it when you for
> example use git mv directly, but this information is lost on commit.

Are you sure about the last sentence?  I do not recall teaching
anything special to "git status".  If "git status" says A was
created by renaming B, and if you committed that state was-is, "git
show" on the result commit _should_ say the same thing, I would
think.

> Instead of storing it get relies on detecting what (parts of ) files got
> renamed, copied etc.

That statement I belieave is true.

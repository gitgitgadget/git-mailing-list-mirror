Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90B601FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 16:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbdBFQiU (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 11:38:20 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:35216 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751947AbdBFQiT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 11:38:19 -0500
Received: by mail-wr0-f171.google.com with SMTP id 89so24508740wrr.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 08:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=known.net; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fkbLZyfednom1ptyIAwjcVWAEgUsqk1UhdvVbMaL5UY=;
        b=VM5U/ozZpI5rNQe0iH+KlMDibsJmJu+VOkBhvUbVeFRFFyEq662EuVMKzE13JGy8Fw
         SCqYP81fBCWfsb0IEA2yEE/u7GMToPpYdg3+khPM5SKjYYn7UUDoKaeAjmvNhcgNebxw
         TsFP/ETh5NPYHz79Fnj8G5Ao9LBhc4hDnO/Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fkbLZyfednom1ptyIAwjcVWAEgUsqk1UhdvVbMaL5UY=;
        b=DvXWDYGlxCm6AcLybHTJc+6Q0lRLqTy0CDiOSxXYVQU4nsqfVI7JJ9WaHp83YEEZGM
         kVU7xbwWIHQVA1H26VpdsYoU6CMNWHva4SNFsRgSLD/Ml/X0Y+1z3n5K7XmT/r0sQKYU
         xWraNRHlTJGolvo7pW7ds5iYXtZ7sDCx/+w6Ttd7NN5SPtmdpUGP28hu+7pzE73981F2
         stCIUVfoLhOzE4bvOIaKH50re89kxwhh1+qhaG0Zt15BrFLyOnN6gimEjheVUA7Wuwwt
         c3fz/fCjgxIO/2pyDnVLJFr+WQMKhbZmBTeboMI+0gsffzNUGv6PvWOXdFSWHpL7TtxX
         kJIA==
X-Gm-Message-State: AMke39lL5Z1tSDrm3cKaKh/eqJJzqBhU1hLkuYchx8DnFYmeQtPo+l2IGAoyWGTK2goGWigK7b/LPP8rkqiAc0fK
X-Received: by 10.223.135.8 with SMTP id a8mr12392799wra.162.1486399098054;
 Mon, 06 Feb 2017 08:38:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.76.1 with HTTP; Mon, 6 Feb 2017 08:38:17 -0800 (PST)
In-Reply-To: <3bd29833-8fb2-5097-f735-6a3f61e678bf@tngtech.com>
References: <CAGSZTjKywt28Pq7S+Hidi0XeseDxUAMEorrspZQ6jb50yic3+g@mail.gmail.com>
 <CAGSZTjLrdYJHixsUz0ha6=E263Z-vQuA11Oq=UNSVZfOmHkRuA@mail.gmail.com> <3bd29833-8fb2-5097-f735-6a3f61e678bf@tngtech.com>
From:   Kevin Layer <layer@known.net>
Date:   Mon, 6 Feb 2017 08:38:17 -0800
Message-ID: <CAGSZTjLKtpFRw5d28m88kSzq+_eFH=Sggk408eNJdBw47Fa9=Q@mail.gmail.com>
Subject: Re: BUG: "git checkout -q -b foo origin/foo" is not quiet
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yeah, my bad.  I was confused.  Sorry for the noise.

On Fri, Feb 3, 2017 at 4:55 PM, Cornelius Weig
<cornelius.weig@tngtech.com> wrote:
> On 02/03/2017 10:36 PM, Kevin Layer wrote:
>> Note that git version 1.8.3.1 is quiet and does not print the
>> "tracking remote" message.
>
> So what you are saying is, that git v1.8.3.1 *is* quiet, but v1.7.1 is
> not? Sounds like a fixed bug to me.
>
> I also checked with the latest version and it did not print anything
> when used with -q.
>
>
> You seem to urgently need quiet branch creation. Have you thought about
> dumping unwanted output in the shell? E.g. in bash
>
> $ git whatever >&/dev/null

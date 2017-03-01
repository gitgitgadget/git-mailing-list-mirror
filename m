Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F9302023D
	for <e@80x24.org>; Wed,  1 Mar 2017 19:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753016AbdCATKe (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 14:10:34 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:35833 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbdCATKd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 14:10:33 -0500
Received: by mail-io0-f172.google.com with SMTP id j18so37915248ioe.2
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 11:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P/Qb5sHXzEqyLx0yQ62ZFtQawuYmxoz9aSm2FwbPSUw=;
        b=rxRgSKcv3lc1lMfRtVRWNACdPn3jFb0Y4EQIpq/Ujpel6bMTcdb56jsZsXzeoH3vcQ
         YaiBrgHXZD4EtvcThwMGe55BEXvkxjnp62tXwH0xfo8C/L06N4mkektTSkJmGbWpvIvS
         cnJ2unao6B6C72pUhWyoawCckn1WTUY/dA9W6jcARM03HlRHX1nP88qFGh72liEwm9mz
         aoSY1RSnMz+X0gtgvajd8NUwKPTSt7cpYz5CD/WabLkSk28HEtXr4KOieBUXyGjsg9fH
         EDkDVQYVq7hp/CLgbPDUgd0yQaeugODNgHpeAiGw0WUVI4hck8IHiEyFB8TQ5i1BbOSo
         r5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P/Qb5sHXzEqyLx0yQ62ZFtQawuYmxoz9aSm2FwbPSUw=;
        b=DIhFabI4yYlsJFsqWmiBFdcXZ/rrwJSLVvh9NyOLi/vDt7xKk3Scxh72Uy0yWNJWqB
         V8Oe1YvAabq9cZ0EL51nzABdeNlPDN3DvOT04YWv9UC+6Nhihl9gu3RHvfPyL8adhC5E
         nS+glwi/BO5KxQsVhLFrEgIt6isClqR6puXwwnRZ2n9e2WXZBYb/4Ii50hJ6qSu5VXyC
         rpOlPW/BXQPqKNguu+6LRlFYiXR7r8CVtqJBrunq4nQFOE66HlnQgxAI0T9RedJgy31+
         78f1x8rxz1ZEKJgkc5TyVyJk46XabBclNXIM12F6kJmk72oBNNmyJqzeguNmIczhcZW0
         snuw==
X-Gm-Message-State: AMke39nd3D54QQARpknzvSO4SN8IXdeLNZPpGOhVdsVS1v2ros4h0jEB5KNux/Rx2WBJyRKbKGhY7UbY8RI5PruC
X-Received: by 10.107.37.148 with SMTP id l142mr9517449iol.159.1488395328595;
 Wed, 01 Mar 2017 11:08:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.13.1 with HTTP; Wed, 1 Mar 2017 11:08:48 -0800 (PST)
In-Reply-To: <8cdd9f2d-415c-1b60-0017-bf973e8cf914@riseup.net>
References: <a9da4416-6437-a491-f461-c5e61d805b2d@riseup.net>
 <xmqqmvd6kykc.fsf@gitster.mtv.corp.google.com> <8cdd9f2d-415c-1b60-0017-bf973e8cf914@riseup.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Mar 2017 11:08:48 -0800
Message-ID: <CAGZ79kav0yB=g5kwB68oHRxbd0mDJ5-gGTJSidSKkZ75gmT44Q@mail.gmail.com>
Subject: Re: gpg verify git sub modules useful?
To:     Patrick Schleizer <patrick-mailinglists@whonix.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Whonix-devel <whonix-devel@whonix.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 10:28 AM, Patrick Schleizer
<patrick-mailinglists@whonix.org> wrote:
> Good questions, thank you for trying to figure out what I am asking. :)
>
> Junio C Hamano:
>> Patrick Schleizer <patrick-mailinglists@whonix.org> writes:
>>
>>> When using git submodules, is there value in iterating about the git
>>> submodules running "git verfiy-commit HEAD" or would that be already
>>> covered by the git submodule verification?
>>
>> That depends on what you are referring to with the "git submodule
>> verification"
>
> cd submodule
> if ! git verfiy-commit HEAD ; then
>    error
> fi
>
>> and more importantly what threat you are guarding
>> against.
>
> All main (non-submodule) (merge) commits and submodule (merge) commits
> are signed by me.
>
> 1) git --recursive clone main (non-submodule) git repository
> 2) cd git main repository
> 3) git verify-commit HEAD or git verify-tag tag-name
> 4) git submodule update
>
> What if the main (non-submodule) git repository gpg signature was okay
> but then after git fetched the submodules these compromised (MITM'ed) ones?

The signing in Git is just signing the commit hash essentially.

> Does the having gpg verified the root (main git repository) ensure that
> submodule commits are also quasi verified?

That is my understanding. There is no difference between the security of
a file or a submodule, just the way of obtaining and its reporting is different.
Both a file and a submodule are referred to via a hash (currently sha1).
Obtaining a file is implicit whereas obtaining the submodule is explicit.
The reporting (in e.g. git-status) ... depends on a lot of options to be set.

When signing the superproject, you acknowledge the submodules
being in the state as recorded. (Same with s/submodules/files/)

So I am not sure what kind of additional signing you're looking
for in the submodules.

Thanks,
Stefan

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C57E720450
	for <e@80x24.org>; Fri,  3 Nov 2017 17:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755994AbdKCRSv (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 13:18:51 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:44377 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754212AbdKCRSu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 13:18:50 -0400
Received: by mail-qk0-f180.google.com with SMTP id r64so4086119qkc.1
        for <git@vger.kernel.org>; Fri, 03 Nov 2017 10:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OshpIWPCvb4ZQSpkQGOAZLcmAM44IIKH1avGQWluSU0=;
        b=nCwRFn+511kCHEj+XrCUPhnZ3QllAso+VSta8H73QhZxa+AH93CT/Tte5tShvObwUU
         F2VcLiiv4W1V8/DAD9kuLP7GCVQadeVFWTeUT8E0oNkqpbrrg6pScsIaRfz4QUZTJ949
         yMdw4Ct3sGKv24iea4YYWV1nMIA2kVpxk9rb8CTpU8yXckE+mTbldHhtjS4iVeKitqVF
         +UsJNWFnPvUeozVkOw/VZ0CKi09eKAPunuwaAF0HB6IcCmGE4rXcyfcwt8m5xAy6JXhI
         aTannVTwz3o0xRq3G9kUUCiIHqQtgjNMkOhPMWXTJri/e6GrreiSmj/OSUbmaUs044Eq
         eIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OshpIWPCvb4ZQSpkQGOAZLcmAM44IIKH1avGQWluSU0=;
        b=UC1EQcidB8AZK2V1bKuvVuUfTn60KiMnvjZTGgqu4JJDO3AjygGPhl7Sp7HLy5ImKe
         iYp/BKEhFq47k2lLOs47X7HaBwzwjCbFdUBjKDA7gLynjIXL18q/Copj538LoIG9UNcQ
         G9Yzy+7q80sZlN4KNap4/wrjOxxOadaIzEyf4KISKoLYtSNdfsoJKFahYDF1LdZXHD2P
         3SXg7nHe5GA+om9XkgKpyOU5Jut3bm+jYV8jWcinKx7ZpKWmgCl8io4mTiAPFJNyMXRE
         Mn5ucwLG7mX/MUIaFBk5RcTOGczUw0yalHzUrhJZdVoPCjG5ZCYu2CJ3uXcUy7mKKWE0
         8+eQ==
X-Gm-Message-State: AMCzsaVWku4Wjo8FgxZwKPmIyjMbZK+eFLLGdXJYdU9kOe8fXZmLIw8d
        l5tuvf8PGCFdg8OuFdq7FWRudfDN39wYY2fgDkwH9w==
X-Google-Smtp-Source: ABhQp+ShU3bKYSrrvv3XReNrhngC3ly7kRpKttyuR2scMuoJlT0oXqmOJUPLJvYYUlMAIsBu7/dIME+WNIMWsYWHAeE=
X-Received: by 10.55.129.70 with SMTP id c67mr11234489qkd.230.1509729529687;
 Fri, 03 Nov 2017 10:18:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Fri, 3 Nov 2017 10:18:49 -0700 (PDT)
In-Reply-To: <1509727946.1734.2.camel@kaarsemaker.net>
References: <9f514a9b-858c-9f3a-e2d4-a45987a19b9a@prolan-power.hu> <1509727946.1734.2.camel@kaarsemaker.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 3 Nov 2017 10:18:49 -0700
Message-ID: <CAGZ79kar+YbMyMK-ktOT3WZW5fZB89HL1QabsZAhofcGuSJSbg@mail.gmail.com>
Subject: Re: git, isolation
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     =?UTF-8?B?UMOpdGVy?= <e2qb2a44f@prolan-power.hu>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 3, 2017 at 9:52 AM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On Fri, 2017-11-03 at 17:33 +0100, P=C3=A9ter wrote:
>> Hi,
>>
>> If I do a "git commit", issue git operations, and at the end, issue a "r=
m <the_git_dir>", is there any guarantee that my
>> filesystem will be "clean",
>
> No.
>
>> i.e. not polluted or otherwise modified by some git command? Are the git=
 operations
>> restricted to the repo-directory (and possibly remote places, over netwo=
rk)?
>
> No.
>
>> Do the git-directory behaves as it were
>> chroot-ed or be a sandbox? (Yet another words: is the git-directory isol=
ated from the rest of the local filesystem (and
>> packaging system)?)
>
> And no :)
>
> Most git commands will not touch anything outside the main worktree and
> the .git directory in there, but commands like 'git worktree' can be
> used to create worktrees anywhere in the filesystem, and when you play
> tricks with the GIT_WORK_TREE environment variable, you can do other
> nasty things.

Or a more common thing, implemented earlier in Gits career:

  git config --global ....

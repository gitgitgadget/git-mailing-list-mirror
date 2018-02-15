Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE9121F404
	for <e@80x24.org>; Thu, 15 Feb 2018 22:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163311AbeBOWG7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 17:06:59 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36085 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162892AbeBOWG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 17:06:58 -0500
Received: by mail-wm0-f67.google.com with SMTP id f3so3602490wmc.1
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 14:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=nRwuHjXYxj1tTBdyQFssbaWWCpPI2HGy0zEPYAGunvE=;
        b=s7mv0KP0V3I1ia0sRw4yXbBOYTn1hwaOaQKxAuPnGWT7IQfjoorWg0HD6rCZglPD6J
         /wY53iLP2tlNMUav4/qXoVIAxdYrWBUYyWR6moY45IzN9rbBpDtcEWW7e7xf1sL/g5+X
         gSv4bMVsSlSZ0SRj/g9Xh9ryA4kzzjsPgywWTwbaMI5lHlTKG7U1SlYKwMPs261P1uc4
         +gmtax5M9q+lbPbLTjl6nq5w2cb46Ju1IhtwEmU4WljieEHqQQDiBUm7FQnXq5aNlfS2
         LIZzIenBrpwxjpAWHNaBSB2hC29MOXxH6sKT6sOBFZSSzIWoHqDL2XsXn8LA+q3U9BPn
         JdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=nRwuHjXYxj1tTBdyQFssbaWWCpPI2HGy0zEPYAGunvE=;
        b=QyTFveL644UZKDqpjBUGjNH68iU/Df4+nuMpT/51R/nGFh7VaMzpiqjQYocenp5J8H
         0qX0n6dqx55+tNPpqUZXXIOw36kNjTo8suL76Bo9yeIUpCRiul5O9EykdPCj2rN65ST9
         sO5q9vYHfNW1jFJlLuRafbNcckuWLxgz17nayW/SeejaEUhWkE1wN8vH8dFMtmy63ZiD
         ctImsQ2Nvx6Z6YvgNYzmfxBcjgLjw4LdLVwKuWqS8nnUbvjU87sPEWlM2E/IdLCg7jS2
         bjoUe5D6rRQK4NV6ANrAJl+nLpIqewlj0Bs+FSO/sNWY91F2A3gndZhA2aVclCPiDGXL
         2TdQ==
X-Gm-Message-State: APf1xPD4Jc8Hw4QGP7ca7IU6icW54IjdUoHZ2O/rvWniBtOvy0Ydoixq
        dI6pRrpiigWDRORclR/8c/4=
X-Google-Smtp-Source: AH8x224YDez4oAutzZkxMkYMCe42w6nr//kby7mq4F8BOG3GVpuz3WpF/+5z77upyFaiDY3asX9fKw==
X-Received: by 10.28.63.65 with SMTP id m62mr3186736wma.29.1518732417188;
        Thu, 15 Feb 2018 14:06:57 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j17sm16482759wmc.41.2018.02.15.14.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 14:06:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Herv=C3=A9?= Beraud <herveberaud.pro@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] make hg-to-git compatible with python2.x and 3.x
References: <01020161992fe7ce-b41bf370-1480-4efe-8980-0c52fb9b9be5-000000@eu-west-1.amazonses.com>
Date:   Thu, 15 Feb 2018 14:06:55 -0800
In-Reply-To: <01020161992fe7ce-b41bf370-1480-4efe-8980-0c52fb9b9be5-000000@eu-west-1.amazonses.com>
        (=?utf-8?Q?=22Herv=C3=A9?= Beraud"'s message of "Thu, 15 Feb 2018 11:18:29
 +0000")
Message-ID: <xmqq4lmh9abk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hervé Beraud <herveberaud.pro@gmail.com> writes:

> ---

Thanks for posting, but this is way under-justified, even for
something in contrib/ area.  

Are all changes in this patch necessary to "make it compatible with
both Python 2 and 3", or are some parts do not contribute directly
to the objective but are good changes to suit your personal taste,
match BCP styles, etc.?  I am guessing it is the latter (e.g. with
Python 3, you cannot use print without invoking it as a function,
but os.system() can still accept a literal command line string, so
introducing variable "rm_f" that gets assigned a literal string only
once to pass it to os.system() does not have anything to do with the
Python2to3 transition), and if that is the case, it makes sense to
split this into at least 2 patches, i.e. prelimiary clean-up,
followed by changes required to run it with Python3.  It also is OK
to make it a 3-patch series, in which case you would limit the
preliminary clean-up to minimum uncontroversial changes and follow
up with an optional update to suit personal taste at the very end.

Also, the submission needs to be signed-off for us to be able to
use.  Please see Documentation/SubmittingPatches for details.

Thanks.

>  contrib/hg-to-git/hg-to-git.py | 140 ++++++++++++++++++++++++-----------------
>  1 file changed, 83 insertions(+), 57 deletions(-)
>
> diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
> ...
>      os.system('git ls-files -x .hg --others | git update-index --add --stdin')
>      # delete removed files
> -    os.system('git ls-files -x .hg --deleted | git update-index --remove --stdin')
> +    rm_f = 'git ls-files -x .hg --deleted | git update-index --remove --stdin'
> +    os.system(rm_f)
>  ... 
> @@ -247,7 +273,7 @@ def getgitenv(user, date):
>  # write the state for incrementals
>  if state:
>      if verbose:
> -        print 'Writing state'
> +        print('Writing state')
>      f = open(state, 'w')
>      pickle.dump(hgvers, f)
>  
>
> --
> https://github.com/git/git/pull/458

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B381E1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 09:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933318AbeFLJvb (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 05:51:31 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34556 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932639AbeFLJva (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 05:51:30 -0400
Received: by mail-pg0-f45.google.com with SMTP id q4-v6so10146245pgr.1
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 02:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=h9oaNjvKA/TVyUjxkqEZFue5D8qXcZ3WF2cKiDvridI=;
        b=Syc8yJY3vkyeSV49jBi2iwF7pfwNQd8KdVGCHLn81ks1dCgKlvyOBzKfXJfsFsXP3o
         Qgi/ErmekAQg/Y9c0xtMhFfvt0QUP2zDZXSEzi31TvaFGc/PIodb8uQQ90U/J5YrwTI+
         yOcgHgL98JGs2BsUmLHIFwodm6KnPAayPafoeUX8KWZll8TXBQLzHIskfnai6VlTa15T
         DTC+2o32TEouI+piebAywbOEk/TycaQqM0XzUzY7Cbn80XTvBA1m9N4xpQufC7Roy3JZ
         cMUlduJzTs4PZLUGSVJiFHBU4IJWxgP7NGrqlMnIK7QcTpQrEJUT2mOO+BZ/isgKGWWA
         YYRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wol.ph; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=h9oaNjvKA/TVyUjxkqEZFue5D8qXcZ3WF2cKiDvridI=;
        b=HF8WaXyuMpPrFJo3jqybxw66Pzkf+Ys1DTiBB2e8YGAspgrBGErJLXy4mExlTnWyvA
         jzmciqxo7n4Nh7NMGDWeTk6myF00aev4cmlOo5KQXJJX98gvgSodQv7m01xa6sK5kdKa
         rwWePi8k7Ve8hgspRpqgsLFsGgmhkRUuvAp+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=h9oaNjvKA/TVyUjxkqEZFue5D8qXcZ3WF2cKiDvridI=;
        b=CK4gYU//Jsfdv9rHH8IM/V75O0oAJ1mME6xSAWgsG7XL+TYzr9z4wbekO26Fgpl7ew
         AMdxu2els4SZ6LeRV18rzMNRCEbqmdhHYnaxv0SHkMSLainzHnC1yBZBDGyn+2uAqRVQ
         gMSWAqfsTBvh80a2aYiIhC1ZufQOQ5tdwFXD9Ep6AQ991HZN10+YAGz0rG4si8ZMi12Q
         +XS4C/OHn7rMtAamXgmow8uZQPws7Kqt0aIoTl9tpzP0A6GWG8ROS4chXbO83PAXYyTQ
         gi3o42Fe+JJ5Kj/fZ0jcDPQs8dYMFuaoi12tHAz9JX5YBSNPRKUTDEjjETRg3EDBFQzi
         0Z+w==
X-Gm-Message-State: APt69E1NDzYOwuvDWlwpBfNrjgmo06LM58pl/OVHUNsCCuR/UqZccV14
        Vi743V8kUQLD78sDoc4soeRVKM/HHEzbeFN3KBQ=
X-Google-Smtp-Source: ADUXVKLrCoch049wVwj61FCUwmxwf8Pszch9IEv0cbvlx6tW70Q+y6zHnjO8JlLvyhtMYETie5mgqZMVYEOIGRp+cyw=
X-Received: by 2002:a65:6147:: with SMTP id o7-v6mr2582740pgv.163.1528797089467;
 Tue, 12 Jun 2018 02:51:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:8906:0:0:0:0 with HTTP; Tue, 12 Jun 2018 02:51:09
 -0700 (PDT)
In-Reply-To: <20180611182053.GA20665@aiede.svl.corp.google.com>
References: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com> <20180417220219.30445-1-szeder.dev@gmail.com>
 <20180607054834.GB6567@aiede.svl.corp.google.com> <20180608211639.7611-1-szeder.dev@gmail.com>
 <20180611182053.GA20665@aiede.svl.corp.google.com>
From:   Rick van Hattem <wolph@wol.ph>
Date:   Tue, 12 Jun 2018 11:51:09 +0200
X-Google-Sender-Auth: 38cSgb-t9XxYWXxFuYj8OrtiKqk
Message-ID: <CAJAwA=wQZ4b-wsy8yqURVK80hv9efGD7LZKCq89sVssBd5cgqA@mail.gmail.com>
Subject: Re: [PATCH] completion: correct zsh detection when run from
 git-completion.zsh (Re: [PATCH v2] completion: reduce overhead of clearing
 cached --options)
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org, Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 June 2018 at 20:20, Jonathan Nieder <jrnieder@gmail.com> wrote:
> SZEDER G=C3=A1bor wrote:
>
>> Being in RC phase, I'm all for aiming for a minimal solution.
>> However, I don't think that the better fix would be erm.. any "less
>> minimal":
>
> Thanks again. May we have your sign-off?
>
>  contrib/completion/git-completion.bash | 5 ++++-
>  contrib/completion/git-completion.zsh  | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 12814e9bbf..f4a2e6774b 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3223,7 +3223,10 @@ __gitk_main ()
>         __git_complete_revlist
>  }
>
> -if [[ -n ${ZSH_VERSION-} ]]; then
> +if [[ -n ${ZSH_VERSION-} ]] &&
> +   # Don't define these functions when sourced from 'git-completion.zsh'=
,
> +   # it has its own implementations.
> +   [[ -z ${GIT_SOURCING_ZSH_COMPLETION-} ]]; then
>         echo "WARNING: this script is deprecated, please see git-completi=
on.zsh" 1>&2
>
>         autoload -U +X compinit && compinit
> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/g=
it-completion.zsh
> index 53cb0f934f..049d6b80f6 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -39,7 +39,7 @@ if [ -z "$script" ]; then
>                 test -f $e && script=3D"$e" && break
>         done
>  fi
> -ZSH_VERSION=3D'' . "$script"
> +GIT_SOURCING_ZSH_COMPLETION=3Dy . "$script"
>
>  __gitcomp ()
>  {
> --
> 2.18.0.rc1.242.g61856ae69a

The change looks good to me :)

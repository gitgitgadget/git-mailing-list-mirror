Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44B271F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 19:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfKPTtt (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 14:49:49 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:41051 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfKPTtt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Nov 2019 14:49:49 -0500
Received: by mail-pj1-f66.google.com with SMTP id gc1so414803pjb.8
        for <git@vger.kernel.org>; Sat, 16 Nov 2019 11:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=51cE3L/XEgL9O/Uath1i8f7rAnlSChaK1R2EUSFk7tc=;
        b=R35sdhJg7DTHaEbcTuZMhmcyQHtzlZgvFf1vRx+k6x1g9sZNOcm3JK6/g7+HWYYh6n
         49DtU3uFVTigiasJqGubsNycpwdTLV56JWnDsuXq11EsHmx0hAIGfQhu/eJJ3cDRYa6k
         pfXQe2aue7AFjvLSXnh5aNnJlU+qdFL7b0xgbtn4DB5csK01Pw75JPq40x1RbgZo01Jp
         Sj+SaefhfLybhUOecQUMndRyJAjQHW+0HgPcqoSjx/c2ZIGW/tgnjr2v8WViBWOBUpaS
         /qYEqyfxOqw2cto2QmCEhCUMn+5sj7wwgXYth7WlIZ2n97EJDnn8BYyqr32Bq4LsrGG0
         sQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=51cE3L/XEgL9O/Uath1i8f7rAnlSChaK1R2EUSFk7tc=;
        b=TD2xgalnt21624ZSLZId1ZlOxujx6XWmwjyjCTRJnZBt1jr1DSX5ICFDLBeGMH2a7z
         9UcRFHdSYjglIkN4/WXnaM4CONh1PtxqMyieMdaazyKi/h7Erl8ZVxI3G4O1Al8QUVnR
         Ja8bvJh3KFzoSnn2Kgvh9osP4kk1Pf8FdSaopI6JdyAb5gNjqX6WNXn1t6IuJH6/DJ4+
         JHDXYfYU2mO16f32oakEdyfIHVUzzUuOLiWXi5QYJp7SYHm5ApA+pIIFfFgOVer9j1i7
         czA+NR4awtvk+uEkK+SBGqGgUOk/fE0zKF6AkpDTX6J9nl7n8TJdfigSdSUm+st2KFBM
         Ruag==
X-Gm-Message-State: APjAAAXfdH0KLusuZwS1PaA2y9u4M0TpzIzera8EgIumW63+7hRdAywq
        H2oDKRa1LYFbgA4ot9615Pc9k6Di
X-Google-Smtp-Source: APXvYqzdN+r0u/8YQHN6KJoyFuRwq0J20UqyQ+R/QgsW3ckztBopIYyGm5Gg8ou1akbu7o6IHacoAg==
X-Received: by 2002:a17:90a:4803:: with SMTP id a3mr11188288pjh.101.1573933787930;
        Sat, 16 Nov 2019 11:49:47 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id i123sm19969501pfe.145.2019.11.16.11.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 11:49:47 -0800 (PST)
Date:   Sat, 16 Nov 2019 11:49:45 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Limit search for primary key fingerprint
Message-ID: <20191116194945.GA244853@google.com>
References: <20191116180655.10988-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191116180655.10988-1-hji@dyntopia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Hans Jerry Illikainen wrote:

> As part of implementing signature verification for git clone, I decided
> to refactor/unify the code for commit and merge verification to make it
> reusable during clones.

Thanks for writing this.

Most of the text in this cover letter would be useful to have in the
commit message.  From the commit message alone, I could see that you
were fixing a bug, but I could not see the motivation or workflow it
is part of.  If I were to later discover an issue triggered by this
commit, I wouldn't have enough information to weigh tradeoffs about
the right way to address such an issue.

Thanks and hope that helps,
Jonathan

> This lead me to discover that git requires merge signatures to be
> trusted (as opposed to TRUST_UNKNOWN or TRUST_NEVER).  This is unlike
> the behavior of verify-tag and verify-commit.
>
> So, I figured that I'd make the minimum trust level configurable to make
> the behavior of merge/commit/tag consistent.  And while doing so, I
> noticed that parse_gpg_output() in gpg-interface.c assumes that the
> VALIDSIG status line has a field with a fingerprint for the primary key;
> but that is only the case for OpenPGP signatures [1].
>
> The consequence of that assumption is that the subsequent status line is
> interpreted as the primary fingerprint for X509 signatures.  I'm not
> sure if the order is hardcoded in GnuPG, but in my testing the TRUST_
> status line always came after VALIDSIG -- and that breaks the config
> option to set a minimum trust level (not part of this patch):
>
> ,----
> | $ git log -n1 --format="primary key: %GP" signed-x509
> | gpgsm: Signature made 2019-11-16 14:13:09 using certificate ID 0xFA23FD65
> | gpgsm: Good signature from "/CN=C O Mitter/O=Example/SN=C O/GN=Mitter"
> | gpgsm:                 aka "committer@example.com"
> | primary key: TRUST_FULLY 0 shell
> `----
>
> [1]: https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob;f=doc/DETAILS

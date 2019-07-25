Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C08571F462
	for <e@80x24.org>; Thu, 25 Jul 2019 09:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfGYJa5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 05:30:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:44725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbfGYJa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 05:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564047043;
        bh=1WnCWgJ18DKQdFAMzBYDo5xorDM4t6rVqq6aG6n46eo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aYm6duyoON8O/wy6C9h4UGsPT8FB0AljdEFnz806O4Eac5iDlPlOGP3/NheOEtNO9
         PK6+ZkMMS07s9cIkzm+BZAOJTyIlXSrA3e1tyW7NM2Alpsc72gWKp1bQEy9GIB0QEL
         iwzGcaf2A0G1+csI+PdOo9rcrcGN+IeUzsX4//UU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1hcVbh3ZBX-00HOth; Thu, 25
 Jul 2019 11:30:43 +0200
Date:   Thu, 25 Jul 2019 11:30:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        jnareb@gmail.com, pclouds@gmail.com, carenas@gmail.com,
        avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/5] repo-settings: consolidate some config settings
In-Reply-To: <597ab7d621983b5ad35006a2530aa70b452e895f.1564021392.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907251128280.21907@tvgsbejvaqbjf.bet>
References: <pull.292.git.gitgitgadget@gmail.com> <pull.292.v2.git.gitgitgadget@gmail.com> <597ab7d621983b5ad35006a2530aa70b452e895f.1564021392.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RJ4riHbzXbC8GqDdRiHj81XpdHH68FVudU/7wBbxuc1ML17j/WI
 B0TA3KXzTHipTCPOTukbY6OY8Yc536Kd2GZu2rzCmiwq55G9VpMoLXz2FwcTrmPVMgwBljt
 ahTLZOQX5B7H4YYYIs0FPmQHeFOC+LF3PLlk4Id5h9vnqyzdJpxJff5yjonwiUMdiv5YEuX
 nPZGArJkSztd0+rgmtTsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UMgpuWoTHvs=:9MHY/tNpPErx7I8ouPzPTd
 OKLWwYRjO6c2FQYzY75ZsNOXQ0gTVOFHIvOV+EgKYQMOqPVcJD7luA91g8MU8rOkTFUQIO2uT
 vc62OD/bMPdSu6xbA58TI3vbS+dOoZ5B547UabMop4n48GHz0b78y8j7ZPGZNm6FWVXP5BDCz
 QIKsaL25tQUNRjYP9FaNvKQN2llPec8kL7lFQfkx6brJOgcZ9s+HX4NsFczEXjRHcDAT+Kcrt
 bzP5YPGbftarzkabCuyoWNfSb+fBhCgsP/b/POtJSDGS4XKxc9mRnV2Np7CWi2PcacUKK2cyl
 1vJlgaQnPLZ9MFoF9XaV6Uf26F7YUEucI1GFz+k837nK8B/xKujKOQgQSyLqybrqf1BmvTNS6
 mtYZaL/tzgN/dmBJZaX1cbgEXX1TkQ9jZ0wEioEwujERwn+lzS8u8HW2TmuczlmQe9knYU878
 ZLzDIQQLBwx2KZO0jF/YEVXRYj0xN6eZNE0FL8D8o1iuY5eO7XabgT/k6IghV2BiMiEt1P7dQ
 nT7PRdC/s9ps4afbW+a3FgExKtv+u7+w12+76LO0gsOnn8h/AYYrQsAM6kveoctTfKjXj45hF
 OPO9FNUpQ5815ht5iAEW7aD7vppbUjINGMabn753n1WvKIQTzWqHX0ejdW8fcUaFTsU/csX22
 lUgQS+KLTEyIQ6PSsss9QsImjb6mR1KUtLD7mJDZoi7hKf2oNRfn0v+OluLovTYLbiy5p8DBT
 uRorkcshrKzBLHTvrUrGLQS55VQIjrG4Kovxf8ufSYCsYXjgRdcxNXks0M3PpkSxHTnegNP/A
 7GD/Q090woxWnWVKp7KTvcmEvCnxHx2kP2JBxpR46kDWlTBO8qeJIckqxhfo8fXH1sy2qzvnG
 KVmpL3Z6nGRIcmg2yn7ClFVEZuXmpF2yqaTmRFwZjco/rpWCajSFX40CHhc7LT6tdxra5EdOe
 eKOGKb5InHZ7fA3a0X998b4D1Mb1GfFsCZ9svVPhjOHQ/+uZKZSzptwM3CktEuDSzhdrXCLYb
 1KrH71Caub8a0ZuaPsRZ5cD2lDqmI7cCnW3Sq3WiRgCunAZKJ0H5S+j6QbSXGqBokonz/rjHs
 J8SzsCB42EIwUeDI1nIMKPVplO73fGgySRp
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Wed, 24 Jul 2019, Derrick Stolee via GitGitGadget wrote:

> diff --git a/repo-settings.h b/repo-settings.h
> new file mode 100644
> index 0000000000..89fb0159bf
> --- /dev/null
> +++ b/repo-settings.h
> @@ -0,0 +1,17 @@
> +#ifndef REPO_SETTINGS_H
> +#define REPO_SETTINGS_H
> +
> +struct repo_settings {
> +	int core_commit_graph;
> +	int gc_write_commit_graph;
> +
> +	int index_version;
> +
> +	int pack_use_sparse;
> +};
> +
> +struct repository;
> +
> +void prepare_repo_settings(struct repository *r);
> +
> +#endif /* REPO_SETTINGS_H */
> diff --git a/repository.h b/repository.h
> index 4fb6a5885f..a817486825 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -2,8 +2,10 @@
>  #define REPOSITORY_H
>
>  #include "path.h"
> +#include "repo-settings.h"

I still think that the `repo_settings` struct could just as easily be
declared in `repository.h`. No need to invent a new header file.

>
>  struct config_set;
> +struct repo_settings;

In any case, this is no longer necessary.

>  struct git_hash_algo;
>  struct index_state;
>  struct lock_file;
> @@ -72,6 +74,9 @@ struct repository {
>  	 */
>  	char *submodule_prefix;
>
> +	int settings_initialized;

Or maybe

	unsigned settings_initialized:1;

?

> +	struct repo_settings settings;
> +

Or maybe even fold the `initialized` flag into that struct?

Thanks,
Dscho

>  	/* Subsystems */
>  	/*
>  	 * Repository's config which contains key-value pairs from the usual
> --
> gitgitgadget
>
>

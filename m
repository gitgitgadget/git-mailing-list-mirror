Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AEBF1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 13:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbeKHWra (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 17:47:30 -0500
Received: from mout.gmx.net ([212.227.17.20]:53749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbeKHWra (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 17:47:30 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLj5z-1gLZBB3cpf-000xJG; Thu, 08
 Nov 2018 14:11:54 +0100
Date:   Thu, 8 Nov 2018 14:11:53 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
In-Reply-To: <20181107220320.GA8970@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1811081408310.39@tvgsbejvaqbjf.bet>
References: <pull.66.git.gitgitgadget@gmail.com> <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com> <a374e4bb-1970-9ec7-fe94-a273f1206d6b@kdbg.org> <nycvar.QRO.7.76.6.1811071222200.39@tvgsbejvaqbjf.bet>
 <efd57458-07f6-2813-483b-dc7fba785dc0@kdbg.org> <20181107204142.GA30078@sigill.intra.peff.net> <e7ff6f22-fe5a-3cca-9305-2c8a6fb55d45@kdbg.org> <20181107220320.GA8970@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Q3NRZYcByMpz5shkR0zF3S0DauIhKWdixzeVmltWkrilbx74lmt
 u9daQjyJBp8R0FJ6lO1QACrtUIETxxpfkNkqqMMpqHhMDLsjlNOoHxOadXBqXjUsVOjRYAp
 4gYS74PqHhGDUVs87jIatg36bJh5TuvVaU7Ka5NAfLUZV8TbNUMfj+rcq8/TdNM5zKq1jLc
 pmTFUmkipmkdHOA5vJvvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KmXijpgAHq8=:GEK6qhD3cT1V9EfGq15EzR
 E0H1O4v/hxO2tvd/HtqQZCFEzrmpanw6cUOsAmi8+K/SVs4ep1dGi4cZJuOLlEPnMEoEC3cPy
 U9P+px1ygVVa+Jd6IpZU18ZZx5HEb/sTvfuLzRvdwpcMLKDb5pjmKkzzwo98OOBqCGcd7RRLe
 FcLGh7Ug92yU1D76WjhCQRfoH9zSw2w45OMBOECbqQL7u5Oscw9Dgpz7/NNhv35NhfrBdbl3Q
 nTR3y9SQlcZVMNN4vd1MnSUngQhBvu//7WDFhVD+CtmRfslzU9vTEtpBZx+D+FiCAhzQ67ZR6
 wTarEy8Jt1/VP7DMfRFwk6wEiYraALTXqni2ykZ/Kn34Rw6YUbQax9k7jKTt6UmCu9Zg3Hzgp
 g9sR9l3oNvpW/YyVFDs2S0PR+PPOwX70lxCgxOJiK/qGVX0nr5ptduiBCYdAuRRX2P8VLpWyR
 Oypv3edumOoeA8d9F+AK8iARwO0U/njBOX7visJMoUowNZASchp1uN/RwcIxh1/zCHsb+L2Nw
 4D1IPseqmIoSA5zX7yKv6rIOH/UdlykGgddH37WFl4x+oLYAqLybQW1ZUC5HFYasCM2QVTSwq
 YyWXMVN+dVEXnO7BsnFqMkxDu4E4c8LA8AUvMYA8m7kHN5Ol4sUcT972JZEYzKRDz2LQvLCGe
 zVu8Wyj7HUoWSYRm0TfqEXToZPvA2OH+eOVcD64I8AmwhdF9rmwrQSAkbIMmY3gPH0xDIs4IV
 mQSnzW1EDl8fOTAagtKVYJ5Z/xnGjta219IWcz9Bg5IUGsUyHvo10fQUFeBJCvYy5AiP3ySPx
 uMvWll4Rh4OHIjloKfHziqhDmg208MsFrHsqpKXhr0ujhPBmdbcwdC2StlwI5UQmjh8edZP/E
 exKhDkGL7YC0lQnuVtsXjyA2ykKd3hwEEBmOJ0jYroDlIuSwpEXWKGAOtHGKpAV5NQwGJCCxt
 Jotrz+eTG6Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 7 Nov 2018, Jeff King wrote:

> All that said, if we're just interested in allowing this for config,
> then we already have such a wrapper function: git_config_pathname().

Good point. I agree that `git_config_pathname()` is a better home for this
feature than `expand_user_path()`.

But now I have a really crazy idea: how about ~~/ssl/certs/ca-bundle.crt?
The `~` prefix is *already* a reserved character, and while it would
probably not be super intuitive to have `~~` be expanded to the runtime
prefix, at least it would be less ambiguous than `$RUNTIME_PREFIX` (which
*is* a valid directory name).

Of course, `~~` is also a valid directory name, but then, so is `~` and we
do not have any way to specify *that* because `expand_user_path()` will
always expand it to the home directory. Or am I wrong? Do we have a way to
disable the expansion?

Ciao,
Dscho

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9701C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 12:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbiEXMAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 08:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbiEXMAT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 08:00:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4937D62CC0
        for <git@vger.kernel.org>; Tue, 24 May 2022 05:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653393602;
        bh=VTqn2tLY9NzaP+d8BBMRwT41YxUvLm/hPunEG0NKHis=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bHZVKiBKvAaTmR+uUuBll/qQv9aT+8+7cAat+ae8EMObGG76hSq+/nXbaWLVeuUgC
         bSPopRuaTmp+jZt3xdJ3No+Zs3yxvKhpfZoAs9W7Ffl4+pM9LK6XOh92AG/PR9orUx
         8LhIAtnPXrc34OPk3a3a2FV4LiWBh25L0WygN3oI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJm5-1nYDI10t7b-00nRlU; Tue, 24
 May 2022 14:00:02 +0200
Date:   Tue, 24 May 2022 14:00:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Torsten B??gershausen <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 00/30] Builtin FSMonitor Part 3
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205241357410.352@tvgsbejvaqbjf.bet>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com> <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WjHE03xfKZe55QIDagfGSojPLlazufzX0ajGIEwjqZTcC/3FkE7
 e6vzYoW/wP5wRmQ/pJ0DKwzbdXfSuedgU2PGukWHzNrd3PToiGcutvbarsLeSukLwfIJe5i
 HvDdxQaQCjZClEMDm8cuaLGo68UP2Lz/pUIrT8yP3NQdUk3vr57slRMxt30ZvIBmgKw2BYk
 RKxI0bucy/seEnXDMcZxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GfAhXBI6czg=:1+4kcoq+M9HK8TGeMhmWgW
 dCX+AX4NYaXOKQXl4lpQyBFXiyhVateBvWHS3hQqjCwtEu4eI6X4KgMPMarjCfBPJZD5COu8p
 BgQKYkOGxQ1SstxbZ47xfie+G254+Mw7q+YkpagyE18pblM795c+odb//PVkKd1moqJg9yAfp
 sJEfLhrziOjXocf5bsr8qjq9kvpnVmAoCrg2NWrVlAhuOZ/hwiat3EiBHyvgHE1rUVXzzk503
 U6kHVGL43V/WRg1k5Nl3Tt+d5Ks/IduaVACIRvASkXfrM8oWH4kd6EtNVsWoUkvllZ7rm7e+8
 A/fTrEP8mUzbT2JUSGU/ctIRo4oiZ/RGWGkiZz4SOGfHIrQH6IQqUwzp0v9c8233VcYIKZ7ue
 N7fjHqWm+GcwTl0MInqx8i+jZUstYgZ81/6BduimHYCNdPIwfhSlP2lVQl28p4b/l8Qc7Es9e
 c74IDWZIfg31wYTXTGUjzSiMhhCcwS+BPMAiR9Rh//SLwC8s0kuVz+6IwonmgJwWXIxxU6YEf
 1uoq496sdf6DfZNHdnyySNf7DxyTUkR7nxbo5boGPS3687FzVMU/C045a4t3141hiGZlR8g/t
 wSs5k0vKRH0KZda8ncsXFDcQp2/2TCD0PLJ9TDkW0ViVVzcP3S4SbYGRdw9pnPMxrK4cRGA4y
 +oFu5tTUV57zRVeZ5fQx4m52J4bxfwiPelv2ortEhOqorZ862xVAqm0zkW+1Zli1td8qyc/tg
 w0mej1+sq4nFd4p+fFoxlRf56WhVPVHmZBnYi517tUYjonhQhiNlc53W3k73MQPuZeEcsFNGG
 qCChgynKhNZ9w4+hLeHA8ff7M9m43qHeT2i4O9HcfbK8lfolXAQPRgbglS9PYLkZtY4plGn9U
 7HmzLH8fVvCTz16sAxlphbIAJSbXwKKqxxkIGxyWKAfZKiD/PacIOEitBarjHKszRlGIKgPNM
 NHU/kgPpQWZXLV9rRWpZ9sKRXe1Ppu6gdGPqbF9rajXGDWkNsw21Yf932dDH5+PSji2vweqU4
 uQGRjIQv6eZD2hBNMNsjtDiXcFbwyogbCDEQnd0r7NMfZ0UQdIsVFAs979vw/8DpSVLxVe4Yq
 piz8IKMGu0cRsFd4zFZMKYOg6ICj0aFMwXMlysNmq1JqW/RSfJ1ZeF5Rw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Mon, 23 May 2022, Jeff Hostetler via GitGitGadget wrote:

>  1:  8b7c5f4e23 !  1:  26144c5865 fsm-listen-win32: handle shortnames
>       [...]
>     @@ compat/fsmonitor/fsm-listen-win32.c: static int normalize_path_in_utf8(FILE_NOTI
>      +{
>      +  wchar_t buf_in[MAX_PATH + 1];
>      +  wchar_t buf_out[MAX_PATH + 1];
>     -+  wchar_t *last_slash = NULL;
>     -+  wchar_t *last_bslash = NULL;
>      +  wchar_t *last;
>     ++  wchar_t *p;
>      +
>      +  /* build L"<wt-root-path>/.git" */
>     -+  wcscpy(buf_in, watch->wpath_longname);
>     -+  wcscpy(buf_in + watch->wpath_longname_len, L".git");
>     ++  swprintf(buf_in, ARRAY_SIZE(buf_in) - 1, L"%s.git",
>     ++           watch->wpath_longname);
>      +
>     -+  if (!GetShortPathNameW(buf_in, buf_out, MAX_PATH))
>     ++  if (!GetShortPathNameW(buf_in, buf_out, ARRAY_SIZE(buf_out)))

Nice touch using `ARRAY_SIZE()` here!

The changes look good to me, from my side this is good to go.

Thank you so much!
Dscho

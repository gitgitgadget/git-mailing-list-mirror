Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E08DC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 19:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiCATVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiCATVE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 14:21:04 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F2C52E08
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 11:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646162415;
        bh=MZ2bCUyK5cU3AmSkGaYpqJ/szXENgT49s+QrDkk0kzI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QJTpm2waMwVEHMuUBPzDlKEcs5AldElx2ODnWh7QUI5F8eZav/y4Ebk7YiqioV4L7
         hvXe+UiAzH+LMz60xyp0x2ZJgfPY1kuuHO0FauMUB3prRUEhWnxesbErMulZKuxkgN
         Q1A+eLYVjSa0Ni1Dzj4g0k9IuY5rM7ZfOlMpFuR4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.214.47]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJVG-1nsP3R1SLO-00fPyx; Tue, 01
 Mar 2022 20:20:15 +0100
Date:   Tue, 1 Mar 2022 20:20:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 00/30] Builtin FSMonitor Part 2
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203012014290.11118@tvgsbejvaqbjf.bet>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZjKO1RMfMiAnG0Es/GWdnd5nzuZCao/4+e16hieVojATCxprZdE
 hEasVT7sYbgmc8WAvxd2waXC7wwNBF00/OH4hcONDjKrlGwpda7lvVoLNUBT5sBU/CqKwks
 TRDg50dOBkD6pLLDhpD8ZcWzTDgN0g+3dxFfV1dW5n2T2z/XZyt2RE8vcnJFAndwx4U5Gyg
 2jJpqbS2KiVLDUof1HEBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S1JCC4iXkF0=:YP/54y/4XqTmyIJko0Zv5d
 laxBOiJQZreSDqJcg8xUD+FStTN0xg+1bEaWomV38BojWJ2owtm5WWWu4wT3DqQgGbODjk0H2
 3drgOAyIEA+7AC5B9XU1EDfH46MdfxleZuw+S6BXSvOcHMmTGlrg+1P5kBB4NQu0q1cxjHcJE
 BWqxevncFbnzW1xWmp4RchHm7zhjWWNug+Xj+m7mfe6XuICEIZuyNuqqXNeDteTPL0Lavsq8M
 9AqEVqCWNS7zbfNxfiZKtfv7PYDO0aSGEH9kiSS15ZU/MjGOn6cxrzxnjBCKQooB4IdExkZ2o
 rqFFb29wmz1/z0iMSZPU93BvCN1HIggKAr1Y6ZE8//6MkWiObqWLByjOW/UgR9db2V/z3cZ+P
 ZQNtb6a8+X8dJHj00nU7WN/S0EZRIBoMaT+UaHPxHZTUh/bdnZ1TtFX3w3JiTT8er+jJRI6N7
 Prtik0p4Z3ewbcUj+MVP1QbSf0CwQpkQTQC8S0/07+Os3qIQmxUhp24By8UG19N21NVxrCQxT
 HNI3ow5mdzbdfS8YFZ7uPCMtDRwFrZ8NWJFJTK42MWXprRfpSYaLNeyL+huJGxdeqMF4SMs2o
 zQ/X+b+L7NgYXFYF4pUBY+LryB/Z2PfoawnEQNCCqmnYUYPzy+lbbY8RnnYHPOTKg880osuIa
 lgJmj4rY5CtPeO/tcDcScs0MK4dbtXvJj7Mh/awmnEZwF+rbEZdiTvNiqMiI/OICYEmoz5m8c
 cQrNKKllhaAQZZFhswZeJSu4Tu27YyjOk/k8YgiVJqI9JTB9O9L1PTqlF4Po5uI5Cg6VkVv+0
 PyOzhQ+zmfkbuo7U2zLNOL+ICmBfQ0erh7siAi4tfpajHEL/Yl7wkfhUJtkQ2z77qfKqMNyyN
 epHzju/d9fqfPGA+A9Yfs2kpPqSF1suLv9kukDUvGJ6tkfzggAxjzU4IWuX23RstgA19yOmsk
 nZX4ndm2//84kPL+vTl9PYw4GQfIpa1Zac5yUOo8o0yMzA2YawzXczutE+v9GGqJ8aWbwQQ/T
 ZcVKUslyn3fE6UJ+toZr8GhES2AxVlolOPRbaplFm38SXaASBeV5TbyUHodDP+e0yj0MtiNPJ
 1ilhiFvIK5aMOY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Tue, 1 Mar 2022, Jeff Hostetler via GitGitGadget wrote:

> Here is V6 of Part 2 of my builtin FSmonitor series.
>
> This version contains mostly cleanup based on feedback from V5. Of note:
>
>  * I squashed in the 1_file fix for p7519.
>  * I squashed in a commit from part 3 to optionally print the "running
>    daemon on..." message on stderr.
>  * I added a note to the documentation about incompatible changes around
>    core.fsmonitor.
>  * Removed/rephrased some obsolete NEEDSWORK items.

Thank you! I also saw a grammar fix ;-)

> Tao has an ongoing parallel series to fix test-chmtime on Windows.
> https://lore.kernel.org/all/pull.1166.git.1646041236.gitgitgadget@gmail.=
com/
>
> If that lands first, we should be able to drop my 't/helper/test-chmtime=
:
> skip directories on Windows' commit.

Thank you for this note so that this overwhelmed reviewer knows about
this.

> A followup Part 3 will contain additional refinements to the daemon and
> additional tests. I drew the line here between Part 2 and 3 to make it
> easier to review.

Excellent!

I only found one slight issue with the range-diff: I _assume_ that Junio
likes to add his own Sign-off (but I am being told frequently that my
assumptions are typically incorrect, so take that with a grain of salt
;-)).

Apart from that, I saw that you addressed all of my concerns, and I liked
in particular this elegant change:

> Range-diff vs v5:
>
> [...]
>   3:  384516ce1a1 !  3:  ae622a517cf fsmonitor: config settings are repo=
sitory-specific
> [...]
>      @@ fsmonitor-settings.c (new)
>       +
>       +enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
>       +{
>      ++	if (!r)
>      ++		r =3D the_repository;
>      ++
>       +	lookup_fsmonitor_settings(r);
>       +
>       +	return r->settings.fsmonitor->mode;
> [...]
>      @@ fsmonitor.c: void remove_fsmonitor(struct index_state *istate)
>        {
>        	unsigned int i;
>       -	int fsmonitor_enabled =3D git_config_get_fsmonitor();
>      -+	struct repository *r =3D istate->repo ? istate->repo : the_repos=
itory;
>      -+	int fsmonitor_enabled =3D (fsm_settings__get_mode(r) > FSMONITOR=
_MODE_DISABLED);
>      ++	int fsmonitor_enabled =3D (fsm_settings__get_mode(istate->repo)
>      ++				 > FSMONITOR_MODE_DISABLED);
>
>        	if (istate->fsmonitor_dirty) {
>        		if (fsmonitor_enabled) {

=46rom my side, this patch series is all clear to advance to `next`.

Thank you,
Dscho

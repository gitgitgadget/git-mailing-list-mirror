Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25362C4332F
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 16:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243188AbiBQQ2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 11:28:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243215AbiBQQ2B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 11:28:01 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DFA9D4DB
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 08:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645115260;
        bh=EN4kRlasFy1Dhe8TfoDWNhbH5xfMSIsRiBiDgoRToX4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hy4FzPq0FYCrAbUixYv02Nq/rsoaW7p/V6/6t0T++M8JT4wmMfkCeV2hlWy+fCC3y
         /HZW0RRCdcrvOaSk9T8ItAqQNG2mCN/U1ZaPbDimM/WdbGosL6E4E+hjTeLNdS3q4b
         /JzP6+BCHU7O82AJ42xrwItod4tqfXMA9pUSkeFA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZktZ-1no1uO3izP-00WlaQ; Thu, 17
 Feb 2022 17:27:40 +0100
Date:   Thu, 17 Feb 2022 17:27:37 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 03/30] fsmonitor: config settings are
 repository-specific
In-Reply-To: <384516ce1a190d836324b2c2262d611090207357.1644612979.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202171725060.348@tvgsbejvaqbjf.bet>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <384516ce1a190d836324b2c2262d611090207357.1644612979.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IcZ24j7EKM4EQ6gVz6pFLgY1dJ+aHq8vcYztdvsCd0riRjZiVlf
 yhMKBmChjjt5BFD0cEuFeR0jlozjvgnPDKNpykmPRPMa9WM4YbNdeevklTqU0V0YiqTsJlJ
 O1IK6b5m+Ot0u7W3ESiXh2qIJ0Wbcx/5ohpP7pf28xlnp1YEfjtEKKce9Eh4JnfH6YoR6IO
 IgJDCBUaYFXhZ+QE7YDVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+fN367zNmAc=:4sDzpYwZWN7N8BPFq2jWIK
 FfeTZU8FQ2cO9pOVMuaBy8XxHGJQwotsAG5ZpvzhllmY3BO8lxer2C1HJqfBmqMoH1TWmHKNO
 QD6ev7m6MKPmERaboLMUH+QdStkdJbcaQ1koAzHhZNoPVeuLUw1aNJyPUl2emQ5ZOBHbJ4ida
 4kWde/ucCvF9IBGuIy1dBPf/G3mdlkE2LjFut3uffyEcIZVXSdrFNPns3UztObEquA5va/8AO
 GSqurQHncDAmZkIUXTBM2W37Bnb2krUS0zdxI4w9H85NELIzZdyJtGMxhbphRZaH6a4YNWd7B
 jb94mg8DXx4dKgY6RizS16/8WzzDwI4sAzHfQCuUpJ/vPLW56aRyIE9xVYH90vmRWC1M+J6cz
 kh+6VWdFWshYP+lyulw/k3ax+NTuaLrBQxlPqHkmlv1bX6zgTlRRDvqXx5H8n5xSOK2oiFBtO
 m/seZR6iXtNQvdR22uLnWH4FqqCNWDlIoBSbeUuM4y5j1aV7PRGFcJ7pqF/XH9NZppqZXLuU5
 LQdyB+vBAr6pZbru3jvv43UkHfQbIAAAx6/tomfBQQ0pcnicEtFIg/0kcKNWSc9Uh4NLiZ9kY
 vzbSP9ZqITFoszgjFxVuWj6zqoXnFX54YA2LMenolcBDkQSQnGKNqFXfG6Up1T1LsQdfynuZe
 1BA8+1wfHQhv9b+T7snJE5F7tpYSsjbE7NNVAZZa/fC8ch/jBxEWkjvD+Wq9qjMeHpgu1UUWP
 Oa9fGsSBiewl92LP/hse814DZVAxOTNXy7x91MKqGd27rGDhYSHNdFhn1EtmWWXUvjrPmM5vm
 Mw2w6Toix+HNSmZQiJj1UC3zC+KCHU2u4c4/nI7rkgnD3gAiMDmP5lwIeb5Gz+wByaA5E0VqQ
 zbO6DTxCWAj5oXeVhYVs2oRjE5C08cT2JV1n/vpmj6fA1h3giZ3ch3Tl0K1GOpQ5VQppmVx+I
 rMnSejALs6KEPAX1U0O6j5S3ZXamIvHv+tewF7Zz3CmZTyx4lukcsERwUMhhYBnMXLJeDu/uC
 P8gzkZ68fJNpiP65FqwxduQJrVSwcclYZzjUKCtcFybS6Xq171Mm4P+JsM877iWnEjSQuH1LM
 ltrEsFYBVVJ780=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,


On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Move fsmonitor config settings to a new and opaque
> `struct fsmonitor_settings` structure.  Add a lazily-loaded pointer
> to this into `struct repo_settings`
>
> Create an `enum fsmonitor_mode` type in `struct fsmonitor_settings` to
> represent the state of fsmonitor.  This lets us represent which, if
> any, fsmonitor provider (hook or IPC) is enabled.
>
> Create `fsm_settings__get_*()` getters to lazily look up fsmonitor-
> related config settings.
>
> Get rid of the `core_fsmonitor` global variable.  Move the code to
> lookup the existing `core.fsmonitor` config value into the fsmonitor
> settings.
>
> Create a hook pathname variable in `struct fsmonitor-settings` and
> only set it when in hook mode.
>
> Extend the definition of `core.fsmonitor` to be either a boolean
> or a hook pathname.  When true, the builtin FSMonitor is used.
> When false or unset, no FSMonitor (neither builtin nor hook) is
> used.
>
> The existing `core_fsmonitor` global variable was used to store the
> pathname to the fsmonitor hook *and* it was used as a boolean to see
> if fsmonitor was enabled.  This dual usage and global visibility leads
> to confusion when we add the IPC-based provider.  So lets hide the
> details in fsmonitor-settings.c and let it decide which provider to
> use in the case of multiple settings.  This avoids cluttering up
> repo-settings.c with these private details.
>
> A future commit in builtin-fsmonitor series will add the ability to
> disqualify worktrees for various reasons, such as being mounted from a
> remote volume, where fsmonitor should not be started.  Having the
> config settings hidden in fsmonitor-settings.c allows such worktree
> restrictions to override the config values used.

Apart from my forward-compatibility concern regarding interpreting
`core.fsmonitor` as a Boolean, this looks good. Just one thing:

> diff --git a/fsmonitor.h b/fsmonitor.h
> index f20d72631d7..f9201411aa7 100644
> --- a/fsmonitor.h
> +++ b/fsmonitor.h
> @@ -3,6 +3,7 @@
>
>  #include "cache.h"
>  #include "dir.h"
> +#include "fsmonitor-settings.h"
>
>  extern struct trace_key trace_fsmonitor;
>
> @@ -57,7 +58,11 @@ int fsmonitor_is_trivial_response(const struct strbuf=
 *query_result);
>   */
>  static inline int is_fsmonitor_refreshed(const struct index_state *ista=
te)
>  {
> -	return !core_fsmonitor || istate->fsmonitor_has_run_once;
> +	struct repository *r =3D istate->repo ? istate->repo : the_repository;

I see this repeated a few times. Would it maybe make sense to change the
signature of the `fsm_settings__*()` functions to accept an index instead
of a repository?

Ciao,
Dscho

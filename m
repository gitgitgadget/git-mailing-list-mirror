Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064CFC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 15:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiBXPuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiBXPus (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 10:50:48 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900FA1451D7
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 07:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645717810;
        bh=ths3N1nGeWyrcZvJsc3CveNC24l/WfH5le+4N8q9XKM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KdzqOMLJGmYIlKoarx9WvXKId6BAGIyCwwx9mA+NTBOcXq1JW6x8VFcQf8U1cAFJF
         xd48kHaDPJJv6tbAKHWCcSem3IaJ29ynr/bSXJLyTy+7Tg2Ie9cseKOPPyD5bnXtQq
         PY1QfI3N/hC51PKkI8LrSAOmbxUJLgY2iJJl4AeI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1nzbvR2OtI-00ni17; Thu, 24
 Feb 2022 16:50:09 +0100
Date:   Thu, 24 Feb 2022 16:50:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler <git@jeffhostetler.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 03/30] fsmonitor: config settings are
 repository-specific
In-Reply-To: <456172c1-9648-c01b-c747-c6d77ae570bf@jeffhostetler.com>
Message-ID: <nycvar.QRO.7.76.6.2202241647440.11118@tvgsbejvaqbjf.bet>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com> <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <384516ce1a190d836324b2c2262d611090207357.1644612979.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2202171725060.348@tvgsbejvaqbjf.bet>
 <456172c1-9648-c01b-c747-c6d77ae570bf@jeffhostetler.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CesnBQk+ZB2dBKdOKv9MEvc1WVT1KIsF5l5F6k4CKVaF9S56IeS
 +vnx85Fs2/d7p+ucpd1o9VW9bW5rZFOrmHmbXjQql9hwnPZ81FogeQaey55ttYEHKdSD2+M
 B/OzRFGFoqMBuVgKYBR1fVu+e8ZQVwsNk+W035KV5UwIkJCoiuPR6a/QJaXCoVjSnqsyJpj
 0vRcVoCzQJ6WxSJUFHviQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n/g9tvVSOro=:DcLk+GBURnnDAg/WUflEMa
 tykx7UMk+wwqeuPS5HR9vHBaMTUHjkGKmoDRa9yNpNTBw8XMWM0tN7FGwjzDMd7fh7H5mdlOf
 V3vWvL+nqqr+Duimsd/YbjWjBJo8fD4BjQM12VRyaT06lGsU28d1eGZF3Agsi7RQiSdV9FVwh
 IgbETe2avF/VTFGWEitDCdSFjVZ6Q6qfGlOeQH+ngAGpJ9s30Vp6HGmTpBWx0TeEsNkK8d2Ee
 uBgmL34dilLl2Waoo4rYrWBkxyWcar76tzW3G0p9Viqop/nV1XzAfky4l6B92He3NMzhNBgoe
 GlLW5HHZPfg95l1u/RyDAuYHPpqa8tUZ2OxFBkZXYD6iIm2hqYCdcQIUZVSmfJoF4M4RWm/4l
 7EPoUqM788Poz8JLzd5SoaCUQdKG60+/h7o8yxN/roPNhiArS5Eb6ftlhBHyJ+mnvOKCZZ8qO
 MZawHkot2HvBGTw7STYJwS3jJMJBS39IUYSe+DUjX+Kh3PhIt+N1Nx0kWMF6Gka7F/qq2IDzS
 wMFBhSBWMNvdG5tAJRjCm+Nn4HxYFBvfXSRN+FfjdYc3rQj/Rlmr2onpuh3AwP5yEWoKnITaB
 rHuQYK7Mtu+xp14+zvMgz1Whk0dEkqARSTt8ZO+8gnA7lZj5yJnhxKdr5AjwM/C0demYNmWsW
 id8pok3vilbuKk01C7/9EVzEKBEF81oY1YRTELgq2xvZAdj8EIqBXkzKZOjiyjvLonC0vvvSR
 fyHANysS2amiKW4bkixT3zs+XzIPdF78VHfQb2ctNa123NgbRepV4KUQjt8RqN4eZovcHws4V
 6XoForZ8Q0jv5F1Xu1UkUrxyzOCduLi6qAUcyxgar5C0UhSpJd7ESLKfGfDSqSXXxISjCYuqG
 BOVFZdIYSHttm+PSAGmX6TvfGpDyY2sRUv4uuvxFlFI3OYjxUFS5ZZ/z/mQ202YlxBERnXtnU
 42EjdNa0ZESsCvGiDvdM97U/7Fv8dPqjo4NNDD+IM3hkCvdPRHXR1ZDZcE7W9kwV1b+Ce8gq1
 YRF/s2Kt9qK2kUZhRtnvEQMgPzC3YueCCNqyqMlSCQRRHe3bTNQ1v74A67OmD5kpyiaFS5euL
 bcEy7X74S8C/IQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Thu, 17 Feb 2022, Jeff Hostetler wrote:

> On 2/17/22 11:27 AM, Johannes Schindelin wrote:
>
> > On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:
> >
> > > diff --git a/fsmonitor.h b/fsmonitor.h
> > > index f20d72631d7..f9201411aa7 100644
> > > --- a/fsmonitor.h
> > > +++ b/fsmonitor.h
> > > @@ -3,6 +3,7 @@
> > >
> > >   #include "cache.h"
> > >   #include "dir.h"
> > > +#include "fsmonitor-settings.h"
> > >
> > >   extern struct trace_key trace_fsmonitor;
> > >
> > > @@ -57,7 +58,11 @@ int fsmonitor_is_trivial_response(const struct st=
rbuf
> > > *query_result);
> > >   */
> > >   static inline int is_fsmonitor_refreshed(const struct index_state
> > >   *istate)
> > >   {
> > > -	return !core_fsmonitor || istate->fsmonitor_has_run_once;
> > > +	struct repository *r =3D istate->repo ? istate->repo : the_reposit=
ory;
> >
> > I see this repeated a few times. Would it maybe make sense to change
> > the signature of the `fsm_settings__*()` functions to accept an index
> > instead of a repository?
>
> I think is just me being paranoid -- testing istate->repo for null
> and assuming the_repository if necessary.

Indeed, this might be a bit too careful here. There is a pretty strong
assumption built into the Git index that there is a repository, after all.

> I'm wondering if it is always safe to just do
>
> 	fsm_mode =3D fsm_settings__get_mode(istate->repo);
>
> (or maybe put the null check inside the fsm_settings__*() functions.

I would like to try. The test suite should give us enough confidence that
we have dashed all Ts and dotted all Is on the question whether
`istate->repo` is always non-NULL.

> changing the signature of those fsm_* functions seems wrong since they
> are associated with a repo and not an index.

True.

Thank you for the sanity check,
Dscho

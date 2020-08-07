Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC96C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 07:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF7D7221E5
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 07:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="bZ+ndc+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgHGH4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:56:55 -0400
Received: from mout.web.de ([212.227.15.3]:38295 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgHGH4z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 03:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1596787004;
        bh=froZRVcmmOOQePibQqwHuSIsQKHt9bgXDxItiP7Vj+Q=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=bZ+ndc+vJ9suwEXvrDgVAmPcV8zHF6Na8IVQzncYaz/5nHB7euO8hGj5VXGlaLjhs
         kpMQp5O1ovkN4oDjfuwinoLnLG/+5qMRU2APya3ABV1dF/usZwsMlEU3tVBTTwaDZT
         Pnb9EgMVjp3ZLLKzkapkUyVZ/LA9x6ILUJzwN5QQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MI3t5-1jympY3VJv-00FCVR; Fri, 07
 Aug 2020 09:56:43 +0200
Date:   Fri, 7 Aug 2020 09:56:43 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: "#define precompose_argv(c,v) /* empty */" is evil
Message-ID: <20200807075642.cw6zjym7xykxbsdm@tb-raspi4>
References: <xmqqy2mribft.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy2mribft.fsf@gitster.c.googlers.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:rbnxCtS4HoLWq4MZtMzGSJHxDG4lDuX9wEUx2+5u5Aw9Zu57MTT
 EggR2fOBsbLq77VQUI6TzF8aFV5e1fZHOUIxFzEgozjzOxa7QJWm14Dc49HhEJ/q4/BDMwj
 AanBgKSIsMjTsaJucYean5Z5fTYY4xf/781pfaho7KTOIazXgmSfwav6QKB6UvRKIY7pA57
 r0tuJdnoJqIL9I7Kj9YkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jpej8dbazcc=:+08jKpMDtPNcXUyCIZVhYp
 t0bWdRr0Cf3KjYyZKrQacEIu4eZzCuVX+aRLEaS38hTGCIFRlR2ihXKpBkHF2xIeVhylJqfKs
 JNkrjE8jBJsqLoFXId6DRx9oEkvcEv2aUYZ/t42oQ3NbZ1liWPkxthvwdkOmla8DUlHhDMhu5
 VNoZ69jz31d1ut0Bar7zXdheMgngffSvTniqoBz2rlju7bmrI+MU3DKG25rqRbazjyij1kKBq
 aXWi4VWM/b9BZEYR0KuNfMYVEdU/G2dTGLGnrtYSveD0gMQKkDmFlWR2XzwLeSugT13Ju8iCB
 4uggTMgGJHyUQt1gUs8usfo5eB+mTY2sCsu24s0qd69ObIipHAfcMRCFluH0j03v+SCHRH+SJ
 XvJ4ezTJr762g5j9QUeU1L1ynF+D+i/syNnEjFJteso+qCN7Fgv7i2q4zO2+Iu9eOldCt4BPK
 XkanDxfSuexDLL2Ykq/PXwdaykiRKHwSUF602ZQL/ptPkGEleb2MXYfZGMx3wJH7Np9ns9/CG
 /OYcYNQdD/W1sdwNIilwMCODj94ko/NEnrC+pBHu28zndgRqDZVoon48bTroMHtpcgHi4yXNK
 /GOEqYRT2LO9XpVqIgLobLIEURSJM290tWz3F+nlYdmyGTMlhKmxTADbGjyTHm1dD8yQJCRfU
 9IRYplZp3Sx6tjbL4E1i+Ln7GMvOzV/gdOx1tne96WilT8OjVGLzrU01VDSznMXBNRcXSbbct
 o3/aTEa+m2EHRYlbjlpSLbkm4jZZuzp7ZR7OqX/TrOKrXyF/75wsaf7dkOg7VpRfnVRckI3Jj
 fHJnBY4n+RqIFlbjEAPxtc2Bxm+iCGkO+7/Wj0h5c09HiamTqoA1NoVqSQCs/polopF94rXUU
 vNrUzfj9nY9KdWegVJwBVy5lfcgMqEHDD9LjskZaBxYnbDHmIIo6CN7K5Gt59NyuxNLmQohd/
 j1K5WDfd+mumxZ+6mSpunt8RdpLWqryqLoTBS+YlAD+VywdjQsF7FPmILnji/FhT42PJylw49
 6baVE4GshqbOsaAE9D95Qxyu+tC39UyB41KzvR5LHQRM5arBzOotANh+SFJVAl4BRPNgs5qxO
 gPKxt9YqM9sfUCJ8dmunyu1F03QYrM9BJQkbK/dHNnpxjno7zc0i9YOcTt4ron65gSIy9ISJW
 WAiZasnSwHX01hIefRvgZJphVWJF6xktlEP/VDYLm5K14e+/Kn0W8PlnySUv+eQRu4K3jM5VJ
 RL37mFMP/qkDwERdX
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 06, 2020 at 04:47:34PM -0700, Junio C Hamano wrote:
> I had seen an interesting compilation breakage today.  A topic adds
> many more uses of argv-array API so I resolved semantic conflict
> patch until "make builtins/submodule-helper.o" passed.  I failed to
> spot one remaining breakage until I saw
>
>     https://travis-ci.org/github/git/git/jobs/715668996
>
> The problematic line was
>
>     precompose_argv(diff_args.argc, diff_args.argv);
>
> where diff_args used to be an argv_array and is now a strvec.
>
> Why didn't I catch this in my local test?
>
> $ git grep -n -e precompose_argv -- \*.h
> compat/precompose_utf8.h:31:void precompose_argv(int argc, const char **=
argv);
> git-compat-util.h:256:#define precompose_argv(c,v)
>
> The problematic part is this one used on all platforms other than macOS:
>
>     /* used on Mac OS X */
>     #ifdef PRECOMPOSE_UNICODE
>     #include "compat/precompose_utf8.h"
>     #else
>     #define precompose_str(in,i_nfd2nfc)
>     #define precompose_argv(c,v)
>     #define probe_utf8_pathname_composition()
>     #endif
>
> I am wondering if it is a good idea to use something like
>
>     static inline void precompose_argv(int argc, const char **argv)
>     {
> 	; /* nothing */
>     }
>
> instead.  As long as the compiler is reasonable enough, this should
> not result in any code change in the result, except that it would
> still catch wrong arguments, even if these two parameters are unused
> and optimized out.
>

In my every-day-live these kind of "late detection of breakage" is
not uncommon.
In other words: this patch allows early detection and is much better.

Thanks for cleaning up my mess.

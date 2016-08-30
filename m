Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BB021F859
	for <e@80x24.org>; Tue, 30 Aug 2016 10:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757976AbcH3Kci (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 06:32:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:63234 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754327AbcH3Kch (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 06:32:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LqW8j-1b9lQw38ld-00e1FI; Tue, 30 Aug 2016 12:32:27
 +0200
Date:   Tue, 30 Aug 2016 11:21:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 12/14] sequencer: lib'ify save_head()
In-Reply-To: <xmqqy43f8fnc.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608301120510.129229@virtualbox>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <cover.1472219214.git.johannes.schindelin@gmx.de> <729cf9d7cca4ec3fe9caeb6f21a322f3c68ce135.1472219214.git.johannes.schindelin@gmx.de> <xmqqy43f8fnc.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7FSiA9gAtTcNV3OwHOQ/chDkxQx/L3xjZu+IWqe2r6M72glGk5c
 msx06FcRaGjt4zoimAhm02m7j7Fk327r527FZGmcKFvcoPzX5azPontKoLH5QncLd6r2FIC
 8KUf6U90OrHid8xASk2RAj6rLLgN6zUUkkXPOrIKMNtghD3HDgD733EgDL6D7apHiU0qMx7
 A+vlErG9Eqavp/Mra3XXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VHhT6hZ2FLA=:bupLR84qjjAYZ2bdvdsOJH
 JEGwLBH83wzdA5YdLS2TUa4tMASIRH4gOsU63503HDRWEVYKcV/yP3E83JtG2qVwIPF1vNT53
 9Rdt0nCfhBf1eDjbnpyLc/RD7m3+G5V1x5gorWiIT56YJ7jQUeg/APuet8g+3k4khebB0Zj3F
 YyM5WzEDRbj2rSEL54J/HFecABVCTMBTN+W4o1caaWTiqTznjwGQ/EtaKevX6MTIaSKP5jGsx
 ssI6VVqBY8ealQW2ZWSoXw+nwGX33/Zn/f1uD9MecrJQmmGXTI9irv+3AimKT1r0PCD/TN9Vl
 ZNXNPBGZXGpmDJcFXWKGCeioqsR675nCKo+MLScADpFwBUGbx0zDO5e+iPqWDu5vCHIevMPKs
 GsaIZhkrNIWioplndoDYxyablzorBGm0iaOsJ+L+XX2GSMkDAe3wVTFMg893zOzWlbDRvnrBS
 qO9xmDKcccq/PllS+Mh50rXPTLme778sG3uuaQPm/EdJy2SkLLNJdz1sAOVXf6/ws3wqpgigO
 iBVXVkSWTFhIb7qLT8xy6m7wo/1UkBPK1r3Yo05MjaAVV/c48IIWJQ2aU+wrbZ+s2F/XM/NKW
 BA471u1D6fMZCM5VFrPcSXr7q/Ka9TN8VrGYNsqPfo7ZhDhWpGUQzQ+pQ1SXQp2w+im3LZWTi
 enDO+ncJuo9iKLxGRyUrdr0sDQFjj2mfEmIp2j0Lftz7YcrIHUw4p/0fjY8bcsZtjhYklGBtR
 WxUe/i62Bt0N/BjQFwhVQqE4lPNBhUnWgY4TOt0B4pzg5mSBGssnjhkg/tFQppT4kIel9vTsg
 cHwE0cv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 29 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> >  	strbuf_addf(&buf, "%s\n", head);
> >  	if (write_in_full(fd, buf.buf, buf.len) < 0)
> > -		die_errno(_("Could not write to %s"), git_path_head_file());
> > +		return error_errno(_("Could not write to %s"),
> > +				   git_path_head_file());
> 
> Same comment around a left-over lockfile applies to this.  An extra
> rollback being minimally intrusive also applies here, I think.

Sure. I added rollbacks in case of failure.

Ciao,
Dscho

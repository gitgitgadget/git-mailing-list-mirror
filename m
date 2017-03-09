Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E0CA202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751875AbdCIWAm (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:00:42 -0500
Received: from mout.gmx.net ([212.227.15.15]:54213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750781AbdCIWAl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:00:41 -0500
Received: from virtualbox ([37.201.193.18]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MAyZg-1cw2G10oQG-009uAM; Thu, 09
 Mar 2017 23:00:29 +0100
Date:   Thu, 9 Mar 2017 23:00:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2017, #03; Wed, 8)
In-Reply-To: <xmqqvarjz5yv.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703092259010.3767@virtualbox>
References: <xmqqvarjz5yv.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7fQZF+kMi4mQDQXHT3Es4tzqm5K4IYTcmEjr8ysTEXvG1omOZHV
 55ncf1gvy62yRlANH+ybn45oUILcmX/6e24U3XHlK4Ms75kYSoJFwq+d2R+ydm+jqafWvip
 0/2pt+IC1evtZ12S4dpILZ26FrguJBGzcD1hOsyue++JqxBJbwJloyd3SrsnolJqAWicoEC
 sWL7Bqd4d+Z0Rw2NX36Hw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PBMs53r26UU=:znwCnjb6cnuMM9SaO5M+Uc
 JzfDBBx45+53FkqfXQ05ltm7NnZaV467KTrpYNpkPeQdDMJyU2ssWjivXhAb2WUD4Vdd8FJ6A
 f7zucVahezC+mYjILNJD31uP4Fp3DMagLy2E65iSXoayBg5e7GVNCpu0FDaZiI5kfQnqoPt0Z
 T0bFzDaTfBBMqKdNQ6BYNvqRVShTpICWm1ghatl9BmAY19H5SmrD6X7UIMnAOCKwlAT/awuIZ
 ilvHhcSHiUmaZn670DTV4HHkZQEHvfqZT65Wsgjy8zNMovJu3T/wuSVG5SikoMzc/nwVarPL2
 3RpBGhUxTKx5XB2zJDW+++vcOOyku3RfpesroAtavSbilrSJE1VhXEGbzGSq74tUMOAyYcgTb
 1xB1sEHpjNJ+g5AunA7CQw1doDXH9Qmd4yG64msj/NBLz7ib4vDCINkeIYwmW7SbId4Ni2fyU
 GSStM4mlS9/81Owm//fT9SKbTbT/bTrRzEvIP3f8E4a/l9RTIJv1hbWUsLg6dQQOCXopEnorm
 9wcPqmkKRqObUm4YmT5v3g08Avy9r+idag1mcKUYbt6fVc66lDPbjY8HV6Q8yvXEoWDoULI1C
 hJOIZqtKP0HFNGC49TkaeZcr9tf0iGxra2TpRcgp7YqB+EdFhdMJq9UJLYf2rJMTspvjjyJbv
 q2fkv940tNem1MyfE+MqTrKOmTTRW2RlMdWYft1AT+60f5CQwt3YZD4uQYqGiKDQqzf7CGFIz
 Wns/FqsaDSM/Y/6UdwhENLBHmjZRmPmy9tarbEXOPhVZ9ECVU290av2QboPv96YBSSIJwQWXi
 eT2scJy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 8 Mar 2017, Junio C Hamano wrote:

> * jk/http-auth (2017-02-27) 2 commits
>   (merged to 'next' on 2017-03-02 at 87f81b4395)
>  + http: add an "auto" mode for http.emptyauth
>  + http: restrict auth methods to what the server advertises
> 
>  Reduce authentication round-trip over HTTP when the server supports
>  just a single authentication method.

Not only that. It fixes a bug where empty credentials were sent to a
server that did not declare to Negotiate (in which case empty credentials
are literally useless, and very likely incorrect).

Ciao,
Johannes

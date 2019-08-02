Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 617611F731
	for <e@80x24.org>; Fri,  2 Aug 2019 11:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfHBLlH (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 07:41:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:37567 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfHBLlG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 07:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564746062;
        bh=J7jgSPdLLrOkhognJpjwlYu6rAitaRL/Thjm+aZV3VE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jPDYZJNpn/wuD6gRapqfoDV2QU4U+0Tqh0qGbN4YIZi4N/TcDPArIim239EgFMAjG
         PViv9ksHBbj/HIZAUjMepDWdJifvsgb6ENOTvKSdL1SlglHHkIvabH5VRTGBndhufg
         75aNLsLje3WpHCTNm27jpMz7g/b6/UbfBSx2OzEk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZ8fw-1hd62M10ou-00KwmV; Fri, 02
 Aug 2019 13:41:02 +0200
Date:   Fri, 2 Aug 2019 13:40:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: Support for --stdin-paths in commit, add, etc
In-Reply-To: <f35fe280-2e26-f719-4030-faf261bc9a22@syntevo.com>
Message-ID: <nycvar.QRO.7.76.6.1908021335250.46@tvgsbejvaqbjf.bet>
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com> <066cfd61-9700-e154-042f-fc9cffbd6346@web.de> <xmqqef24op5q.fsf@gitster-ct.c.googlers.com> <a6610e94-6318-b962-5dd0-ca379def3bba@syntevo.com> <xmqqimrgmx6k.fsf@gitster-ct.c.googlers.com>
 <f35fe280-2e26-f719-4030-faf261bc9a22@syntevo.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7N3qJOwC4fB/bxA8nCIufkPoWNQeDeXnxWt4mboY+cuTtAhXHL5
 EmjlnsrQT7djsgTvHICi9SHWhiauFy0sP0w4F5SC2HAJ+mEbtKgjLk2T9kUCAppzx1tmME8
 kcIQ3tLk4Bq7ChgxwErEV0GzYdLbzL208aPzGoYJ+UCwFsWIyBGqEa3VIo+X1+dylJWfoYX
 submBPSI9k80d/yK1G/2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OQgRZDPxbbk=:M/A9CQjB3hxZ5opXVEexAK
 pr+OOMP4TKoxoYUVRARoxUI9/NW4Tgn5C7zLqAJyZ6C2z4kotorSEyE+WjjhbhXZ5GJtzj/oR
 kI7CXwHtaXwZf3TdUCtrGZvsSuC9N2O9hGSmVaDp3KUtEMf4rx+QwtoOYnL8bNMN3W+79bgrA
 TesQZLTEPm8rF2sR7TsyexOWn4oCQ1BpEUyXhlM/Wzkl+DYyXG9UhIzE6DWFzytcCZCScu6e0
 d+Gq2oJxl1kCp9cNQixvYdaxQ5qBvDSLttqrv1gQXn9hcyt/g/2ZFapetTpoWOHu/ZXSt2zKW
 7DKfYyU6FwEm0PaSNj05CMoMQkZDMSTvz7VB49yZzxnyQ7Ae/foV/vID6x85q7fbDg1imPcq4
 957UeWvTH1JKdIVTwSSN1nD8TveKDAsBHsztLe83n4kRBNdBax72DRBjuNebSS382qNGyD17r
 J5CxWG39NgbhKCeZt4C7kioUd61gcThkWVmysE576g5MjlyQmdDn/dLB14M1vV1wJLoPLHYVR
 pWQP63gl5q/kodXNL4rqRL/1dWPLPpaMzxVFAUgyS2sovDuWI1EqdCLTFkLl8zyezX+cUmX5n
 yBxuZG6lSyp3UbUNE0Zdl/o4Q7Ao2L8vYUxGXeLnqyl+5S19QgETbGmp45NtOk3KE4Q6pXgGI
 KUwa5e1vDjQ9T6rsevram26AH9hlxPOaATgQhyKYssOEWVKUkiS6Zyrutne4kVgXvBOTzQL8/
 ApkBx6RzfKuaWqg4ST7MljpTooeL3AYcmkea3WZ4pJENWYc1h1ove42xL8x9e7Bw+njiSjx9L
 +DHI5BR33bSD2oDBHmojnZvopWf6v6uLRErRpqp1BFIKxb2sxW0Uitq5v2Jzddx+ShzL6ng8h
 P04IVdfQqV53KZu8AWIbO0TaTaTIY4NRnIjXYHR0t522l99QxD7lNaOCL1PpKHRIKdgNyvjeR
 J3d1fSnqZGrLo4r9dCfg3ZV0zWW+g0p/W/wRa2O61RnFqOIH6YYj071ljdzhnfEydyct8VKzO
 gZA0pawAjxhOhMx1VheBeXz96JFlScMpkzenw8ti+nZ+4w2iEgaJ5heEPbF8+FFcuJqZVkOqm
 RknTKBo3l5562xzdZHFvuUz1bXyr40EaRDYOBo9gNiFVdOP36Fg81mVn1NRiyYSbCXENhNSC+
 M43a4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexandr,

On Thu, 1 Aug 2019, Alexandr Miloslavskiy wrote:

> On 01.08.2019 22:45, Junio C Hamano wrote:
> > That does not mean that any patch along that line will automatically
> > be accepted, of course, so the answer to "am I ready to accept"
> > question is a definite no.  No, I am not ready---we will have to
> > look at the actual patches before deciding.
>
> That's why I previously mentioned "good enough" patches :)
>
> Thanks for your time! I guess we'll start with a patch for 'git commit'
> and see how it goes.

=46rom past experience, I find that it is important to also implement the
`-z` option (which traditionally means: accept items via the command
line that are delimited by NULs).

And you might find inspiration in my patch to read the paths passed to
`git reset` from stdin:
https://github.com/gitgitgadget/git/pull/133/commits/1db4ef0ec1ec

I guess you could use a similar approach just after the
`parse_pathspec()` call in `prepare_index()`:
https://github.com/gitgitgadget/git/blob/1db4ef0ec1ec/builtin/commit.c#L33=
9-L342

Ciao,
Johannes

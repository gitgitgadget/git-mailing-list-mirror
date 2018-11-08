Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1CDE1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 15:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeKIBXF (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 20:23:05 -0500
Received: from mout.gmx.net ([212.227.17.22]:33149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbeKIBXF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 20:23:05 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MK3bN-1gJxhg0n5B-001U1u; Thu, 08
 Nov 2018 16:46:53 +0100
Date:   Thu, 8 Nov 2018 16:46:51 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
In-Reply-To: <xmqqmuqj7hiv.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811081645280.39@tvgsbejvaqbjf.bet>
References: <pull.66.git.gitgitgadget@gmail.com> <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com> <a374e4bb-1970-9ec7-fe94-a273f1206d6b@kdbg.org> <nycvar.QRO.7.76.6.1811071222200.39@tvgsbejvaqbjf.bet>
 <efd57458-07f6-2813-483b-dc7fba785dc0@kdbg.org> <20181107204142.GA30078@sigill.intra.peff.net> <e7ff6f22-fe5a-3cca-9305-2c8a6fb55d45@kdbg.org> <20181107220320.GA8970@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1811081408310.39@tvgsbejvaqbjf.bet>
 <xmqqmuqj7hiv.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Kz1ghOwK/HxLUe/T/+uO9VEw2QO4F6Ro8LyETgifjmn9nv1jKy0
 4MJCL6SYI+aGwXuhoKDerr5KKFfrIQ2o5X7Xocpwf/Ol24j0asaLhXrwXPQxMJmuotpB3QO
 5ZRWUzWBHOgfM92vlaECN8R9JMi6k7BN7F3xueeK64ilb4mn22wV77pmVUJAWFfBra51yqi
 4gYR6OVP2HYI1aBPCYr8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8RuahFWYdZg=:wkASTIHYDV5i8ISyNa0k8f
 TzmikE7nGFgAo8mCkqcxWM4hiXbzhAT3jDfy262NQhrhjiGkiYOdQ2vFuNxF/K+YZwPIM2rCX
 V8Mk4gdpNgt9BybkMzW5mwww8dLRPSJQ2Mg+1nRQBlVRn3ZeiLT6TX3nhpsrnx9y7e+nhUR9/
 dOu6iYHWtas0tucDU+hTomLnCQT7VHFcfSIneHW+kSN9ECSiLnblYKyO9YG5SkKdkrBqQzwas
 IqI9trb5x0A9zTS3N1fNVPRJK2XKxx0pqi95C4fIILQ9rVWOoMEPcusjb/Wawkcsn+4FgsQgE
 O4heH7gBMEMJrIklIxCy2EcmbEmT04fnQJLpxpDTwxyQd4+a/ca9Pxc1M8fc1RUoWIleTVRBf
 uPOqbJ/myyKHRFyj0B67rEx9w9d7fCyIevJzPRYonCytzrdDi5NpRPWKi4jZ4Bv2/bMYefW1J
 fHsfA4TY3SVYHK+KRbp9J6wLTRFS9wAgY2LYsZ5mE0YUrrjsIed5E0cmnJj3sn3/fQC9vzNBN
 mY+G1fZjZ5suMP5gAFt5LE7EMstWcsF3P2T+iPmXE6z/OPiByxdidZOd10n90TbM21UbJDZEO
 IUVhnNFPxIGtg5W3uuTAlCF+5pI19If2c2bOyAtK6YVaNOKo69csbqibFok+/bDZOzM80I1vb
 uTcUgSnsOLmMio/KGa1JWhulRu9aJpAJEs1SLufIyc9ApiKjv7kIfTmKkinnBe8k3Tr5WTu09
 5L2MMi0j6oFTxmInkWkFPlkYvWx/goFjaxqT4DiB0Ku5KNXkXu0NFNpTEYf0+EPDZSFNxKzEX
 fwJd7MA/tqTUnSK6ugo/DWhXVyZFNsXOeHejZkeEiAZ7VpDsOhKWdHhUArX5w1GV89hydBMPV
 BSaw+3ncH7kH14fPdmIj6hsXzwEokC7KPtU0PMSqGgub3Ve2TYpB6KQVT5ssjO1JsPvTp9coA
 fAhm6REB3Jg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 8 Nov 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > But now I have a really crazy idea: how about ~~/ssl/certs/ca-bundle.crt?
> > The `~` prefix is *already* a reserved character,...
> 
> We would need to prepare for a future where we need yet another
> special thing to be expanded, and it will quickly become cryptic if
> you said "~/ is HOME, ~USER/ is USER's HOME, ~~/ is runtime prefix,
> and ~~~/ is this new thing...".  ~runtime_prefix~/ (i.e. carve out
> the namespace for USERNAME by reserving any names that ends with a
> tilde) may be a viable way to do this, though.   It is just as good
> as your other idea, <runtime_prefix>, in an earlier message.

Indeed. Your "cryptic" matches my "unintuitive".

Ciao,
Dscho

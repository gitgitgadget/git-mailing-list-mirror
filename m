Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40F781F453
	for <e@80x24.org>; Tue, 16 Oct 2018 12:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeJPUMM (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 16:12:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:32831 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbeJPUML (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 16:12:11 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPUZ7-1gGUx91hcv-004iPA; Tue, 16
 Oct 2018 14:21:46 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPUZ7-1gGUx91hcv-004iPA; Tue, 16
 Oct 2018 14:21:46 +0200
Date:   Tue, 16 Oct 2018 14:21:48 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, github@brendanforster.com
Subject: Re: [PATCH 2/3] http: add support for disabling SSL revocation checks
 in cURL
In-Reply-To: <CAPig+cQFb3S0Lm+huUZDN4aw9rWwinh0iZp12ss1zVKpJ=2MdA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810161421340.4546@tvgsbejvaqbjf.bet>
References: <pull.46.git.gitgitgadget@gmail.com> <764791d13d20478639402e7af95e901223444240.1539598481.git.gitgitgadget@gmail.com> <CAPig+cQFb3S0Lm+huUZDN4aw9rWwinh0iZp12ss1zVKpJ=2MdA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:15S5I5byPW/51Ue68/kN6qz3BWcVptuYl9V/9xwYpIUjbLT1SPV
 XG3aOMMVlEnWxaUuqpY2d6O6QNPwYnBr0K1okJ4K2C6ykLNveF/5kJtl5YQv9kvPN3Jzbm0
 n0vB1dx/ZNIqsJ2UAVJWnd2AH2SeBdaOefGXWMWVhC5reXh9SOQVzcy/tyJ/aQilvUUgiT3
 wO1QwUfGEEYmPTZXs+eLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RJD+lP7f2lk=:Xf4fnFTzPOeeeBN2RfSEWL
 9UmhWRu6tpqS8oYmi7wG1eedPbTr4VqQhyJ2X7MnPUMbS75t1oYJo17eXSx8ugL0kNY99BiEY
 K5eSteBd0S49l0Kwa/sYK5MNTRnSVR3Y3GVj4P6sqSuUORniCMJVxBgdpincwtIZmUWetniPx
 YvdmhwwbQ+J2eDkw4tJu3UtVy/fklYnqKfCcRcrQJeTVxsWxcDSipVblLDfhR59zQf04vRitP
 qlEp+f5aJC3A2dKoSSbyThYXnNrJdxOo/PlX/8W4fzjw2QeuuUSGjUDJG4DFFqTdKQHhV/1iH
 ScALj5nmMfR5GpiFWKkAjy4ePkBeM8XCwhavh1CiyBEKwFAwJfI6vfex1TUXhcMOD17otMUjQ
 g/dLUsoH98DEvMa/iknTIgBTEA+05SncyGEVFwgOL4dUQXZpFEo7lWaitk5Jnw6eKDhT9SUfL
 23xdm4PKN1/UODa2D8vS32HrpNF9uAHgF1/lOFucKNhizyOKuIkW1UxD8XeEyP9CiWEZGbbyE
 qigKaQEldYOjVzSIR5IqFzvC0AzwdL147A1U0zHRhQTfBdn2CsALpRf+vYlMKLnFWcSxOe2Nm
 mEnBDVfrNV/MFE/05ln56yf654LsMN/UF1ZZ6EAJt1p3Z9xMNeKkZRuPF02LgjXmybawVBAvf
 moSSbqn4ssw/x6MP5GJGG68Fptl3iVMS1IEOLY1ihGOT2Vhxw0XhtHIPj9MmNzQhugNAn8vfs
 nF/+glaij8mhQ4ak7B9iAjuhk/bffSgdgCdwOm5l5vrZ+ofym/etQ/72Ekn3427bteFXcxrzr
 40GGn/mzcvvbe4o0+qmKdJK43q/FX3I5XxXtTiWukvPFv3y45k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,


On Mon, 15 Oct 2018, Eric Sunshine wrote:

> On Mon, Oct 15, 2018 at 6:14 AM Brendan Forster via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > This config value is only used if http.sslBackend is set to "schannel",
> > which forces cURL to use the Windows Certificate Store when validating
> > server certificates associated with a remote server.
> >
> > This is only supported in cURL 7.44 or later.
> > [...]
> > Signed-off-by: Brendan Forster <github@brendanforster.com>
> > ---
> > diff --git a/http.c b/http.c
> > @@ -811,6 +818,16 @@ static CURL *get_curl_handle(void)
> > +       if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
> > +           !http_schannel_check_revoke) {
> > +#if LIBCURL_VERSION_NUM >= 0x072c00
> > +               curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
> > +#else
> > +               warning("CURLSSLOPT_NO_REVOKE not applied to curl SSL options because\n"
> > +                       "your curl version is too old (>= 7.44.0)");
> 
> This message is confusing. If your curl is too old, shouldn't the ">=" be a "<"?

Absolutely correct. Will fix,
Dscho

> 
> > +#endif
> > +       }
> 

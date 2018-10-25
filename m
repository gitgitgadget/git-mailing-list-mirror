Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20E2F1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 12:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbeJYUpe (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 16:45:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:40909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbeJYUpe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 16:45:34 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsgvV-1fZU7g2fQ9-012ErI; Thu, 25
 Oct 2018 14:12:53 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsgvV-1fZU7g2fQ9-012ErI; Thu, 25
 Oct 2018 14:12:53 +0200
Date:   Thu, 25 Oct 2018 14:12:57 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>, github@brendanforster.com
Subject: Re: [PATCH 2/3] http: add support for disabling SSL revocation checks
 in cURL
In-Reply-To: <xmqqzhv2lnn6.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810251410360.4546@tvgsbejvaqbjf.bet>
References: <pull.46.git.gitgitgadget@gmail.com>        <764791d13d20478639402e7af95e901223444240.1539598481.git.gitgitgadget@gmail.com>        <CAPig+cQFb3S0Lm+huUZDN4aw9rWwinh0iZp12ss1zVKpJ=2MdA@mail.gmail.com>
 <xmqqzhv2lnn6.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+M2/EbaXUr576xlaf8GiW20pd1uoOYJBHJPQZbEMd/lMQADAnI0
 fPFUDejfXZyu82xK15I7Cmt5Z3a8NCUd1y0/GFoZxsL06wS0Ulu2NjWsLWH+4To2i8cGYlY
 e2ESAt1X5UpyUZagM6vG5wTcO5g+Zm6X7ILDV5nsYgsWyxenp0kitovrAq/ntLuzifWsHib
 1JH6HUYRPlKxq+JvAiO5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qeaYHXQVfec=:JHoGhomRpYwSaGXLSyeEmm
 8tRUCai+r4ofPNhpru6DWcz9N6UsGfiiKpERb1jb3FohJ0kP5+aiLZppCtG9vVHfQ22l6Y/Vg
 C5nViIU5HGjoplyQpu24p217XO0s8N6W+ISapgSoIR8SD3485iD7JG8mqn6QaejcTUyL0auwk
 sA0fPAy788qnbMANKRaFLTR9l117zkJVZBEtyjK0Ab4Ml5tTYspv6X2aSnt6qS/w8wXv+b5W1
 8QReaLP5RRzotaqsE6u5AlKMz6EhKuC2dT68lXT3ssM40C56BEV4unmLfNxOQvDgWnEUwC/HR
 fh0Unxx4acuu1fKfxGG83iE9gw4CfWBGJdbIJZyaIZzNcSWXwfRTEOIqMLFL1DHy7ib9Fqq7J
 RoZucdWmWZw1E2wQf3iwMKjd4hdlRizOZhl+3rVvEmeYbYMYGYWsju7KTApMYuA//AAvNfnYf
 pqxQfNOVPMYsG2dNj1//d0lLWzq3huXEZGyF75C+fFZcDvApAUMtfE7DQiMBvS40PoKfYdbqA
 Cg9ReyeH6iMXrYIKmN6oSJFCHhdRGE9tP0hacyz/EXmNnbvodDYroa2DPqRKqQ9rgBYFW7KR+
 2VcNA0qqF7eetYNrN+ifnxb56CyySOElpT1/DzNn2fxqgMqQSb4Cxzbsw06xk4X2smOzcSHL0
 wkDvswMP5XRmJlczdXLPJm9gmgFY6qrSCqaHswn4pgS8TSEh5kFGCuKP9/cHRN5AvfQ3V0QRP
 GW5ujsiNfF8HTZLucs+Rjjhumoa4Teh9SBiDO9VnFQBEjmogHqD7FLqbfXX4FhDTtw/DLbauU
 kj9OxSgk51FErRFGEtSnJ9p2hDGsL+APJ3/ErcCAj8iQG/U1fA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 25 Oct 2018, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Mon, Oct 15, 2018 at 6:14 AM Brendan Forster via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> This config value is only used if http.sslBackend is set to "schannel",
> >> which forces cURL to use the Windows Certificate Store when validating
> >> server certificates associated with a remote server.
> >>
> >> This is only supported in cURL 7.44 or later.
> >> [...]
> >> Signed-off-by: Brendan Forster <github@brendanforster.com>
> >> ---
> >> diff --git a/http.c b/http.c
> >> @@ -811,6 +818,16 @@ static CURL *get_curl_handle(void)
> >> +       if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
> >> +           !http_schannel_check_revoke) {
> >> +#if LIBCURL_VERSION_NUM >= 0x072c00
> >> +               curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
> >> +#else
> >> +               warning("CURLSSLOPT_NO_REVOKE not applied to curl SSL options because\n"
> >> +                       "your curl version is too old (>= 7.44.0)");
> >
> > This message is confusing. If your curl is too old, shouldn't the ">=" be a "<"?
> 
> I do not think I saw any update to correct this, and worse yet I do
> not offhand recall if there was any other issue raised on the
> series.

Sorry, my bad. I dropped the ball. As you can see here:

	https://github.com/gitgitgadget/git/pull/46

I have some updates that are already pushed, but I still wanted to really
think through your response here:

	https://public-inbox.org/git/xmqq1s8oxbpc.fsf@gitster-ct.c.googlers.com/

and what I should do about it, before sending off v2. You can see that I
already updated the description in preparation for sending another
iteration.

I hope to get back to this tonight, for now I must scramble off to
non-work-related activities.

Ciao,
Dscho

> So assuming that this is the only remaining one, I'll squash the
> following to step 2/3 of this three-patch series and plan to merge
> it down to 'next' in the coming few days.
> 
> I have a clean-up suggestion related to this but is orthogonal to
> this three-patch series (after the fix-up is applied, anyway), which
> I'll be sending out separately.
> 
> Thanks.
> 
>  http.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/http.c b/http.c
> index 0ebf8f77a6..43e75ac583 100644
> --- a/http.c
> +++ b/http.c
> @@ -835,7 +835,7 @@ static CURL *get_curl_handle(void)
>  		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
>  #else
>  		warning("CURLSSLOPT_NO_REVOKE not applied to curl SSL options because\n"
> -			"your curl version is too old (>= 7.44.0)");
> +			"your curl version is too old (< 7.44.0)");
>  #endif
>  	}
>  
> -- 
> 2.19.1-542-gc4df23f792
> 
> 

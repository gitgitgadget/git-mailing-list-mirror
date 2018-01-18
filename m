Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 296BF1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 18:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755243AbeARSZ5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 13:25:57 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41148 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753228AbeARSZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 13:25:57 -0500
Received: by mail-qt0-f193.google.com with SMTP id i1so15745104qtj.8
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 10:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6MHdNMk3f4xFQ2Wc3TKpq6fF3KG8wymKAqSIwE3QiRE=;
        b=LRUdlj3J/BZZtUPLRLJ42+lvRIt4nn0i9nwEh+5LLTMHFpPBjEyUVgEsn0r2+NMd6J
         3z0g+wJQAeRzgHMAlNzLoXTZW/nlu+IO+EJPIM7KQBE+uM/PNlTxzvC0nNP1pIvVkwtq
         /X4e5u76a9OSB6HD20mteK3KQkwtneGG69ozXPvd39+tZhjHcnVJOl2YXjslsHeik7HX
         uUJidmcVuIQoepl3qgFGZwShEVz+QHy8LoUYrauvoyg7xtDxrCSxjL/8Fx8xaFMUjUqg
         4qLd0ckyXS30h4gHpl+Sc3VbUmIVDAJXMkmnwcCv40BW7Wk1Kye7vyHuqfWs17ze51He
         gyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6MHdNMk3f4xFQ2Wc3TKpq6fF3KG8wymKAqSIwE3QiRE=;
        b=GbtEmbXAma1FpwJ9j42dTyrBCoMYHSUekBOaJ9IADHqFUwxBN0xcOvWl21ZEB9sECt
         SftaMdl4K12LxSzn5F2QhSd57mtRWOFaNwvN7MeeUNRhKgCeZiLMR9zjxzBAeWWzP0dS
         BXpDJqhIdH4Mc5vDqEbZDaM4kOtxfwYgkVLObQZoyOVzNO+VXXQXOo0WHu9V39DUVPJH
         aYHpg6TDj512j2i28tMwweIfpVofh1HDTXHfImEfQjXqiesExI+j/faTED8p1L45i3Xr
         6WY6SaWs4+Cy0RGlEvtDlIA830htQoA9x9dIcZ+n1HD47LnkGgGN9vYa1bTTfX3alWPv
         MtBA==
X-Gm-Message-State: AKwxytftNAtHdEAbt1P2W6zYRPncIipHoczfdYA1x9d90Tlp60+iGdTQ
        WU4NXY1BxOBqEIRbWEh8VKmSJHd6bwPYhpAnWYlydg==
X-Google-Smtp-Source: ACJfBotyWk16vWdCupkalUzVl0mnT36Jms0wCpw02wjZ9DQESQellSxIp72Y6ueMaWt/EY1mvKnxbzdSbVod7bsYNJI=
X-Received: by 10.55.204.18 with SMTP id r18mr63739157qki.212.1516299956458;
 Thu, 18 Jan 2018 10:25:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.137.143 with HTTP; Thu, 18 Jan 2018 10:25:56 -0800 (PST)
In-Reply-To: <970dbd7a52de6ab084df8e9ce083bb76ec1889c0.1516235197.git.jonathantanmy@google.com>
References: <cover.1516235197.git.jonathantanmy@google.com> <970dbd7a52de6ab084df8e9ce083bb76ec1889c0.1516235197.git.jonathantanmy@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 18 Jan 2018 13:25:56 -0500
X-Google-Sender-Auth: CvJM2_FnvRmDWOsNA1xM7_dIopE
Message-ID: <CAPig+cQBysXjoLKRg=tqJnHPdW9jx+TH0=PV-yTyxMqEOtuiMQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] http: support omitting data from traces
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 7:34 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> GIT_TRACE_CURL provides a way to debug what is being sent and received
> over HTTP, with automatic redaction of sensitive information. But it
> also logs data transmissions, which significantly increases the log file
> size, sometimes unnecessarily. Add an option "GIT_TRACE_CURL_NO_DATA" to
> allow the user to omit such data transmissions.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  http.c                      | 27 +++++++++++++++++++--------
>  t/t5551-http-fetch-smart.sh | 12 ++++++++++++
>  2 files changed, 31 insertions(+), 8 deletions(-)

Please document GIT_TRACE_CURL_NO_DATA in Documentation/git.txt.

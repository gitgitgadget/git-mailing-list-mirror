Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 370C31F404
	for <e@80x24.org>; Tue,  6 Feb 2018 20:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbeBFUd0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 15:33:26 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:36532 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbeBFUdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 15:33:25 -0500
Received: by mail-yw0-f176.google.com with SMTP id q6so2306200ywg.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 12:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0W+rqnvwsPqEbJsTrq7kmKV8va3GZbTg2QweA437Ehk=;
        b=ZVOdY3ovlcx0N3T7cXlMRvAM6SnkZQXg3M3D69RtVYc/VZBBLvTo+PVab2idIf4ReN
         x7zIzxhPZWVJa4IVv/pnJQlw3qD8EFCZcTqQdyDXT2e2E3hD2i8vb+Fsxzx1eP/0C/xI
         zzq4Pt+5aFURLrJwZxWKWzsMHBWlZzyAiIHFgzxaYQPUaguZeLOuvWtY74G/3658+Oqn
         +y/+DvBbLrzsDFOUImmVH7d/y6pLywl/DEjI9JwWPnmhcBBd5oFVcfGzH18E8Dt4Sg+i
         8Vlh2j+MFuNT6yyPMOXvgWe05ap9jO+Dq/59pBK2Ywoepm5dKWnCz1c6HU44LMOK/Q72
         fVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0W+rqnvwsPqEbJsTrq7kmKV8va3GZbTg2QweA437Ehk=;
        b=tywSmL5aQxk1DFJp9mh4Wv/udJHC3k2GCi5jEy6Tmb0SmKD8iSdYbHniW34O8R1xUY
         Vn/s7xCPxHghxUN5msWVF2WbieJHf/XXcwcxrPIwltkfr8HJfFtr3AjDHjP+mcSquoPO
         ChWIVwgVBIXcJtwB3bKqYbm+veZKAQfgcoJPT8pvUMl+6/7t1QpGE8ILud8TFwaRyqHN
         iEp+q9j0GzpHltglreZ4tEb/8MZhKy1J2Vf/CDYNuXbCIkpXyTqUxycALPnKpAR7LnoJ
         ws4OCS0dDIQJXHa+1zKciWzJIu3S4D8DVT1oO0yEGze+agVrFk0e2+10BP9C+KttmKkh
         1i9A==
X-Gm-Message-State: APf1xPB8Pw9/22hX+juX2c6/pJzFm01nkbvoz6ajz4MsFXz8zFfpu6Bj
        U3kXQs2eEgF37hc664OlQ5HB3bOVPvThr3qOZPZODQ==
X-Google-Smtp-Source: AH8x225mEeZqJvhH7B2EKGP8IBQIlS50y80xTlSkd69BbEtqVqQReb59xXC+uDb2lVdyOGGBQel6c9MW7VNvcTQhfRU=
X-Received: by 10.37.34.138 with SMTP id i132mr1888837ybi.114.1517949204973;
 Tue, 06 Feb 2018 12:33:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 6 Feb 2018 12:33:24 -0800 (PST)
In-Reply-To: <CAPig+cTjUAYRbaF_CLAmtYf56cL2hhvYc4VLrE8DX-MiryCWXA@mail.gmail.com>
References: <20180205235508.216277-1-sbeller@google.com> <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-55-sbeller@google.com> <CAPig+cTjUAYRbaF_CLAmtYf56cL2hhvYc4VLrE8DX-MiryCWXA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Feb 2018 12:33:24 -0800
Message-ID: <CAGZ79kYRg4URASwy5Xf7iZR_CQsGxcVDzfS040Yyc7z1uKKqZw@mail.gmail.com>
Subject: Re: [PATCH 075/194] fetch, push: do not use submodule as alternate in
 has_commits check
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 8:20 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:

> Or just combine these two error cases:
>
>     if (submodule_to_gitdir(...) || repo_init(...)) {
>         strbuf_release(...);
>         return -1;
>     }

will fix, thanks!

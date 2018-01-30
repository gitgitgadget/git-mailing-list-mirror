Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B10F1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 18:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeA3S0n (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 13:26:43 -0500
Received: from mail-yw0-f180.google.com ([209.85.161.180]:43769 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752559AbeA3S0m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 13:26:42 -0500
Received: by mail-yw0-f180.google.com with SMTP id x190so5468800ywd.10
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 10:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h4KQR4Epcpp1F6r9vo9ry1qyuAGjCpF1sk+lCVaNyzA=;
        b=mENFrjXQZ3tjrfs/zeReoKOMHZ/FxG9zsbSTHNjDAGsAD1p9xNZomGJkYus+XTvd1g
         ZgO98CqfnzXsnQ8Zr6Lnh+MWR0R1C8/g8OHRXFXEfvKBcwr3Zj3MIqwyQ2V0AasaDJ5d
         OtPPJXqnibMHQeIlVjRxC3lM9f+BZIhQjM9CTsMxGzmu2F6frBU6xagyQ2f2xMGFOXIl
         QVgg+h9gLkJGPI7bhzYzaA+/l033tXwv8ZP46XMVYTMEyempONXI8B8We0KPwIIFEYH+
         +/dMVYAgfq9aIWm5cKYpnmDOP+fPq6CluDu4bGNvM7cxmxcMpuYvsBr+5RpvgoIJLn8W
         S3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h4KQR4Epcpp1F6r9vo9ry1qyuAGjCpF1sk+lCVaNyzA=;
        b=VFb3NV2ijBUzHJVjyIKXXXFnYA4wAFHgUi2QjyFtXmw3BAILbmI+6q6DSy55lXBXHt
         U35BpsAazu3aXLWC2juUVIVpHtHmD8lGAohDmQMhOHe9SfQSYonQXc5M1/FlGNF/6eWR
         Ezhp1n3B7DwRThBcndyTBxhFrkTGjf7gBVxRDHscuBGYufAOzW7t961DsP7qmMw5FeQj
         75WrcljSg9YyFPsDgiOcpV6jMDuZiOig7FbNJRzf3cUkUyA+Uue0x7teVkjggWHRx16i
         6Txvcze1GHw/+9KTTEFBLCPWU02XNZBD3WBhLTDpn4POiKTuzrfV82t9VB4/U5mpC2Gw
         ao0w==
X-Gm-Message-State: AKwxytc0Rx8MCQJiVyX/D9CJpqTIByLK7JIqWqlos/hrZ/Ubyvw7kCaC
        QTfuCjD4hpM/LZAhVj6efuLcBcpOc7iYJzu9wlLhXg==
X-Google-Smtp-Source: AH8x225rQMODUjTHvRctzAL+G4dbFCYO73HtqD3qrNsmTlDL5VuUbzWGYsfoxmZsh/rL4Y6LMrkX8GIHubhx5DMzWcM=
X-Received: by 10.37.34.8 with SMTP id i8mr20696830ybi.114.1517336801827; Tue,
 30 Jan 2018 10:26:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 30 Jan 2018 10:26:41 -0800 (PST)
In-Reply-To: <1408921517058505@web15o.yandex.ru>
References: <14657461479715884@web21h.yandex.ru> <CA+P7+xrKfqOb-3FhKxXdnF6g9PktNWNzY+ZnHJS=yuVo1YdXzg@mail.gmail.com>
 <CAGZ79kZbGPneUXVEqJYhQAn+dfYve7qCjhO7QFaV1JBs3HD1aA@mail.gmail.com>
 <CA+P7+xqMUPLC-aKW-fiS629_Owat8sCa5vp_bOwQTO8LP4hCzw@mail.gmail.com>
 <12531516812201@web36o.yandex.ru> <446801516908691@web22j.yandex.ru> <1408921517058505@web15o.yandex.ru>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 Jan 2018 10:26:41 -0800
Message-ID: <CAGZ79kZbhHugy4EOjXn4DO_XjpdrAnKhk56j4Ew2XGggGYQVyQ@mail.gmail.com>
Subject: Re: Feature request: Improve diff algorithm
To:     KES <kes-kes@yandex.ru>
Cc:     Jacob Keller <jacob.keller@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 27, 2018 at 5:08 AM, KES <kes-kes@yandex.ru> wrote:
> One yet more:
>
> @@ -43,22 +44,25 @@ sub tariff_title {
>  1;
>
>  __DATA__
> -@@ control/tariff.css
> -* {
> -    margin: 0;
> -    padding: 0;
> -    border: 0;
> -    -webkit-box-sizing: border-box;
> -    box-sizing: border-box; }
> -html {
> -    background-color: #121212;
> -    color: white;
> -    font-family: 'Roboto', 'Arial',  sans-serif;
> -    font-size: 16px; }
> -a {
> -    cursor: pointer; }
>
>
> +@@ control/tariff_about_old.html.ep
> +<div class="option__about">
> +  <div class="option__info">
> +    <div class="option__icon"><img src="<%= $icon %>"></div>
> +    <h3 class="option__name"><%= $title %></h3>
> +  </div>
> +  <div class="option__duration">
> +    <p><%== $option1 %><%= stash->{ comment1 }? "<span> (" .stash->{ comment1 }.")</span>": '' %></
> +    <div class="switch option__switch">
> +      <input class="switch__toggle" type="checkbox" checked id="<%= $id %>">
> +      <label for="<%= $id %>"></label>
> +    </div>
> +    <p><%== $option2 %><%= stash->{ comment2 }? "<span> (" .stash->{ comment2 }.")</span>": '' %></
> +  </div>
> +</div>
> +
> +@@ control/tariff.css
>  /*  BASE BUTTON FOR TARIFF CARD  */
>  .button {
>    display: -webkit-box;
>
> But it would be better if `@@ control/tariff.css` were untouched:
>
> @@ -43,22 +44,25 @@ sub tariff_title {
>  1;
>
>  __DATA__
> +
> +
> +@@ control/tariff_about_old.html.ep
> +<div class="option__about">
> +  <div class="option__info">
> +    <div class="option__icon"><img src="<%= $icon %>"></div>
> +    <h3 class="option__name"><%= $title %></h3>
> +  </div>
> +  <div class="option__duration">
> +    <p><%== $option1 %><%= stash->{ comment1 }? "<span> (" .stash->{ comment1 }.")</span>": '' %></
> +    <div class="switch option__switch">
> +      <input class="switch__toggle" type="checkbox" checked id="<%= $id %>">
> +      <label for="<%= $id %>"></label>
> +    </div>
> +    <p><%== $option2 %><%= stash->{ comment2 }? "<span> (" .stash->{ comment2 }.")</span>": '' %></
> +  </div>
> +</div>
> +
>  @@ control/tariff.css
> -* {
> -    margin: 0;
> -    padding: 0;
> -    border: 0;
> -    -webkit-box-sizing: border-box;
> -    box-sizing: border-box; }
> -html {
> -    background-color: #121212;
> -    color: white;
> -    font-family: 'Roboto', 'Arial',  sans-serif;
> -    font-size: 16px; }
> -a {
> -    cursor: pointer; }
> -
> -
>  /*  BASE BUTTON FOR TARIFF CARD  */
>  .button {
>    display: -webkit-box;
>

Try the new option that Jonathan Tan implemented:

  git diff --anchor="@@ control/tariff.css"

to produce the second diff.

I wonder if we want to have a permanent store for these
lines in given diffs, such that you only have to figure it out once.
(And eventually the community will have a corpus of data to
figure out how to improve the diff for real)

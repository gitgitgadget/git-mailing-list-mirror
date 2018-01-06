Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48B501F404
	for <e@80x24.org>; Sat,  6 Jan 2018 08:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752668AbeAFI02 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 03:26:28 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:41324 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752450AbeAFI01 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 03:26:27 -0500
Received: by mail-qk0-f174.google.com with SMTP id a8so8727165qkb.8
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 00:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PclxLjb1VXchcfcjue6XW5J/YNHqLxGGIeHNcCh1Gtk=;
        b=lslLtW0y/OjYA7CAB/qJ5JMiGZn9Ik8Y3UKlrR6wL/HN2Lvz/1Bfi8VDBim/jXlbYt
         kGAbN7kgVQ/uQ5+DuHv0CLb51kYr7PyBi/rEZCmyFMLJFB/+m8VnxXnOB2pkqPBJXJfg
         +HtBJ9uaZ6vaIxA4q4HwMXDpYNR9A32SjwS0YYM3l05oHxsd0mRJ/pCBbPDuDEhKUapz
         yxnaapzXxEDYm8+ey5NQpmvGI+Bk6xw92ptnSfaLmN9FlFE8RXEz6wh5ZdxgMSraZVas
         WCbahdZsbU73MzuNsnrr35nN/ubYl5aXj5TUvQa6FwRj83bPHYIklKtuJESwflmTW9Jc
         PEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=PclxLjb1VXchcfcjue6XW5J/YNHqLxGGIeHNcCh1Gtk=;
        b=VnlRkO8ITFbETyTX+YKu8nJUFhbAcT0n7c1cxBIQqceXXlHw5QuoJ0KhCrieIv+j06
         am49BPzLT38yTlcI9QiMDD2x99+54qxrKjdlaElNt5GUhF2Pwc4O8vKzFTp88DETQdBp
         X9214m6Txr1JA8Cq5/dPGIk8Eo2qngRF90rTd2PdkAfKL5kUI9J9L6UIBSXB7V6q/ffG
         hE2EG3QXZCsDFbNJJ4cUKln9esb2KO5ZSehepx2EcF71/XtXtwksi2HAHzWEMsubjj7m
         u9H2lb8D0epiaJr+ZAywHF9SlJ215+nMhzXtx6aMAYIpDUvyDRwj/sLwf6SjWbbULbbx
         AjjQ==
X-Gm-Message-State: AKwxytdzU/+8GMoat70NVFF6l9wtD551wo1gndat1pJrYH3WTykN0CAa
        GBnpvsqye6GUC8HjeQ5dWInv2WneA7Z7IMzDPs0=
X-Google-Smtp-Source: ACJfBosmovbJkSP4F8ahk2lYgabT4y2OYESsRvaL5JFtzIm24CxsmgWREYxlAHQ4aZw+APE7bjFuMK+euGQ36iOZYbM=
X-Received: by 10.55.119.68 with SMTP id s65mr7399357qkc.357.1515227186431;
 Sat, 06 Jan 2018 00:26:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Sat, 6 Jan 2018 00:26:25 -0800 (PST)
In-Reply-To: <CAGZ79ka22DPHX5_etFREvdVjfsQPzQG66iFgyfsjCdLnwUcAdA@mail.gmail.com>
References: <20171228210345.205300-1-sbeller@google.com> <20171228210345.205300-3-sbeller@google.com>
 <CAPig+cTkxmiJZwLqYhKhvApZubJLTLufv2Yo6D5nLMLmrUc2cg@mail.gmail.com> <CAGZ79ka22DPHX5_etFREvdVjfsQPzQG66iFgyfsjCdLnwUcAdA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 6 Jan 2018 03:26:25 -0500
X-Google-Sender-Auth: ub6niu5sHtYReUCSjBciZF5PnVo
Message-ID: <CAPig+cQg3o2iicGhSmwPM8dDjtUFSGow5dwprbRNnq4-m5EmFA@mail.gmail.com>
Subject: Re: [PATCH 2/4] builtin/blame: dim uninteresting metadata
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 4, 2018 at 5:10 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Dec 28, 2017 at 2:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Thu, Dec 28, 2017 at 4:03 PM, Stefan Beller <sbeller@google.com> wrote:
>>> +static inline void colors_unset(const char **use_color, const char **reset_color)
>>> +{
>>> +       *use_color = "";
>>> +       *reset_color = "";
>>> +}
>>> +
>>> +static inline void colors_set(const char **use_color, const char **reset_color)
>>> +{
>>> +       *use_color = repeated_meta_color;
>>> +       *reset_color = GIT_COLOR_RESET;
>>> +}
>>
>> I'm not convinced that this colors_unset() / colors_set() /
>> setup_line_color() abstraction is buying much. With this abstraction,
>> I found the code more difficult to reason about than if the colors
>> were just set/unset manually in the code which needs the colors. I
>> *could* perhaps imagine setup_line_color() existing as a separate
>> function since it is slightly more complex than the other two, but as
>> it has only a single caller through all patches, even that may not be
>> sufficient to warrant its existence.
>
> Have you viewed this patch in context of the following patch?
> Originally I was convinced an abstraction was not needed, but
> as the next patch shows, a helper per field seems handy.

I did take the other patch into consideration when making the
observation, and I still found the code more difficult to reason about
than if these minor bits of code had merely been inlined into the
callers. I neglected to mention previously that part of the problem
may be that these function names do not do a good job of conveying
what is being done, thus I repeatedly had to consult the function
implementations while reading callers in order to understand what was
going on.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D3220899
	for <e@80x24.org>; Sat,  5 Aug 2017 16:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbdHEQzz (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Aug 2017 12:55:55 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33985 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751523AbdHEQzy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2017 12:55:54 -0400
Received: by mail-qk0-f174.google.com with SMTP id u139so23061423qka.1
        for <git@vger.kernel.org>; Sat, 05 Aug 2017 09:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DCPbMPcyi1hx7/CB45Pl4ymzN9qQtaKgNFAXYxQGqWA=;
        b=VUXa0eeoiCtNXaR51cCemFCqd3ETeLWOlEpLliXyEG3/CaElxsTMuO7ktQHCSb/fvf
         pCwRB/KcUiwXtGAE6Tt8zOwl5O3xhyoNaLfpdk++VLfIt6KiZ+YHy5zjhhJ34NxqKkBl
         UReg8EW39VpSzV3o1kX9F11gQJaSrsGHdZOrXozV0cobFW+DY/tkXe1OQr15F9jElLfK
         U/STptOJYiW6Ry++HVZM8E1nsRrqXe0hSKsU6AOhdLr3Eg6mXBJgkskl2MJSm3rSw620
         sLyOUk9MwTs1YqwEdB9X4SV7NK/8bB5onlr//FVjP1Cd9LrkjUyM8/P/VKb5FuO4iLPJ
         Dm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DCPbMPcyi1hx7/CB45Pl4ymzN9qQtaKgNFAXYxQGqWA=;
        b=MAfQ5Kp94W3mcafjFNEW0NfTU0E9kr09QygreTxZBpfFbRj0n7FBHI4shsycL0WxLB
         jKblS/Z7LPbZMeoTM2OFEE9kNAw7im6RuRo/cLxjc4xfk8lMTBa5xi5BBcSoy3b1DjBz
         9Br1CQheGS75A1cyrM64njW3XcicVEJchQgSzAvhMjGACS3/bHxZDco3X/ESVoWhaxF+
         YeoC4StmKNryVjL44PNH3vsXF80wkxMJnNB8v36OY+Kp/JMMlZubLG/y7hQ7FDxNz2Eo
         eo2TQXzlcEaBBr4zIPQK1lLGVaoCS+kJV2hRSR7T39ioMU5DA5sPcPm6VYgeRvCQKg+K
         ZFmw==
X-Gm-Message-State: AHYfb5i+o+4B73O0vLx1TuesTu5cDAAxN7MDBFcyzxfUjPls33u1sgud
        XrPD8j+adsmtm9XR/Ge6r7QqOM8Szw==
X-Received: by 10.55.71.76 with SMTP id u73mr8496692qka.25.1501952153701; Sat,
 05 Aug 2017 09:55:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Sat, 5 Aug 2017 09:55:53 -0700 (PDT)
In-Reply-To: <CAME+mvUAspzuzbB4pFiQeOtT7NGRTO25M-k8o8hoysMFLGy_0w@mail.gmail.com>
References: <20170731205621.24305-1-pc44800@gmail.com> <20170731205621.24305-9-pc44800@gmail.com>
 <CAP8UFD3_zX0=h9tuNA-w+30V4P8zZGyUCEnpciTkwRWpXjjmNg@mail.gmail.com> <CAME+mvUAspzuzbB4pFiQeOtT7NGRTO25M-k8o8hoysMFLGy_0w@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 Aug 2017 18:55:53 +0200
Message-ID: <CAP8UFD2oqdaQqVwuGqqj9OOnm5Pyufpck=rod0UFQEWrROJsXQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH 08/13] submodule: port submodule subcommand
 'summary' from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 5, 2017 at 12:28 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> On Tue, Aug 1, 2017 at 4:57 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Mon, Jul 31, 2017 at 10:56 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
>>
> We can avoid it to behave same for "" and NULL, by checking if diff_cmd
> is "cmd_diff_files", since its value is set NULL by this case.
>
> ret = compute_summary_module_list(strcmp(diff_cmd, "diff-files") ?
> NULL: sb.buf, &info);
> strbuf_release(&sb);

It looks error prone, more fagile and less efficient to me.

> instead of:
> ret = compute_summary_module_list(sb.len ? sb.buf : NULL, &info);
> if (sb.len)
> strbuf_release(&sb);

I think it is ok to call strbuf_release(&sb) many times, so the "if
(sb.len)" check above is not needed.

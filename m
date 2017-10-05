Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 799451FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 22:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbdJEWIL (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 18:08:11 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:49449 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbdJEWIK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 18:08:10 -0400
Received: by mail-qt0-f169.google.com with SMTP id o3so28248272qte.6
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 15:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J86/htunIFk0/iC3PhMLdKOpC16rK0j6aSPFF26fZYg=;
        b=SB1aw6+1aAlbZXP1GhaAzVP9IXYKdwaAjULkolg5rjpR/FWuMwxXIa2401k/ZaoT3E
         fxU+KgxvjvCB532PdcAPCCT0Vz2yN7F/HWYgvoVcNr9OsFUXyjuzjto+84TREVIkInwz
         uwh/E7xC3LUOZAMh6o8bC3yCxDjKm4QG/w0ZXzTSNjSZJV+BvwcXodT+yHVbfdrdBfI4
         Pe0zbOldNp5b2bwamLn4jogZyXW/ZqRzlDZXas8QmqBgmXDMBhWBUY9pzlqIKqUyXqjb
         HnSoAly+oT/0riOnXRmmZ/7co9+6ONyXp7Kb6U/MmtxwwdptgFZ6MowIgAeaSmIuoDcR
         AqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J86/htunIFk0/iC3PhMLdKOpC16rK0j6aSPFF26fZYg=;
        b=CpR8ChYb37cMPh6o9Hi9wyQEoj5HEHO+gT40eQFscm37PHCudon2f8MyDSZovTH+Ti
         2cXVkNSHBTQcPZbzHc30M9NmzAtOWhUKscvRPz7E31M4k+b6CFOMePRnJsyDGSRc36jT
         TSG+g5u0xBxrtzX5N8UoSilgEu6w4PsBFJKDNslApz/H2Ozmw4364jSUWzhM9UFfBtoF
         QS288yGXSvBUKRjQbkFplCdLYGTal1wZpFH+2CH/C5vaEYyl9vwVTDM+7IccszGXBY+1
         hgOV0W7j6dR+AcAhpf0hqM3xlxbxJoGDks1hiHW1T0wfJ0gJWgmmONnoFLHdde/a4XBb
         dMpA==
X-Gm-Message-State: AMCzsaVzZMQBoImzxbBy5IOzGT87Tu/H1bGzt02Y0JSYdNV/SH4UNrVZ
        RzZG2sOvmD86uKxRdW0T+6RgDaD1EcWkTzYE59E+2g==
X-Google-Smtp-Source: AOwi7QCDROSVleAiZguPUOsK8TymZp/mLHRtg6eJ//Ufq2tUJxmQzDD5akDbCb6SkHTbdR8YAKA/Hv2daepeVbgdTAE=
X-Received: by 10.200.8.53 with SMTP id u50mr203841qth.260.1507241289548; Thu,
 05 Oct 2017 15:08:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Thu, 5 Oct 2017 15:08:08 -0700 (PDT)
In-Reply-To: <20171005205443.206900-7-jameson.miller81@gmail.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com> <20171005205443.206900-7-jameson.miller81@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 5 Oct 2017 15:08:08 -0700
Message-ID: <CAGZ79kbdObhu0j5yAo-KZk0H12oSzoP5sLd6S8kUbZMzEXBEQA@mail.gmail.com>
Subject: Re: [PATCH 6/6] Handle unsupported combination status arguments
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Jameson Miller <jamill@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 5, 2017 at 1:54 PM,  <jameson.miller81@gmail.com> wrote:
> From: Jameson Miller <jamill@microsoft.com>
>
> It is not clear what the correct behavior should be when you ask for
> specific ignored behavior without reporting untracked files. For now,
> report this as an unsupported combination of input arguments, so it
> can be modified in the future without back compat concerns.

Is there a rationale to put this as an extra commit at the end,
or could this be squashed into the first commit as well?

>
> Signed-off-by: Jameson Miller <jamill@microsoft.com>
> ---
>  builtin/commit.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 34443b45d3..7812e106ad 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1400,6 +1400,11 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>         handle_untracked_files_arg(&s);
>         handle_ignored_arg(&s);
>
> +       /* Check for unsupported combination of args */

Oh, this is the first check that we add here for unsupported combinations.
How much value does this comment bring to the future reader?

> +       if (s.show_ignored_mode == SHOW_MATCHING_IGNORED &&
> +           s.show_untracked_files == SHOW_NO_UNTRACKED_FILES)
> +               die(_("Unsupported combination of ignored and untracked-files arguments"));

Thanks for taking care of the corner case!
Stefan

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53FB31F597
	for <e@80x24.org>; Sun,  5 Aug 2018 04:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbeHEGWt (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 02:22:49 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:45627 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeHEGWt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 02:22:49 -0400
Received: by mail-oi0-f43.google.com with SMTP id q11-v6so16556192oic.12
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 21:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tF4EROc6r2usT8lPTyyxMxAziz56mYzvD7Hy2F9udcM=;
        b=Fjs485qBYpHK13obNSowAinrqJ/apodxwoyR22NY7AJQ/imEUdoguV1kW+Zf1nYgs0
         +l9jcy1hnQqJ8DGM/7dXNQQ0E2ONWtNUWAvIXOpy07EMEICur67hMXRlrzTiEbpLpfkE
         bAjPkPTaq2XI/qTN+Kk18Ex/1AKGIqA39KPbOnfPsEYGxOPNgxk3GcL+1Iz1h3K/AKvO
         +raEhiX83BeGrOWuXUlCGjrgR/S6H9qNzTlWS1SpHgEBjAKve0O4cWLFlk+kNmLnC/km
         RviEmmqEyqtCT+SL96k0FBWoqS4ThhkZooS+/Xj5Cp8oVnT/Cavy3tFPTq1MEwT2t/Ud
         okHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tF4EROc6r2usT8lPTyyxMxAziz56mYzvD7Hy2F9udcM=;
        b=NCdJKCDkhohxx3XIeZ/Y+KlXCuLCklBr4EAIKLPVm+oT12Tos/JZLx2mYxHiRxoZXN
         J3N5qHDYkoiLk4mgeTAeoWM11+CWauxsnSrZF7y8+4fJMGoBnOBjxgBNsvN5UaV39i0o
         DkXcXLs2NPfLTHNsA98A62N4rtUn9wNQ4BfRFTdagsEmPNGjBfvNKHM1BunnRFxSYjax
         RBncDAGW1wojK0ginB2knDG1HmgvbiwaF8CXWZ/AIu+qI7w2+4DyEZRg43oB3fzSa9hf
         NxIbFD1Py3+dAVbSRkfqcU1edN4wgUOq1oVMWy0NRInk8yDz135YyQ6HtaTUbi4BtDNj
         RwDQ==
X-Gm-Message-State: AOUpUlE8q1soui4h1Xe0126B0jMTI6Aac1EbB5/GGnOPlgdv/E+0OdBc
        UiSSmUzTFPbM84fbQtZejLeC8Sz5C6uHDr9uwJA=
X-Google-Smtp-Source: AAOMgpftpXKfTfrpMflQcc0R/9H9sB/hzYpbEqxC1UnRhEqxhrDpuPbCvVgdILkcE9Nc+ohk/k2gZMlJ6ZZMQwENjrg=
X-Received: by 2002:aca:f305:: with SMTP id r5-v6mr10083111oih.230.1533442780341;
 Sat, 04 Aug 2018 21:19:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:70d9:0:0:0:0:0 with HTTP; Sat, 4 Aug 2018 21:19:19 -0700 (PDT)
In-Reply-To: <20180805033629.GH258270@aiede.svl.corp.google.com>
References: <20180805022002.28907-1-wchargin@gmail.com> <20180805033629.GH258270@aiede.svl.corp.google.com>
From:   William Chargin <wchargin@gmail.com>
Date:   Sat, 4 Aug 2018 21:19:19 -0700
Message-ID: <CAFW+GMCT_Ptu59vBLTvFXNn6nX5pBgyToCyYKe8J7JZnV2Bv9Q@mail.gmail.com>
Subject: Re: [PATCH 0/1] t/test-lib: make `test_dir_is_empty` more robust
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

> This information belongs in the commit message

Agreed: I included it at the start of the commit message, though I
suppose that the wording in the cover letter is clearer, so I've amended
the commit to use that wording instead.

>                         Continuing the note about administrivia, this
> kind of cover letter material that you want to not be part of the
> commit message can go below the three-dashes delimiter when you send a
> patch.

Perfect; this is what I was missing. Thanks. Let me try again. :-)

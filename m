Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F5371F404
	for <e@80x24.org>; Tue, 13 Mar 2018 18:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752975AbeCMSCJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 14:02:09 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:37420 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752022AbeCMSCH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 14:02:07 -0400
Received: by mail-lf0-f48.google.com with SMTP id y19-v6so771017lfd.4
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 11:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CQmVxYLKEs51buwyepvOJyM1tf4HycbFogEai5/FssI=;
        b=ntEBFpF54/MR/zBdpoCgGeZUqiDfuXwfPiyLJkyQIgFKBeNiQrfvt/I/ODom+vNfyP
         w0A0NLewcm74xK0qvQL0a5P6fBQZm1InXD0mkGyvK8xrP1GCEUQa+hWQzWY4HM7OXvzQ
         zH7g/4xS8WWE59ISJwo4nQPJNRzGLS9HaFcYQmDrzuigUHMd6lWk7HMRU8CipFwRCOTi
         +ptsGeU1Wz87LR9nQpCmyx9XRsxLj0KZGfnnyUv1N7OLHeOdiJT/+CDQI+tSSqnkkvIz
         u7BQ6QI4TZaqP/CZon8/B3OgORDGXrmn30FG62tah7bxvEks7eQx2N14OlhwhJTsAGp3
         sbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CQmVxYLKEs51buwyepvOJyM1tf4HycbFogEai5/FssI=;
        b=iDXnufzmhJZV9nrWDle13SU3l9+ARcper3dq3bMZDrGxgIkDjHWR3CTRV4wPAqGjVD
         rqIv4YED6PprghlGkDtU+Se43/uJFOdiMD1Fx7iNAyM3ZNj3xgevJyto02Gyor6iAdoN
         kCqB3ddz9kDubofGqyy+k4FykNVaUCjUAhgItqHAt5bRW9wfv6wnmfZq3vRaDFmYFCHJ
         elFsFGRUYWvuelPnsTBeHNVpBZN96xO/UnJK05XQFAChu7CKIU9wiwvycD7f9uZ93Fjc
         2biURAV+B2SaXWKtezS+ulhVTqqYWagfbolf5uyVps/phHz3EL6BT0sghv/QndN5V8Zm
         1eBQ==
X-Gm-Message-State: AElRT7Fvff8ZQGGYhglgPLLpE6cGEk7ZNIyP9oO5oFIWr3XkXicCX672
        9xEcz5g88NGn+KcKp/LDFgXiPlOFd/dfjrxtc8N27Q==
X-Google-Smtp-Source: AG47ELvl1ocLmQVnAkRiefwP9Qg/sqWQXAUq8hdkO6O6XjpU1NuYPyALO8Ajz1OzEwH0MTikkO8v8rvGOCTnnQxTABM=
X-Received: by 2002:a19:8f91:: with SMTP id s17-v6mr1255483lfk.56.1520964126426;
 Tue, 13 Mar 2018 11:02:06 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.46.114.19 with HTTP; Tue, 13 Mar 2018 11:02:05 -0700 (PDT)
In-Reply-To: <CABPp-BEC48EoTc5eyLrcaLLtUexgbShQsB7zbQJB0QE6AA19kA@mail.gmail.com>
References: <CAHd499Axo7HFviUJavigTZ6BGZCkj9iOSeNVndu1oPivkPv+5Q@mail.gmail.com>
 <CABPp-BEC48EoTc5eyLrcaLLtUexgbShQsB7zbQJB0QE6AA19kA@mail.gmail.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 13 Mar 2018 13:02:05 -0500
X-Google-Sender-Auth: kvUqGztVUuEjTF1mt4UoLptNakQ
Message-ID: <CAHd499AyfH3o7wU8S++40ryRHmf++zkE93uMxkVhBx0hWMcr+A@mail.gmail.com>
Subject: Re: Rename of file is causing changes to be lost
To:     Elijah Newren <newren@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 13, 2018 at 11:51 AM, Elijah Newren <newren@gmail.com> wrote:
> Anyway, I recorded this at
> https://bugs.chromium.org/p/git/issues/detail?id=11.  Sorry I don't
> have a workaround, but I'll try to eventually get back to this and fix
> it.

Thank you for taking the time to verify this for me. I will keep an
eye on the issue you linked!

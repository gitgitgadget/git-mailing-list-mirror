Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A76CF20A21
	for <e@80x24.org>; Thu, 14 Sep 2017 17:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbdINRqR (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 13:46:17 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:44125 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbdINRqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 13:46:16 -0400
Received: by mail-yw0-f174.google.com with SMTP id r85so58506ywg.1
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vMeO1+YgAqJaN7ynDOPoSdVKA+YQ9MWn4quRgIQ7qzM=;
        b=g6g0HPWRjMGGzw++8EbzNxzht07QeA9UtU7Wg4zjbm3ge6mPyeGZutRRcPDzABTz8v
         L0ZbiIPpV0az7GAoyTVFaHUAzwPbI8qku013zwgLn3kOMw4YU5wfj43IL8Ll3JhnAwdr
         4WyYGZBFycjCHgGqumoxEW9g2TbObtRj4nulh0vQp0uaJjyPEXV4zfj8b2v8hrx9nXnl
         0Qqi97Tz5FKHC4KmfuSO6qyiBYTR7jdbvaGEKunJDupAdDqoVwKLa81UiYkzNOkgMTTz
         YtIkfiatrpWMlbqe16N+//TsjIa/G5DdBmHwMRat6QlNiyb0DedTofUjzJ6v7AbdMMKq
         WsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=vMeO1+YgAqJaN7ynDOPoSdVKA+YQ9MWn4quRgIQ7qzM=;
        b=ZbwRQaehTX1hrQO7psmyoNxKGWNAnuGCvWdYvTZ2XzJZ5dPVMBazCDU5GOu7TIgTfD
         lZZnictr2V5LgsKDzpthg0An8Tu+utq+IelDCPMiHlR/iVxN3hptHFHVHUQS9fIEhD3u
         Kaj6+EImsNJMnLAujOfNc2aQBW3Zw/R6IgtEubcaJcAqoUbb4adg92PkDb/P7coxP72Q
         1XngP0K/QDsp43mpru4jHZD5aZ65LzmBDsBVVfoeFxcOtVvvBfuxKnXdXWLfIgsuWfgQ
         10uYjLcWo2SXmuZABUPU0VGnRmSN1djg5wH4jfby2//oVTcYPKVbdONEBPgmtyX4ywxZ
         Mjvw==
X-Gm-Message-State: AHPjjUh0JGrrYkJyS6VpIZ9TE48A8rAb71hHSzRPpyb8eo+E23sMSgUh
        WE57qOw1/CQUejS+DcAqMnXBhHkokh/vjc58gi8=
X-Google-Smtp-Source: AOwi7QCl//qeIBMHdgpd67GICPD1IrjdWiVC12KkX+sQr5sKCY64BRYM7aKR7+JulYXQv8CUUW5yG4y9N863vyHkC6o=
X-Received: by 10.37.95.80 with SMTP id h16mr17874260ybm.89.1505411175853;
 Thu, 14 Sep 2017 10:46:15 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.129.82.203 with HTTP; Thu, 14 Sep 2017 10:46:15 -0700 (PDT)
In-Reply-To: <bf4275e5-ad96-4b71-e6a0-52c198cd541e@suse.de>
References: <CAHd499ApnHpt0CmcQMx+qVQ60NV6auFKkuvikCq2Zut4p4rzaQ@mail.gmail.com>
 <bf4275e5-ad96-4b71-e6a0-52c198cd541e@suse.de>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Thu, 14 Sep 2017 12:46:15 -0500
X-Google-Sender-Auth: D1sr6_019q-xCOWvdoH8ggB8jTw
Message-ID: <CAHd499BeANJBryo3sOoD2vT-A0M-R00GTa5-wTOumyj0EkSHkQ@mail.gmail.com>
Subject: Re: Rebase & submodules
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 14, 2017 at 10:57 AM, Nicolas Morey-Chaisemartin
<NMoreyChaisemartin@suse.de> wrote:
> Without changing your workflow too much,

If you mean to imply that you have other recommendations if I'm
willing to change my workflow, then please by all means share them.
I'm very interested. I'm not too hooked on my workflow.

> simply add an annotated tag to your branch before your rebase.
> This way the SHA1 will always exists. Unless you want to cleanup at some point (branch merged ?) and then you can simply delete all those old tags.

This definitely the best idea so far; although the maintenance
overhead of this could be high for long-lived branches with frequent
rebases. Maybe with bigger workflow changes there are other solutions?

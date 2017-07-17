Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFB3A20357
	for <e@80x24.org>; Mon, 17 Jul 2017 19:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbdGQTVN (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 15:21:13 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36412 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbdGQTVM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 15:21:12 -0400
Received: by mail-pf0-f182.google.com with SMTP id q86so80919565pfl.3
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 12:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PEEljadXIziiUccWz5a/EM9MeRJg9fEFwY4fN2uu4hs=;
        b=Whg1AnmZu4CLRGFHxLiKxm4wAzrJPoug6UDpeZRbzDjJYhKJsD+JE5B7gpVlJOcBDF
         r7ifHx9d2P72cLCbywz4Tk9sfPMDXSpSs3iyfbKyhB9zMAcbtjfkC+Y5d+RgOebIKrQJ
         tHGsA4t3T44kDNepzIEvx6g8t+itwxGQJk6n0mQArDOaQdizwQO8LCIY43k+TBHtzll7
         0tkxpczd/5y5uJp7eM2CnQAPSyXgXAR443VjA2yvt19ZCEgA2EkDbkbNBMEPPZF8fADw
         d0GTxtMDZVDlO0Mb/HCakoFX6R/Lg3SMf6v6CQt0JDlS1F/P+E1O0fOx5sT/YEuq13fK
         UM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PEEljadXIziiUccWz5a/EM9MeRJg9fEFwY4fN2uu4hs=;
        b=QR6+hlOXw5VscD8mvbflL3lLYQO9hU9Bpd7IgOpEEC7tJqbsOWIyc4pJQWWyQ9UBnS
         ABo84efbChXvUxJ88w69BhpBNYJBXZHFqBOtdogidrZnLbKQGpD6kR+Vxhc0a8S/bm6J
         TQMOTy6JlM73+8dzn5PUrBa6ei/mC+jUD4noS7BRFJZLXiHQR0V8hztYdnnibov7u+aG
         FW3VnnMoyvuY4qAEtP/QB3WrPLcFQP+FRRsxxvau1k9XspmeYHzzWeUy8LcYjdoBYcNB
         mNkgL6opjNLdHYednHHvBNvPIDIjBgIgeHZt0lccLJMBucHznVLmSDHtIw3v9XJEyJTV
         8glQ==
X-Gm-Message-State: AIVw113V8MkEcfUq4UA2R7I+ycwHtYBNFEa07AX8wzmIuRs5G6cuEBkc
        uvwx7wKQstdwYtJD+xKNCCYNpHrTa4nC
X-Received: by 10.98.147.142 with SMTP id r14mr20920797pfk.150.1500319271915;
 Mon, 17 Jul 2017 12:21:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Mon, 17 Jul 2017 12:21:11 -0700 (PDT)
In-Reply-To: <B998F81875C940B1B7D4D26764B44B04@PhilipOakley>
References: <20170711010639.31398-1-sbeller@google.com> <B998F81875C940B1B7D4D26764B44B04@PhilipOakley>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 17 Jul 2017 12:21:11 -0700
Message-ID: <CAGZ79kYjGBg6ep07OCbdGkwZkauZ8T07d-Z7L4_wym02zaOsMA@mail.gmail.com>
Subject: Re: [PATCH] RFC: A new type of symbolic refs
To:     Philip Oakley <philipoakley@iee.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 16, 2017 at 6:04 AM, Philip Oakley <philipoakley@iee.org> wrote:

>
> If I understand this correctly, the new type is the 'starts_with(buf, "repo:"))'.
>
> It just wasn't obvious from the text that the new type is "repo:" as you
> never spell it out in the commit message. Should it be included in the
> message?
>
> Have I understood correctly?

Yes, you understood correctly.

The idea is to allow submodules to "borrow" its refs from the superproject.
My original idea was to only borrow HEAD from the superproject, but this
can be extended to more branches.

By having a more generic way of borrowing refs from another repo, this
can also be a different repo than the superproject (I don't know the use
case for this yet, but let's not have a to specific proposal).

Let's see how this RFC fares in further interest from the community.

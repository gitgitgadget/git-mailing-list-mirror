Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 286101FAF4
	for <e@80x24.org>; Sat,  4 Feb 2017 11:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753923AbdBDLGt (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 06:06:49 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:33803 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753811AbdBDLGs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 06:06:48 -0500
Received: by mail-ot0-f179.google.com with SMTP id f9so32394357otd.1
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 03:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wOFCLJZdMhc/EbalTqY4d9OcJodADF+Px+gI94PjTZE=;
        b=S4/e5Ux7Mtu4EFBGg0O5TYil2WVejvskvhaEac2T/BR+zFpSh6TYxRUwNPLJGsbPX/
         SN5QJSYCMYeI1V0ONTZA66MwZqmt4aCEIfgI6Xe2b1K5QvkOTqUrg9yUQr5w4Tp/zQfW
         ThHEBxDshHTNnRi0bV3UEogpy7Gjy/GVtYANLOnyJJPF6USkCk2qHqFxe7xnJhSV0rjS
         XetLZ0GE6829+mFTYL4gMR/qWBu4s+bxOsRID7y7CVJ/65TDsfl55vCYIasO95FQUKLD
         1j4sI4CzJKwmU0/G7Vn+Vb19K0eZcM/aHxZ0wgI0S5S8zVct3FgtsydQMl5tDJ+sAxx2
         wevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wOFCLJZdMhc/EbalTqY4d9OcJodADF+Px+gI94PjTZE=;
        b=BDRqSn0W0Pfpw1Y5Q8MNFRqFQOjjz2ojJjcBaPYpKVSLME4I5+4IqZZItbIzZU577v
         sKLnBng9Lvi4c+Hf4dUZykfbjCJWWUIy3Mo+Ly2N69sXn1YsjrjZlaWHcQCGQPaiuTgD
         UpWPjOW4z0XbG76PL+IOLMBB6BbVO2JVlMktiLjYoOJ2YzUJ/uwADvlWTzWJnsif5eZO
         Nfim4Ud8+VRxFszpcbD5AJ0kQgqNO/n5gKtQFOkRHqjqBmXrTAdPu3uYPGX+uNkZMfOp
         6uqDglZeqM1CIsIGDNZK0G5zjPj/gTwzeLSQezDqVqoWgvb80eeAleF01ePYMGNFLvXj
         8kfQ==
X-Gm-Message-State: AMke39nLRrBNCZErx4tOKsSfLBlGpIIDUQos9boEorbuDWionbWbS5LE3HVAgQ/p7mx7OfNw7rDebzC8RVZnIg==
X-Received: by 10.157.18.246 with SMTP id g109mr838265otg.10.1486206407580;
 Sat, 04 Feb 2017 03:06:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Sat, 4 Feb 2017 03:06:17 -0800 (PST)
In-Reply-To: <20170203202833.17666-1-jacob.e.keller@intel.com>
References: <20170203202833.17666-1-jacob.e.keller@intel.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 4 Feb 2017 18:06:17 +0700
Message-ID: <CACsJy8B2gyw7RQBh6Qfm5HxOyKWted-0ZeDfd2_U3MvWCO1HEA@mail.gmail.com>
Subject: Re: [PATCH v2] reset: add an example of how to split a commit into two
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 4, 2017 at 3:28 AM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> +------------
> +$ git reset HEAD^                           <1>

It may be a good idea to add -N here, so that 'add -p' can pick up the
new files if they are added in HEAD.

> +$ git add -p                                <2>
-- 
Duy

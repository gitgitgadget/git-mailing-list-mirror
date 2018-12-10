Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF51020A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 16:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeLJQvm (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 11:51:42 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45060 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeLJQvm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 11:51:42 -0500
Received: by mail-io1-f66.google.com with SMTP id o5so9265140iop.12
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 08:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hr76fJZdXLDW3LTxdhxgjmedVFV2DzGIdNVOq9FXXpk=;
        b=A1vlmB4UA09WXKguqkVZKnZUBw+JLeMX18uGxIauVUSRv7i2O/slW4vpEEwOzXTY4p
         0J7Z9i5oYI6oMBy5NCSNk0O0WjNhydN2zMyWI59rvZ7mIsoXIbtsqh21Vm9PsEAh8ZDH
         h0Me6WP7WsDnAyHuwULzdgRaf96hJT+VdT7w8VLpcvojwuMgvqmA05DqGgpQWRUy63LW
         ih0voaQdVF9pP6reY0XW89Gyj23V2gDpGCt/9EU/zc7NP3kF8BTaLqH0rdFKcHeACZ2X
         2tb/ZCr03RA9l6sIGRft6pimyKSbu31PO3LbFDSucJnOd9gvWJ5dG1ffDaWftphFtzqG
         x3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hr76fJZdXLDW3LTxdhxgjmedVFV2DzGIdNVOq9FXXpk=;
        b=qYLIshRC4DMPGh4izM4lFC+9tL56DeSnCYy3K1NB78OBd6O2zPkVoP0nJnegqkzZm6
         AFddPkLQxeo7d5KWVn/rvUQ3nfMLJVnaMraOzhPXvHSyzNYPQ0KjLDVIdU8vs8Ml8uL3
         x6ipmLtNSBSluc1KwgEd7ZIZ/zTOkeQL4IlMYFwN0yx+T8QTGBTh/rS4AeRC/yf0PIdk
         WNYw38kGm8vKaipuia34EqtZVAgxM2zJMEwlGMj5Z9Q5q6E/gWl22SlwJ2Ng4Yua6k0B
         SYwr9Sa14uuJYrsQyhzalFPPOOiNpOEkSVryUeNNWYGFf+itAZyzux38j2FGD5cEdjGp
         Yd7g==
X-Gm-Message-State: AA+aEWaYA+tMG9Iai6aFweXmUM94zkLU1QNPLuCR/yC2bukACR3H6veB
        /LUMmsnQFNe7V9v+/4xxBQC1idQn3+GT1d5Ofe0=
X-Google-Smtp-Source: AFSGD/VGRaoNxB5vHh+lrtHnyC6z8ndygVzddWoGmMMomFFlRyqtlvYJOCPGXNDhJQYWGsZw5iZsdavC40qXtc+VrTg=
X-Received: by 2002:a6b:242:: with SMTP id 63mr10466452ioc.118.1544460701012;
 Mon, 10 Dec 2018 08:51:41 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-8-t.gummerer@gmail.com>
In-Reply-To: <20181209200449.16342-8-t.gummerer@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 10 Dec 2018 17:51:14 +0100
Message-ID: <CACsJy8CjQHGANKf2Z=vJL=_ktoeXxOzQGL+VFJC4W63fzok78g@mail.gmail.com>
Subject: Re: [PATCH 7/8] checkout: allow ignoring unmatched pathspec
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 9, 2018 at 9:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> Currently when 'git checkout -- <pathspec>...' is invoked with
> multiple pathspecs, where one or more of the pathspecs don't match
> anything, checkout errors out.
>
> This can be inconvenient in some cases, such as when using git
> checkout from a script.

Wait, should scripts go with read-tree, checkout-index or other
plumbing commands instead?
-- 
Duy

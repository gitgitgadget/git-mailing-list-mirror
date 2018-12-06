Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC7E211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 08:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeLFIYn (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 03:24:43 -0500
Received: from mail-vs1-f44.google.com ([209.85.217.44]:43865 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFIYm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 03:24:42 -0500
Received: by mail-vs1-f44.google.com with SMTP id x1so13763688vsc.10
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 00:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=d2uhflIzGvRl77JzY3KywZPiYuiCvvvhT676yxmhlHI=;
        b=H5z2zue+LlyyFKtpuKyl7SDlOvvBRaCxAhtwHa4NG9saaWJIokJbc/Xs4WlMiwzVAR
         DwyNFtKncuIraxdksQYo0eyILemx7jFNXUjuky46X6S7XDg0n78+xRdcSYGBOgnUTnvO
         Vqt5irN1ojMvd0EtIrysfjLtbWzlbBF25KdZthDPjv7wht93AffBJFQhF5D0p/4Yqzq7
         BCB97+SwfYwdsG8U6OlPhFZ1axxd1U1lYwnpGQhG70YBUbZdfq0XsNjYjln3tmJC2Uy4
         +gWj/5OHWjri9so5WrAoRm4/c6mejqWMtgzdF7wJtHwZrCB+AqMMtixgj2rEtWTfarBu
         Sd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=d2uhflIzGvRl77JzY3KywZPiYuiCvvvhT676yxmhlHI=;
        b=J9XsoamL5yIubl0xZZXYWK5sfsmOl+ihS1bwFxSB3axdIaO60HjjsJGWtXopqdRiDB
         kRR5YmDp/NfxHnWnbeIQhCENlZK2OJAgnfXlTNTv85jtoazWwu8X2Ebxb0WNJbkRVpy2
         MzX5eB2v39tIozhjRzA6Ocn8+/vSUE9ZLpC84C0R9Q76GEy93ZYdKRcqmVKeVqZr0Syq
         RJ9QB/EtqZ5X0RmIRjVJk/kdN+3RHdmGdiZudoDfT3/fsLk7dHi8icKN+RqOFa8hm9U6
         K7XLuBpFFXaLE8DnCX6Dg+jbKYSH8BguFUksXx57wgkWmhN4Q4sE3mwjmlMqAz/E4Uup
         O9tQ==
X-Gm-Message-State: AA+aEWZwiT5KO06BtTHChSnYpZeJ3iAc/2vjfnZW+LAhFqZU/EpWBdT0
        8Nmg2ofnqbpzCmqU4YIHNSvPzKei1lDVUzRegSmQNw==
X-Google-Smtp-Source: AFSGD/UHvMKL/lPFQ0tBWoL7ioZ3VyOeGZTsc6Nw38xsD79gEUskj6jlPLM6T4DNz4YKjNWc8USl7CVkzj47gGIiBvM=
X-Received: by 2002:a67:e15e:: with SMTP id o30mr12399359vsl.66.1544084681630;
 Thu, 06 Dec 2018 00:24:41 -0800 (PST)
MIME-Version: 1.0
From:   stav alfi <stavalfi@gmail.com>
Date:   Thu, 6 Dec 2018 10:24:04 +0200
Message-ID: <CAEP21x2KzncYrA3C21W=doNRA2_hGGk6hKa5-5wRkfXqmNxxYg@mail.gmail.com>
Subject: =?UTF-8?Q?Git_fetch_prints_unchanged_branches=E2=80=8F?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

When running `git fetch` it returns every time the same 100+ branches
that didn't change at all but still specifies them as new branches in
the server. It also prints the branches that did change.

I don't see this behavior in other repositories I contribute. how do I fix it?

The same output of `git fetch` multiple times:

    ....

    From github.com:Stratoscale/mui
    + 499a9ae65...63b55f08e Itai/ui-2837-validate-user-name  ->
origin/Itai/ui-2837-validate-user-name  (forced update)
    * [new branch]          aaaa1                            -> origin/aaaa1
    * [new branch]          aaaa2                            -> origin/aaaa2
    * [new branch]          aaaa3                            -> origin/aaaa3
    ...


Thanks

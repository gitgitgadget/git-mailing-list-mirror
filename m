Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24F3B1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 15:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439907AbfFLPDP (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 11:03:15 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:35510 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439910AbfFLPDO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 11:03:14 -0400
Received: by mail-ua1-f50.google.com with SMTP id r7so6028655ual.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 08:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GvrNiH6LYoREvobQJQxBVr02t8I4TUbPv9uT1sorato=;
        b=VYbIfE5nuGc7rCT2+4qhixavOW3cflpHU6Mwd5tCLZAQkrBITj+pEp07JyS/mRyuuE
         tjFMVz7nSloKtdxS30/si7pq6vSQ0EZ+vXWyBzfE/obqcvszuh7kRuHX1k1qC8kLH7Ih
         EAZjcPf20KjFAfGqpajhq1E/+PKN26eOGs0k0H0eSrbV1IQ4xrpPYkU7ZdwIOhErVQaQ
         qUbP6cpjAoDIZpN8+l0CyI7DWZs8ceQJ8/xfh4qyos4EMg52n7FxKQQ/uu+SB+C6JNWX
         ykwOsl0BGsgO2/6hTbAiO15i/d9nfJg13D8p/VJ4rUuFij7XWwHdg65PGIJIOx5uAFku
         UEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GvrNiH6LYoREvobQJQxBVr02t8I4TUbPv9uT1sorato=;
        b=ec7SnkDCTgyl3woY2iVtAgEYJ2z74t806h6vQ022RSueo6Wx1xiaL3RhTmCzLwuiZb
         vdaVQQwATma+fuA+25w3B4uAl/KMI22ZmgV+nf6+Cr7/VYUxsRAB/cRx29Kz9GHQOsJv
         ALwiRoP0jWaLA3sROLhNf3IhclO08AvY6AsiFIDmo+35bHXzATbtxV6u7NOiQ7GiUzBm
         MngdH1H+uZE6V6t8d+9M1Pvg6FzK+1HJlX6ZVd7J/KUXr/UiIbQGeaTOWpQ6g6mxsYY1
         +TSUptfRrR8aU3B203fEXw8Rav43Eh4ifr3dpQuaRJyGDkC69j44TkVdoJEVduWK8f2W
         S/SA==
X-Gm-Message-State: APjAAAX05lvN8pORKEfEh21xk13KUrhBiJqA0uf9q2PESVyfLQPIb7YM
        XHGxgggvupv0JFOkujYx5P3+6sfFUmfqziZF1dTlj4itR/A=
X-Google-Smtp-Source: APXvYqzq2HCUXD97wqmpjZUMaQsiE2bQQI3KnTfBvOqwtMGKYLIdAa/Q/qpABuYQJRodMErNitSr7RFvOVlOO7EYuXc=
X-Received: by 2002:a9f:31a2:: with SMTP id v31mr17969541uad.15.1560351793594;
 Wed, 12 Jun 2019 08:03:13 -0700 (PDT)
MIME-Version: 1.0
From:   Shawn Landden <slandden@gmail.com>
Date:   Wed, 12 Jun 2019 10:03:01 -0500
Message-ID: <CA+49okrxjv63UQfQ1fMt6xC95Pjz2wuZu70WMS94vukTHevEaw@mail.gmail.com>
Subject: rebase drops patches that have since been reverted
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a patch has been applied upstream AND THEN reverted, rebase still
drops the patch, requiring the use of relative rebase git rebase -i
HEAD~5 et cetera.

git rebase should detect reverts as well.

-Shawn Landden

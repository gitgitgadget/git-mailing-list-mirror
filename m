Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63FCE2055E
	for <e@80x24.org>; Wed, 25 Oct 2017 22:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbdJYWqb (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 18:46:31 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:52655 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751753AbdJYWqa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 18:46:30 -0400
Received: by mail-it0-f42.google.com with SMTP id j140so2894488itj.1
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XRiIeMwlCnY10gscUak0GdkB22KlDwSXL+jMaxy2RNE=;
        b=eEjPknKR+8b6SF2b12Ee0Gr/fNsXWUuX+Cz218Tn9a33JkeOEZRVAcjaznC5Vr8HoH
         pWfAmWqHubRoFAMZJZ3MCiUoWpnyCTW9uuS9Mx0NMZ7bBuNHvYk2kISAiD5DIBdhCA+R
         cYqerx08E8CfAvmEbyv1+Dsenv2+qwAK+wpYJUA3KZTmxqbR7vaZQ1el9WDAqYRoPg7y
         ciXJ7YD/x5+IwvKINhCewKMNsC0U9mV/nEfCIIQNqEOpAIKyZOeC7f2he9imkdc1d5eL
         SQbJ0FoLZnz0DJqW5avSAl8WHTgK0UryqiFt/y5EJFdHL/StAFBMQHaKKb+2P6WZZzVq
         wjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XRiIeMwlCnY10gscUak0GdkB22KlDwSXL+jMaxy2RNE=;
        b=dNT0EISAKn01bhL/2J++bmCo0YfPdc8sDA/RAwMaBYTmGXp8ekoSZJtWNivNYz15ad
         9rVhnGouL3W8BG/R8QrmfuJfLr5TlRDwhOAQZkfBkCFc5lDFZrPW664AFjawnu6XrYjT
         62NnXf3xTs4ncX8kM/mIlyM0EkuU1T7CnD7DhIHA8+g6x32WfuGNjK83oTtCJG+oUnzo
         e1opY4e158/10u8uetd+Q5xioNNWWqNq7uqIDyzLKIXbc4+GMa88Hqam7WjxwkosY2S4
         vk7X9QnK0l2bQLom8Lpm25h1T3iHP7YKHg3cAiks+8CuG7Q2IIn8837SzL3xQD58ugox
         d+Mg==
X-Gm-Message-State: AMCzsaXwg2kISO3Tw4plC/CEbJk/MskZZ6f19PMgXFRxWfFKs5WuB8gR
        JSXk0nq1hzE7zPXausKJ9byoVr99vpU=
X-Google-Smtp-Source: ABhQp+S9rBOyHDIEKdvHLqpQEpLa75A9oYaBv6gbSwObGodeY0rnWDuMC+ePG1Vzfpxf038CoiSZ5A==
X-Received: by 10.36.71.74 with SMTP id t71mr4468006itb.53.1508971589181;
        Wed, 25 Oct 2017 15:46:29 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:4d7b:dd00:69b5:edeb])
        by smtp.gmail.com with ESMTPSA id w195sm1836598ita.44.2017.10.25.15.46.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 15:46:28 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] color-moved: ignore all space changes by default
Date:   Wed, 25 Oct 2017 15:46:18 -0700
Message-Id: <20171025224620.27657-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.6.g953226eb5f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 23, 2017 at 7:52 PM, Stefan Beller <sbeller@google.com> wrote[1]:
> On Mon, Oct 23, 2017 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>  * As moved-lines display is mostly a presentation thing, I wonder
>>    if it makes sense to always match loosely wrt whitespace
>>    differences. 
>
> Well, sometimes the user wants to know if it is byte-for-byte identical
> (unlikely to be code, but maybe column oriented data for input;
> think of all our FORTRAN users. ;)

... and this is the implementation and the flip of the default setting
to ignore all white space for the move detection.

It applies on "v3 (x)diff cleanup: remove duplicate code" [2].

Thanks,
Stefan

[1] https://public-inbox.org/git/CAGZ79kbba9KuDX7HsxhW3jXs7ocWfZg=KSHE-GsXjntnT4PWdg@mail.gmail.com
[2] https://public-inbox.org/git/20171025184912.21657-1-sbeller@google.com/

Stefan Beller (2):
  diff: decouple white space treatment for move detection from generic
    option
  diff.c: ignore all white space changes by default in the move
    detection

 Documentation/diff-options.txt |  15 ++++
 diff.c                         |  18 ++++-
 diff.h                         |   1 +
 t/t4015-diff-whitespace.sh     | 156 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 181 insertions(+), 9 deletions(-)

-- 
2.15.0.rc2.6.g953226eb5f


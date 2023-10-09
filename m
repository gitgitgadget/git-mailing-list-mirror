Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B66E95A8E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 07:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345404AbjJIHjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 03:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345391AbjJIHjI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 03:39:08 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0568F
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 00:39:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b974955474so714141966b.1
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 00:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696837145; x=1697441945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++y71iiJKzgxB9QbB4aapr/6Tq4nsyEaASbSp+CoW2E=;
        b=c+c2bUnPWlSdVBuYaIPTILPLITvTe9L+LD63BgNlewC6wQ5t4YdX5G02EvWEOg2zDs
         Ss/xUIGUgHI6wijsFIrrP/yJNQbikNitljHiLWSR62V7y13+8CJwRGBrE1/edDIiqzpM
         DeYbL/mh5kb0uXnW75SOjEmSXmGDN9Wr0pKr/mHonn2Ne4Juzjvsu0ZG2vl5YMirj7xy
         VvVhtBwEJfByd+nnA2PgUXYxaPuG5cZ3sqDyKzW1r8W+srSbUgSh8dE0rfy5kx8qyTUp
         brmLsMsFi50cnWYThuw35nwCZ2/nQzg5oOtYX9FG/DPiS4hPqBG6fgF2lY7OhGPYPGq2
         blUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696837145; x=1697441945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++y71iiJKzgxB9QbB4aapr/6Tq4nsyEaASbSp+CoW2E=;
        b=PmcndYS/HWfs5sXFN/3Ys2Je3mQHTU2SZ71K4KlBIsun1id72Ruh9/no1elk1oCs7z
         89BkLayFIogGFWtT85TLWzSHibRjacjfH8I3IY7FXd/uDbZrAZrRQrqBAk74AbMBR9hx
         xW5/7KL+NgXZnZgOmORDPTKDIg4cwOZuln/EzG1e/2/Uzl/19OGvn8iUdvGMmLUk/6vY
         4wcB6gq5be3QyKmu76PriZ3xBcEt5aoTI6g6tUEO7PIR6Trq1rx19vICXN+doGzp9XZI
         QQaE/jD3iYjvpyJJtJRv+ovAPzsR6lRLFJ4cUrgYYr3oVfRgNn7kOsphkGFOVxfPHcr0
         gifA==
X-Gm-Message-State: AOJu0YzAj/hZzrX9W1c337IMe1PwtlChdvN1k8ING06nCwik0e3Zl7ht
        UV7aEkBNXLZir7wGikTDLczeQNYxKqJxgJhizLcsE24oRHAxiQ==
X-Google-Smtp-Source: AGHT+IEad4sQf/XbXqHSd25CCKqC0iwlb7G2qAIo9G6lejgqabW18iUesm9JHURqtrF064iOmiIdzCpIVra5cm3qPc8=
X-Received: by 2002:a17:906:300f:b0:9ae:6a8b:f8aa with SMTP id
 15-20020a170906300f00b009ae6a8bf8aamr12677734ejz.26.1696837144782; Mon, 09
 Oct 2023 00:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231009011842.1956-1-naomi.ibeh69@gmail.com>
In-Reply-To: <20231009011842.1956-1-naomi.ibeh69@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 9 Oct 2023 09:38:52 +0200
Message-ID: <CAP8UFD3HZOMJTxW5EkUwKu48GebSKX3-EPD8tjGEQnE2MGaZ7w@mail.gmail.com>
Subject: Re: [PATCH 0/1] *** EDITED add.c ***
To:     Naomi Ibe <naomi.ibeh69@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 9, 2023 at 3:19=E2=80=AFAM Naomi Ibe <naomi.ibeh69@gmail.com> w=
rote:
>
> *** BLURB HERE ***

A patch with number 0/X (where X is any number) is called a "cover
letter" and is supposed to explain the purpose of the patch series it
is part of. Usually a cover letter is not useful for a single patch
long patch series (when X is 1), as the commit message of the patch
should be enough.

Also things like "*** BLURB HERE ***" (including the stars) are
supposed to be replaced by a subject or some comments to explain
things.

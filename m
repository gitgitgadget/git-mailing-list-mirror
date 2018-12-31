Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14C6B1F770
	for <e@80x24.org>; Mon, 31 Dec 2018 17:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeLaROe (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Dec 2018 12:14:34 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39106 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeLaROe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Dec 2018 12:14:34 -0500
Received: by mail-io1-f67.google.com with SMTP id k7so21630010iob.6
        for <git@vger.kernel.org>; Mon, 31 Dec 2018 09:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFPCLg2KG8HVO2zfeEJLEDgqNJptW+DGmvFmQwzj5TU=;
        b=hQ8MdnRKeG6qwyc4lplkSrc/oGgn9zYVKXBzVJ3yZ6wEThi3uJcKNMBcEa9EFtFouv
         F6fU0kq49fhTBdRxUBS/FG0Ed1EIIs6XTuWxyB+JX/ZXXvRMaMFwd8FIjwZw8kxCtFZI
         etOE/VGwkIUE6pZihOZ/qRqydkOwBlM2xiJg2dYbOrtOaHxJ6JAlw9WFoG7DUZBY29WM
         6yobR6dTRm3rXKD2R38Bffud8mvoIUZWmJGVlh37UWZjG6vmP/xe5f3AMNQ3YTKP1DRD
         b09L/hqtMF7WVwvYWfIMyqNxB5/MSqUNzB/gR8WzbOvXgUDrg4gCzwtA7jl/XMoY7XD0
         p52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFPCLg2KG8HVO2zfeEJLEDgqNJptW+DGmvFmQwzj5TU=;
        b=JOFWGBYf/MIwd70EaRU/BVPz/bg/7ZMZTE2MQrswJsWk7QGlv+q9/vo6SDqzT2XSiG
         1OsqZOD9Y7eAVWtUxpYQFQ46DhWMTAVV++A5HDUIaUcXrkFmbLh3iiqLFtjjZkL7coQn
         v1kgteoni9coG8GMwpN2jlUNRy7CBQmLY2YOwagM8drwTLO7g9Ifnp98R2vucMSkRGPY
         ZiOfnYRdqkON3OpmteSCZ5TAFCLflHYbO18sjBV7q+5rnBBkwexLYbTCtK3TNV1RPjLB
         EkcmMHt438h9somG3L8z4U+RnYyNaM7xYkK7IuW5Ssz7fPsqUXIuOgYs4zPWZmnpTUay
         XAww==
X-Gm-Message-State: AJcUuke+hDxC0f2HjkOLF0cFlW4w2io5gt+mubJ2t3wukr2rRpoG4E0b
        V2DAikfF38onMJxJ9b2rDPt+AhELZuucsuw3Xeo=
X-Google-Smtp-Source: ALg8bN7R+07QjgizyU6CYT8pyox3edqh6CTUcnJm5rrU7tVBfs3NXrB4FsaGJVsZiQ2VnJu7AuU2v/GlviKjYf5qXDA=
X-Received: by 2002:a6b:c3ca:: with SMTP id t193mr24078516iof.269.1546276473377;
 Mon, 31 Dec 2018 09:14:33 -0800 (PST)
MIME-Version: 1.0
References: <20181209225628.22216-1-szeder.dev@gmail.com> <20181230191629.3232-1-szeder.dev@gmail.com>
 <20181230191629.3232-7-szeder.dev@gmail.com>
In-Reply-To: <20181230191629.3232-7-szeder.dev@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 31 Dec 2018 07:14:22 -1000
Message-ID: <CAPUEspirwDtbrnj2cNyEO8TuoRp_4ZhjkT0TRb_QgEO-Db8H-w@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] test-lib: extract Bash version check for '-x' tracing
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

slightly offtopic and definitely not meant to be relevant as a critic
on this specific change which I found otherwise fine, but just a heads
up that this test itself is bash specific (since it uses arrays,
against the recommendation in Documentation/CodingGuidelines) and
therefore breaks, at least in NetBSD as reported in :

  https://public-inbox.org/git/20181121224929.GD5348@jessie.local/

Carlo

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 493CB1FD09
	for <e@80x24.org>; Wed, 31 May 2017 18:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751037AbdEaSJV (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 14:09:21 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33582 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdEaSJU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 14:09:20 -0400
Received: by mail-pg0-f43.google.com with SMTP id u13so1912896pgb.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 11:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HYT5eXpeZgsIW1Tl+5xSgso/X4lRoX/O0W7tTr5P5aI=;
        b=nIMXF0u1tFLWmK6/lUoBtAAldgWPhmHGag3a7IGtQ/k03nibPEnlrxzZxQ1QInQjSz
         IXSJZCESWr/gkQe+WK8I7b2p7SgmbYmEuv37RalAZK8S3GDRxokw8K/SmrJedVWyzevX
         dCyvaynZXhGUPJSfo5EmY+ZCbM4uqNe7+51nebLE6AI0j2Tem1j9XRWJiEucukWT2sE9
         wlvfUBhX3M2reEaXbIEknoMz7dijb9NmnYkgt1fWWDSoAySIhp1lge7kbV3w0t3eYv2O
         naCBVRY3Kpkm0BvFun9MMc2xWCGy1UPW/M3PKoZ7JKTQyYH8rIx+VB0w0z72HHUhNLvX
         kcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HYT5eXpeZgsIW1Tl+5xSgso/X4lRoX/O0W7tTr5P5aI=;
        b=bhuOao2iKUauC4K9IVIVb5AiBbHOyFgQWuzOenofGCGm3u7NRQb4cCU2U3stMIo3Db
         5Uw0zMWzm8FbihqkAcScqbhb+82dMAJ2LAljatn5VUeeZGlWOQKPUX+vXq36S9mDLTE0
         9gxCqJvhxWtPsVSF3MQVnavk4DypSSDM4KYDri8x9TE0/LhtxsNw9BvNSeUHDg1uoeDF
         n4h8eSIcZPjHmbTaP+exa1hmzGQL287vtnLh9KOuqX5IzmTAXZTEfwFCyA3AGaPRurW/
         43DwhLkUBJpd715tiSzCupE29YREBHhhaGZwRqljIXgJrAw6xh19N5vLs0joAjnsGaPJ
         Iipw==
X-Gm-Message-State: AODbwcDQ8u6MjNtsKNbvTJl3YMGuNgilzBJPpwIgUt1fZnAZSfoVwsGc
        nNT/x4Zssy2X/P7jl4/Ntz33l1mlvyWEDvvjtA==
X-Received: by 10.98.205.65 with SMTP id o62mr31518722pfg.105.1496254159902;
 Wed, 31 May 2017 11:09:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 31 May 2017 11:09:19 -0700 (PDT)
In-Reply-To: <20170530173109.54904-26-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com> <20170530173109.54904-26-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 May 2017 11:09:19 -0700
Message-ID: <CAGZ79kYz7jhBVivhVNVMHhO1NfC_j4CEHF5uis-S093dzZL8tw@mail.gmail.com>
Subject: Re: [PATCH 25/33] notes-merge: convert verify_notes_filepair to
 struct object_id
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 10:31 AM, Brandon Williams <bmwill@google.com> wrote:
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  notes-merge.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/notes-merge.c b/notes-merge.c
> index 55dbb3659..962e9b1bc 100644
> --- a/notes-merge.c
> +++ b/notes-merge.c
> @@ -22,21 +22,21 @@ void init_notes_merge_options(struct notes_merge_options *o)
>         o->verbosity = NOTES_MERGE_VERBOSITY_DEFAULT;
>  }
>
> -static int path_to_sha1(const char *path, unsigned char *sha1)
> +static int path_to_oid(const char *path, struct object_id *oid)
>  {
> -       char hex_sha1[40];
> +       char hex_oid[GIT_SHA1_HEXSZ];

Here we better use GIT_MAX_HEXSZ ?

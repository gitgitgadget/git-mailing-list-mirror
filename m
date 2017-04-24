Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06060207E2
	for <e@80x24.org>; Mon, 24 Apr 2017 22:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S978718AbdDXWK1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 18:10:27 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36856 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S978247AbdDXWKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 18:10:25 -0400
Received: by mail-pg0-f43.google.com with SMTP id g2so18945200pge.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 15:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+t+Xma3SsCz48JP+aHG2w9UEmukY5WKvpBRPpRTY+f8=;
        b=nI8GPWVT+oOhMr6t9CwIvwUL6Q1RYNtk3h5kxqTWm3g8EHJgxtJFPOut0qwTYgn4e+
         qq7HpmJACnNBJUe41ZTj3N7JNn51mr4eFbxCl3O/DtQgSSxyTW+5jG5zPb/NQrcgJKHP
         UeVnfO4V+IlV9agTyoNLixHOav7gX3CbYD8JK4rwdRdnY+m/DyqZ+ioI3k4xZnPyV2d1
         k1UomOyAmunkWU0plUmTXkkuBUL32f5QLppdJexNNqkodIqQQFyKJj55XTdkgV9g9glg
         SDTmuv5+3gwfUPyj4GwrXlL/iwcWoCGnf0dEu/oqvwn0EvEzuoqHPtOIk+UkZGNuB32G
         B2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+t+Xma3SsCz48JP+aHG2w9UEmukY5WKvpBRPpRTY+f8=;
        b=nPkAchbuYsj+TWWX+JLvsWvkxsM7Sd0udMsYofWyjj2k+yvNosGIR8mylw8ovLZZV1
         YnKgeORf54NxT4DSH+elvtdWpWDF8zJ73VDf59eUJQ9KyfB8YcSIGsJcIzfjZoukAvAO
         EDSphlNKj6FapV0L29X3WkqMbZ5u9YO6IiKv/mG/z2klVRflJWR7CAJcrc9HUoO9X1mq
         vrVptuW722vzxxHkCZ/Pwoma/9fZO2tzfF+QRiQ65CggBkldlo2XMffcEwzs4+NxfB9I
         8tHqKVDpjJ3JRtyFANwSISzB01TkvNUjyq8QIJJFzABjS+n413jeykUNzPawUNXVUTfd
         NYXg==
X-Gm-Message-State: AN3rC/44DY79YSg2nZUnSrNfTWahN45kCv1dEOAemFMDf1rArUeBr1Mq
        ie/CcRZ/tpBIJnxwNCFDj02s89wIwuWP
X-Received: by 10.84.231.136 with SMTP id g8mr27553234plk.12.1493071824909;
 Mon, 24 Apr 2017 15:10:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Mon, 24 Apr 2017 15:10:24 -0700 (PDT)
In-Reply-To: <20170423213453.253425-14-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net> <20170423213453.253425-14-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Apr 2017 15:10:24 -0700
Message-ID: <CAGZ79kYKLin0=Yz33NO8tQrWUBbjBGU==2RCEeNZFLhV5j7oQw@mail.gmail.com>
Subject: Re: [PATCH 13/53] notes-cache: convert to struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 23, 2017 at 2:34 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Convert as many instances of unsigned char [20] as possible,  Update the

s/Update/update/ or s/,/./

Side remark: In all patches up to now you put a space between the char and
the [20] (or [40]), which is irritating to read (for me). I presume
putting it adjacent
to the char would offend others as that would violate our coding
style. So having
the whitespace in between "char" and the array makes sense.

Up and including this patch looks good.

Thanks,
Stefan

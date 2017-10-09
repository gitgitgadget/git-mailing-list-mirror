Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C446E20372
	for <e@80x24.org>; Mon,  9 Oct 2017 18:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754878AbdJISAd (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 14:00:33 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:43456 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754240AbdJISAc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 14:00:32 -0400
Received: by mail-qt0-f171.google.com with SMTP id a43so38779707qta.0
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 11:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aJDQJx4RCdbgvNrkyDwwRZodjdRIKsHJsqMc1dlO+y8=;
        b=eO/7SGmJ/HWLPc7p+6bu276MV/1ColqmtJ3h3eNDngsaczfIvECQjPFrNWkV/MT0zQ
         GD2RmUcXEr9ja3xlSh3TH9l3niP6lZIunZSAZweuN8arwglsXTjtq9cNPDZtGYqjzFWp
         8YVKfKVs+ZaIbrtJhfFkq2I9QtuPW9F25rrAp2nb5wP2BNE4/zhWCwCF0ddAagYQRKeV
         0kmHwS+0LQKHYxdcT5ifgmXyTFgPblp2UDsQS8zJbFeFITKNu7rotpBecE6kdMm71zNg
         zqPYpv9CHUUTtFn5bAsIgLzYjTmAKJqDg+H2FdgwJxgucfg16a8TMJt/VHJrBma/8wYq
         +BaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aJDQJx4RCdbgvNrkyDwwRZodjdRIKsHJsqMc1dlO+y8=;
        b=btDJZHdZjwTzEIfxEqLiETi8aQDFWpFLctcNr6YlqVPeYQx9Ep5JYhdLinK6RcV/vH
         6/BEZAKeA7uny0TdK51lmpjPB3c6OqbuPzseoLZFNxv8aXrZE3jS+Gcia5OTSuauZX2P
         onN8WMzVv0gyknKgwQGO0dzDdhaNQNWgK8/VBStbgPX5CziwteT9TfEzRKk1or+6lAJG
         l1Vr9IVf+lCnaCXLui3dxO/YdAUMAl6BOkP30S9EGoHcZbilW4T2fF3F2ymlUUCF4dAe
         /KeWMN5Axlpdq8C504fhDZLUpa4MhZgmO1WjmknOM4sk2kTnFaz4+qGLkJOBTN9fM0bn
         yfpw==
X-Gm-Message-State: AMCzsaUXErlv4c8O9yEsPTyMAeAfiUL4OBTM1/jhG7FtR8s/RdnxjZ0k
        mpGqeJqp6+OSj0Rx6E/qY8RvzGjJZ0+SCjZm149rVg==
X-Google-Smtp-Source: AOwi7QBk5IQ49kVN5SASr+5a2QK0YQC+d1AP0JA1CLH2m5xxrvZSUhzmARQ81UyxVV03MSTF/5TAmUleYtsXX6dz4J4=
X-Received: by 10.200.8.53 with SMTP id u50mr16148409qth.260.1507572031432;
 Mon, 09 Oct 2017 11:00:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Mon, 9 Oct 2017 11:00:30 -0700 (PDT)
In-Reply-To: <20171009011132.675341-1-sandals@crustytoothpaste.net>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Oct 2017 11:00:30 -0700
Message-ID: <CAGZ79kYAEcVRr19pj=7Y6skwjukVLC-veA8bAPYMLdA8TDVe0w@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] object_id part 10
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 8, 2017 at 6:11 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> This is the tenth in a series of patches to convert from unsigned char
> [20] to struct object_id.  This series mostly involves changes to the
> refs code.  After these changes, there are almost no references to
> unsigned char in the main refs code.
>
> The series has not been rebased on master since the last submission, but
> I can do so if that's more convenient.
>
> This series is available from the following URL:
> https://github.com/bk2204/git.git object-id-part10

Skimmed-over-and-found-no-issues-by: Stefan Beller <sbeller@google.com>

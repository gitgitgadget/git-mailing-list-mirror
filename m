Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8504B1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 23:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbdFMXnD (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 19:43:03 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35886 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbdFMXnC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 19:43:02 -0400
Received: by mail-pf0-f179.google.com with SMTP id x63so74774612pff.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 16:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ggnXkRtAgjcRCdzTUomSPhZPRfdNtW3iV2/DFtJk0AI=;
        b=QCVR3HUmco7T4ZIrA9HXDsSsgykIuqYmWUWcoErkORsDeCcdp3l64TFZVlujIEMusI
         MNRKiCqtCTndvUdBpS3iO8q0s8JFS13zixWmojnZuyAxtQ4fhDxjfH8ia69tkCu9NUd8
         /QxXkF0XO/gQi/g01Oq9Netl1ZQa9u8faZAwJsCnvHyJj7ClW4RpLwZLbambXDWJq8hz
         JCEntp3rAHyWESJDRfMCO7vwjugXGlQSdQIpRf95kj9tZ1+4C71fq+a14+g0jUDYzG+5
         gVySFkap2Rf6vXR5BRNKz72yzjZMtc+kaoagiTpya36L+titgvIuNw0wa/k5RXms7rCt
         ZzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ggnXkRtAgjcRCdzTUomSPhZPRfdNtW3iV2/DFtJk0AI=;
        b=HdhJwwh2Kp7YXHYHrT9G84M4J4eBX4ghKf5cZlM9f2HIFptgurQ+iAv62XZb//1ngd
         tJIZ/aAdTyA4dxN9mn9+VFyv/8nKy0dW+kXFmuKzG7ha6rMxA4/unLXBwUh9SCb8vVD0
         dp5TNWIirylKj1KSwU7ndroRcIIwUtaFLYZvEScawE0XKdE/iR/obXooPvnwu7UNQDaG
         YFzFCashFXSQsXVNUKwbbt1Ta9d/8tB2QrWOwKUS5np+VOQw8WPTv1/WqvNuk2kkVxyf
         +mn9BQAj7ldTp823t3nit90/J5byuzvLtTqG6JPrB3C8iHSabDugWxBuBDvEmcqyhNO5
         aSog==
X-Gm-Message-State: AKS2vOyWnUTwS6GAHDsGReaqgr3BMlKlH7njZg/CIgS80S0Qu399QKgL
        fPVcA86upRgGLfd9
X-Received: by 10.84.216.88 with SMTP id f24mr1952831plj.103.1497397381506;
        Tue, 13 Jun 2017 16:43:01 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:85a0:52c1:8d73:eb63])
        by smtp.gmail.com with ESMTPSA id r2sm22127382pfa.96.2017.06.13.16.43.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 16:43:01 -0700 (PDT)
Date:   Tue, 13 Jun 2017 16:42:56 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] builtin/blame: darken redundant line information
Message-ID: <20170613164256.1773a62d@twelve2.svl.corp.google.com>
In-Reply-To: <20170613023151.9688-1-sbeller@google.com>
References: <20170613023151.9688-1-sbeller@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 12 Jun 2017 19:31:51 -0700
Stefan Beller <sbeller@google.com> wrote:

> When using git-blame lots of lines contain redundant information, for
> example in hunks that consist of multiple lines, the metadata (commit name,
> author, timezone) are repeated. A reader may not be interested in those,
> so darken them. The darkening is not just based on hunk, but actually
> takes the previous lines content for that field to compare to.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
>  Example output (blame of blame): http://i.imgur.com/0Y12p2f.png

Looking at this image, how does blame decide what to dim? As it is, I see many
identical timestamps (and also from the same commit) not being dimmed.
(For example, see the very last line with "2013-01-05 ..." which is
identical to the previous line, and I would expect that to be dimmed.)

Also, my preference is to have all-or-nothing dimming (dim the whole
line up to and including the time zone if nothing has changed, and dim
nothing otherwise) but I know that this is a subjective issue.

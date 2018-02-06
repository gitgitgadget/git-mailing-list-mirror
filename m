Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CF7D1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 20:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeBFUZy (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 15:25:54 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:37072 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbeBFUZx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 15:25:53 -0500
Received: by mail-yw0-f176.google.com with SMTP id v139so2290216ywg.4
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 12:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YFEw0/HxDF7ADuKoJdxzr+yS8CYLoDN/YG5yl795hX0=;
        b=X4tcpsR2r6uHTFYia242Fz4nWAY7zaRmeTOYl8eCJzgtAWZpBlKhFC4UpWOLjch791
         QckAZMbIulAfHwnOiUgaA7G06E3lmEeLNqkzxMrQahQsSehPcIrruArgW/2Kq27oyM1x
         txMr7hLaE/lljl0Yko/0O/zt9iWy80dKXDlkAnVsrlYoAr3EUKI7nfxfMUXkbxfABfqb
         mcQM7NRb+f503EMSusCB3CsAdR/vBdAsmEe/gLvnS+nU2ipSeu3+jZnr4QBRPgzgjaCw
         /5SfXzj/kMx3olecIxCMqzrqT7KNFQWMToLpVIVDa2L4+V54HCdsIWgqLkcM24ExZ5Vp
         /sbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YFEw0/HxDF7ADuKoJdxzr+yS8CYLoDN/YG5yl795hX0=;
        b=p/y6TKrtbfwG/ryRIc41a0yGAmktXmoxAz9U8/JVKLjRkgmneoEcwTLg6tRtlLBnSR
         dghyuChndcRiMQtdYKihyX68Mf1v1HceutOTbeaMmHvELcqQ8J6a/osPwXnwidZpAlRi
         ABlbRnTcEhXmfVPWrykBpDSwX0K8D3usuG9dbUhwZZR+QPrJ/bJlZS5iAWKoPpuAJC1j
         6nYk/nvssJoMax4NDUwz0yQao+AInJwK6HHv+ibgCjFWe7uTFmweDWUTcG/BrmJclNqg
         fHNthrx0Fxa0LitjkY0dVtOFHignLBKH+nZSYQ5nuZfzB+2Czfb/8ImW4FwgWiKBEeUg
         +1tw==
X-Gm-Message-State: APf1xPB8dAq/KZlQ6KtTOOb2waShJcXvO2fw64Eu84tQ+pmqdhZ17qWy
        7YDmKnlT2odN5py7y8xLAhm5onbWhTToqCulH1wPALT6pRE=
X-Google-Smtp-Source: AH8x224MNKfvO8oz4ijNhVJ8W3rNVfJvT6f044tUU+e6o+aysaeXTS2LT8Krij/yp7QJSGCX1YAfpelGeo481S2d0i4=
X-Received: by 10.129.86.139 with SMTP id k133mr2266548ywb.253.1517948752103;
 Tue, 06 Feb 2018 12:25:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 6 Feb 2018 12:25:51 -0800 (PST)
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Feb 2018 12:25:51 -0800
Message-ID: <CAGZ79kYYZ-dmHA5jZeKTk9TFxn+7_zzxLPR7jNS4X8+K-JU_dg@mail.gmail.com>
Subject: Re: [RFC PATCH 000/194] Moving global state into the repository object
To:     git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Any suggestions welcome!

Eric repeatedly points out leaking memory.

As of today we do not care about memory leaking as it is cleaned
up at the end of the program anyway, for example the objects
hash table is never cleared.

In a resend I will put the infrastructure in place to free the memory via
adding

  raw_object_store_clear(struct raw_object_store *)
  object_parser_clear(struct object_parser *)
  ref_store_clear(struct ref_store *)

and calling these functions on repo destruction. The functions
itself will be empty code-wise and contain TODO comments listing
all variables that need care.

Follow up patches can figure out what is best to do, such as closing
the memleaks. As repo_clear is not called for the_repository
we'd even keep the property of relying on fast cleanup by the OS.

Thanks,
Stefan

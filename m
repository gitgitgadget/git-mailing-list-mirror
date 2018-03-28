Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 907761F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753090AbeC1R4J (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:56:09 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36880 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753232AbeC1RyS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:54:18 -0400
Received: by mail-pg0-f49.google.com with SMTP id n11so1250049pgp.4
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2NlqGEeEVyMR8C3FnfaViPWGED6whenfq3mEbpzUvhQ=;
        b=okXMKB+dXilrHd2Cf7dqqARWIClEhKEjP/Mz4c404WpJV4LnHBq1XB++N+BfUFERKM
         VqbO7prZ7Hus/xIzdmoUGmy9z5wdywrQqcYY+Ho+NQLOz94Zq/9wNP49T3G6UXyblttA
         NaIQaZj1EA8r/g1vo4NeeDhoPHZ4ODDbRChrnaP81Ph+2RVaGESOWNzDR90s1B4Jbe+4
         ZGayiP8EjjEkLPjHRIZ8nxfnzU6PNRUK0BJ2sCHn5P21/MFXjtF/cEtwjNjK1iHmKWdP
         S921Dlzyztwxod6XDCdz7NRaiMxb5fj83PYAKrf/8i0guVgMuKu/Y8bRT0kjTTusDSsu
         jqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2NlqGEeEVyMR8C3FnfaViPWGED6whenfq3mEbpzUvhQ=;
        b=alLu8cHS9OiTxihSJ3yJvB4s3zNLELafb3A0zu2fxEDc3nDpibZ2kOQhG221UBNxOT
         6wVr9h3FjHovhwBbxCfX9MM4xBVx1CHcf2ph9rsa3dGIWrG6fayw8NJH9HpWctDYI25Z
         04b951o3XMl69u82jC3CISlUSGhoEZ9ENruhDVSovqmf9nWsn5WyLxLs8e7h+CYt6LqA
         XRN+vAh1Juvcmx1CsWwTYnHoI8Ta8aV0oB3i5LdysiNwgJypY+ARi8GNGXSo5LPLEkUk
         HB7l3OBO1lyZsklNxnfwGKo9Qd92kmMcgxmgvroCH8UQtKA/gfLzIwq2U8PWVsZeMiFK
         YWGA==
X-Gm-Message-State: AElRT7EKdeJP9R8utZG4ThCdc+TXxu/dRFwCWt6EtAg47zQ1jmJHpZQW
        C9ZJN7W2RsCKmKD7ylqAiheEZw==
X-Google-Smtp-Source: AIpwx4/6MMi4l1byIl2xmQ9yhzSVjTekqsg5Ty4cPLJULIIkswyaS0v+nUcidCFTOv4RzZ2m/CSm6g==
X-Received: by 10.98.17.85 with SMTP id z82mr3756759pfi.206.1522259658055;
        Wed, 28 Mar 2018 10:54:18 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id a3sm7674240pgv.14.2018.03.28.10.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 10:54:17 -0700 (PDT)
Date:   Wed, 28 Mar 2018 10:54:16 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, bmwill@google.com, git@vger.kernel.org,
        hvoigt@hvoigt.net, seanwbehan@riseup.net
Subject: Re: [PATCHv2 0/6] Moving submodules with nested submodules
Message-Id: <20180328105416.3add54858bac92573d7d1130@google.com>
In-Reply-To: <20180328172449.27012-1-sbeller@google.com>
References: <CAGZ79kaQYjepND8EdgB73meBsShOc5aBporiK2Bo40fqcar0gg@mail.gmail.com>
        <20180328172449.27012-1-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 28 Mar 2018 10:24:43 -0700
Stefan Beller <sbeller@google.com> wrote:

> * picked up Jonathans patch and added it as a nice finish of the series.
>   I did not see the need or aesthetic desire to put that patch earlier
>   in the series.

Thanks for picking up my patch. The aesthetic desire is to avoid what's
currently happening in PATCH 2/6 version 2, where we still have the
potentially confusing submodule_free() -> submodule_free(repo)
conversion, which is also later redone in PATCH 6/6 version 2
(submodule_free(repo) -> submodule_free(the_repository)). But I'll leave
the final decision to you.

Other than that, besides PATCH 5/6 (which I have already commented on),
everything looks good.

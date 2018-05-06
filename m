Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A979200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeEFXxo (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:53:44 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43903 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeEFXxn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 19:53:43 -0400
Received: by mail-qt0-f194.google.com with SMTP id f13-v6so24368899qtp.10
        for <git@vger.kernel.org>; Sun, 06 May 2018 16:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lbBJ0skH4qkeIlMb+ZcjMEyTR5RjpnV0xrreDVtd0yQ=;
        b=Z6hv39E+Z1Rkrw/uB0eARZAV1Qlgt4ALTuSfEc0ucq8WGA6gNVc+CF71MMcWAENEUt
         eyJ9XuKdvETnKgwUtJMVbJiCyVVkvhcsFrs3qaclE3XSHSBwbiBiXN42rqtsSEyWWx67
         I+9aKRghTfhlHBdmx7/JOnIqY07iwn1a94LEB4DoT5tLIIgHGuGUDHio+EDFakH/2nC8
         3gY//tJnJeNsnon9rpuhKjvuTyJ5bhxcqkN+3a5a1dYxHCJgvH9LZjTWUidyGTAMwwde
         Q/aXWJd2fYpRqju7jdJcvRzF0oeIPrMbRkXyCrcqNLa0IWCn3im8hEFGLV1KTHQVCd2A
         OShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lbBJ0skH4qkeIlMb+ZcjMEyTR5RjpnV0xrreDVtd0yQ=;
        b=nOJ9fZyyf0pgqAZ+ZdsNSKBnfYpON7fCETe5p54nV/YnRk3gZ7EIVjeC8iJhmzuDir
         qvIQ7muqxCVgT9iLbc41Q/sog+jzOhojnXE1PPXIwt80HJdSoA3k6zmXF102ANRZ3m+O
         1if3JLwtRDrbG+PVghAA9ESR184prpUhEdOMLEny0QfPLmPWbkVFSOJ5pZ+OX4ZOW2bi
         FDuS7+rWNn+xKC/3D4rGNcK8guT33msj7jUVP1x2VsAlH7viS9CytrbO+C3FofdVPL0W
         qhtpvNNEIXUaeqz0lmon1Ybj+liM+bdI5iN9xKp1WdbSnTv9VwUKmwiDgUxBYMPTOcFC
         xwGQ==
X-Gm-Message-State: ALQs6tBsfCqfpH3Z3aONXQE4FV7bJdWENxwdmkCwLGGoLGdeq67Zix+U
        pXKyMkmVqfx8zVj71es/wpUYeULgNnqDxTlNwhI=
X-Google-Smtp-Source: AB8JxZq497OSDZAjEaWUQbra/kxsryiAyxzhYJoagBBT4YBnqZyv+yAOYygYlyOk4ujFcAzujnE/6sM/q2TCBPo9r2g=
X-Received: by 2002:ac8:1204:: with SMTP id x4-v6mr32577775qti.35.1525650822641;
 Sun, 06 May 2018 16:53:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Sun, 6 May 2018 16:53:42 -0700 (PDT)
In-Reply-To: <20180506231752.975110-5-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net> <20180506231752.975110-5-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 6 May 2018 19:53:42 -0400
X-Google-Sender-Auth: K2w7_t5BkZB3Wpz0JIxTdailOPI
Message-ID: <CAPig+cTrLseKxznrMb63rQ4NK1JYvPraV=Bz6vbnO0sY6qkK=Q@mail.gmail.com>
Subject: Re: [PATCH 04/28] t/test-lib: introduce FULL_HEX
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 6, 2018 at 7:17 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Currently we have a variable, $_x40, which contains a regex that matches
> a full 40-character hex constant.  However, with NewHash, we'll have
> object IDs that are longer than 40 characters.  In such a case, $_x40
> will be a confusing name.  Create a $FULL_HEX variable which will always
> reflect a regex matching the appropriate object ID, regardless of the
> length of the current hash.

Bikeshedding: $FULL_HEX doesn't convey much. Perhaps $OID_REGEX? (And
$_x05 and $_x35 can be named $OID_REGEX_SHORT and
$OID_REGEX_{something}, respectively? Or perhaps they don't need
renaming?)

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

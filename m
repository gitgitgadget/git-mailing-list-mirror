Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PYZOR_CHECK,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAAC320248
	for <e@80x24.org>; Mon,  4 Mar 2019 23:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfCDXHO (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 18:07:14 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:36716 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCDXHO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 18:07:14 -0500
Received: by mail-qt1-f173.google.com with SMTP id p25so7068472qtb.3
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 15:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:date:message-id
         :cc:to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=eVSCkB3bDabw9bmkKwngDMTU/yunohdTCtEBcvzxb6Wj33lxXx+thkQICS8cbRzw/j
         HyQd4SSZDQ9sMiSmmn9KXfVrQkJULSkDO263YW+5qTPZw84HqAJDQX6Wa/bgcSxnBPjW
         NEhpQU4i1TiYOk6TJ4w09qwX4Yw0K2dN5/i/ns4N+Vh3bD4JcrwkIQi4SwLRvYefZAKB
         XDhvTN3ZPdQFScEpU1bTO5n3izcgcEO8Xm4U9x21/+CySRbyMDm96hmkh/WvgZzaukj/
         DyvSnRN7JGD1KwbEeRcEzMm6jJBAMuAltP/BJKpTVFpTyjxR3G+7PB6yBVmfWCkm9Nj9
         0v4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:message-id:cc:to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=Q+iHGXchzTOjFnCCcQaG37zJcrc/aOfwZqO1efiAImZFZjspE/nkooYhAWjQsbvvIV
         5ZCKlMbFekf1pfTS5kCOhFt1R1G7UPIVtcLSoK3dcpCNnDId8GmQyLLzaYtTu7D9t2aY
         TSUnNKAYCAp/0Gaj4EQWI5wD2hobd/74wNesFL+NIUwZ2EyCBAPSzW15i8ZXiSQBf9mm
         tuVWQksS+KCqH5Lvu/TYvNo6QQ1XkrSEe1PNTtabvwiRe5pBa4FA0GK9nDUiBLfjLkPa
         erkLYPCfRfFxcQfEHy1ojl7fGS/2Wo4DtcaoiMHZ7lRvaj7VXryys+Vw3JwnAUoc02pT
         WQng==
X-Gm-Message-State: APjAAAXXmO4eypsSa8TYsGxrtyN2JoefrW0zXEeAM+gA8BlXJUj+atQy
        hcHP3ih7neAUl3+CKTrnTaM7fXJqu9uK6w==
X-Google-Smtp-Source: APXvYqx9/XcQlOJgfMND5yQ9W9QmRVAyRajOzutjRvoi5MOkxCXgZT0ihC4pw8PRyoRdSbow11VHvw==
X-Received: by 2002:ac8:5297:: with SMTP id s23mr16047107qtn.371.1551740833404;
        Mon, 04 Mar 2019 15:07:13 -0800 (PST)
Received: from ?IPv6:2601:19a:280:1e4e:5106:4027:47eb:2f6? ([2601:19a:280:1e4e:5106:4027:47eb:2f6])
        by smtp.gmail.com with ESMTPSA id x43sm5757551qtc.10.2019.03.04.15.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 15:07:12 -0800 (PST)
From:   Woody Woodman <wwoodyy1@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] merge-recursive: ignore_case shouldn't reject intentional removals
Date:   Mon, 4 Mar 2019 18:07:11 -0500
Message-Id: <E996067C-E91F-4333-B996-D9AD9DD077C3@gmail.com>
Cc:     adam@dinwoodie.org, dturner@twitter.com, dturner@twopensource.com,
        git@vger.kernel.org, newren@gmail.com
To:     gitster@pobox.com
X-Mailer: iPhone Mail (16C101)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BFF11F453
	for <e@80x24.org>; Thu,  7 Feb 2019 18:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfBGSnF (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 13:43:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35746 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfBGSnE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 13:43:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so983471wmt.0
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 10:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BXi3fOApgB+N1a2Pl4ipVBJ/xdElaRdPFAhHvpGllpY=;
        b=btt0Q3LrUKortZuc5SC9ERaAhV2VQV0AejebZ82+TmrIDMIXfXLd7PLbrnzqPlVp4Z
         3kMPpOzkw0MGqysdWxSP62lije40X5l6fbjosWxAu11uc+OFrVOsz9l61PQcdzUJ4dlg
         zAUQTfEOedrN9Xucj35ABhvhbh9Ye8w+2Pn/6t7co/mL3pH5Y/gSN+f0Vepo7w+gWaVl
         1Cp9m30z8AeAcIK3ooVTJXqdCE59p+pAl7ub8y73mQPxOzP+AW6PHMOnlZJUPtj9d9OH
         SKWMxmWks5e7Fm8V4M5vnObq7k6307g8hTAPDKHqYAXuGS2y6oDPUSeO/TfHUi7sONL2
         a1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BXi3fOApgB+N1a2Pl4ipVBJ/xdElaRdPFAhHvpGllpY=;
        b=SA6PrC31w1ZYlVF0Cd9nz4V0h5wCZkp3u3VKHTMdjcp7zBvXS/kRBeZ3esWXHeVvPW
         8bTnbTMxvLX9YEMTHgW/eeC27UErsgdAZtqORerdGFyFwpbkPvk+ieUg6oaCh4P1VMkJ
         B2ALHAdNixK6NqFF5A9HaG1YMForhkxfQOpcSM18fc7fAMYLxM+SKhBcHvLDG7U+omwM
         Y0lycBnSuWbm0/Bo8+aLDlsxAtkNFCzX3wxvl5dk+qBow/QHhhViComBVULI8FbYZ3Em
         hT34MxSNrxl8B+QQMswLfaAbGXUdVUtDJdsbrmXvz0CClo4HbFJOm3l5XdM2fMBxK2Jb
         /+zQ==
X-Gm-Message-State: AHQUAuYL5LGt8yYUulAXLXegDLBYIypQsFeHjYUiY1MOLn7XxCZEAzBa
        +xRWJzWlDW/QT4x70MWBRds=
X-Google-Smtp-Source: AHgI3Ibji3qyCEz9Z1R8k/SYacRmrKgPliv4W52eNRf3qtbIhgSDuryQlSG7NCMlR1rxudrRQRkcfg==
X-Received: by 2002:a7b:c458:: with SMTP id l24mr9058243wmi.143.1549564982806;
        Thu, 07 Feb 2019 10:43:02 -0800 (PST)
Received: from szeder.dev (x4db57a12.dyn.telefonica.de. [77.181.122.18])
        by smtp.gmail.com with ESMTPSA id j8sm18790680wrt.40.2019.02.07.10.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 10:43:02 -0800 (PST)
Date:   Thu, 7 Feb 2019 19:43:00 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/21] nd/diff-parseopt part 2
Message-ID: <20190207184300.GN10587@szeder.dev>
References: <20190207103326.10693-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 07, 2019 at 05:33:05PM +0700, Nguyễn Thái Ngọc Duy wrote:
> Nguyễn Thái Ngọc Duy (21):
>   diff.c: convert --patch-with-raw
>   diff.c: convert --numstat and --shortstat
>   diff.c: convert --dirstat and friends
>   diff.c: convert --check
>   diff.c: convert --summary
>   diff.c: convert --patch-with-stat
>   diff.c: convert --name-only
>   diff.c: convert --name-status
>   diff.c: convert -s|--no-patch
>   diff.c: convert --stat*
>   diff.c: convert --[no-]compact-summary
>   diff.c: convert --output-*
>   diff.c: convert -B|--break-rewrites
>   diff.c: convert -M|--find-renames
>   diff.c: convert -D|--irreversible-delete
>   diff.c: convert -C|--find-copies
>   diff.c: convert --find-copies-harder
>   diff.c: convert --no-renames|--[no--rename-empty
>   diff.c: convert --relative
>   diff.c: convert --[no-]minimal
>   diff.c: convert --ignore-some-changes

Nit: convert to what?  Perhaps a 's/$/ to parse-options/' would
improve the shortlog/oneline output.


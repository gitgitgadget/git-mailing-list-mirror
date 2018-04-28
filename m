Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A07A31F404
	for <e@80x24.org>; Sat, 28 Apr 2018 09:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759649AbeD1JE5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 05:04:57 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:56164 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759620AbeD1JEz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 05:04:55 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id CLmifcsI42vvYCLmjfb4nR; Sat, 28 Apr 2018 10:04:53 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=LLdIvqe9 c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=rhIh4dFitXp3uf_4HX8A:9
 a=QEXdDO2ut3YA:10
Message-ID: <A37AE6B64CF7414ABE41697663B2BEC4@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        "Git List" <git@vger.kernel.org>
Cc:     "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Jakub Narebski" <jnareb@gmail.com>,
        "Stefan Beller" <sbeller@google.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Christian Couder" <christian.couder@gmail.com>
References: <cover.1524650028.git.johannes.schindelin@gmx.de> <cover.1524865158.git.johannes.schindelin@gmx.de> <b321979f88589e7b006466159c470800db948d66.1524865158.git.johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 11/11] Remove obsolete script to convert grafts to replace refs
Date:   Sat, 28 Apr 2018 10:04:46 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180428-4, 28/04/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfKDbImX/AsOB057tRJW9HBJu3SUXi0mDfsQc4bzSc2d8ttigUlB/gKfxyCwRXa1EulCR7F7YVJQDFT4Nx2/M6x4TBftpawXBkwiAzQh6d+FrgAfbbUgX
 6WezyPjmuPX20GjkPbDivZo96/zu9li7CLds0Qv+tbUASUyuQSx8J/HuHEJanLqO7NFMibCqTBedOLEiay4JRbDD3d2mpTBZ0zxN8J+4lt1AkQptS+k7J+3g
 g4gKPUSA7/x6/qTCvgXubtyL1F86xKyLJzXk91Cx7LJtJ4ZGrzGrAPA/3ogNf+qnR/PQK/YPlnwP3GcVMxOXiz3kxTsgCMa0+86Vcn67ohAK1cRjgVHeOfPF
 P/5rKtBvu0n1MLGIvOOE8yNv/GiwRuIHE6rHej/XGQxctVk8neU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> The functionality is now implemented as `git replace
> --convert-graft-file`.

A rather late in the day thought: Should this go through the same
deprecation dance?

I.e. replace the body of the script with the new `git
replace --convert-graft-file` and echo (or die!) a warning message that this
script is now deprecated and will be removed?

At least it will catch those who arrive via random web advice!

--
Philip
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> contrib/convert-grafts-to-replace-refs.sh | 28 -----------------------
> 1 file changed, 28 deletions(-)
> delete mode 100755 contrib/convert-grafts-to-replace-refs.sh
>
> diff --git a/contrib/convert-grafts-to-replace-refs.sh
> b/contrib/convert-grafts-to-replace-refs.sh
> deleted file mode 100755
> index 0cbc917b8cf..00000000000
> --- a/contrib/convert-grafts-to-replace-refs.sh
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -#!/bin/sh
> -
> -# You should execute this script in the repository where you
> -# want to convert grafts to replace refs.
> -
> -GRAFTS_FILE="${GIT_DIR:-.git}/info/grafts"
> -
> -. $(git --exec-path)/git-sh-setup
> -
> -test -f "$GRAFTS_FILE" || die "Could not find graft file: '$GRAFTS_FILE'"
> -
> -grep '^[^# ]' "$GRAFTS_FILE" |
> -while read definition
> -do
> - if test -n "$definition"
> - then
> - echo "Converting: $definition"
> - git replace --graft $definition ||
> - die "Conversion failed for: $definition"
> - fi
> -done
> -
> -mv "$GRAFTS_FILE" "$GRAFTS_FILE.bak" ||
> - die "Could not rename '$GRAFTS_FILE' to '$GRAFTS_FILE.bak'"
> -
> -echo "Success!"
> -echo "All the grafts in '$GRAFTS_FILE' have been converted to replace
> refs!"
> -echo "The grafts file '$GRAFTS_FILE' has been renamed:
> '$GRAFTS_FILE.bak'"
> -- 
> 2.17.0.windows.1.33.gfcbb1fa0445
>


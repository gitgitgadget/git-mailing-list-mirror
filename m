Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84C4D1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 22:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932924AbcLGWwH (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 17:52:07 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34133 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932777AbcLGWwG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 17:52:06 -0500
Received: by mail-qk0-f172.google.com with SMTP id q130so245579327qke.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 14:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZtfLvXaFPnsCXCoIFyjh5YCj3RBRPKt8cwgdvBXdwK8=;
        b=G52hGsjobtNAGK/f0Vqz0/pWeOjcPjsqksFIzcAnVSqhRQYKaoYrHKSxdMc8yL4OFz
         AmhMN4kSAqWf36x/d0T6/KQMCGzBrgTLLsjTJrwz20q08G7icmR83rnLpCRdxOm+UW1k
         lYqtpcBpFsGAysUF+ojZU57M26BFvdHX9dptu2iOn15s1ffC51w48jhObv0sOIJgGF0r
         +jFferqNmEnu6waxKVf82GBGcomfsqedZCaguSEuGrYsCTFgGic/qsSISnnnKg25yM8H
         iQbB9g5Gu3egymmgaZBjZnFdc0yh3BBv/R9R8ZdED47ASA/FG9wRFhN/GJPI4IXCiTNd
         WK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZtfLvXaFPnsCXCoIFyjh5YCj3RBRPKt8cwgdvBXdwK8=;
        b=E2JeGA/xX7t+8qe0kxcDMkLNEfy9FpzuVT8kBiQKk7qIYeb0/mhAvccFXzrUfXNehh
         72R8GNkh/iAaOvtl9gXuAeSw1xRgbZDL9/AcsMj51XTevf1h91oqIOQAoEmNw6pJNBRo
         jmhwO/xG3rp/qvmPUsbHTHovue3NzreMtEoV0OzHxhILRsshnm0qC1vg7qsp6e+XvLLc
         RYaugYgtbops1nLI/Zf7lS+j0uOhaNtglMb5D5BUtOn+VK5wfl5NDuaXXlF9L87ZPDSj
         XPCXRibNOulK2k8j4jV+AAXGt9fMtnoyYlpGRKUpE45Gp+jZzMShaxKtk6g7odC/L4Mi
         9Tdw==
X-Gm-Message-State: AKaTC012vqG4yeyE5k+MCGfZuRv5K2iq9544Q2qE/YYqb0QtRwowntkLTki7b1/KBFxbSyHwGqk55kc0QUy8rxIu
X-Received: by 10.55.16.147 with SMTP id 19mr61372875qkq.255.1481151119068;
 Wed, 07 Dec 2016 14:51:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Wed, 7 Dec 2016 14:51:58 -0800 (PST)
In-Reply-To: <xmqqvauvuzna.fsf@gitster.mtv.corp.google.com>
References: <20161207210157.18932-1-sbeller@google.com> <20161207210157.18932-5-sbeller@google.com>
 <xmqqvauvuzna.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 7 Dec 2016 14:51:58 -0800
Message-ID: <CAGZ79kZiS9dx6QUOcFYh8sSNoVsrv2eNLXJd6X54UekzUiC8VQ@mail.gmail.com>
Subject: Re: [PATCHv5 4/5] worktree: get worktrees from submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 2:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +     submodule_common_dir = strbuf_detach(&sb, NULL);
>> +     ret = get_worktrees_internal(submodule_common_dir, flags);
>> +
>> +     free(submodule_gitdir);
>
> This sequence felt somewhat unusual.  I would have written this
> without an extra variable, i.e.
>
>         ret = get_worktrees_internal(sb.buf, flags);
>         strbuf_release(&sb);

Yours is cleaner; I don't remember what I was thinking.

Feel free to squash it in; in case a resend is needed I will do that.

Thanks,
Stefan

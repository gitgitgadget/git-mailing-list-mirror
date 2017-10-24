Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10C651FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 15:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932141AbdJXPcZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 11:32:25 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:48193 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751369AbdJXPcY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 11:32:24 -0400
Received: by mail-yw0-f175.google.com with SMTP id q1so15422716ywh.5
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 08:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=i5YlRHeBvbghO0+qeUQnBsZDVFv9aenVBh6zmoKY/go=;
        b=Wpwf9gXok0M3N+D//H6hk0zd5B/EKm8fPMUYQIp1EwB3ZVHEAwTy+dAEyfPqvERTk/
         hPbANeL58QLuYHaKj2jfW6/rZED13BGf9u97dLSDErHj31jsu3lSEEvZRs8uKyKfsG+u
         35oX+Z9maVi2caxKv7E9LIFcBrD5lW7OsbcsC8IdLeT2hbniJ722SpWR9O6K5Ixp2fev
         DAZdu+IHFLDvMW1FIu8P6wIus7OPu9jbqD2wDIOHCWk0/0ZlBBVPApakzD9z/xbrVIyl
         wi5A4voVU8FVbxsP6wINnjF6bcydGGvIr9yb0EojTGGVDN4mEa4jEapXMAf7OdIdDK02
         2t7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=i5YlRHeBvbghO0+qeUQnBsZDVFv9aenVBh6zmoKY/go=;
        b=MuKefWcU78/NlcOY8gqQkeYAdspYBjdMNSQOpiF3op053p68KrcUL6QiJsq6QKdITy
         MX3owOviTtN0ihFlfUzggC8wZqQkDcd3oAGIhe4dVbLbt2RrH+h3rxFK3K7kWQ9G2iYf
         I0wrVBQVevyzbfNhomBv8Y6LQ+t0pAjbd4+0th9mvNKtxTs2hwQNKRn4Gfa4nRRkihiT
         43F8AfV+c/7f9sJ/wwBJzIgdNMWeSp7z9myIOcI31yWuLNz+seQRWFnDYpdLkqF51NNo
         KIagm76mUDMfpCeDqSymIX3YqPbSkUnAw0XCT8WtCQkenUzapZ4+VUg9lgX8cLxTgKAK
         1xHg==
X-Gm-Message-State: AMCzsaWQBFPgbPywPJjyBDGjEjGx4ewemNrRN80iYekqJvk/zvO0Y33T
        OXdie5tmjF0ImxAlun21cCaX8ciJJW8hs+lMXHo=
X-Google-Smtp-Source: ABhQp+QZr3gqOSSGc0oX+gyjlzKO/jRpwaAjGejy6ATzK7CrB21IwDsUMPVKpSCs6D30IU8bHcrazYtp8MSml97atWI=
X-Received: by 10.129.83.198 with SMTP id h189mr10906113ywb.260.1508859143703;
 Tue, 24 Oct 2017 08:32:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.95.73 with HTTP; Tue, 24 Oct 2017 08:32:03 -0700 (PDT)
In-Reply-To: <CAFA_24Jov7FDw7AxUtFDV6avOj40LD6ptEVMPpVuSdAo_6L_1A@mail.gmail.com>
References: <CAFA_24+svnt4uSpx1tjj2t6iAt4G3p9UvrxahEYj=VZWeJxC=A@mail.gmail.com>
 <CAGZ79kYbeVcpEXsei8Lr=Zw+YgJE_E4mBSRWYcYDqOWz20z5oA@mail.gmail.com> <CAFA_24Jov7FDw7AxUtFDV6avOj40LD6ptEVMPpVuSdAo_6L_1A@mail.gmail.com>
From:   Max Rothman <max.r.rothman@gmail.com>
Date:   Tue, 24 Oct 2017 11:32:03 -0400
X-Google-Sender-Auth: _mzSx62tQNnpH0F2lZvKIrd6cLM
Message-ID: <CAFA_24JGE=MyRFYwZ_zKsFCt_xFVNqrmagMBQBam3nHhdO6Gzw@mail.gmail.com>
Subject: Re: No log --no-decorate completion?
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just re-discovered this in my inbox. So is this worth fixing? I could
(probably) figure out a patch.

Thanks,
Max

On Thu, Oct 12, 2017 at 1:41 PM, Max Rothman <max.r.rothman@gmail.com> wrote:
> To be fair, other --no* options complete, it's just --no-decorate,
> --no-walk, --no-abbrev-commit, --no-expand-tabs, --no-patch,
> --no-indent-heuristic, and --no-textconv that's missing.
>
> For example:
> $ git log --no<TAB><TAB>
> --no-color         --no-max-parents   --no-min-parents   --no-prefix
>      --not
> --no-ext-diff      --no-merges        --no-notes         --no-renames
>      --notes
>
> Thanks,
> Max
>
> On Wed, Oct 11, 2017 at 2:09 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Wed, Oct 11, 2017 at 7:47 AM, Max Rothman <max.r.rothman@gmail.com> wrote:
>>> I recently noticed that in the git-completion script, there's
>>> completion for --decorate={full,yes,no} for git log and family, but
>>> not for --no-decorate. Is that intentional? If not, I *think* I see
>>> how it could be added.
>>>
>>> Thanks,
>>> Max
>>
>> Using git-blame, I found af4e9e8c87 (completion: update am, commit, and log,
>> 2009-10-07) as well as af16bdaa3f (completion: fix and update 'git log
>> --decorate='
>> options, 2015-05-01), both of their commit messages do not discuss leaving out
>> --no-decorate intentionally.
>>
>> If you give --no-<TAB> you'd get more than just the completion to --no-decorate,
>> but all the negated options, I would assume?
>>
>> So maybe that is why no one added the negated options, yet?
>>
>> Thanks,
>> Stefan

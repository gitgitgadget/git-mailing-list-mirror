Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FBBB1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 19:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936048AbeFRTlv (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 15:41:51 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34316 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936040AbeFRTlu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 15:41:50 -0400
Received: by mail-yw0-f181.google.com with SMTP id b125-v6so6067549ywe.1
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 12:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+fjPbfe35/S4PvmaWSrSekcPE/zz73r/DcZcrV6iWkY=;
        b=FkJfMXo3O940YsWf7jqc343HGPpo5JTXG8KKYPhOjyHGowV/GjN+CNb4j7igJ+cpzF
         Cq87gGpq/OIWxkzFTJmoAc5qk6Ets5bDz/+mkx4HkYffU2s+cMARewcwfrtCz7tQFLIC
         5d40RFySyT7dYD1f1W24wBxvqab65pp4IVw6c8WadwGW5l6z5YFTGgObxif9u2RsuDJ1
         U8Im0mu3PWABB7zbD1MhF+7pUd+XnPiYR3+s8XZ9+S2ugKJ7j7KsQoUMtQvt4Egxq31g
         +udFRxuo5LqmUFTfhZUub9M0/8cGvIuJC9OOsavT9fzNs3peFOlDtSJUxGAF1Qi6/Fln
         w6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+fjPbfe35/S4PvmaWSrSekcPE/zz73r/DcZcrV6iWkY=;
        b=aqcVYmzbxDhRdRFc0vAmZjP5dtqPLOg3ItP9WZXiUw1ETfcm9sFmfluI9AFBAmSKy9
         sudHb4Uy+dO/oSHLe2ihaVeu8cNxeQ7HPOM173u1UqWAl0IwJkBV8IZebEH6yy2i/4UR
         2jSdtebv2/qXMpApUaOyrdikXt6xhMJILUHfDmbNgM1kRyEMAonTNX6XxNgPDSrEwVtu
         1XX6vkMsFrUGK49qlg0sh3C6oSEA5w/gnuzCN3mxd8hHFsbkW9wx0M5Y/sOxM6asxA0k
         ZuWnJcqxgg9wQPT+CHOl7wNCR2BzNjorVDOeNWMpuuD5EY1nMLHTFrYWzI9/e7TSM3cB
         0ilg==
X-Gm-Message-State: APt69E3cHMzioX6iv7dGLK1xrJmcCmSvPK8zsBJuyj6JuReN257wL2qc
        yE/QenC1r2ui78OzSm4PX6e3RVKImQM34Trt15O+ZA==
X-Google-Smtp-Source: ADUXVKI3sOf0BKXjSkv4SH8S9t/IUKOBg6oekIfznU/ujyFQ33PJXduaD94600rN/E1uFtzdw8K9ItFRzOBxk/L/vKM=
X-Received: by 2002:a81:3743:: with SMTP id e64-v6mr4746079ywa.340.1529350909305;
 Mon, 18 Jun 2018 12:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-3-dstolee@microsoft.com>
 <CAGZ79kaDiXnAuRym3HHQPEZh9z0-sPL5V4Yur5-_RojsyLJsYA@mail.gmail.com> <a0dbd78c-507b-3005-c2eb-2fa82e7d29ec@gmail.com>
In-Reply-To: <a0dbd78c-507b-3005-c2eb-2fa82e7d29ec@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 18 Jun 2018 12:41:38 -0700
Message-ID: <CAGZ79ka+RA2jUb-VmDMGwCN80LARTz1Ku5ZMP-PbabEhpNtGCQ@mail.gmail.com>
Subject: Re: [PATCH 02/23] midx: add midx format details to pack-format.txt
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >> +       (C + 1) * 12 bytes providing the chunk offsets:
> >> +           First 4 bytes describe chunk id. Value 0 is a terminating label.
> >> +           Other 8 bytes provide offset in current file for chunk to start.
> >> +           (Chunks are provided in file-order, so you can infer the length
> >> +           using the next chunk position if necessary.)
> > It is so nice to have the header also have 12 bytes, so it fits right into the
> > lookup table. So an alternative point of view:
> >
> >    If a chunk needs to store more than 8 bytes, we'll have an offset after
> >    the first 4 bytes that describe the chunk, otherwise you can store the 8 bytes
> >    of information directly after the 4 bytes.
> >     "MIDX" is a special chunk and must come first (does it?) and only once
> >    as it contains the version number.
>
> This sounds feasible, but unnecessarily complicated. I don't think any
> other chunk will be this small.

I was just writing it as a way to test if I really understood what you said
in the doc, not as a suggestion to incorporate it.

Stefan

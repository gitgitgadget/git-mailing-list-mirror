Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE57A1F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 23:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbdKMXL2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 18:11:28 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:53449 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbdKMXL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 18:11:27 -0500
Received: by mail-qt0-f174.google.com with SMTP id n61so21692611qte.10
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 15:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ezdHhPbkVCD7ntOUQq026Uh1fB0y3BwKttSsIFBMpEQ=;
        b=pLAF4M1cul6iBs6vlHdtA7avXaLbVHV/jlG/nEgE+CetjYRSAUjeuXnoh6Gh5M+4fe
         rlrlqMg3Se9ph8Kg7a4DiyxmRs9bt4Wyic2oW00TxM8d8Vk4zp7R3PI5c9dGLtEo08WK
         hfa3d6XuNoDEG4I6PmNPuZmVm3q7TdTQZJAo30p5TEVTsIpnSfMqjdkgZSuoK1s/VTHa
         I74gZUx9TNQ2CtS1eLAZc9nwRvKI/4P8/wgQxoRyDBxdxgWaZjc8u/inyESgODXm7ssU
         w6n/KjiCByQPpHEKzFHdCCF7l8TlvwylPyEPgEDWPcAaUKpdCcA/Jd2Vh3w1FkljJMs6
         W22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ezdHhPbkVCD7ntOUQq026Uh1fB0y3BwKttSsIFBMpEQ=;
        b=OePKyLAMOh5msIs9GqhjRSYjnBK4bTUCAL8jpUPOSaefRlDuGa8McMtcsBwk7Nyfar
         bgoEHhXpnmXLsxPFec4ZoTfZQ+TKcXCIXxrItgaL/iU2/qHDLPpb3d3GkbJe4Q/Ikfld
         KdX+yzpIP7zDMSP+KL1Ntjg3q4to70wG+M1siTr7TZ+0cCmr1Ai3rZTQ8UOokCki1IHh
         zKcGHX+bwFwRYJhULgLt6KuCgL+ByidWt4l7dJyQYZf5/w+M/8xBrQzI4itZOT0hoG+1
         KbjWSovz03IsA+ahKoDZAyasCrdSrrLk0o65f+IGeWesN+ttOiemBFmhaiE7zpOP9lWb
         LUOg==
X-Gm-Message-State: AJaThX5IfbeuOkWPBJzNc/wgrozQaGVJU5h2Eut0h4mD9EipbcMPkn3C
        chBx3zBZTvkbVtoxZm4y8pdZ0XdxRubJdrCIrEKRcA==
X-Google-Smtp-Source: AGs4zMaxVKKzagLn78bFy8Vx6X+nzw+FXjmBax888DVT4xzEPbrjPmcwSqaJtfpl/cpMkwYM6xH7oDrEhLut6VCJubw=
X-Received: by 10.200.27.225 with SMTP id m30mr14897753qtk.260.1510614686691;
 Mon, 13 Nov 2017 15:11:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 13 Nov 2017 15:11:25 -0800 (PST)
In-Reply-To: <CABPp-BFSt8NGSzkoJdhst_NHqx_hVGMzO-688SOdYRB413Zd9g@mail.gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-4-newren@gmail.com>
 <CAGZ79kZ7d7fMp3Cw3Yy4bq9-Mh5Z_jhM5XDQbkVLoqzm6ONzDg@mail.gmail.com> <CABPp-BFSt8NGSzkoJdhst_NHqx_hVGMzO-688SOdYRB413Zd9g@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Nov 2017 15:11:25 -0800
Message-ID: <CAGZ79kYD8QjLDsF8APBP8P-WvAz7NBhnh6vbkr8xMnzW7XAm9g@mail.gmail.com>
Subject: Re: [PATCH 03/30] merge-recursive: Add explanation for src_entry and dst_entry
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 2:57 PM, Elijah Newren <newren@gmail.com> wrote:
>
> Perhaps:
>
>   If 'before' is renamed to 'after' then src_entry will contain
>   the versions of 'before' from the merge_base, HEAD, and MERGE in
>   stages 1, 2, and 3; and dst_entry will contain the respective versions of
>   'after' in corresponding locations.  Thus, we have a total of six modes
>   and oids, though some will be null.  (Stage 0 is ignored; we're interested
>   in handling conflicts.)

I find that much easier to read, though I am biased with prior knowledge now. ;)

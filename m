Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20A771F453
	for <e@80x24.org>; Thu, 24 Jan 2019 21:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfAXViL (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 16:38:11 -0500
Received: from mail-io1-f73.google.com ([209.85.166.73]:53228 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfAXViK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 16:38:10 -0500
Received: by mail-io1-f73.google.com with SMTP id h7so5934663iof.19
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 13:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Sd+PnwTN8DOurts9v/jUVKL2TeLDjArNuiEyZJ2qS70=;
        b=l40JPT0uUBaau0rYFPvoHXo/pR56WIavvdp3MiWh9101Ujqi7dV8r8YAxDW3Ulp1Rp
         a29d1RpeUFabE7GDcnwBS4tj4JkfiAlS8sAb35j/QaTT3MEquqE8U+Aw7Ozr3kgYVJAD
         kVlGfjJvJ7uZeAeX7SBmBk0/iAQ5pfDHTzOQ5zf3VPB5+HOH9M0nB3p3cc3QqnhRTF9p
         3T71NjA76qIevXVtUWHim+rCKNsD9Oo7/H3NgOeUbe/9B82TT8twJZ38y21BsWfjF3LB
         nMeslo7HQueeHGZ2QjNJ9r4X9EdqjjTeWLBwzHCdKYvIB4Lo7HiqcGOEHl2eGSW/QhYl
         Stww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Sd+PnwTN8DOurts9v/jUVKL2TeLDjArNuiEyZJ2qS70=;
        b=sZyTcOXaGbaLgyLE+SJU8sU5D3tJ1SM142+afCCzzigeVJfHS7UGpaSetUgo/jpfoY
         yeHYLwDXaENxlzM5+wfS6FgGRc3vUTZyzhW9G5Fzb/NgtxZbymWUGOuNs/DqqEsDweZr
         4z6AVPLXqHnIBT9K9wYzdsaFSI0ROxEWGsehzR8h0yckH2aTDUY2MSbIYcplwgR1zqQY
         GAQb+v0sdSeS1jV2Jc6/hYshkVIo8jc71PnnkEzHfnE2b24jWc9c3RzRzOZEC4qJLhHf
         TAU+MBaWR3JI/rrhs1kAuuT/WtIi8Xv6S1/Uz7ek6o2s7MJYkv46Xg8g2KbSN+fBgyFL
         vgXA==
X-Gm-Message-State: AJcUukcweKRYxXt+9aM6Drjo4uc41pUljxjfVPMnGcOZtPJCH6YpaTDV
        UA9evMHeaK7Crw3iDY/SqTjGW3WgWOk3k7he9QlV
X-Google-Smtp-Source: ALg8bN4tcHn2LCzqsyEc8+sZvPqLp4Dtz8dTmQJRHc7yl6BuG9V9Z2/jAxaEdt6W/zVrWfGNuvARVdA4HYVpsu3AOqpU
X-Received: by 2002:a24:e387:: with SMTP id d129mr3514034ith.40.1548365889935;
 Thu, 24 Jan 2019 13:38:09 -0800 (PST)
Date:   Thu, 24 Jan 2019 13:38:06 -0800
In-Reply-To: <d3194048-3907-71d0-1e81-490707f39ff2@gmail.com>
Message-Id: <20190124213806.179907-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <d3194048-3907-71d0-1e81-490707f39ff2@gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v3 7/9] multi-pack-index: prepare 'repack' subcommand
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     jonathantanmy@google.com, gitgitgadget@gmail.com,
        git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Thanks for the suggestion.
>=20
> It is slightly wrong, in that we don't sort by size. Instead we sort by=
=20
> modified time. That makes is a little complicated, but I'll give it=20
> another shot using your framing:
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Create a new pack-file contai=
ning objects in small pack-files
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 referenced by the multi-pack-=
index. Select the pack-files by
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 examining packs from oldest-t=
o-newest, adding a pack if its
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size is below the batch size.=
 Stop adding packs when the sum
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of sizes of the added packs i=
s above the batch size. If the
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total size does not reach the=
 batch size, then do nothing.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Rewrite the multi-pack-index =
to reference the new pack-file.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A later run of 'git multi-pac=
k-index expire' will delete the
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pack-files that were part of =
this batch.

Thanks, this looks good.

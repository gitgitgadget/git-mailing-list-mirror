Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 217A01F667
	for <e@80x24.org>; Wed, 16 Aug 2017 12:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbdHPM2g (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 08:28:36 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:38715 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbdHPM2f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 08:28:35 -0400
Received: by mail-wr0-f169.google.com with SMTP id m57so14341792wrm.5
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=bLsWsfiD/ZN0o4ysitaE+2hNRxOzqZAjuFyd4YWtIMw=;
        b=cHSwClrgcSu0r+7o/9B3ILhRxr7KuoI2X7XVgOKJO5lC+dY6NUfUja3sYrZrK7u+02
         2x3GQRFOfNERP3n8+qZjbpAKYDbEOMBXQhcUrVIso9nN84ZAnFpHc9Xo3IzKIp4eBDYj
         mF9JayXCaQ/YZABqa8ILuR42YAZkCWo/+ukKLtzSA9Ru7IOl9d40gce/2FXRey6NNKxr
         LKO5QvwyYixclDxFKcYg7LUhPgEWXLVm/SYc5PWROiTnBFjq5yGIXDKcXAjZ1sgdH5XS
         GWIjfyUExj9fGRIUVLVBh2gj2oS7E96sfKSjx6Q2z/OVS+RNaEy1e9pNRFXtQV7SmKVa
         HyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=bLsWsfiD/ZN0o4ysitaE+2hNRxOzqZAjuFyd4YWtIMw=;
        b=BE0vYZCB2PJG0dLNjGqJo/m8ctWvSnvO6KH7Ivgx5+h2kTvB+3NyPUAM6R2NF94Oqb
         XLt0F7oCn2iU+TNUVuI+ia7s2nFZKz8f4zcHFcZm4Ue0w0N6n6UD2tjt1tEKW1HU8fCk
         14Phng5z6BQYCLoQ9EPx1cEHBjhZ/4xQajrnZGFxP1IGwBSZRP7YeIg/v1BtFoOZAaNe
         SDQN0R0qVsljAKc3mExdYQcvP/qFm1v/MP0W+lMtjpfNGNMYeB5xVox/E/GWBd1lGQSU
         XwavNAr6FWLnRLkn91Lqqo4119U9hOps355H8keMxdvJhB5zsgaQud0V1p85D6eMgtsm
         GXoA==
X-Gm-Message-State: AHYfb5hDoEOv5L0G8/mQI1gi2bQeWj4Ig6AztETcbysr/om05oL56IB/
        6pErYZrEulQHWxayWlsqvw2BGlspEQ==
X-Received: by 10.28.107.144 with SMTP id a16mr1060556wmi.178.1502886514567;
 Wed, 16 Aug 2017 05:28:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.24.130 with HTTP; Wed, 16 Aug 2017 05:28:04 -0700 (PDT)
In-Reply-To: <xmqqshgsr8kn.fsf@gitster.mtv.corp.google.com>
References: <cover.1502796628.git.patryk.obara@gmail.com> <945cc94bedab645885f9025cee51efd8205a69a4.1502796628.git.patryk.obara@gmail.com>
 <xmqqshgsr8kn.fsf@gitster.mtv.corp.google.com>
From:   Patryk Obara <patryk.obara@gmail.com>
Date:   Wed, 16 Aug 2017 14:28:04 +0200
X-Google-Sender-Auth: pr_O2-9OljWN1du2fkw1xvMzeUA
Message-ID: <CAJfL8+QBO261M-twofEqaXA6i77n91AK_vF7a1JYh_6aith0qw@mail.gmail.com>
Subject: Re: [PATCH 4/5] commit: implement free_commit_graft
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> I do not see a need to make this new function extern.  Shouldn't it
> be made "static" and revert the change to commit.h?

Ah, of course :) I was anticipating to find free(graft); in more places
throughout code but forgot to get back to it once there was none
left.

I will change it in v2.

--=20
| =E2=86=90 Ceci n'est pas une pipe
Patryk Obara

Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A407C47255
	for <git@archiver.kernel.org>; Tue, 12 May 2020 00:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9928B2070B
	for <git@archiver.kernel.org>; Tue, 12 May 2020 00:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="xaXxm223"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgELArr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 20:47:47 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:21974 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgELArr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 20:47:47 -0400
Date:   Tue, 12 May 2020 00:40:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1589244011;
        bh=9iiKvVHx/LhbQXTUPoPASBfZNFLQ3pgbQ9oXyCozA3s=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:From;
        b=xaXxm223jH3Dl38uOj4V7g88Xoo2Zt+Y4YrQeZqLnTRIA2+iPSDZHY2ZLB1rxQs/f
         TnDYV7TGqsHCUSAfZ2XNY1+uBtjb116sXtIkHnVaQeoKV8CI70sycbQoHcnzptrOGQ
         E3iMe5hBlMlMX7CG70cFlyD/MC6Sgve6OS7wHnSo=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   David Moseler <davidmoseler@protonmail.com>
Reply-To: David Moseler <davidmoseler@protonmail.com>
Subject: git-credential-store does not work with a file
Message-ID: <uBc-Htk5XJFPF28aiZsQUIowfd66Ay2NiCyVbxkWpD77ugn3k4LBLse-jm0Jf4HpAKMWt4chuRAbxskeczZpj_pEnUaX_XOrmhfYksCeVLw=@protonmail.com>
In-Reply-To: <56HlWgfQEg1t99VKZaFZqhdcjAs279HXXP1gQ9YzZGOGcR9jEzSVYgl3flvbTiqSet2HB0gc6jotcDmYbtDipE7k0-QbdrzjgxiKZBnIK_4=@protonmail.com>
References: <Wc7NKqbl9k45DWha23OG_TvVA4Ftq3sOCiHScVXhmAbCPOaz8pkEqQrPXw_JBC8G7g9CrIKxwfE8pv8Nr9Dcw5J0zA7fNCAi9Mq1OnxhpMg=@protonmail.com>
 <56HlWgfQEg1t99VKZaFZqhdcjAs279HXXP1gQ9YzZGOGcR9jEzSVYgl3flvbTiqSet2HB0gc6jotcDmYbtDipE7k0-QbdrzjgxiKZBnIK_4=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm using git version 2.17.1. Providing a file to git-credential-store, suc=
h as in

git config credential.helper store --file=3D'./git-credentials'

is not working. When using this command, git writes to ~/.git-credentials i=
n the home folder anyway.

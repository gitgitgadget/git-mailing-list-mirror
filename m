Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6A12070F
	for <e@80x24.org>; Sun, 18 Sep 2016 12:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756552AbcIRMbe (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Sep 2016 08:31:34 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35925 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754166AbcIRMbc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2016 08:31:32 -0400
Received: by mail-lf0-f46.google.com with SMTP id g62so89109955lfe.3
        for <git@vger.kernel.org>; Sun, 18 Sep 2016 05:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=YZLq++bMR/S7Q2xJJPTocW8odZBZb96hDNmVL8MVEhs=;
        b=G7nmdfeLFUp4WGw0JynQClNq4/6psOs/lFl9Y/XmxrZxRI+wacpu3TJX8yzmfNKz6J
         xwiE8LxYQulIHkNKRf7W+9VNEKpakJohN+V9YJ25K9Ycwl5njxjHJ4NjLzK8RVlr4meM
         p03PC/hr5ZcJa3LidG2uWx6xwyHmuXDgFdxP0YLzJrdz+uQbfbbnQO5RspsQPywWxfZD
         hCtEDV7wxx0jfWd4rVh+Nz3DZt3Y3LofzJvSseUjrIPxxOtrI2DukVKMKfnhdtdHkUvF
         kA+1d9zx4OeWs0TLRKIYqz4rmTszarDU7AHHlUeDKvolFBCH750P4mWpKPn5GtFOTiwQ
         86BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=YZLq++bMR/S7Q2xJJPTocW8odZBZb96hDNmVL8MVEhs=;
        b=bk4m0vxOmvKoK7Iw2Yn46QdQwzGfunNFPEVg5256CBR5DGeizBNSmxIQRma3gvBSNw
         i8CyDtxoulDIYTyb7V9EnYKa9cbRV7R8W76MC1+H6y04FLnDzWYPab/NM3gx8wY5IGOp
         iacqOpBVq2L/q+JPAzsugRMcuq3/y4LBS8E5wLycu7lZ9MCypXUM/YtddF96YjFEFZd1
         raT8NJ7AXAwUkXuEdQ0yErZf30l3e0b1opdj97v8vWAOE3aTrm4pfh7hS36blkLDTi/g
         /cU7ck5NHOP0zgGrbDkCeGbPjqAHGxKnM+lvlFzmJsgiXoLRQGYAj44jrpOh27uoeLjk
         a8Pg==
X-Gm-Message-State: AE9vXwNR+xXd3neZP+pv99bo2BYxLLZLHORMnZVllDLAoHx3iRx11EJGlMNRJnCveL3+MYdmp6f2qsynmaAKug==
X-Received: by 10.25.18.23 with SMTP id h23mr2093680lfi.5.1474201873522; Sun,
 18 Sep 2016 05:31:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.173.193 with HTTP; Sun, 18 Sep 2016 05:30:52 -0700 (PDT)
In-Reply-To: <db20ae0c-9c33-1e65-b201-1b6a9ed11340@web.de>
References: <nrje96$q7s$1@blaine.gmane.org> <db20ae0c-9c33-1e65-b201-1b6a9ed11340@web.de>
From:   Anatoly Borodin <anatoly.borodin@gmail.com>
Date:   Sun, 18 Sep 2016 14:30:52 +0200
X-Google-Sender-Auth: FKTAjygm2Ol7JhrMegfM8oG2j-o
Message-ID: <CACNzp2mkD7Se9R=SVwXhyRstkGAs1N9YbNgaZRQYKkpPM1kj8A@mail.gmail.com>
Subject: Re: Two bugs in --pretty with %C(auto)
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ren=C3=A9!


On Sat, Sep 17, 2016 at 8:25 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> I'm not sure how just how automatic %C(auto) is supposed to be, but you
> expected it do emit the reset for you, right?  Sounds reasonable to me.

I don't see a good reason not to do so. Spare some bytes?..

> The following patch implements that behavior.

Thanks, the patch works great!


--=20
Mit freundlichen Gr=C3=BC=C3=9Fen,
Anatoly Borodin

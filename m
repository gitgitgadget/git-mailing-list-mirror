Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F7091F404
	for <e@80x24.org>; Thu, 29 Mar 2018 17:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeC2RXt (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 13:23:49 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:39600 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeC2RXt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 13:23:49 -0400
Received: by mail-oi0-f53.google.com with SMTP id q71-v6so5822559oic.6
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 10:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bl8hCEqBPVdvP/TPlkn60cSsQ2dV99sE8lQtt2fKWJA=;
        b=AnT3GRhqHQrGBHYepv3iu4ym0rfnUqikAEb9hkDkRBQm9kRvMjs+huf4W5jSMckDu4
         gp9FG0YyW73R02GcvnefXrexuWoIG/WNlkRto8LB8plUeUvkITb3p++2n7vRN5mhEBJ2
         1lVvZ4a9c2Htps8gnnxRahTCw9RwHrjLrYv5vL73Up2MLgYkW/ucx5k2QTdeg+o/eqI3
         yhiixEepm4JpPz9IkurnSSTE1/Ji6q5Tiians/4yc1YCdxU8r/FK6L3CWjxR9MI5DU6H
         5Y5Jtr/wEleryw2cr6xHsnwCSMKi5pqJawSKlUfCJNMu01M/++N9PfZEoDeoNkQuknmt
         7IYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bl8hCEqBPVdvP/TPlkn60cSsQ2dV99sE8lQtt2fKWJA=;
        b=tU2a7TOckYsNBkz/pqWtH/xynI3mWfhdUkt+Dbe0vm9uZgqcQJ+HE+B1debgurOE27
         Mo1t9bjQ8l3QsKMU/SMo6kENggHKZjtKwd4sLS8AXknEo/rBGL6FeYM64/9yRD1akGVl
         bdc1Q2p8Fv82xxikFHK6dBghfs8Y1zFwnzXR1LemYs8f2yCp42BgR7T+tNt7fdHTsBgR
         QzLg+x25B0FvDcTA6ltwyjbHfuNBbU7XrtWFji1Xdo0zOm/qVHSx7JOxBWxW5/B0x0i0
         TEgX+p/wVkTy3Qw9IJzJTkSm0+WIGKLCsML7JsKN7LZzlkzPc95u63OZwdVw1cV4+QNN
         mIog==
X-Gm-Message-State: AElRT7FN1sjsIUZijbINVND2+uEoNn7Bz2BSsbd+w1nvPUUj1ABzegeu
        3Z4lfyZte5G7y2projPVr4djbWILTMQqdCsRMmo=
X-Google-Smtp-Source: AIpwx48xW3ENrokAea45NaKzYqHMeU3QedcIlO+CwRp0bWg9EjCAeVbbOHlLY3eKzklNLnniZNQ5T6goANpDEzJyEG8=
X-Received: by 10.202.243.84 with SMTP id r81mr5148636oih.281.1522344228437;
 Thu, 29 Mar 2018 10:23:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.211.131 with HTTP; Thu, 29 Mar 2018 10:23:17 -0700 (PDT)
In-Reply-To: <CACsJy8CAjb4zdAgD5H9OZOAoHdrRFzGm9gaL8Wbna+GXJJCW4Q@mail.gmail.com>
References: <20180328173656.GA29094@sigill.intra.peff.net> <20180328174215.GC16274@sigill.intra.peff.net>
 <CACsJy8CAjb4zdAgD5H9OZOAoHdrRFzGm9gaL8Wbna+GXJJCW4Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 29 Mar 2018 19:23:17 +0200
Message-ID: <CACsJy8DP_D14ZwJnNjkqPDBXCyXYkW9mK_boqZDRxiTUFhMmMA@mail.gmail.com>
Subject: Re: [PATCH 3/4] set_work_tree: use chdir_notify
To:     Jeff King <peff@peff.net>
Cc:     Rafael Ascensao <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 7:02 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> ...
>
> It's less code this way, but it uses up more of your (or my) time
> because even though the first set_git_dir() call actually happens at 8
> places. Is it worth trying ?

Never mind. I took a stab anyway. The setup code should have much less
side effect before we can do stuff like this.
-- 
Duy

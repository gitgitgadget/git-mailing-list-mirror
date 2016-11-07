Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6D4F204A0
	for <e@80x24.org>; Mon,  7 Nov 2016 05:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbcKGFgT (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 00:36:19 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:36266 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbcKGFgS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 00:36:18 -0500
Received: by mail-yw0-f176.google.com with SMTP id l124so124926734ywb.3
        for <git@vger.kernel.org>; Sun, 06 Nov 2016 21:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lpfXs/anBlSTQO3wOeQ7kS9Tld5PWyBGoCa9wAQGvYg=;
        b=V4DWFBmq2etpjwxl4gD5uvYHshqW+xx36r44Cu5gswe0f2S+f7dQVwfbn/lGPwRTC9
         SHvzJD3ByvAeAwTAxykQU3o5Myw6ptsT3mDxCfj803qJ6c3sxD05dmDBOkIOf71p+F+5
         e04hbbnJXHJkZp/uRJCuAYbBsVdfdU5JpkW3wJLzJ+TBcOJN9TROUz2n66GnZIWEXnyU
         CTLv840svP+CwThWb4hFJjLn/81bJpJsm7W9mnaUnVcSYP18yo/eynhuyuTofGtn40X+
         PHfH8fHHcvBFmPxgkZrTOeT+ps1y46EcH5bG9diMhZ2OImd8E7WZXVd0qgnmAiagO8IX
         y2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lpfXs/anBlSTQO3wOeQ7kS9Tld5PWyBGoCa9wAQGvYg=;
        b=bulDiqG6jv3VEhF+FyCnr2G9f2yLSWOe6UfV6OZsy9sodyTttH33uvOrFzd3EHbj+9
         FKXsPa8dmxPzkBupb2yeWzHWmNiMPltotvPsXVwOSqYu3N0gA/k8nS8C4WxNQew4pb9p
         0JXsbnNzWdGXfbuXCdtLNpEolTKWFSy7sHjmNZCI/WMOmhLlStBDYzm/DKMfwhsSDS7k
         zhskxjhXf4jmhCyGM1y1k9CFhEjXZWctplT0iz0EJpaO1hemBvhQQz1Z2WoPALuOMFjZ
         qrlxigLXV7qVkr9g3mqpDSh1UPZYjQ/dmQbAkC64VnQStxeJsojkCJzTsZzeQ72Hf3oX
         S/3g==
X-Gm-Message-State: ABUngvfsitKnkKvEN4HPedzADTnSdu6RQRUE0D1qHu68+dO6vR+u1KDr9856UwktErGBQuZZXMGrgzLNl97XHA==
X-Received: by 10.129.102.132 with SMTP id a126mr4082760ywc.160.1478496952881;
 Sun, 06 Nov 2016 21:35:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Sun, 6 Nov 2016 21:35:32 -0800 (PST)
In-Reply-To: <20161107011841.vy2qfnbefidd2sjf@x>
References: <CAP8UFD0bqNQZ3nuGUDX0qrSo44hf1NL9LeZB_FQcXg3j0mD38A@mail.gmail.com>
 <CAP8UFD1EZ8HBzLAeyFBFgU7n2uJpswqgEgA4XM1YJuRAG_ZAAQ@mail.gmail.com>
 <20161105151836.wztypzrdywyltvrc@x> <CAP8UFD3XFHr7POKmZr_6guapC6sme3GvWBV5vPw4XO7FE5HOPw@mail.gmail.com>
 <20161105202553.migx75gfuujakqyk@x> <CA+P7+xoG3ag8dj7s_NRoqz-EwjVENSJSzE_qj6gnW-SmWt0bgA@mail.gmail.com>
 <20161106163410.ilysej5r6qd3744e@x> <xmqqshr4cyy7.fsf@gitster.mtv.corp.google.com>
 <20161106173311.lqoxxgcklx4jlrg7@x> <CA+P7+xoxjwvjXrW0Pwh7ZK-OYBiYamPAxvf_=zqJOsQ8xWDPWw@mail.gmail.com>
 <20161107011841.vy2qfnbefidd2sjf@x>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 6 Nov 2016 21:35:32 -0800
Message-ID: <CA+P7+xpmC8AdjEL59S_bRbf5QAsk=fO9-d1kmrSppTaJLVL2Fw@mail.gmail.com>
Subject: Re: Regarding "git log" on "git series" metadata
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        "Shawn O. Pierce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 6, 2016 at 5:18 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> Once we have gitrefs, you have both alternatives: reachable (gitref) or
> not reachable (gitlink).
>
> However, if you want some way to mark reachable objects as not
> reachable, such as for a sparse checkout, external large-object storage,
> or similar, then you can use a single unified mechanism for that whether
> working with gitrefs, trees, or blobs.

Fair enough.

Thanks,
Jake

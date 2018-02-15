Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECDBB1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 21:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161121AbeBOVJW (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 16:09:22 -0500
Received: from mail-yw0-f177.google.com ([209.85.161.177]:32832 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161109AbeBOVJV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 16:09:21 -0500
Received: by mail-yw0-f177.google.com with SMTP id x84so771462ywb.0
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 13:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=omL60MSQSRuG37iih5mF9jT6/EzHxqxGLaCvFZxqev0=;
        b=gd/B2EBBBpexPC4Fhx8kO24n+vIkfl5pdpxZIsvbFI4eQMgZWQL2HAI2nu+L+m5LsF
         e0U/NN958A/PGfdgF5WEyqwxsAYs9/YLRtkFgaM1YSMRd2DTYv3XNn9izKAsrnpYuEMs
         DYIP85UfBMux8WPZQk1N8Mobn97RZNDonEq0O12WtkP2KjfpNVaOUm4SOuc7pWaL9VuG
         XZqkoA/qN/vn0OZFwNdTB4y+Nid0+Z6ApmDlCtP6y+U/5awQ7WtvKobEVB1TxfwoVgFM
         G7ERey3l5fdWfoXFSmGCzciCLUeXy5L9ABYToF14xwsRD1rr804mJ8SsmTnP6i9L/O41
         xxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=omL60MSQSRuG37iih5mF9jT6/EzHxqxGLaCvFZxqev0=;
        b=G51aZp/MqOZU9ZnurGx1FpOaNdHsOUd4ihGgKdtufrooV5kpUKRlxUBWKyuOnmILyK
         Dyi1SAgPXIlfYJ99Ju4lCH8mnyQKCDwalpbvuGc/lzg5NsLi1C3BkhV5pRmpm7JMjO4w
         p7jjIncH+2Ge7WyCSTCfQmYtv4t2D6Nk9yU8iRutEOJyuHX6Rs8eAPkGDC9oQUNdGsNZ
         rH6povxf8DLrjUOcNEKuYQ8QMuP4B+R5KrjumQafxDEghqXdwH2FpPhAl9zp9ir6jPLz
         MOFGDDwNCMgrjVfRx6yJRJ5jWrJYK3MkKv3RjyPdyvB72c6wmWQBmp6AD/FfKLWxDiPO
         wTKQ==
X-Gm-Message-State: APf1xPCXg/yW2v9pZzdA0NusB9E1v9TfiILHyiNIzBfRnDGHyRqCDIY1
        L+DwSjHbn1lJCn3L+bndayrWiatFuPED2MDydb5kIw8p
X-Google-Smtp-Source: AH8x226IoFZM9VCFOmiY9IcgYleV84rAKMYiiN8qhhomRRey9wHH+JHXQjOjaSmyaY1E0mD6HI3yddihROSuMwBRD3Y=
X-Received: by 10.129.86.139 with SMTP id k133mr3072492ywb.253.1518728960920;
 Thu, 15 Feb 2018 13:09:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Thu, 15 Feb 2018 13:09:20
 -0800 (PST)
In-Reply-To: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
References: <20180213012241.187007-1-sbeller@google.com> <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 15 Feb 2018 13:09:20 -0800
Message-ID: <CAGZ79kY5_aL0YRE5JMp4Y=J_yKA0QfoB-LzXxQH0NN8iU-q3TA@mail.gmail.com>
Subject: Re: [PATCH 00/26] Moving global state into the repository object
 (part 1)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 15, 2018 at 12:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This is a real take on the first part of the recent RFC[1].
>
> For the patches remaining in this series, The scope is about right
> and the size is more manageable.

ok, thanks.

>  With topics already on 'master',
> they have some interactions:
>
>  - ot/mru-on-list & gs/retire-mru
>
>    The packed_git MRU has been greatly simplified by using list API
>    directly.
>
>  - cc/sha1-file-name
>
>    The function signature of sha1_file_name() has been updated.
>
> I could certainly carry evil merge resolutions going forward (these
> changes need to be made to object-store.h that has no mechanical
> conflicts), but it may be less distracting for later readers of the
> series if we rebase it on top of a more recent master.

I was debating when to reroll this series as I want to make the
change that Duy proposed, moving the 'ignore_env' into the
object store as well.

I'll rebase on top of the latest master or these topicc while at it.

Thanks for the heads up.
Stefan

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E167A1F51C
	for <e@80x24.org>; Sat, 19 May 2018 04:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeESEvz (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 00:51:55 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39912 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbeESEvx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 00:51:53 -0400
Received: by mail-oi0-f67.google.com with SMTP id n65-v6so8895955oig.6
        for <git@vger.kernel.org>; Fri, 18 May 2018 21:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xKcqeVE03p/aZ5fS5KNWgcESat8UJaAxVci/De0V24E=;
        b=Z7FMT5S+Cu3CVYhTGfFwiVDH9dpkE+10F2KyAxJp/MA1fCNVe/+jxkYUrDhdofGPF1
         iuvdazjIcp/WRgy/e26qWNGNETLw2icH1FfDuVhVPYCXYDppGIVO9CaIdXZVeEz9Xyyu
         NOx3I57BxtJ7/+xV3Fd77Fxrkf4oVg/Z9RmiXVm87a7fD32bJ4Q6S8OgIWm22U2awy2+
         jq3Ln7zJ4kJUP50D/9+FqCWO86XFDrHMkjpRTMovXeJHKKH1/1EwHrAyfdvmhkQzR/cC
         /CCZtO1t3bOq9htxG8zFT8FGW+FC819dgkC369kuO2MCgL9NApzIRDldYKaZ2T7WLFwn
         5gfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xKcqeVE03p/aZ5fS5KNWgcESat8UJaAxVci/De0V24E=;
        b=iFHYP8uo2hkZmaJawVwf2ul88a6VzOGah0NUVtHmLUs42tt+ez/iD8R7nJuYT23kZT
         UxLsxvNFt5fu/3wUhWWu2K/2LHiiMDf90dTtVyLB6aqv3PCfNN0BZa6Q3Kb3OPqe2rMP
         zh7EAW5Q9cEKhREprZW7r7YFPwhNtEzTYci4D/RnaxD8jIklqG8SkkCAKwkiHTsEyXTp
         oVmEKdvI3votMT3Mcs8DfcadMahS1ESZHAptUS79uXmcsPzvj1bJsQaZf4qZnZ9TXHOn
         fKS8RHbga29pc828ldiLxILpZ+GYWrFAReHeZu34BTBKECywgtxra473CtrtACA4xn7I
         m7Wg==
X-Gm-Message-State: ALKqPweQBEOY7AFyrtQLYwMbtJObXkOe0bpSDd5UgNGEvNynK4p+CTbR
        24MMSar62MnycVAL3pMjh66H1ogymtrogTAriKo=
X-Google-Smtp-Source: AB8JxZpYg8rfoX1nVkB5VR13wW5W4GfGEEq1BbD/e5ASo5klZYQCAkQH9hd2nLrznuwHdrnEEZOizdh7UnlOKb4dVKo=
X-Received: by 2002:aca:aad3:: with SMTP id t202-v6mr7316991oie.30.1526705513285;
 Fri, 18 May 2018 21:51:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Fri, 18 May 2018 21:51:22 -0700 (PDT)
In-Reply-To: <xmqq36yud9bp.fsf@gitster-ct.c.googlers.com>
References: <20180512080028.29611-1-pclouds@gmail.com> <20180513055208.17952-1-pclouds@gmail.com>
 <20180513055208.17952-12-pclouds@gmail.com> <xmqq36yud9bp.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 19 May 2018 06:51:22 +0200
Message-ID: <CACsJy8Ae4kE+hcPp70Wu28eX-8g9W3mHCtjoUqVXAHPq2u+hSw@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] show-branch: use commit-slab for commit-name
 instead of commit->util
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 14, 2018 at 8:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> It's done so that commit->util can be removed. See more explanation in
>> the commit that removes commit->util.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  builtin/show-branch.c | 39 +++++++++++++++++++++++++++------------
>>  1 file changed, 27 insertions(+), 12 deletions(-)
>
> Looks obviously correct.
>
> Another place we could use commit-slab in this program, which I
> think is a more interesting application, is to use it to store a
> bitmask with runtime-computed width to replace those object->flags
> bits, which will allow us to lift the MAX_REVS limitation.

Interesting. I have a feeling paint_down() from shallow.c might be
reusable. Anyway I don't have enough interest in this command to
actually fix this so I'll just make a TODO note in case people need
something to do and grep for them in the code.
--=20
Duy

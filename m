Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB4D01F51C
	for <e@80x24.org>; Sun, 20 May 2018 15:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeETP6S (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 11:58:18 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36724 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbeETP6R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 11:58:17 -0400
Received: by mail-oi0-f65.google.com with SMTP id v2-v6so11035938oif.3
        for <git@vger.kernel.org>; Sun, 20 May 2018 08:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iRcRJj7+wCSwV/Bjep0C19rSfjKGIab53Pq/lkJrssM=;
        b=mDYwf1nAmVkObczq2ufzGlwWqlcDqd9XVMriBsd5HXrhO5p7SyeBM1qEfFc5aAahMN
         hF1daADG15u95VGjoJSdtO17W6lrciMUC2tzvsGPzi8u0bGClZAmXRC7r6leLkkJMkdH
         tWFqu+73WKw4dQ6npiZtK3wjR8UbtlVnfvWMxcQFc0pIxOAInBFDdFSZpiFEV7oAsZR8
         WqVY5uyDFC8WjmCv/XO1cVTKXRBXVVdfD7ZS34Tti6eGuYfXRsUCTklVlBol//yvXEFK
         U9WTLW5hYU1RdcfK/rDO8Z3kCwoGLRnIakJ92K7AmSAGZlXNRaZqNJCqdE2T7N17gTZP
         PZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iRcRJj7+wCSwV/Bjep0C19rSfjKGIab53Pq/lkJrssM=;
        b=ZXkChz4YZx9wT3s4r5KgWO/039SHkyttAn0ClfdAUsPvLbZhy5L/Y5VTg4esFaGRnM
         rHif1ItbpIEtbVOGHUKNO++1bqXT91wL0GeJo5S9c7Bs2h8ARJ0CcZzLU+FMw6oz3iO2
         pOmgCc5BlDKXKsW5X0HCPMPbLbFJbk5cERhWeKC8W7FRHTkQr+Dx9O23pxkS0gKs2K36
         VrqFH9cDVVMLffnrJ5vMo+BW1RNX12r7cJF/6x8J5wD491FL//xLkPhShrHurcqypGsl
         mB3TR2fl2AUUBd8JmLXceJfhRYoDvdW4GVJG7QosXkKEnU3FAOl3ftkd/MS166Ul+Iii
         /K9Q==
X-Gm-Message-State: ALKqPwew7xZTWXMVWvGqrGVq1F1R1C/Yj58WlnTbU5kXSGic1KBgiRtK
        oIsIagi72J7pSZh1gm/vZNIeg8NklhTPYda/czA=
X-Google-Smtp-Source: AB8JxZrm4OWPUx8kiMf8BQJiGsmubEfnAuaIz06FMxgezuVfek7kpgeaqVJYJuNO+0s6Y6hI7XJaP+QvbcecwTmB3M4=
X-Received: by 2002:aca:110e:: with SMTP id 14-v6mr10247830oir.56.1526831897412;
 Sun, 20 May 2018 08:58:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Sun, 20 May 2018 08:57:47 -0700 (PDT)
In-Reply-To: <CAM0VKjk4F-RfDjPLfC8_YzzJxPEM0O79uBx3kiCAMSCV4xVAMw@mail.gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com> <20180519042752.8666-13-pclouds@gmail.com>
 <CAM0VKjk4F-RfDjPLfC8_YzzJxPEM0O79uBx3kiCAMSCV4xVAMw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 20 May 2018 17:57:47 +0200
Message-ID: <CACsJy8DcDku-8M2+Q6m2BGFxsR+-qDHqX2w4-LXBawsQ3nqXLA@mail.gmail.com>
Subject: Re: [PATCH 12/14] completion: let git provide the completable command list
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 20, 2018 at 3:20 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> On Sat, May 19, 2018 at 6:27 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> Instead of maintaining a separate list of command classification,
>> which often could go out of date, let's centralize the information
>> back in git.
>>
>> While the function in git-completion.bash implies "list porcelain
>> commands", that's not exactly what it does. It gets all commands (aka
>> --list-cmds=3Dmain,others) then exclude certain non-porcelain ones. We
>> could almost recreate this list two lists list-mainporcelain and
>> others. The non-porcelain-but-included-anyway is added by the third
>> category list-complete.
>>
>> list-complete does not recreate exactly the command list before this
>> patch though. The following commands will disappear from the complete
>> list because they are not in command-list.txt and it's not worth
>> adding them back: lost-found, peek-remote and tar-tree.
>
> These commands have been removed long ago, see the topic leading to
> 577aed296a (Merge branch 'jk/remove-deprecated', 2013-12-12).  Perhaps
> you saw them only because they are still somewhere on your $PATH or
> $GIT_EXEC_PATH?

Right. Old commands remain in my libexec dir. Will clean up this commit mes=
sage.
--=20
Duy

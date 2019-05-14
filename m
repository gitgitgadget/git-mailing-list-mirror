Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACA661F4B6
	for <e@80x24.org>; Tue, 14 May 2019 10:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfENKyZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 06:54:25 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:35140 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfENKyY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 06:54:24 -0400
Received: by mail-io1-f47.google.com with SMTP id p2so12648954iol.2
        for <git@vger.kernel.org>; Tue, 14 May 2019 03:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zkkjmkmZ//jjQTXEyNgF1PoxcwhR10DEEamziFgc/6o=;
        b=ip3t99J+RmoPl+GqgJqb1i99Qnr1g5ZpY2XztIvG43rK3L9zhG9oXdEKPhdqVX+rNB
         vKXmKLEkB16wzzcGEiarz5cTj8cvAgg2e+njN6kSq3YPWupZuLQAZ5qFeg0zBPYGM7Qr
         4n5sjMcSCby934BuAlvVTMPZM50cOQQ9WlbQIL9sUL8Wxu2cVhDUEHtbLVIggVJiDA6B
         74A8Ka097aFYCGeRHAdqvB5PaGDFaxP26u01peEz0dxJe6B4qWFXyc0Gy3cpszwofa51
         pC1ppy1L/MzZV5DGvSkKOIKn5H32fIGH90ZbOfRVgVnAVmUGvFCn7Nwd9qwQnZ+nbuXE
         m97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zkkjmkmZ//jjQTXEyNgF1PoxcwhR10DEEamziFgc/6o=;
        b=kW06juXcvdvaUomECxGb5wWFzFWU4M/8j119DikUVbrhK+AHt29UGQsMqSAefXfvN7
         DGnRsHih9TNN44gejGoAs8zVMy0X2qztbbAGWx9jfGGwA+XfMm2Mgu/XodRQxCNRV2Ji
         mlO3QM4kP9f5cXtp0smM0jk8NQWVkum3BNc80D/05T0E1jifxP7du59qQlUi6/0lOYbd
         or2mdpK3BRRCcd17SZ3L/QrIqVazTrHlR4RvVAkjawzVELKp+dWD5LLGLmPZVGnGhgTy
         xR0DTjgxbTabRYYs28pE3XPCvO84MXEKTgTklwe+dt5/kiU2o3tb+vXt2b/VJ1nMl4Dy
         HHYA==
X-Gm-Message-State: APjAAAXQCsN21GnSibjrx+Xfi4A9j0nbXT9qrG2rvsHPGWyeqLcRgTdt
        QE1lulir0D36jPN7FdRegSpgGwgsjlR65JpI+nxWgA==
X-Google-Smtp-Source: APXvYqzsJDZoBzskNTQfZoBYrcvQoq4/5hRKEXmEmsab+sAbWbqsMrD/x0CBliOEpPsiArsuApEPcFeIk62R8vzcbDc=
X-Received: by 2002:a6b:ef12:: with SMTP id k18mr16510132ioh.236.1557831263656;
 Tue, 14 May 2019 03:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <5CDA8D37020000A100031319@gwsmtp.uni-regensburg.de>
 <CACsJy8AX9Wp3W=d1=ozF9nZXGE1muooMf7fKCtdOOi1g8QRmig@mail.gmail.com> <0c9ec78a-9245-e1df-7ec6-a5d77d1a5261@iee.org>
In-Reply-To: <0c9ec78a-9245-e1df-7ec6-a5d77d1a5261@iee.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 14 May 2019 17:53:57 +0700
Message-ID: <CACsJy8D9wDiTOfKP4sdMFQrR66qa4cLZuqqn32yH83_q0XjKRg@mail.gmail.com>
Subject: Re: Missing branches after clone
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 5:33 PM Philip Oakley <philipoakley@iee.org> wrote:
>
> Hi Ulrich,
> On 14/05/2019 11:12, Duy Nguyen wrote:
> >> Then I foundhttps://stackoverflow.com/questions/10312521/how-to-fetch-all-git-branches  which handles the subject...
> >> But still the most common solution there still looks like an ugly hack.
> >> Thus I suggest to improve the man-pages (unless done already)
> > Yeah I expected to see at least some definition of remote-tracking
> > branches (vs local ones) but I didn't see one. Room for improvement.
> Yes, the 'remote tracking branch' name [RTB] is very 'French' in its
> backwardness (see NATO/OTAN).

The name is not that bad to me.

>
> It is a 'branch which tracks a remote', and it is has the 'last time I
> looked' state of the branch that is on the remote server, which may
> have, by now, advanced or changed.
>
> So you need to have the three distinct views in your head of 'My branch,
> held locally', 'my copy of Their branch, from when I last looked', and
> 'Their branch, on a remote server, in a state I haven't seen recently'.

What I was looking for is this. I don't think we have something like
this in the man pages (I only checked a few though) and not even sure
where it should be if it should be added to the man pages, git-branch?
git-remote? git-fetch? git-branch.txt might be the best place because
this is still about branches.
--
Duy

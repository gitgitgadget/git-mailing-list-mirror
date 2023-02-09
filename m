Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92800C636CC
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 01:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjBIBMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 20:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjBIBMG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 20:12:06 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298651C7E2
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 17:11:53 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id x4so637347ybp.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 17:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nhe/dorzD+k2h+2YC9KAxcylszzP7dnxLuR+WiFgUwk=;
        b=WKvfuPVCIK7qap2IDvCoqaBiS6dCCA3/lXIihYSXj41ydcuBUzciSUO4JVRAfIuCtR
         /8CRa0qWKCQCqeZnIOshhI5fvLhDDZX4QyA/Je21IWrPW84bv68QbRtWNgF5H8Y1PHfr
         7dWPMrPlBn5korqGcuSku6yDGlDAlOrRg0GcaEuewW+wMiIXDc5Qy+0guByd8y1O/LCt
         1UQURue6bQJ2O9uliD04l1008myA4xadW28puyQLRswE5dQIosgWHIWMXz00ur4IfVAZ
         bfbydPVxhpoXgTmr0EzfnMM+V1EKWMY8OTLilfXHtiFUy26LnuVeqk/+0q9TWvlft0zp
         5yMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nhe/dorzD+k2h+2YC9KAxcylszzP7dnxLuR+WiFgUwk=;
        b=iyIsGJLZ4fkxenN7H0KLPbouPe4N11l3Sj3Ebtm4dNfxX1bCBzGA/ODu07DfAm0czX
         mWDylw4HZLUyk6cu+2lPZN1UikGPh5T/kl6Z7g6FxG1Latpb1bT0Jin2Z+d+fTllQXV7
         uNtsPN/BURrm89i7d6/uhFTbV8R8LGswVUUbQrAvzz9NC31b1oQdtWhtrKqjvTLpNZgw
         B7t7cHzRgSR+mVxvmrxnYSuACaTVA6pVDI+n0CTOJmS/5+qrb3lCVRDY0XL7yEa9Sq9m
         G204lt/IJJrnHtoPCdmj2Fem4i7iQznx8eGOtwgLgTiE7g9B22h9HaPzZK/zhN2777wa
         t/gw==
X-Gm-Message-State: AO0yUKVu3NLTA8P+pay6W/oTxavQravq40V/nvF26MaLR6HrDuFfgbhy
        vcU3K+aU3VnihLxE2ginqZtBK0wEHwA2/zRViu8=
X-Google-Smtp-Source: AK7set+jIY6lV7Qer8/H5/6ZzRCP4fXaFWxmvNDm9ppawEuvN809AzSL0XRg3BPViX00CqWGr4Hm2HRbtpFdsrAImZ4=
X-Received: by 2002:a5b:bcf:0:b0:80b:65d0:424a with SMTP id
 c15-20020a5b0bcf000000b0080b65d0424amr1185300ybr.386.1675905112235; Wed, 08
 Feb 2023 17:11:52 -0800 (PST)
MIME-Version: 1.0
References: <20230207235238.1850757-1-kolyshkin@gmail.com> <xmqq5yccuo2s.fsf@gitster.g>
In-Reply-To: <xmqq5yccuo2s.fsf@gitster.g>
From:   Kirill Kolyshkin <kolyshkin@gmail.com>
Date:   Wed, 8 Feb 2023 17:11:40 -0800
Message-ID: <CAGmPdrxcb+ztx96=aF2+ok7DgOkEnZ+znSrG4D=AE_nQ57A17w@mail.gmail.com>
Subject: Re: [PATCH] remote: align columns on -v
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Roman Dodin <dodin.roman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 8, 2023 at 8:19 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Kir Kolyshkin <kolyshkin@gmail.com> writes:
>
> > Currently, git remote -v produces a misaligned output when a remote name
> > is more than 8 characters long (i.e. longer than a tab step). Here's how
> > it looks like:
>
> The condition under which URLs do not align is not when they are
> more than 8 characters long.  If all of your remotes have
> 10-character names, their URLs would perfectly align, no?  The
> description may need to be tightened if we really wanted to do this.
>
> But I am skeptical, even without my devil's advocate hat on.
>
> > giuseppe      https://github.com/giuseppe/runc (fetch)
> > giuseppe      https://github.com/giuseppe/runc (push)
> > kir   git@github.com:kolyshkin/runc.git (fetch)
> > ...
>
> The current output allows programs to post-process by splitting each
> line with a tab, but this change will break such practice and force
> those who use such practice to do something different (like "split
> at the first run of whitespaces or tabs").
>
> > While at it, let's keep the \t in case some tools depend on it
> > for parsing (there will still be trailing spaces in the remote name).
>
> That will not help avoid breaking the behaviour for existing
> practice (they did not need to strip the whitespaces, but now they
> are forced to).  It only make the output uglier by putting mixture
> of whitespaces and tabs.
>
> So, I dunno.

Yes, I agree that this can break someone's scripts, and adding \t was
not a bright idea either, as having it may hide the issue (of
incorrect splitting)
rather than break things entirely (and thus urging to fix it).

I assume that any decent script would split by "any whitespace", plus
the output of git remote -v is mostly for the user's eyes, not scripts.

Please take a look at v2 which I am sending now.

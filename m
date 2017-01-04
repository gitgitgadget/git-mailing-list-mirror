Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CE491FEB3
	for <e@80x24.org>; Wed,  4 Jan 2017 01:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762301AbdADBPp (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 20:15:45 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34305 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762267AbdADBPT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 20:15:19 -0500
Received: by mail-lf0-f66.google.com with SMTP id d16so31467003lfb.1
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 17:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GifwI7eU5yAdDWQUQtnj5TGF2pobV3QHPcpgyGguZMo=;
        b=NiYu8OMXOgBFrYNic7aZrU9hSo2CS4Hsws4EHOVJku4MXwbscrYJpEh3OJGpvI3T4H
         Pvor09CJzyZvybYh1UxFBHMPSgsJT46so4o04EtcE4ddHZdnjPJ2a4ULvGfPSqjYelSm
         680Q6n7UPevSleC/1cpgLp4qxahBlxFPvXo9pPS+SnZFJ4Y2NWWLDnCkyo3ZI3Ps4oiq
         JQnjxGG37akKEC1h5zY4/YlqW67EmYES0Sic6nDsFZZp7nJGI8iyN+FMVwZKJFqwWoQo
         ual2fELnq+L8O096zvvcBQIIpCGHOvP89NGGlFPU0BSf/MFhXQGslKsVE4l0XH0Zz9vr
         MokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GifwI7eU5yAdDWQUQtnj5TGF2pobV3QHPcpgyGguZMo=;
        b=eyCNBQ6gb70muMrOJnYDydbpLhJ6OIdpUba3127rfThL06gc33p82XVK3c/NXhOA4E
         cLHQOKLSMk8fO/9CkG7+3ZvvGCflDHsh05sW/obrfQZtjdzqdVFBcQWSorLNwGzzQMnB
         kMGhR1mXdWUDdauj+uICCSYDGW3weiB4xBxIQWqtL4I3x8BDpO64EasWI0t5dNX1cWND
         fHagIiqA5G9IGulatJviWQ7ro0yWG/rbaLEYeyR3kR1p5pATOe+CS0AoAax+gAUjXYoM
         H1ibFskyxc/JriMvcJakL7hMkuWXXF69rKWn58rYsDSbTt+Oxx9B4pkRCIZZy8XUnz/8
         GriQ==
X-Gm-Message-State: AIkVDXLjp/9jB1sYnkjzBVx4xKgf65bMY5lbrjRn+l/CHzGiKJYvKYW7I80G9VFRNAaLywgSJ+oi4kLlD6pP2g==
X-Received: by 10.25.141.147 with SMTP id p141mr23540795lfd.147.1483491978131;
 Tue, 03 Jan 2017 17:06:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.79 with HTTP; Tue, 3 Jan 2017 17:05:57 -0800 (PST)
In-Reply-To: <CAGZ79kaMnFUefiMagU82euxjeQdnc9KdgSwyDvkDp--QT-MbCA@mail.gmail.com>
References: <CAGf+dShpkPvsC8wQN6mWmYeMZ3=i-ZOzDNSM1aa0rinKW6+-+g@mail.gmail.com>
 <alpine.DEB.2.20.1701021712010.3469@virtualbox> <CAGf+dSjM9nuroeSM9mkQmO3ho4XcZhLo1CR76q-jbeQ-WNGG+Q@mail.gmail.com>
 <CAGZ79kaMnFUefiMagU82euxjeQdnc9KdgSwyDvkDp--QT-MbCA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 3 Jan 2017 17:05:57 -0800
Message-ID: <CA+P7+xqaOXagpXb53raPcD19uZRgYrOYH6O9pDPsAxE6TsMkvg@mail.gmail.com>
Subject: Re: builtin difftool parsing issue
To:     Stefan Beller <sbeller@google.com>
Cc:     Paul Sbarra <sbarra.paul@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 3, 2017 at 10:47 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Jan 2, 2017 at 11:05 AM, Paul Sbarra <sbarra.paul@gmail.com> wrote:
>>> I would have expected `git difftool --submodule=diff ...` to work... What
>>> are the problems?
>>
>> The docs for difftool state...
>> "git difftool is a frontend to git diff and accepts the same options
>> and arguments."
>
> I think such a sentence in the man page is dangerous, as nobody
> was caught this issue until now. There have been numerous authors
> and reviewers that touched "diff --submodule=<format>, but as there
> is no back-reference, hinting that the patch is only half done, and the
> difftool also needs to implement such an option.
>
> We should reword the man page either as
>
>   "git difftool is a frontend to git diff and accepts the most(?) options
>   and arguments."
>
> or even be explicit and list the arguments instead. There we could also
> describe differences if any (e.g. the formats available might be different
> for --submodule=<format>)

I agree with updating the documentation. Difftool would require
extensive work to support the --submodule format, and I'm not sure
it's worth it.

Thanks,
Jake

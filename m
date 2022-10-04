Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5BDC4332F
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 10:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJDKQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 06:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJDKQM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 06:16:12 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93042BE23
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 03:16:05 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13207a86076so11724333fac.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 03:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2H/sLCYH2DoGHoXh1NCNMqJxjSTi88SitliOoGkREMo=;
        b=WOaPrmzHTxnPaP1JVfQV/P5ue7vmKJ0qgq4GMwjWXAx86IbqDeSLrIJm4xEMAsS9wZ
         7usGdqDjKfPFDZ603ukqQgBuzObvhKIlRDrBZgSBC8TsqG6AJ5oFdNxgypwBMKyNikj7
         ouoJtCFyOSehdH+qWGhcJ/N3HbZOieJGIXGP5iTNXirtNAZLT8n+251hsvIDlTD7R++8
         xDmFGKt1q+oMG4fJp6bsikNj030cQjSkYr9GvAtEuyNUVV6m442LtS2JEKgJT/I5qNe4
         wzKp5I6RotlLsbLKkn/BH4Y37pJjEZc5QKsJ4FNg2Hl7RMgSdgLhuhN8OcfkXt+T2TXz
         tAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2H/sLCYH2DoGHoXh1NCNMqJxjSTi88SitliOoGkREMo=;
        b=4Vhos3Iq768h9AFqq3ooX8HonSp7KS5Ppd2cIaCaKzUuIMsxiOF0uY6mfrM0nkPesj
         tqamkEiaEh/Tz/3tCvyYSnW/e5gC5HHHGWP9FtQIlmS+tUVqFOWf+wDEzyu2XHIvFuOF
         NuC+iHv/regY75Jxz6NvNRZdDjslU2AZ9Qswn/3FrXiiVMHzPIxDs7dilTqnk/Q1d6rv
         akREPKJe3DVpT44DGgWC7TV8RF8FiAnIwJmuEWwThHkTH+ewY4dj84x54ILMUVfDXaqp
         nuiEJwqM6Qt4Uio47EyYkyRHpDevpm6TG+QkegZrlesxzCeDd/Cvhc7bT+AiDytrxW+1
         Golw==
X-Gm-Message-State: ACrzQf2S+bzzfZOvY6DyhAXzBrULsVYmVjvnhl3GoBpenvym9gVT+3Ci
        kScLtInAV9gMtxiFYxw48hRimD+XkrcID3rcVvaAd5MCwetn2A==
X-Google-Smtp-Source: AMsMyM7rf4d53JdPGi+cFudDi5y1JhdtIJEi4Nvbs/UoS81hROMJdJ/OGOXeRR0X8ewkncQqZimtW1A94DCOBxACZC4=
X-Received: by 2002:a05:6870:d591:b0:131:690d:eee1 with SMTP id
 u17-20020a056870d59100b00131690deee1mr7706121oao.16.1664878564771; Tue, 04
 Oct 2022 03:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <CADTs3HEn8JQzfWGP-rq_BBLvwGD163=c2i_7vFK17g+wAVec+Q@mail.gmail.com>
 <xmqqill0voft.fsf@gitster.g>
In-Reply-To: <xmqqill0voft.fsf@gitster.g>
From:   Alastair Douglas <alastair.douglas@gmail.com>
Date:   Tue, 4 Oct 2022 11:15:53 +0100
Message-ID: <CADTs3HFZjX7P=n3PpjAtt=6E9m3PUgFKXksZKuOY4t71hSSnrw@mail.gmail.com>
Subject: Re: Bug report
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 3 Oct 2022 at 17:53, Junio C Hamano <gitster@pobox.com> wrote:
>
> Alastair Douglas <alastair.douglas@gmail.com> writes:
>
> > I have found no solution to the issue below. Apologies if it has
> > already been addressed.
>
> Thanks for a report.
>
> The solution is to remove "[pull] rebase = preserve" and replace it
> with "[pull] rebase = merges", I think.
>

Thanks for this reply. This seems to have worked, since I got no warning.

Now that I know it is a new option to the rebase setting I have found
it in the documentation:

branch.<name>.rebase
...
  When merges, pass the --rebase-merges option to git rebase so that
the local merge commits are included in the rebase (see git-rebase(1)
for details).
  When preserve (deprecated in favor of merges), also pass
--preserve-merges along to git rebase so that locally committed merge
commits will not be flattened by running git pull.

It does seem like nobody else on the internet is aware of this, since
I didn't discover this by Googling it.

> I also suspect that they were hoping that the users will read the
> instruction based on these command line options and understand that
> it also applies to the configuration variables.
>

I understood immediately that it applied to the config, but I couldn't
find a single thing about what I *should* have done until you told me
here.

Having said all this, I am fairly sure that I checked the
documentation for the rebase config and failed to spot that new part,
so I am not blameless myself! I feel like *something* could be updated
to point in the right direction, but I really don't know what.
Yesterday, I genuinely thought there was no replacement config for the
deprecated one!

Thanks for your time, but I suppose, in conclusion, there's not a lot
to be done.

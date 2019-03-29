Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 923D920248
	for <e@80x24.org>; Fri, 29 Mar 2019 22:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfC2WCW (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 18:02:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41315 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730357AbfC2WCV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 18:02:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so1822716pgs.8
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 15:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exactasystems-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tgZ3R2x+lds0lyVJcrIGGOqJuvsnUAU5/hbILVVuOEE=;
        b=vG384f2GH3uTndRpQIqDhPNZws0qQWOlr2Lyf7OMJkQbI8PytaVMiebzZdjsomyVVL
         FP5+SQVGmKuYQ8rFVLnbxPAKmqJGrlwhIRjokuorJClV92ya4LcW5JXP2OjQmqQRsIGE
         cR4d4e5H9j9z2IwpGe6Oxy6T5m3G/N1Iqiwmf0Q38VhRcBGp3dOSGutimhNbf60hVjoG
         BbPyXhx1rFGV3KjyTn0FargWPast14dql42TsCXotNmIJ0hIYIeO6+z9RhNNTyGoqZSg
         RMkOAZZSfbV1LUBmV74pb0oGoFSVoVyE0KigY0zfx6orD70SdqEMVp9sysUhBHXdyx94
         H2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgZ3R2x+lds0lyVJcrIGGOqJuvsnUAU5/hbILVVuOEE=;
        b=rOVJXBadaih05Eg8tEC/PNAzJM+lmRa95EDtxcsWXCjx41ltfIHRnpAcMkqtgaMYCv
         oRGs0Bx9jFmY+7S4Q24SFP3czEoLgbeKyIZNPp/hvGLr+II8m5Mt5Cl+NSYErZCCZUEs
         Tb3vJoVvJMge9WnRY1UbS1H+WMWUQhIASRKXDdsO/ybOcWdStxQqEtu35aCBUqAYfkIw
         zRaIhkDk/DnHSSjKCYa01nKAUFkxVZWjI4yUOQpkLXuz1rPoTaQLcJg5wrn+pTLVYivf
         AP99GGDcQIfTZ5yP1e4W2DWIF71R0dYQ4MIjFVO5S6Uxm2WL5oFm3gHpazLDdttjLtsE
         b3mQ==
X-Gm-Message-State: APjAAAWfa1bdWhSCbcOi3Ab98hfyDuqZI8ejDgtDFO3+2iojgmnKVxfl
        1wrXCcwG1HcYmCu5/ROtnkZ3k0VbUzVag2HF3Knvzg==
X-Google-Smtp-Source: APXvYqxrOUnAWGJMeW1kc/5HATdTihqHZBBBOYRB88jjZ48XI5rUM3AJJrxCz40sb0ce92K6zZEpa/3GGfbXdIZpfns=
X-Received: by 2002:a63:c54a:: with SMTP id g10mr26156836pgd.71.1553896939759;
 Fri, 29 Mar 2019 15:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAApa7v-F7Y_WR11V-3jc-R4Y1qSv5PPof6GWvJuF_XMeTcC2zw@mail.gmail.com>
 <CACsJy8AS5eNO6gACGtRZq=qdQGkQ3jmQPVivPG+=du9u9hKYcg@mail.gmail.com>
 <CAApa7v_noujdWcogGNJUS7ZJRzPRxK5PPv53tST-0JoEk8+9Mw@mail.gmail.com> <CACsJy8D9h2yT18V6pH+TKOaFPNQUf=Gd6YtgVkqUW_hvS1ZFaA@mail.gmail.com>
In-Reply-To: <CACsJy8D9h2yT18V6pH+TKOaFPNQUf=Gd6YtgVkqUW_hvS1ZFaA@mail.gmail.com>
From:   Joe Enzminger <joe.enzminger@exactasystems.com>
Date:   Fri, 29 Mar 2019 17:02:08 -0500
Message-ID: <CAApa7v9-2BhTQgt_Vd1mLACsrR2ZhYRBRrNTx2HDrEKXuHVSXw@mail.gmail.com>
Subject: Re: Feature Request git clone shallow-include
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy -

Any updates on this feature request?

Joe

On Thu, Feb 21, 2019 at 7:06 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Thu, Feb 21, 2019 at 1:07 AM Joe Enzminger
> <joe.enzminger@exactasystems.com> wrote:
> >
> > That is correct.  What you suggest is actually what I tried (using
> > sha-1 syntax).  For my purposes, excluding the tag's parent's but
> > including the tag is sufficient, but if is fairly straightforward to
> > extend support to the other use cases I'm sure someone would find is
> > useful.
>
> It's not hard to do. I hope I will find some time to do it soon. My
> only concern is whether reuse the current code or write new. The
> former makes it easy to accidentally accept some extended sha-1 syntax
> that should not run on the server side. On the other hand, the latter
> will not be as thoroughly tested because it only runs by shallow code.
> That's my problem though. I think I might be able to find a third
> option somewhere in between.
>
> >
> > Joe
> >
> >
> > On Tue, Feb 19, 2019 at 7:22 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > >
> > > On Wed, Feb 20, 2019 at 7:07 AM Joe Enzminger
> > > <joe.enzminger@exactasystems.com> wrote:
> > > >
> > > > Currently, git clone supports shallow-exclude=<tag-name>.  The client
> > > > will clone up to, but not including, the commit with the tag.
> > > >
> > > > It would be useful to have the ability to include the commit with the
> > > > tag.  The suggestion would be to add a "shallow-include" options to
> > > > clone to support this behavior.
> > >
> > > So exclude the tag's parents and everything before, but keep the tag, correct?
> > >
> > > I think if we support --shallow-exclude=<tag>^ then it should work the
> > > way you want (if the tag is a normal merge you may need to add
> > > --shallow-exclude=<tag>^2 as well). And you can do even fancier thing
> > > like --shallow-exclude=<tag>~3 (i.e. exclude the  grand grand parent
> > > of the tag, but keep the tag and grand parents). We will need to
> > > restrict extended SHA-1 syntax to a safe subset of course.
> > >
> > > > I have tried to use shallow-exclude with a follow on git fetch
> > > > --deepen=1, but it always returns "fatal: error in object; unshallow
> > > > <sha1>"
> > > --
> > > Duy
>
>
>
> --
> Duy

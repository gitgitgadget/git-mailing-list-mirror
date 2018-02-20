Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C4091F404
	for <e@80x24.org>; Tue, 20 Feb 2018 22:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbeBTWIp (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 17:08:45 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:40377 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbeBTWIn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 17:08:43 -0500
Received: by mail-wr0-f171.google.com with SMTP id o76so18660889wrb.7
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 14:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q39LaJcNL7d8g59jJq7DV5C0JvPxl2xJB+HRtg1NGXw=;
        b=P302ShuB5NH1rh9J5rcu5zfh0MYj/gR3LapEJ31Jw9zkLGR7ZPObthR+j6l4DttSxv
         d0dZvTDISCTMb74qCrt8PbY37N9qa1tA7hQhpu2Qw0vhDt5dn+UmMYIx8Sa56b+LFl2D
         blFgHaeEXuAEKgLzqbljb2j8mukh47WLkV6s5ItOg11jBsjfbQrweCV7swIm+thPtsHE
         Afh4oGdboGb00RLXZKkO2L6yTiOPUbxPcvNLyJ0dQ1NKWMvbwC6M+f6zvNoSe8Rd1VDJ
         BxO2d9Hog2FrxDPUeOn3SgGTFt19blxjAadc3WMb/ptirp0rFdBMoITEiW7p7qPRcC74
         wTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q39LaJcNL7d8g59jJq7DV5C0JvPxl2xJB+HRtg1NGXw=;
        b=NtZ9HhKENKDvQcJGacrLZ+bB8ogfz4E9ZJXdLp2mT/3O1AncksEiKeKky4V1wVPA6R
         BBdi2yP8gCn8JNYjDmnGQhThso2qyF/JJLY/1JE8pHLK9VFJ1zu/7Z7tMTmYPrqxsW10
         fiAke28cXFObCjhlqf1JgEAVOjhzwyj2e7gLHHOPf7CTzdQXMsl3ixjbK4AN0MN9822/
         kDiqkszrtJhE81Ko27mI6OX19Lb/FLQeZRiMFX3jDr/eH5gwlYDkE08eUdd2c3lirWNi
         6f4kz0mdCr+XAEL5+rGhErN/IOHB7mN3YwE839mJ4Dx6OxbsHFk7TkzlfywJdBztAEY5
         m4eA==
X-Gm-Message-State: APf1xPCipX0jJIPzw3g8jep3e7GMf5beN2ZJLKiwhdNrd3uxqrpb8zI4
        cB2ZCISa8m5wyvaQouHofVWxbnQRjZVV6hU44sfNrw==
X-Google-Smtp-Source: AH8x226egJzCKduxzYxAtHFkfdboLG8mgOtkCMcrImoXTOSpzfmySyHLJS5YaW+M27XLjZRCUXQWQ8jtxF/SB8TWcWM=
X-Received: by 10.28.237.5 with SMTP id l5mr332478wmh.154.1519164521284; Tue,
 20 Feb 2018 14:08:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.179.2 with HTTP; Tue, 20 Feb 2018 14:08:40 -0800 (PST)
In-Reply-To: <CAA7Zk=vWdEUnrfBcxCH6WAFH9Jss7T9_zK-zMnWbVO7B+2YySw@mail.gmail.com>
References: <CAA7Zk=vWdEUnrfBcxCH6WAFH9Jss7T9_zK-zMnWbVO7B+2YySw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Feb 2018 14:08:40 -0800
Message-ID: <CAGZ79kbXvNqAvrkH-=S_bb-VRPGd4Lj7-vvnPh73HavV7kM9zw@mail.gmail.com>
Subject: Re: I'm trying to break "git pull --rebase"
To:     Julius Musseau <julius@mergebase.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 20, 2018 at 2:00 PM, Julius Musseau <julius@mergebase.com> wrote:
> Hi, Git Developers,
>
> I'm currently writing a blog post about "git pull --rebase".   The
> point of the blog post is to examine scenarios where two people are
> working together on a short-lived feature branch, where history
> rewrites are allowed, and where both are using "git pull --rebase" to
> stay in sync with each other.
>
> I was hoping to concoct a situation where "git pull --rebase" makes a
> mess of things.
>
> So far I have been unable to do this.  I tried version v1.7.2 of Git
> as well as version v2.14.1, and as far as I can tell, "git pull
> --rebase" is bulletproof.
>
> Does anyone here happen to know a situation where "git pull --rebase"
> makes a mess?

If you are inclined to experiment with submodules,
I would have an easy answer for you. :)

But instead of giving an answer myself (as I love reading about
things the usual mailing list folks miss),
maybe this is a good starting point to poke at things
https://github.com/git/git/commit/a6d7eb2c7a6a402a938824bcf1c5f331dd1a06bb

For the non-submodule use case, I would think pull is pretty solid,
as you lay out in your blog draft.

(If you finish by Wednesday 21st), you may be interested in
submitting to Git rev-news (or a later edition if you take time writing)
https://public-inbox.org/git/CAP8UFD1HPruE3N_0k8_TFreBML9V8K=SS8LqD-XkeEuheSmGvw@mail.gmail.com/

Thanks,
Stefan

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 047021FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 15:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbdJXPcd (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 11:32:33 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:51958 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751369AbdJXPcd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 11:32:33 -0400
Received: by mail-qt0-f169.google.com with SMTP id h4so30921207qtk.8
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 08:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T8Q+PetKnoqN/lUQuCPjV9Ja+qYSTCVjFmgmYHaedS8=;
        b=nllYj2V2O5nbU8N4oe1nqk7pNALmKDBOYUyOBr29HclyVgQnFTtsNCktSDAqBJBvyw
         3K/yNhkBVoXkJTHXiSiXahGUofu62HMG12XHIJUsf2HfTK4DbQjo3XfI6aKhfOah5OKy
         F7JawBoUqcoXxzLoK7jZU3rIRvpSSpawkG6x2AKCeXMDDsVe4BVupf2Xqvys7yuFaKPX
         hcrvgpKaW6A4dqAD+pcjmlIKFeaiZIG1ey+IW0/suXlT+RL5Ju6tfNfhh3qHdZzEqrei
         LypItO42IfBwgI3GQX3bCrRVdyDpb2Ya4xh+WT2wyewWBmZuXp/weQrbMP7rMv1NaHGc
         drjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T8Q+PetKnoqN/lUQuCPjV9Ja+qYSTCVjFmgmYHaedS8=;
        b=QEHwEuaPIHRy9072KlaA8eR9q9hd2XNu/Yw1peEYITj4V77wMnw/Sz8M/MoTSjl8nP
         pEFpG2pVJ8Om70i3+264yB0L33iq/zII6bhxfe6iLTOmedOJypI/f+4icNYJX9Iu+Fvo
         mGm4aD+4LMj4i7BHJbk2+BUsnwNG55Ju6O75eOyzMY5zyBGyMhFWUhxK/j2PHuO9Z0Ej
         MaH49SgYx53gvraVe6VYXbj6nKOasGQa+G4g0YJS4jkjxSbs6RnhdEy3+Pw1vnXVyqxe
         hguZ5gxLZj86STdjD+wXNYU0A4kIMc6JPU8GsJTbPDkcxiFNRn0dMmM9UH21jt06tPLs
         hwiw==
X-Gm-Message-State: AMCzsaW2hkkqGggeJ5PNCc5j33jj3FlbEPaqKKpIL5o0b4Fk76FddQET
        QFivviZXcpzAiqRvz1o88vFu5bjPPoD9jl1zh9ILOA==
X-Google-Smtp-Source: ABhQp+TgNovzXOpS/kst8XKa7wgcKilP/+frDZf2HTriZMZX6ZFyAHFSdl4o0TCq6+1Z2jPUS3xGYMnh/LXrji7i2VQ=
X-Received: by 10.237.53.137 with SMTP id c9mr27398089qte.125.1508859152147;
 Tue, 24 Oct 2017 08:32:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 24 Oct 2017 08:32:31 -0700 (PDT)
In-Reply-To: <CAFA_24K99LkeJBKV7+a-m-m9PUZik49cOd40+cEn-6zCvGmMsQ@mail.gmail.com>
References: <CAFA_24+svnt4uSpx1tjj2t6iAt4G3p9UvrxahEYj=VZWeJxC=A@mail.gmail.com>
 <CAGZ79kYbeVcpEXsei8Lr=Zw+YgJE_E4mBSRWYcYDqOWz20z5oA@mail.gmail.com>
 <CAFA_24Jov7FDw7AxUtFDV6avOj40LD6ptEVMPpVuSdAo_6L_1A@mail.gmail.com> <CAFA_24K99LkeJBKV7+a-m-m9PUZik49cOd40+cEn-6zCvGmMsQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Oct 2017 08:32:31 -0700
Message-ID: <CAGZ79kZHapHLXDM-iU9T_BU5qoYAAAS+yKWLVvfUhxMmp+6mxg@mail.gmail.com>
Subject: Re: No log --no-decorate completion?
To:     Max Rothman <max.r.rothman@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 8:15 AM, Max Rothman <max.r.rothman@gmail.com> wrote:
> Just re-discovered this in my inbox. So is this worth fixing? I could
> (probably) figure out a patch.
>
> Thanks,
> Max
>

$ git log -- <TAB>
Display all 100 possibilities? (y or n)

I guess adding one more option is no big deal, so go for it!
We also have a couple --no-options already (as you said earlier),
which I think makes it even more viable.

Tangent:
I wonder if we can cascade the completion by common
prefixes, e.g. --no- or --ignore- occurs a couple of times,
such that we could only show these --no- once and only
if you try autocompleting thereafter you get all --no- options.

Thanks for reviving this thread!
Stefan

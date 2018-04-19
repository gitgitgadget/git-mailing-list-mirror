Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007F61F404
	for <e@80x24.org>; Thu, 19 Apr 2018 20:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753411AbeDSUyt (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 16:54:49 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:37827 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeDSUys (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 16:54:48 -0400
Received: by mail-pl0-f51.google.com with SMTP id f7-v6so3952198plr.4
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 13:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bOByWWOiLZYz2mT73IgCbyPjg+THdugeI475tkI/hts=;
        b=S1m7zSuZQfAdBK+nyC9+naZHI86ckxXU03ZnBtXP736A1sSuUMpPNEhPhGOOqZ3PSK
         xgmGt+hJWYM6PS2Ln3TyC9CUXOlCuN6a85mhHqWDoVn2UWK+oe79Kw6rrWgxT6kd8Qj4
         +00gb8cMCxtR+dYofiFID7YoB11RttfHfhIalhVp+/mlBSCEprge11i2efRCSJ9gWYPs
         9XGcqEP3A8mQ39rPxcpRZAwomQ0fKsY90BWUJjw/da+qgTRhInW2SRYaZ3wDHtVmrK17
         MmptnK8mu20KC6mRGk/FBPIBr26xkU8NTzYCMJNXc0TFxQ0uNJji9yCyji//3pThN010
         yf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bOByWWOiLZYz2mT73IgCbyPjg+THdugeI475tkI/hts=;
        b=BDQpSjKCZKAyt1CnACY9tgJB8FeT7+RTh7ZqPCn2LxVJxtAuxd45dtKbqKWQb/CxrK
         8gNtWHcP7Uitdmhl+KCVyT1I8CP8bczP//Uhm20UWJHXvSvbom3eJ1h7ARQxNGHFGOoL
         GCyffgwMdGW2LQUaF1kOoItY/s7q7vvl5s5ihsNUsxL5oSquuzWQRXIFhwW5m+545yDN
         Ii9AqLUGTlnKQXcZYoMCSJJ9QitfEJB+qTtsnhb6UFMWpJJPiXokak0Q/F+EJs+YPLwo
         PpDKuAvFmSPWGJFmd2k8CMeLNJVGBER3pL63pNxFtlfjYr1jk+kApdB3JQ7QIppoL1Ay
         MDJQ==
X-Gm-Message-State: ALQs6tBDP4aSK2cvHBKQpY3c6hxhKeBZUfGbHZiMz9/D17/pcCb6JD94
        RZPxIosKeSzSh/dqYvr4ef51e5vjwO2yP1Jv9Xg=
X-Google-Smtp-Source: AIpwx49jOi3zUm6Q+pD8+cOJEME280B2nnGG/KER8y6ISP34X1KpGGvXYm37r4YzqnGMtbqhfvIEwEfQxL+qP2dC1kQ=
X-Received: by 2002:a17:902:74c3:: with SMTP id f3-v6mr7498372plt.7.1524171287659;
 Thu, 19 Apr 2018 13:54:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Thu, 19 Apr 2018 13:54:46 -0700 (PDT)
In-Reply-To: <CAN0heSrSn1wYGoRD6+c_Jk+rAUTbY94JLspwfiki6z4h=mnPSQ@mail.gmail.com>
References: <20180419175823.7946-1-newren@gmail.com> <20180419175823.7946-26-newren@gmail.com>
 <CAN0heSrSn1wYGoRD6+c_Jk+rAUTbY94JLspwfiki6z4h=mnPSQ@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 19 Apr 2018 22:54:46 +0200
Message-ID: <CAN0heSpvjPoXESsyBnua2NsRPMv8OqCqUdddZYxYa+87+tERMQ@mail.gmail.com>
Subject: Re: [PATCH v10 25/36] merge-recursive: fix overwriting dirty files
 involved in renames
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19 April 2018 at 22:48, Martin =C3=85gren <martin.agren@gmail.com> wrote=
:
> On 19 April 2018 at 19:58, Elijah Newren <newren@gmail.com> wrote:
>> -static int git_merge_trees(int index_only,
>> +static int git_merge_trees(struct merge_options *o,
>>                            struct tree *common,
>>                            struct tree *head,
>>                            struct tree *merge)
>>  {
[...]
>> +       memset(&o->unpack_opts, 0, sizeof(o->unpack_opts));
[...]
>> +       setup_unpack_trees_porcelain(&o->unpack_opts, "merge");
[...]
>>  }
>
> As mentioned in a reply to patch 33/36 [1], I've got a patch to add
> `clear_unpack_trees_porcelain()` which frees the resources allocated by
> `setup_unpack_trees_porcelain()`. Before this patch, I could easily call
> it at the end of this function. After this, the ownership is less
> obvious to me.
>
> It turns out that the only user of `unpack_opts` outside this function
> can indeed end up wanting to use the error messages that `clear_...()`
> would set out to free. So yes, the call to `clear_...()` will need to go
> elsewhere.
>
> It does sort of make me wonder if we should memset `unpack_opts` to zero
> somewhere early, so that we can then `clear_...()` it early here before
> zeroizing it. So yes, we'd be constantly allocating and freeing those
> strings. Am I right to assume that the code after your series would do
> (roughly) the same number of calls to `setup_unpack_trees_porcelain()`,
> i.e., `git_merge_trees()` as it did before?

Or, of course, both `setup_...` and `clear_...` would go outside this
function to churn less memory... Anyway, this still holds:

> All of this is arguably irrelevant for this series. It might be better
> if I clarify this memory ownership and do any adjustments as part of my
> patch (series), rather than you shuffling things around at this time.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF8DC433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 23:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiKKXju (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 18:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiKKXjs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 18:39:48 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7754982929
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 15:39:47 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id t10so6145692ljj.0
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 15:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xabC5HbdjkRCzSsSz3Kw72mffCBu/v/ZWq8ddjmc8iw=;
        b=VWwCDvX4Kdqy/+Os3ibC3f/HxtNYD/cCnSK4YqkjSzMm5iYoubVW5Y1UKPb6KWBlYq
         m2lvcS9g8KrQcHsJQkL4HWnY74svM3WmKsIDoWQjlallmbYD2Ck+Kyl52O388aGzT2xx
         cK9MY3scrOya0iJ7rbIe+Cp//2OKtwoguUpk/H/nw4kwKuRXvdVIzBDKM/f0C5ALUQp+
         JnXquML56209nO28+ynCV1EDTrhVJ6A0UR5FjUDBqf/u7oDlXitSDmufafzOhoL/CJBU
         8upVJtdMkOzkM95UJDcrbbE0N5l+Wzj3ZT0fABbObshaVxsJRRTt1nWbPmPafRezTJyY
         NFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xabC5HbdjkRCzSsSz3Kw72mffCBu/v/ZWq8ddjmc8iw=;
        b=jHdM1mXIXHfwt3lfiE4UzqiEKW162NjmAjsqUA6qiEaOFgmb/SWHSfO5uKxwDNuUlR
         WRZOVUoMyMBUuiQNDIWGgXfd9kWX7vSaxZJ5yhd+eVclTQqmsJiphdM/OGJCEF3v15v5
         8tLeOf9Vq2gNivNhUp5rM5mX2M/hbGY+m443ObQ+IIETpAY8+HQtt64oLCkdmk1ckTus
         3IghvznhJRWXinBFetx+h5fFijmC+sDEDZCimjAipZAwLrYSh7tXzyPmiI1wgEcCXq3o
         UelpEtADF6BizPXovNHpwY0iivzqj46YM2heSFpJfYuwt3u6S1IS1D3Ny0FXgNEXM+CD
         UDqA==
X-Gm-Message-State: ANoB5pklWQugPufBAoky1/WG4WniQZUpnwK4RDW/Y2DV5x+YDl7ulZ3z
        /5bBxtTh5NMk/i46sOcHxpErzfhxX2isfHcen9iJW0qH
X-Google-Smtp-Source: AA0mqf7vSjQkkYocinLNSLI34MduougCYW3NTj6Gi3vcTCJs2UQwrzjjzb+FeYPNZ6lARV8KXbUhJiJBFR3CJ6eSv+Q=
X-Received: by 2002:a2e:a5c7:0:b0:276:76c4:aefe with SMTP id
 n7-20020a2ea5c7000000b0027676c4aefemr1330701ljp.128.1668209985690; Fri, 11
 Nov 2022 15:39:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com> <4013f992d15aab69346bf6f8eafe38511b923595.1667846164.git.gitgitgadget@gmail.com>
In-Reply-To: <4013f992d15aab69346bf6f8eafe38511b923595.1667846164.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Nov 2022 15:39:33 -0800
Message-ID: <CABPp-BGqkSmExRN=bV2014sM5n0msiSOXBG-q-REc8Of4CM4wg@mail.gmail.com>
Subject: Re: [PATCH 03/30] extensions: add refFormat extension
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 7, 2022 at 10:48 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
[...]
> One obvious improvement could be a new file format version for the
> packed-refs file. Its current plaintext-based format is inefficient due
> to storing object IDs as hexadecimal representations instead of in
> their raw format. This extra cost will get worse with SHA-256.

> In addition, binary searches need to guess a position and scan to find
> newlines for a refname entry. A structured binary format could allow for
> more compact representation and faster access.

This doesn't parse very well at all.  The scanning is due to refname
entries being of variable length, and changing hexadecimal
representation of object IDs to binary values isn't going to help
that.

I _think_, after re-scanning your RFC cover letter that you had other
ideas to allow a binary search in order to read a single ref's value,
and that the juxtaposing of these sentences together leads to an
unfortunate assumption that one change is related to the both goals,
but something extra here to clarify would help.

> diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
> index bccaec7a963..ce8185adf53 100644
> --- a/Documentation/config/extensions.txt
> +++ b/Documentation/config/extensions.txt
> @@ -7,6 +7,47 @@ Note that this setting should only be set by linkgit:git-init[1] or
>  linkgit:git-clone[1].  Trying to change it after initialization will not
>  work and will produce hard-to-diagnose issues.
>
> +extensions.refFormat::
> +       Specify the reference storage mechanisms used by the repoitory as a
> +       multi-valued list. The acceptable values are `files` and `packed`.

> +       If not specified, the list of `files` and `packed` is assumed.

This sentence doesn't parse for me.

> +       It
> +       is an error to specify this key unless `core.repositoryFormatVersion`
> +       is 1.

...is at least 1?  Or are we trying to be incompatible with potential
future core.repositoryFormatVersion values?

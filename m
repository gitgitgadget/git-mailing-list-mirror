Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CF121F463
	for <e@80x24.org>; Sat, 21 Sep 2019 20:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfIUUer (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Sep 2019 16:34:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44291 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfIUUer (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Sep 2019 16:34:47 -0400
Received: by mail-io1-f67.google.com with SMTP id j4so24023384iog.11
        for <git@vger.kernel.org>; Sat, 21 Sep 2019 13:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hM0RzgKEv+D/eXogyTz3rQhdJO3CK3lPy5jQR+pA8gE=;
        b=q6IUIay502kY7DJCiC3avbiNUAM+nbZGs2Pc2XI/KmzwSGok692Hk1UP2t6UkuDZND
         MasJSvdVXFGmEV8uL3k2XsgwcPRvdUVFB7jKiBJztyg3gpu6k9h5CjkyRJ8MAjxoBPCE
         5JSR+DwGtMtdpgf+ehMs63cMYnLm/hTKiQ97Z5bxbtkGBstONZfWZCpJ6Ri7c2tiL+t4
         EEYqOvN7MENATBhO7DHCN2YSFZjDNMqFqH1dHSMLO0opNSIichYyRV/i65U8diCWksac
         j91SrhNtWPhTxfyqJU4RYc0Me5m+1I/OM+SfW8++3zV/FKTK+JGw6DoCRObkXfKjuPbu
         IYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hM0RzgKEv+D/eXogyTz3rQhdJO3CK3lPy5jQR+pA8gE=;
        b=X+9TfG5KTRSwkGcPn/mYDDgamvBJgcp5oE9aeRsJb66N4fIFVm0LslnYjA4Sqcl3Ur
         jEhGpMwbgob+/xSqjRn5oCHe5+Kw0FCs15chFLm3ubF/Ve12viY7fAeY+R1PeApyxThp
         oHmLoOwfDwLq7gFhqUJgc0xfRkKOk/D073V5+FX5jVThDzZcusYiAV47P4QD6yVl59Bl
         mpiteU7cM+5KFl+zYVT8ANgxuoMS2FVEmSOlQalfx9Uvw0hSoEzI/G3rVD93YwhF79Ns
         ENQzDe5zGZgwwe7xTFx0fT/Mx6Qstd8yoV3grHKhpzYU134ixmQWITNEbYnX8m+yL8cO
         SPsQ==
X-Gm-Message-State: APjAAAXRhdTSAVpJaf17vrjFkN+NDVKsYEE5xCzz1dsIfF2uCGvCJrJk
        qMIAkJVWOOyfcwWz0TpSYGxYFE3EGwzsiKekoQO+7Q==
X-Google-Smtp-Source: APXvYqxPa9XS3Pem8LGcSA5WXbVVsI0hQW79Ghnyz8ZDCQfNJ5+oV2Yth6XseiHaboH0ySBJVIibGfHdEUWTFPeTm78=
X-Received: by 2002:a6b:7116:: with SMTP id q22mr9067085iog.280.1569098086291;
 Sat, 21 Sep 2019 13:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568771073.git.matheus.bernardino@usp.br>
 <xmqq36gt5qhr.fsf@gitster-ct.c.googlers.com> <CAHd-oW4u+iPFMvSGNvSJxfPLE34dQQ3x5_aQ-Y4Pd99FXR1p7Q@mail.gmail.com>
 <xmqqh857vsqz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh857vsqz.fsf@gitster-ct.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 21 Sep 2019 17:34:35 -0300
Message-ID: <CAHd-oW5iEQarYVxEXoTG-ua2zdoybTrSjCBKtO0YT292fm0NQQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] grep: don't add subrepos to in-memory alternates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 1:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:
>
> > Hmm, I may have gotten a little confused here. Are you talking
> > about the attributes stack (which contains .gitattributes and
> > info/attributes)?  If so, isn't this stack already rebuild for
> > every path? I mean, by the previous call chain it seems to me that
> > at least these two files are reread for every path.
>
> Yes, but for the switch that happens when coming out of a normal
> directory and then descending into another normal directory is just
> to pop the entries from the directory hierarchy we are getting out
> of, and then pushing the entries from the new directory hierarchy.
> We would not be discarding and rereading $GIT_DIR/info/ or the
> .gitattribute file from the top-level of the working tree.

Right, this would be the best way of doing it. However, I think this
is not how it's currently implemented. I if correctly understood the
code in this call chain:

grep_source_load_driver() >  userdiff_find_by_path() >
git_check_attr() > collect_some_attrs() > prepare_attr_stack() >
bootstrap_attr_stack()

it seems that the whole stack is being rebuild for every path (even
for paths descending in the same superproject or submodule). So
$GIT_DIR/info/ and .gitattributes are being discarded and reread every
time :(

> Descending into a submodule is fundamentally and completely
> different.  None of the attributes defined in the superproject
> should affect the paths in the submodule, as it is a totally
> separate project, oblivious to the existence of enclosing the
> superproject.

I think we currently have a bug here as the attributes from the
superproject *are* affecting the paths in the submodule. Here is a
small script I wrote to test this: https://gitlab.com/snippets/1896951

The cause of this problem is that boostrap_attr_stack() doesn't read
"<subrepo_prefix>/.gitattributes" but just ".gitattributes", always
getting the superproject's file not the suprepo's. Yet another problem
is that when this file is not present and we need to retrieve it from
the index, this function calls read_attr() > read_attr_from_index() >
read_blob_data_from_index(). The last one always reads from
the_repository's odb, so it won't ever find the subrepo's
".gitattributes".

And a third bug is that when reading attributes of paths inside
subrepo's directories, from index, we call read_attr_from_index() with
a path such as "<subrepo_prefix>/<subdir>/.gitattributes". However,
the subrepo_prefix should be stripped when looking in the subrepo's
index, otherwise there will be no matches.

To fix these three problems, I think we would need to pass on a struct
repository in these call chains. But this would require a very big
modification as there are many places that can lead to one of them...
And there're corner cases such as index_stream_convert_blob() which
would need to receive a struct repository but it always writes to
the_repo, which would be kind of inconsistent. Do you think this would
be a good solution or should I try something else?

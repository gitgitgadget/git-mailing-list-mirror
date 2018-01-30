Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E2001F404
	for <e@80x24.org>; Tue, 30 Jan 2018 22:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753146AbeA3WLJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 17:11:09 -0500
Received: from mail-yw0-f170.google.com ([209.85.161.170]:42821 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbeA3WLI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 17:11:08 -0500
Received: by mail-yw0-f170.google.com with SMTP id u17so5983025ywg.9
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 14:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O59k9pC/F0ZlagStiEJT+5i0Evfid5tvqYrDGtJXBnM=;
        b=YW0oL00ys9HP3jl8Lb1Q8CWVycGv4u3btPtvfe2CTmqd34+Y0aTl9YhH2/FeEXD2lG
         1QUeBpGnKJb61Io8pTbc8YFORfsQiQGcCs+SdTrrV+gjZ4PsOHBozKpgsk4LniFes8Zb
         nSEHk5Bolm90Nf+ZB56mVSYMPRRQUFymwTbyhXjdUgZbzpEfSku/BBWASwhOApY18JZg
         OPUj5/fAKfQ3NBnnzmaXRy03uhjEVtwcwWxAzlL4BSA8wBcyS1H4QmvrwqA7LVu8t8+K
         19ij06nOv+HUJnm1Uxh3O6KA+L+YerYz+gO4t+KtC7cOsiAz+vStga0qLl9BVESBImo1
         g9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O59k9pC/F0ZlagStiEJT+5i0Evfid5tvqYrDGtJXBnM=;
        b=hn4pirI3NVV6XZmgpyUILQFL4iVX6E+pn7l+oGzkBPbusD1y/YWWMxR3kbZJw5CGvq
         EntXsp5Vj7UFEbNnkzeFWptSDPpiIYEBP9oJ66ygEXRqh8GxwjkITxoSp4a/qH3wnGHS
         VjzpFNi9kDMtYRdjJDyE2KLljUc5zqHnIiLDWPWRSQaUTrfW/OLd1s8+nRfPw4Z55Z6H
         76O9CLPbZjYrA4gabJGGsfBTdXFxmI31HI/P6FVj7OeVdwwQLzT2yCmswP6JgGDsCQNw
         zs/+/8qUPy5U/232EuSwUydiEURHiuDEuXxilaCwMLsOdm5O/TLASQXR/Pk2oJvTcvY3
         VeBw==
X-Gm-Message-State: AKwxytduWc/cw+IiVj8WmADBHW9ba5JmNgrWu11wc5Iubvx66pL6rCye
        GNa2aw0b2TVcsnDD/ISsBo2XikBP6jD0KjosHyAWBhjtLhM=
X-Google-Smtp-Source: AH8x224umWj7wqAA50jx+7Ly13PuqACVO4PbcS7S3eykgMeKiao8qiWnE1fElat5HuMdyYij4aniT06sIKgOWZxQ9wQ=
X-Received: by 10.13.220.3 with SMTP id f3mr20498557ywe.288.1517350267277;
 Tue, 30 Jan 2018 14:11:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 30 Jan 2018 14:11:06 -0800 (PST)
In-Reply-To: <63a7d2b3.8dd7.1613d72ec2f.Coremail.niuxu16@nudt.edu.cn>
References: <950adae.6741.160c458ce64.Coremail.niuxu16@nudt.edu.cn> <63a7d2b3.8dd7.1613d72ec2f.Coremail.niuxu16@nudt.edu.cn>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 Jan 2018 14:11:06 -0800
Message-ID: <CAGZ79kbYgTVw0LH6w14Ho_g0yy7XBLhoZO_vP71GHYf4JdmfYA@mail.gmail.com>
Subject: Re: recommendations for log enhancement
To:     =?UTF-8?B?54mb5pet?= <niuxu16@nudt.edu.cn>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 28, 2018 at 7:46 AM, =E7=89=9B=E6=97=AD <niuxu16@nudt.edu.cn> w=
rote:
> Our team studies the consistent edits of git during evolution. And we fin=
d several missed edits in the latest release of git. For example, there are=
 two consist edits we have figured out from historical commits:

Thanks for studying the code of Git. It will help the project in
bettering the code.
Welcome to the Git community!
Which version do you mean by "latest release" ?


> 1) . Version: git 2.3.9 =E2=80=93 git-2.3.10
>        File: builtin/merge-tree.c
>
>         dst.size =3D size;
> -       xdi_diff(&src, &dst, &xpp, &xecfg, &ecb);
> +       if (xdi_diff(&src, &dst, &xpp, &xecfg, &ecb))
> +               die("unable to generate diff");
>         free(src.ptr);
>         free(dst.ptr);
>  }
>
> 2) .Version: git 2.3.9 =E2=80=93 git-2.3.10
>       File: combine-diff.c
>
> -       xdi_diff_outf(&parent_file, result_file, consume_line, &state,
> -                     &xpp, &xecfg);
> +       if (xdi_diff_outf(&parent_file, result_file, consume_line, &state=
,
> +                         &xpp, &xecfg))
> +               die("unable to generate combined diff for %s",
> +                   sha1_to_hex(parent));
>         free(parent_file.ptr);
>
> Those two commits both add if structure and log messages for handling the=
 return value of xdi_diff_outf().
> And in the latest release, we find one candidate that may also need log s=
tatements inserted:
> 1)  File: git-2.14.2/builtin/rerere.c
>
>      1  static int diff_two(const char *file1, const char *label1,
>      2                  const char *file2, const char *label2)
>      3  {
> =E2=80=A6.
>     20          ret =3D xdi_diff(&minus, &plus, &xpp, &xecfg, &ecb);
>     21
>     22          free(minus.ptr);
>     23          free(plus.ptr);
>     24          return ret;
>     25  }
> ...
> }
>
> There are more examples of consistent update and corresponding suggestion=
s in attachment. It is so nice of you to read them and share me with your o=
pinion on the correctness of our suggestion. Thanks a lot.

Thanks a lot for this suggestion and the suggestions in the attachment.

However these are less than optimal to consume for the project.
Care to make these changes as actual commits in your local repository
and then send patches?

See Documentation/SubmittingPatches
https://github.com/git/git/blob/master/Documentation/SubmittingPatches

Thanks,
Stefan

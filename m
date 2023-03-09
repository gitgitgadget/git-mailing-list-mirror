Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC87C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 23:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCIXVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 18:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCIXVT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 18:21:19 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A78F4DA9
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 15:21:18 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t15so3468861wrz.7
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 15:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678404077;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1370zV1+1u4oVmEV4YVArIOZprpJLtQYIK8ykn8a5E=;
        b=Yk3Zh8P7XeQc1gaV6jUeEM/1xWurMoiB7IB+lRwY5osCdtL90WpORNT2869NklRdzf
         2LzkaZcLuWbv3kC4hKWFfylv3r3SffWx0INU95dbIhUCIpubBK4jDgjknaWc6rraD3Bx
         GtkK+ZsqwihNoT40x6drRsaPsg1QhbxeK2HrTx4gcQ7cVq+rdLU3EMYw9sYDlIVAXJNY
         U2NG9xF6S8e117irdzs+jUEYjqZo2vaEtuEzMDORtdMCx5SuqDsVV0fhvTTmJpughNOm
         QqKsUOZM/MiDwZmXpA4QLcUW05UIEZHTFZrTUPJt2mk+5yAfmtrq9wQfXrFCreN4mPmU
         FJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678404077;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1370zV1+1u4oVmEV4YVArIOZprpJLtQYIK8ykn8a5E=;
        b=GEbYZHmc4oHgcHSPg2Gx5CLC+v33EtNw7kxQEmO5yuYqXyxpFANFgwNXPxDwRF1COk
         q2Behx7Qdf2FEpUenwTTCnaBghFUKSSKuIUzCYRvQPoKCR+pVh9W+wkdc2t0KUY5C4Nf
         e4AEzoDIm7O3wLxwJXH1EwqDVrmcIFN8DahrRG16aa++pCntzlIo1MWs/S9BZ/UU9c0f
         ATX2tsJN5VBEhWX39oKNmN96ZektTJfqsb/ToiuV7xvW0awJAaih/x/vsEXxMrTabrdG
         tlqTt4GjdolJmZELJx8uamx/M8JQb6hqKBHb+M2SMNOenZnLmLnsqS/wo3UNovPrMGlI
         CJhQ==
X-Gm-Message-State: AO0yUKUZm7Cg5tSJkAAuPixPYKMajBDJaCQUWn+3O377QwpBifkNaoa3
        4MNcQLWLXvX+a7pLQ1RqtWtf+Zixnx9FmDZs3ao=
X-Google-Smtp-Source: AK7set/rpBO91bmJ4yQXCG2oEs5EzfsUACgWwr5NWVbily7gJaRF4bu0V+m+fZexHhNrAuH8f1b8pb+z482wfOQxalU=
X-Received: by 2002:a5d:4b83:0:b0:2c5:530c:cd36 with SMTP id
 b3-20020a5d4b83000000b002c5530ccd36mr5121144wrt.5.1678404076526; Thu, 09 Mar
 2023 15:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20230309013314.119128-1-cheskaqiqi@gmail.com> <20230309063952.42362-1-cheskaqiqi@gmail.com>
 <20230309063952.42362-2-cheskaqiqi@gmail.com> <xmqqmt4lc03s.fsf@gitster.g>
In-Reply-To: <xmqqmt4lc03s.fsf@gitster.g>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Thu, 9 Mar 2023 18:21:04 -0500
Message-ID: <CAMO4yUFs5zSafO1pGFZqBU9R58G8ENhfTh5qNayeFMRPrCa+Jg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] t1092: add tests for `git diff-files`
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>, vdye@github.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On Thu, Mar 9, 2023 at 12:20=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

>
> > +     run_on_all ../edit-contents deep/a &&
> > +
> > +     test_all_match git diff-files  &&
>
> An extra space on this line.
>
> > +     test_all_match git diff-files deep/a
>
> And on this line.

Will do !


> As output from checkout and index are known to be identical (that is
> one of the things that test_sparse_match does), I do not think there
> is much point checking -out from both sides.
>
> If we know "diff-files" invocation above should never send anything
> to the standard error, then checking that sparse-checkout-err is
> empty may have value, though.

Agree!

> > +     # file present on-disk with modifications
> > +     run_on_sparse ../edit-contents newdirectory/testfile &&
> > +     test_sparse_match git diff-files &&
> > +     test_sparse_match git diff-files newdirectory/testfile
>
> We do not care what the actual output is in this case?

I wonder if the method below is good  to test the actual output for '
file present on-disk with modifications' :

    cat >expect  <<-EOF &&
    :100644 100644 8e27be7d6154a1f68ea9160ef0e18691d20560dc
0000000000000000000000000000000000000000 M newdirectory/testfile
    EOF

     # file present on-disk with modifications
     run_on_sparse ../edit-contents newdirectory/testfile &&
     test_sparse_match git diff-files &&
     test_cmp expect sparse-checkout-out &&
     test_sparse_match git diff-files newdirectory/testfile &&
     test_cmp expect sparse-checkout-out

-------------------
Thanks,
Shuqi

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C901F597
	for <e@80x24.org>; Thu,  2 Aug 2018 21:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeHBXJB (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 19:09:01 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46668 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbeHBXJB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 19:09:01 -0400
Received: by mail-yw1-f68.google.com with SMTP id e23-v6so177194ywe.13
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 14:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tUGqlId6W+ODMIlSpM212U/aNOLCQ5DiNb1uNd5XDBw=;
        b=izzsJGeyier0z5xQsqOmN7OpKOjnl2A9Rb80KxXoaoCLfSJJggrTKZ2ZMefbAUW0nx
         3ozMlfWzbCTGgHJac7q9aMSQ6ajaTzcCFVxg9gbD5WC4zK5Du3Jyt/4O7F75v8JkPJgi
         /cSqE7n941xyeVgFifwnIxprfWyQ1AmFo17fDSdPPpQ9CH7fOY1vJWZHGG1jDrzbtpcH
         hofWunL1A3AcAn2jFk4PNCBu0G/9KvdVdJLlRDqRLVdjdNu0i9a5XAw5cqi+aTPY+dUe
         hx7fGAjHRK/chjL4SjIxslFw1A6VyAT4tumzni2sA04CujMD9q4/Zq8aDneVR+2DZp7Y
         lhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tUGqlId6W+ODMIlSpM212U/aNOLCQ5DiNb1uNd5XDBw=;
        b=cpn1i7kJuVzQeYZHk8Nmr6c6fkKb2CNBFMZ/8MMCRpyRUyN0K1g8498ztofH2Af5rd
         IGdlI/qCg9Y+udzSYsm9iI7pYatSQNc3UBA5RqfEs30lbdypUsgejrD/HeDtl8+xg9Ox
         GM0mIKDwseE+OQ9l6rnbFZbmuZYpbOxRxsaoF4qxDpE77PzvrlSz8oHvwUUsf3GQnmKz
         EBDz+QB1+qSF8SKrReknNONTi5vJEe8McRKlxS2JJZNhsxvsq3SnMNM8xo91Q3W+a353
         GpxRw+aW93zU16VCwTJukoUvckgiRA/ioG1Stt2sEQnggtQRN8+jYiokIdrikqHBaUzc
         Gg8w==
X-Gm-Message-State: AOUpUlHq+4xy0o9rlP6u4G0ty66Ezqh8YhPahQfuG4h8iMEeQMeUSk/y
        HCijlatX1qCawZf6uuZaDQ4cqQk2FCpfGySYigcPkA==
X-Google-Smtp-Source: AAOMgpcO1f7Yxb69P0H9z0P0sSp2N6A5TeCHHczzXjzqVqK924eblg7T203kmrhXqtHaaMZqkH/udEPYVw693O4jryo=
X-Received: by 2002:a81:af67:: with SMTP id x39-v6mr705133ywj.33.1533244565967;
 Thu, 02 Aug 2018 14:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180802134634.10300-1-ao2@ao2.it> <20180802134634.10300-13-ao2@ao2.it>
In-Reply-To: <20180802134634.10300-13-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Aug 2018 14:15:54 -0700
Message-ID: <CAGZ79kaDK9nuUm_hqAZKMHydiaBDhDkM_y1UFwpRHoGjCQoq4w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 12/12] submodule: remove the .gitmodules file when
 it is empty
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 6:47 AM Antonio Ospite <ao2@ao2.it> wrote:
>
> In particular this makes it possible to really clean things up when
> removing the last submodule with "git rm".

This sentence is a continuation of the subject line, and I had to reread
it to follow along.

>
> The rationale is that if git creates .gitmodules when adding the first
> submodule it should also remove it when removing the last submodule.

I agree with this sentiment. It seems slightly odd to me to have this tied
in the same patch series that changes .gitmodules reading behavior
as I could think of this feature as orthogonal to what this series achieved
up to patch 10.

> -       test_cmp expect actual &&
> +       test_cmp expect.both_deleted actual &&

This seems to be the re-occuring pattern in t3600, and given that
we have

  cat >expect <<EOF
  M  .gitmodules
  D  submod
  EOF
  cat >expect.both_deleted<<EOF
  D  .gitmodules
  D  submod
  EOF

with no other writing of expect in the range, this seems to be correct.
Maybe worth testing that we do not delete a .gitmodules file if we have
more than one submodule? (But I would expect this to be covered implicitly
somewhere in the test suite. If so that would be worth mentioning in the
commit message instead of writing a test -- just looking quickly we
do have " git rm --cached submodule2" in t7406 which might be sufficient?)

>  test_expect_success "rm absorbs submodule's nested .git directory" '
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 48fd14fae6..2bb42a4c8f 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -99,6 +99,17 @@ inspect() {
>         )
>  }
>
> +test_expect_success 'removal of last submodule also removes empty .gitmodules' '
> +       (
> +               cd addtest &&
> +               test ! -d .git/modules &&

test_path_is_missing ?

> +               git submodule add -q "$submodurl" first_submod &&
> +               test -e .gitmodules &&

test_path_is_file

> +               git rm -f first_submod &&

Do we need to force it here?

> +               test ! -e .gitmodules

test_path_is_missing

Thanks for this series!
Overall it was a pleasant read, though I had some comments.

Thanks,
Stefan

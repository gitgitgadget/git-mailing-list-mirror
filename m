Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3900EC433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 09:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJCJgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 05:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiJCJgM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 05:36:12 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C995A803
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 02:30:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bq9so15798566wrb.4
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 02:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date;
        bh=iz52hV6KWDAq5qYYqsR1Fi3cp6UuJEnpncmzjPYMe8g=;
        b=hFT+80cWwMvG2KKlezt76qSdnq7P7eues1MQtZw7+lZ+9QHV3wr7oDsvGdPxilskZ4
         H8FIwD7no9yf0KpAyZczyfqnXo4ZsKdjr6ehwdGAsAULN2YO9K7sV/b0lh5bqdDgKUJ+
         y6zpt5nuXxO1lpjnNOYh5MYFOI1Wz4ZKKTfoVatE2+880K/KLBYu+duHaJy+c6puvFhj
         hgBEXpOnUbQHAp42GZTTeG8sG003963IhPqS0PRonAUdf9BZRoODtUJgDGzFNp88B5mB
         HQ5FFPs5sKLNAkDZCXSF/OCyfKRZK1CmF9AOEfCPjiRvaHl8ufJmu3H/3UX2mdcI9hCE
         VoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date;
        bh=iz52hV6KWDAq5qYYqsR1Fi3cp6UuJEnpncmzjPYMe8g=;
        b=AADyY8BNcQnP2V5Y4fC1o1S9iY8E6qzDJwcmYRbyF/y5rZ+WJc05PArKzdKoIuk7lo
         UWC+aWhCaZfk/zxb2FuMiNwPrLGg5UZkilhf7qdvvzRaWZtHo6EEEld1AhvyTlL8bwy/
         OdaJYFm/zraFHP4XN5kSDDImXunHElZ200v9jsOL+ZHIMiM9doYm5n8PUvtPkFskUWkY
         AJtcLTjHuobZePudY7+6dq+lB9wBR1A0SHQdJhZ61R/WonmEO+5gzCKRqSpBPVwQ3zYW
         YXR/BRF00Tj39G1dClqCJIZuqlsCupanR6nv2Yq1ymAjeg3G1IuGI/52YQy6Xo3yKIIN
         RWxQ==
X-Gm-Message-State: ACrzQf0mSy4dQh/VDVz2tjfTHWCdi4E9zm7t9PlTXBLleAZwskWJPUOv
        LwXYg9eBO7HzQL8Y1DDP5FwuWpU4Z7Q=
X-Google-Smtp-Source: AMsMyM59qXrTT+4HoN9c1swLMeDGHPN84WW2EZhmAaZ360XQ+tuujqkMVeDe2tW8CEB64NAfDwkHNQ==
X-Received: by 2002:a5d:5887:0:b0:22b:1255:42e5 with SMTP id n7-20020a5d5887000000b0022b125542e5mr12863322wrf.114.1664789365708;
        Mon, 03 Oct 2022 02:29:25 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id e18-20020adff352000000b0022cdb687bf9sm11696723wrp.0.2022.10.03.02.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 02:29:25 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <f0a5abe5-761d-4c92-68df-cfd26a414c23@dunelm.org.uk>
Date:   Mon, 3 Oct 2022 10:29:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: detect author name errors in
 read_author_script()
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        "Michael V. Scovetta" <michael.scovetta@gmail.com>
Cc:     git@vger.kernel.org
References: <CADG3Mza_QU+ceTUsMYxJ3PzsEqi8M98oOBAzzz0GHRJ-F7vkpA@mail.gmail.com>
 <YzqhEcTDwMwa8dQX@coredump.intra.peff.net>
In-Reply-To: <YzqhEcTDwMwa8dQX@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On 03/10/2022 09:45, Jeff King wrote:
> On Sun, Oct 02, 2022 at 11:39:16PM -0700, Michael V. Scovetta wrote:
> .
>> In commit 2a7d63a2, sequencer.c:912 looks like:
>> 912  if (name_i == -2)
>> 913      error(_("missing 'GIT_AUTHOR_NAME'"));
>> 914  if (email_i == -2)
>> 915      error(_("missing 'GIT_AUTHOR_EMAIL'"));
>> 916  if (date_i == -2)
>> 917      error(_("missing 'GIT_AUTHOR_DATE'"));
>> 918  if (date_i < 0 || email_i < 0 || date_i < 0 || err)    <-- date_i
>> is referenced here twice
>> 919      goto finish;
>>
>> I'm fairly sure that line 918 should be:
>> 918  if (name_i < 0 || email_i < 0 || date_i < 0 || err)
> 
> Agreed, but +cc Phillip as the original author.

Thanks, I must have got confused as I was typing.

>> I haven't validated this, but I suspect that if
>> `rebase-merge/author-script` contained two GIT_AUTHOR_NAME fields,
>> then name_i would be set to -1 (by the error function), but control
>> wouldn't flow to finish, but instead to line 920 ( *name =
>> kv.items[name_i].util; ) where it would attempt to access memory
>> slightly outside of items' memory space.
> 
> Correct. It also happens if GIT_AUTHOR_NAME is missing.
> 
>> I haven't been able to actually trigger the bug, but strongly suspect
>> I'm just not familiar enough with how rebasing works under the covers.
> 
> It's a little tricky, because we avoid writing and reading the
> author-script file unless necessary. An easy way to need it is to break
> with a conflict (which writes it), and then resume with "git rebase
> --continue" (which reads it back while committing).
> 
> Here's a patch to fix it. Thanks for your report!

Yes thank you for reporting this Michael

> -- >8 --
> Subject: sequencer: detect author name errors in read_author_script()
> 
> As we parse the author-script file, we check for missing or duplicate
> lines for GIT_AUTHOR_NAME, etc. But after reading the whole file, our
> final error conditional checks "date_i" twice and "name_i" not at all.
> This not only leads to us failing to abort, but we may do an
> out-of-bounds read on the string_list array.
> 
> The bug goes back to 442c36bd08 (am: improve author-script error
> reporting, 2018-10-31), though the code was soon after moved to this
> spot by bcd33ec25f (add read_author_script() to libgit, 2018-10-31).
> It was presmably just a typo in 442c36bd08.

s/presmbly/presumably/

> We'll add test coverage for all the error cases here, though only the
> GIT_AUTHOR_NAME ones fail (even in a vanilla build they to segfault

Do you mean "they ought to segfault"?

Thanks for fixing this and going to the trouble of adding some tests.

Phillip

> consistently, but certainly with SANITIZE=address).
> 
> Reported-by: Michael V. Scovetta <michael.scovetta@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The tests kind of feel like overkill, as this is such a specific
> condition and I doubt we'd regress to have the same bug twice. But it
> was nice at least to confirm the bug and the fix now.
> 
>   sequencer.c                    |  2 +-
>   t/t3438-rebase-broken-files.sh | 53 ++++++++++++++++++++++++++++++++++
>   2 files changed, 54 insertions(+), 1 deletion(-)
>   create mode 100755 t/t3438-rebase-broken-files.sh
> 
> diff --git a/sequencer.c b/sequencer.c
> index d26ede83c4..83e0425b04 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -915,7 +915,7 @@ int read_author_script(const char *path, char **name, char **email, char **date,
>   		error(_("missing 'GIT_AUTHOR_EMAIL'"));
>   	if (date_i == -2)
>   		error(_("missing 'GIT_AUTHOR_DATE'"));
> -	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
> +	if (name_i < 0 || email_i < 0 || date_i < 0 || err)
>   		goto finish;
>   	*name = kv.items[name_i].util;
>   	*email = kv.items[email_i].util;
> diff --git a/t/t3438-rebase-broken-files.sh b/t/t3438-rebase-broken-files.sh
> new file mode 100755
> index 0000000000..e68aac4b36
> --- /dev/null
> +++ b/t/t3438-rebase-broken-files.sh
> @@ -0,0 +1,53 @@
> +#!/bin/sh
> +
> +test_description='rebase behavior when on-disk files are broken'
> +. ./test-lib.sh
> +
> +test_expect_success 'set up conflicting branches' '
> +	test_commit base file &&
> +	git checkout -b branch1 &&
> +	test_commit one file &&
> +	git checkout -b branch2 HEAD^ &&
> +	test_commit two file
> +'
> +
> +check_broken_author () {
> +	title=$1; shift
> +	script=$1; shift
> +
> +	test_expect_success "$title" '
> +		# create conflicted state
> +		test_when_finished "git rebase --abort" &&
> +		git checkout -B tmp branch2 &&
> +		test_must_fail git rebase branch1 &&
> +
> +		# break author-script
> +		'"$script"' &&
> +
> +		# resolving notices broken author-script
> +		echo resolved >file &&
> +		git add file &&
> +		test_must_fail git rebase --continue
> +	'
> +}
> +
> +for item in NAME EMAIL DATE
> +do
> +	check_broken_author "detect missing GIT_AUTHOR_$item" '
> +		grep -v $item .git/rebase-merge/author-script >tmp &&
> +		mv tmp .git/rebase-merge/author-script'
> +done
> +
> +for item in NAME EMAIL DATE
> +do
> +	check_broken_author "detect duplicate GIT_AUTHOR_$item" '
> +		grep -i $item .git/rebase-merge/author-script >tmp &&
> +		cat tmp >>.git/rebase-merge/author-script'
> +done
> +
> +check_broken_author 'unknown key in author-script' '
> +	echo "GIT_AUTHOR_BOGUS=${SQ}whatever${SQ}" \
> +		>>.git/rebase-merge/author-script'
> +
> +
> +test_done

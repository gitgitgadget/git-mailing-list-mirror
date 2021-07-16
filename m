Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27595C07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 12:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029EE61374
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 12:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhGPMk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 08:40:57 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:32812 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232620AbhGPMkx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 08:40:53 -0400
Received: from [127.0.0.1] (144.178.202.138.static.ef-service.nl [144.178.202.138])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 64C23CA821;
        Fri, 16 Jul 2021 12:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1626439075; bh=D0i6d65GR1L+ORanK5o9lQn/fNOIP6T6wTlhLwNOkq8=;
        h=Date:From:To:Subject:In-Reply-To:References;
        b=KK29Dp9iAF7+b4sTrcQOHSwVP943Ho7DHSPX3pp7YrSZObJqtKbgmdDTsy69y+YTt
         r3Y5evtq3uIBcRZmz3gy+4KHaq82KmRwVqoLoMkCDomVhxeyHuEQN3spXM1wYrfm+w
         boICWHBicyuDQ7dZOjG+VTUCxp7yOZ2RVhnE41pw=
Date:   Fri, 16 Jul 2021 14:37:48 +0200
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Luca Weiss via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] merge: make sure to terminate message with newline
User-Agent: K-9 Mail for Android
In-Reply-To: <8678772b-dd5d-9188-8b63-98d05cedb323@gmail.com>
References: <pull.1048.git.git.1626421416.gitgitgadget@gmail.com> <31371c25743e1001b4fac89e80e7206ff477ac8a.1626421416.git.gitgitgadget@gmail.com> <8678772b-dd5d-9188-8b63-98d05cedb323@gmail.com>
Message-ID: <AB048897-F70A-4388-B2A6-56BFEA40B303@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=luca@z3ntu.xyz; keydata=
 mQINBFgc0/QBEACzBE9TBfe+O2TARphhmhVgMd2zo3lkvjWdohb9mg9+NvUq7swQR2l8davgwaTN
 VwDUA9jdzfjp4GShf0VFnqqFGouEc3OMeuHFdtjG4RoYGW+XvEoAcTWgY6glANmMZMi33D+2wnQQ
 Qziie3LMTQ7Tlpk8at8Ck4ShmmGTmek9LNFq1eHs3IHK5eH0fDA/rYvPxFMmwbHRDjdwtXjZlXBC
 nxEXK8CJkNG58G+RbtPU0I8Iu02TDOkr9x6KwLT1lJmq03wCkuQEXrDAzo6kkeAMhzWBtBtxTB1M
 byOZqNlbzEtxOTK9iA74U6POyN//876ESQ87LicFS4mgoyHL0Vt7ro9CSH7Imzv96Ae8HDZqIcBy
 Bn9YMBswjy4JOsC9JP/oDhr71y40nnrVvgx4ZesJM0PL9J1JYQWJQ22GoinnDwSB11Re51OYsK+l
 xEqph38N+AjcNYm+l85O/l+BkkULC+0kHWG6wQCv67KyeYCJJhNqJucXj2gXXaKyv2ltWPwHgK6w
 OAtN9QbimcYV2PUgfx6hl5r7buwc3tefp9ccmtoLq74mgrKiLurHqa4pKCa1uqfhBEN5/Os5tMrX
 IGa2sRvKHK0Pn7iyJQyuclyOp4r9W+QUw2DENm4n6ovkl7rfriL6ibBgVLcnexdG/8LZRaWFV96G
 YY3VCcRlz8SCwQARAQABtBtMdWNhIFdlaXNzIDxsdWNhQHozbnR1Lnh5ej6JAlQEEwEIAD4CGy8F
 CwkIBwIGFQgJCgsCBBYCAwECHgECF4AWIQS9BNokyXG41YeyuNf69pz2zS0CzQUCX5CaYAUJCVT5
 7AAKCRD69pz2zS0Cze7SD/0Xnvid+b9qeqAoXZeAqju1sXlv1BU8dNvA7AlDOQejNOAOO64DB8Ye
 r6AWu5Wcizo0KHEGPKmgJaAcjUac9MqFdLfhImsnUKEC6cjVeIJE5fynkNibtucQQFWO6nQMMF/3
 DmmfFOVeY70dhUzprvR8iYHyehh2yytQ7X7y83DSC89GpWq5hHJX41M3M0g006mPSNQvd79XXXVe
 RM7CUg6Ny3f3nThD7oa6SjLPF3hvYnhg1QTZk2zF3P0IeK+GiXI6RrogNBrCSKr2u3jW1QwiFJu1
 RI8TFgYdxMFyckUDpLZbsgEOsss07ffROQm7i+tVVlUQH7RM9TWVxA7jCMkFYtiE4V0WrTowcuk+
 28g/L/SKC+wrhAV/s98+CghS7u7A/xhamXGMdcW2ZQEUkvTBJULe6343bM1RkiYDKbfra1p8/rww
 TH5G3mtoCf8in7VlfNEcjf00oBHHtoz3xZtIRRf7QaW7XOz9vQaMV0YcmGhZzFd/tbWI9R74gwqD
 Zf9Qtt5P4ptKBYH7yKqvl1wuncTDrIcltMgSfeP9Z6yt+EkMz08XvZwC6OboozEmM+zd7jbCcjom
 o3XNYUDvgBPZq+nWzOGFH8KdPHnLHbso2DZf5StxKdYXH8WWyJkQqLW+BYCiGxTLfjyFofEUoTdY
 2bEWznuNRPmsKWeqEkzxyA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

So the behavior that I have observed is the following:

I've added a usleep for ~10 seconds instead of the line I added and
=2Egit/MERGE_MSG was not terminated with a newline=2E
This didn't change when using --log
It was properly handled with --signoff and the trailer was added
correctly=2E

I have a simple reproducer here:

mkdir /tmp/test
cd /tmp/test
git init
echo 'dest=3D"$1=2Etmp"; git interpret-trailers --trailer "Foo: Bar" < "$1=
" > "${dest}"; mv "${dest}" "$1"' > =2Egit/hooks/commit-msg
chmod +x =2Egit/hooks/commit-msg
git commit --allow-empty -m "Initial commit"
sleep 1
git switch -c foobar
git commit --allow-empty -m "Foo1"
sleep 1
git commit --allow-empty -m "Foo2"
git switch master
git merge --no-ff --no-edit foobar
# look at merge commit message now

With my patch(es) this works properly=2E

If you have any other ideas on how to fix this, I am open for
suggestions :)

Otherwise I'll try to add more detail to the individual commit
messages (I deliberately kept the "unnecessary" detail out of the actual
commit messages before)=2E

Regards
Luca

p=2Es=2E sorry for replying off-list, and if this is wrongly bottom/top po=
sted, email client troubles ;)

On July 16, 2021 12:23:06 PM GMT+02:00, Phillip Wood <phillip=2Ewood123@gm=
ail=2Ecom> wrote:
>
>Hi Luca
>
>Thanks for your patches=2E It would be very helpful to have the=20
>explanation from the cover letter in the commit messages for both=20
>commits to explain why this change is being made, otherwise that=20
>information will not appear in the history=2E
>
>The cover letter says this happened when using '--no-edit', but unless=20
>I've missed something 'git merge --no-edit' creates its message using=20
>fmt_merge_msg() which calls strbuf_complete_line() just before it=20
>returns=2E append_signoff() and 'merge -m' always terminate the message=
=20
>with a newline=2E The only path I found that does not ensure the message=
=20
>ends with a newline before calling the prepare-commit-msg hook is when=20
>using '-F' and I suspect that may have been a deliberate decision but it=
=20
>could be an oversight=2E In any case we would want to make sure that 'git=
=20
>commit -F' and 'git merge -F' to behave the same which I think they do=20
>at the moment=2E
>
>Best Wishes
>
>Phillip
>
>On 16/07/2021 08:43, Luca Weiss via GitGitGadget wrote:
>> From: Luca Weiss <luca@z3ntu=2Exyz>
>>=20
>> Signed-off-by: Luca Weiss <luca@z3ntu=2Exyz>
>> ---
>>   builtin/merge=2Ec | 1 +
>>   1 file changed, 1 insertion(+)
>>=20
>> diff --git a/builtin/merge=2Ec b/builtin/merge=2Ec
>> index a8a843b1f54=2E=2E646bb49367f 100644
>> --- a/builtin/merge=2Ec
>> +++ b/builtin/merge=2Ec
>> @@ -867,6 +867,7 @@ static void prepare_to_commit(struct commit_list *r=
emoteheads)
>>   	}
>>   	if (signoff)
>>   		append_signoff(&msg, ignore_non_trailer(msg=2Ebuf, msg=2Elen), 0);
>> +	strbuf_complete_line(&msg);
>>   	write_merge_heads(remoteheads);
>>   	write_file_buf(git_path_merge_msg(the_repository), msg=2Ebuf, msg=2E=
len);
>>   	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-comm=
it-msg",
>>=20
>

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 145511FC44
	for <e@80x24.org>; Mon,  8 May 2017 21:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbdEHVY7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 17:24:59 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34818 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbdEHVY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 17:24:58 -0400
Received: by mail-io0-f196.google.com with SMTP id o12so2760480iod.2
        for <git@vger.kernel.org>; Mon, 08 May 2017 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+lvmQ/GF07Vw1+EYptJCn7pThR5NmeD+3/ITNXUqSPI=;
        b=mey8Qhk+g425ZFs6tChgm51/B73QFuCCX7aW1JdincNR2ztQEdWUAT2wzkPuIqePqK
         4AH9HFgCQ48KUCu3fJ3YcRa16Ke/sM4dK6jmhbaPvler6cHEND+EbVSCFyR6BochW3ye
         qXJj/nA2ZfuYSgZ9Cfj6RK1FB/ljOLHucEtAESJ0f7/rPIGzGsftCjVp4zbwyg+MMdw9
         OzSyOG9nlcb9iq9h82prYnEBXN+wIy6gyy+U5QKCuQgPrmKJFa3q/r+T7rm6/BNBnBFC
         JrqJVm9ewGwAuTQkmrAbPq2aH9eTdIvSf4dpGegWduE5j+YG3bF5hKvl6caDwX7pZ6Sr
         FUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+lvmQ/GF07Vw1+EYptJCn7pThR5NmeD+3/ITNXUqSPI=;
        b=sFfM9HUI583RhnuRL7zA+m7k8lISmu4hNM4xfMktEZaXrrnsuEne6gz4tcxCwbadTm
         ABQAchh0j6DztM5qHWzEYDmkbHuzH4l4OewgXeQxFJ0IWGbjp3UfZ/kRdY4eakclqTba
         6ajDCV1XBBqvQzL5hbDm0RCOJNCd+uDwEL8XnPb3qOWmDRWHuSmkkvN0yn+2kTud0ha9
         WyQwVGf/l2g+5XwT1rAYpZ2gq1v8CbnUSrx5hO56JNVqOViPilg1vJqUMZhFgz/CRf+u
         GRG5b92OzHcPznSNGSKNETqH8sD4Fsrc8s/EcvrhVXAsORad4qbjw+W79rUpIKSMWisW
         075w==
X-Gm-Message-State: AODbwcALYpqFstSMbqnkj5M2/8QBJLKDp4tU1W47PO8xhNENI/dJAqbR
        WtQxSaE5WN/QtkrG6OryxD1VCO4bVdp+
X-Received: by 10.107.201.206 with SMTP id z197mr2554317iof.85.1494278697949;
 Mon, 08 May 2017 14:24:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Mon, 8 May 2017 14:24:17 -0700 (PDT)
In-Reply-To: <22e44a7d-0e9a-3e49-14c7-d69d6c6d733a@web.de>
References: <20170505104611.17845-1-sxlijin@gmail.com> <20170505104611.17845-2-sxlijin@gmail.com>
 <22e44a7d-0e9a-3e49-14c7-d69d6c6d733a@web.de>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Mon, 8 May 2017 16:24:17 -0500
Message-ID: <CAJZjrdVGm9j_yja+sfW7K5CPdHqXKxGBK7WWqmxNpowEYZ_2gA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] t7300: skip untracked dirs containing ignored files
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 7, 2017 at 2:12 PM, Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
> On 2017-05-05 12:46, Samuel Lijin wrote:
>> If git sees a directory which contains only untracked and ignored
>> files, clean -d should not remove that directory. It was recently
>> discovered that this is *not* true of git clean -d, and it's possible
>> that this has never worked correctly; this test and its accompanying
>> patch series aims to fix that.
>>
>> Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
>> ---
>>  t/t7300-clean.sh | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
>> index b89fd2a6a..252c75b40 100755
>> --- a/t/t7300-clean.sh
>> +++ b/t/t7300-clean.sh
>> @@ -653,4 +653,14 @@ test_expect_success 'git clean -d respects pathspec=
s (pathspec is prefix of dir)
>>       test_path_is_dir foobar
>>  '
>>
>> +test_expect_failure 'git clean -d skips untracked dirs containing ignor=
ed files' '
>> +     echo /foo/bar >.gitignore &&
>> +     rm -rf foo &&
>> +     mkdir -p foo &&
> Minor remark:
> Do we need the -p here, or can it be dropped?

Yeah, the -p isn't needed here - will change when I reroll.

>> +     touch foo/bar &&
>> +     git clean -df &&
>> +     test_path_is_file foo/bar &&
>> +     test_path_is_dir foo
>> +'
>> +
>>  test_done
>>
>

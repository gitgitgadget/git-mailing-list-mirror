Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F15AE1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 16:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbeAZQzo (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 11:55:44 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:42892 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbeAZQzn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 11:55:43 -0500
Received: by mail-vk0-f65.google.com with SMTP id t4so664011vkb.9
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 08:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PyRnTV6naR7wzhcsUhQ3FIVOA/Mxaiu2yFJsMGOw4PQ=;
        b=O80Lug5jmICNcuZUzxjg6teUv5UzdZ71BSyHZo+1gz2U680Bqfb4Qpi9ZR6vronoXA
         CYTXFK8/1zxpZ4sxxaCtJby1lPgWuLN0/Yltsy3NZ7hxvwBS8WsBdzBCzaPeAUriHhxH
         HWEKRd/g8eMl54zQggoH4Z2XmGFY6mf5Rc9zI3O/ykE3LtJxlgunKbL0XrMf7PDEP0Xi
         5704mNBQU/j1nouRm/DFhDkmn8G6aIP5MLgoHwI8AUskJkhdYnCg99kfwKdbbrKDrfe4
         jXCSYCsnTrmrQs2qx+FDlgSY5/5kM0zLPa7y5uChBNG7dcd/pgeaktPa71Ikvx6/PZW3
         l9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PyRnTV6naR7wzhcsUhQ3FIVOA/Mxaiu2yFJsMGOw4PQ=;
        b=OjMqmYbrw1wRInExtBYtu3xpbpcQYaPDlV53jfaeqcRFUT3SCigRzaY4FIKQlGc1M2
         u17ZKI7va5eRT7p9nmBNO494L8jqbPjTLuxvqA+gkmlgWDWYv54kIILeWLUAuLhvFyji
         XA53lqdoYQIzSvOHqc709HMcR26ezcgBo/IeQtXreMwPEVKJVCezVaNsRbg5ERVCLPy5
         VhgtiUPLmVJvxvFRvJiv8diw6gCzVS9xF0ofWkZdB0PjZ3ZX0uqtA9no309fNwJssTGT
         8wE1vdoOIG/ZJCvd33+cxqy8kiNyJ928Zu8r1mLGc2lI67W+fvMRSOEvsNSoFSC9z9DR
         LVlw==
X-Gm-Message-State: AKwxytf+19UgKj9RNu47D0AVpW/TyR91ixp9HGO6iDC8LhmcAzbyMg9R
        yx6D7BIp8Ovd8lGa48KvTrOVCP/6q8kiG5KAGE4=
X-Google-Smtp-Source: AH8x2253lUIFFOcbLgb4Am8xSi+GAXdImfR0rOJChIaqOy4acZsBSI+mCu9jNnNGcBFrI5jAtp3WkfmjOAkqxVp4A6s=
X-Received: by 10.31.92.142 with SMTP id q136mr10476251vkb.29.1516985743086;
 Fri, 26 Jan 2018 08:55:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.8.83 with HTTP; Fri, 26 Jan 2018 08:55:42 -0800 (PST)
In-Reply-To: <CAM0VKj=qhJQJ7uJWbBouSTYD0frA1zp1gwXzMVXuTiF+C6GH+g@mail.gmail.com>
References: <20180105202711.24311-1-newren@gmail.com> <20180105202711.24311-4-newren@gmail.com>
 <CAM0VKj=qhJQJ7uJWbBouSTYD0frA1zp1gwXzMVXuTiF+C6GH+g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Jan 2018 08:55:42 -0800
Message-ID: <CABPp-BFJCu_BY5SLrdXNSBWyXu1+Vz6Fwc6u2qNXA5hTRN4ZcQ@mail.gmail.com>
Subject: Re: [PATCHv6 03/31] directory rename detection: testcases to avoid
 taking detection too far
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, git@matthieu-moy.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 3:37 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> On Fri, Jan 5, 2018 at 9:26 PM, Elijah Newren <newren@gmail.com> wrote:
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>>  t/t6043-merge-rename-directories.sh | 153 +++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 153 insertions(+)
>>
>> diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-=
directories.sh
>> index f36493289..239819f2d 100755
>> --- a/t/t6043-merge-rename-directories.sh
>> +++ b/t/t6043-merge-rename-directories.sh
>
>> +test_expect_success '3b-check: Avoid implicit rename if involved as sou=
rce on current side' '
>> +       (
>> +               cd 3b &&
>> +
>> +               git checkout A^0 &&
>> +
>> +               test_must_fail git merge -s recursive B^0 >out &&
>> +               test_i18ngrep CONFLICT.*rename/rename.*z/d.*x/d.*w/d out=
 &&
>> +               test_i18ngrep ! CONFLICT.*rename/rename.*y/d &&
>
> The filename argument is missing in the above line.

Whoops.  Good eyes; thanks for pointing it out.  I'll fix it up.

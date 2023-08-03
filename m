Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA29FC001DF
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 21:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjHCVsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 17:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHCVsI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 17:48:08 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7BA198C
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 14:48:07 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6878db91494so173575b3a.0
        for <git@vger.kernel.org>; Thu, 03 Aug 2023 14:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691099286; x=1691704086;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFGgVWLUNIurtAVUwPi09pC7x9pnMdLQQqBzCbvO2ok=;
        b=ojkQwKa5Cr5Voh8uxFAISO2xwQZq1v4pVKp4vglAMhkmWf4CWzRQIk+S3J1F6V8igl
         B5uEOIIRRfp0ed8x8V2tGXnRtHwX4Q9spi2iRytD1xqvB6DZivuNgFuUWVDElMGVmSHF
         7RXjY+3Et0DNfFtShG0wd8bycCrUMfNxg4CifM1a84X5RyHqq7IiRSb6tfJAAZSDwST3
         iyWcd314UfkJscRNtk4/XNuXl4DRPX6WQFUaHvZkUvJ7Ij2LRhwsXmcPnXTz0r9/AQ7g
         ltDoBKlEsXDSwhLozOG0fz4FfmwyMfK54S6lT8yvTPpH48od/FK+8cukWNvlQXbP/Uvy
         twow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691099286; x=1691704086;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFGgVWLUNIurtAVUwPi09pC7x9pnMdLQQqBzCbvO2ok=;
        b=Xtq8+Ltr3DqT4jhJkkMHpve9ut1rKR7oihzLpzI+8FTprH4ZrYZxcm7vOZqbLEvUej
         66SDixsic6ZtgYaXoB6Idlu8JaGV8DPi4XWOtr+Y30bMKwfhYzSIBG1AclJkf0YgDOPi
         jLSw4Mw1scyp0XNQVgcapzansEaxdLfL3uC8jGsjkrnd140sWeO2y5AeOayo5s86kCz5
         SLlndQtp7PhFupzdperUFe/L/0b7baQ847bA1X1M/w1Am4CThUs+NA0hB5P7VJVPfqB8
         B49Ns0oA4/DPegx9ASRxK9NxQMq0aHMpJVOq0b11QsUKbVQzy1OduK5P8r6/mk28V1Mz
         H8hQ==
X-Gm-Message-State: ABy/qLaAqpC0PO8jn9aQvV68FN4siavcurAwhM6QTBDtLTIfh+RO7U83
        io3xP1imdkjayB28cMmbQ3MwyfRhb04=
X-Google-Smtp-Source: APBJJlF6XYwxAydpE/xTaql9VfDWlXRC6sAJ3XltH6z7hlOisipnUCnBUVxXeYUCT4eXgB8Rb0C/Zg==
X-Received: by 2002:a05:6a21:33a6:b0:134:1671:6191 with SMTP id yy38-20020a056a2133a600b0013416716191mr21649984pzb.0.1691099286207;
        Thu, 03 Aug 2023 14:48:06 -0700 (PDT)
Received: from smtpclient.apple (mobile-166-177-250-42.mycingular.net. [166.177.250.42])
        by smtp.gmail.com with ESMTPSA id k14-20020a637b4e000000b005533b6cb3a6sm282798pgn.16.2023.08.03.14.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 14:48:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Aleem Zaki <aleemzaki@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: .gitignore is not enough
Date:   Thu, 3 Aug 2023 14:47:53 -0700
Message-Id: <BAFA1866-33FE-461C-812A-5E4232D40EAA@gmail.com>
References: <ZMweZHQZL7nnla+2@tapette.crustytoothpaste.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>, git@vger.kernel.org
In-Reply-To: <ZMweZHQZL7nnla+2@tapette.crustytoothpaste.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: iPhone Mail (20F75)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I understand, I shall copy the empty config and paste into a new ignored fil=
e where I then add my personal customizations.=20

What if, however, all git commands besides =E2=80=98git pull=E2=80=99 and =E2=
=80=98git fetch=E2=80=99, are able to modify the files in question. Would we=
 then have a potential new git feature?

> On Aug 3, 2023, at 2:38 PM, brian m. carlson <sandals@crustytoothpaste.net=
> wrote:
>=20
> =EF=BB=BFOn 2023-08-03 at 17:17:15, Johannes Sixt wrote:
>>> Am 03.08.23 um 07:35 schrieb Hilco Wijbenga:
>>> I think you might be looking for "git update-index --assume-unchanged
>>> <file>"? See https://www.git-scm.com/docs/git-update-index for more
>>> details.
>>=20
>> Sorry to tell you that this is a myth that lives on because it is
>> repeated over and over again.
>=20
> This is indeed false.
>=20
>>> This allows you to tell Git to ignore the changes you made to that
>>> (tracked) file.
>>=20
>> No. --assume-unchanged allows you to make the *promise* to Git that you
>> will not change the file, and consequently Git does not have to check
>> whether the file was changed. If you break the promise (because you
>> change it), you will get what you deserve. For example, you may find
>> that Git overwrites your changes, or commits them nevertheless.
>>=20
>> Perhaps a better choice is --skip-worktree, but recent answers on
>> Stackoverflow point out that even that is not a suitable solution for
>> "please, Git, ignore these changes".
>=20
> Neither of these is an acceptable option.  Here's an entry from the FAQ,
> which I have referred to several times (on StackOverflow and elsewhere):
>=20
> How do I ignore changes to a tracked file?
>=20
>  Git doesn't provide a way to do this.  The reason is that if Git needs
>  to overwrite this file, such as during a checkout, it doesn't know
>  whether the changes to the file are precious and should be kept, or
>  whether they are irrelevant and can safely be destroyed.  Therefore,
>  it has to take the safe route and always preserve them.
>=20
>  It's tempting to try to use certain features of `git update-index`,
>  namely the assume-unchanged and skip-worktree bits, but these don't
>  work properly for this purpose and shouldn't be used this way.
>=20
>  If your goal is to modify a configuration file, it can often be
>  helpful to have a file checked into the repository which is a template
>  or set of defaults which can then be copied alongside and modified as
>  appropriate.  This second, modified file is usually ignored to prevent
>  accidentally committing it.
>=20
> There's no option to do this and you should adopt a different approach.
> Probably 95% of the circumstances I see where people are trying to
> ignore tracked files can be done by moving the original file to another
> path and using a script to copy and modify the file to an ignored path.
> --=20
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA

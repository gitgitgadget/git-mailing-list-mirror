Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369DCC433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 11:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiGYLBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 07:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiGYLBH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 07:01:07 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380CB5FDB
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 04:01:07 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id r70so8468676iod.10
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 04:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jBoecrw9NskztLjgEBtL1aPFFRBN8zYXyPQXbk3SmSE=;
        b=UV8GvrLxqlyruTx+R0e+RfeixAcC4vGBMjVz//kWVlDOXHtTo7ArqQtSZZ1QF7zBl+
         CKP2jntVTEV3O32ZTVFoVtogxL08FX8M9uD5l3Niwdp3CkWtj1IWEofj9Ipot/FBwzRP
         9aoFXay8oiCX9+7nTtz+IcNF4DPE+YP0Xj8HXHvPZa/4eJHV4/p79uTaZ/zSdo3UwTkL
         9DT9S3DKib7FpkJgzCSmYoNlZ5IXHHElgjc2dkfrbo922wa4Ih736eQxZd0LMDjSXBYM
         GSe12KSV5mCS3C49l44nEZ4/OMeTyrtwTKqGInKkVaH3mfcZTLBTTDexrVCPPxjRpLWq
         Yxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jBoecrw9NskztLjgEBtL1aPFFRBN8zYXyPQXbk3SmSE=;
        b=EtxNS8Hc9269ztPBv5jlMasDdX5bAn+MWWUdmRx+6LIPrHFpjbTSi4b7skVbXeb334
         BvRRobOVf3ONS8oYbNyFfWT9eYIBb88lH1o8bkhDVP7XpkjFP8duvih3vebZskZEezCM
         0fLB1niy9iRn1ZgYD+L3eZC8APmx8MsxD6/bjXh6KQYBmXFY1jkJXbvHlJzyCHXTpMAe
         DCsjgzIDjb/oQ5PcKJpGwTl7SqJrApZsm8r8q54d4tuVuShJfm3pvtMfSOaibtvyhDQR
         RUcmR8O83pB49WXc2cHqN/DdrLM3+5vAaAv5KCVV7G7dpNSvf+ikwVZ3wjruSgJ+opji
         VljA==
X-Gm-Message-State: AJIora/8ek6dDPvext2aUK0Ibku+5aCMgoz0GRFVCSL0uyF+2TluSJLL
        0urNEa5w8Ftoy6q8AHDUev6bNWm+p0CfTDv6Zds=
X-Google-Smtp-Source: AGRyM1tMigkGIzV1McE/O531fvQ9SMB6CL1lmuBAjI3AMgNEozL1djI61vXs7Wn44fXKDFIn0XAv7LUAmTTji1mENI8=
X-Received: by 2002:a6b:c301:0:b0:67c:5d64:ba13 with SMTP id
 t1-20020a6bc301000000b0067c5d64ba13mr3901702iof.126.1658746866633; Mon, 25
 Jul 2022 04:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v7.git.1657692472994.gitgitgadget@gmail.com>
 <pull.1262.v8.git.1658334983053.gitgitgadget@gmail.com> <xmqqbktj3ct7.fsf@gitster.g>
 <CAOLTT8RjLoooT7t+ucFqa9P=8TiVL3M+ZgcEY7qVhRbjB=9OhA@mail.gmail.com>
 <xmqqsfmr8ygp.fsf@gitster.g> <CAOLTT8RqMU-k85LmcpY0wATHSDoWDEQLnPtfuZ2OC2nWN9305A@mail.gmail.com>
 <xmqq7d4280m8.fsf@gitster.g>
In-Reply-To: <xmqq7d4280m8.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 25 Jul 2022 19:00:55 +0800
Message-ID: <CAOLTT8SKW1RCB1Md0DOxKikwq3mgsKWp4stR62YyMyGxjn56aA@mail.gmail.com>
Subject: Re: [PATCH v8] ls-files: introduce "--format" option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=B8=80 09:03=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> >> That was not the point.  By extracting only "%(objectmode)" without
> >> having any other clues (like "%(path)") on the same line, the test
> >> is assuming that ls-files will always sort its output in the same
> >> order regardless of the output format, whether it is "--stage" or
> >> "--format=3D<spec>", and that was what the "is this testing the right
> >> thing?" question was about.
> >>
> >
> > Ah, so that we should sort the ls-files output first, and then compare =
them.
>
> Imagine that there are three paths in the index and "ls-files -s"
> gives
>
>     100644 1234... 0 path1
>     100644 2345... 0 path2
>     100755 3456... 0 path3
>
> but a bug causes "ls-files --format=3D<spec>" to show entries in a
> wrong order, e.g. first for path2 and then for path1 and then for
> path3.  If the test used enough fields (like the one that mimics the
> full output of "ls-files -s"), then the output may be
>
>     100644 2345... 0 path2
>     100644 1234... 0 path1
>     100755 3456... 0 path3
>
> and you would notice that it is different from "ls-files -s".
>
> But if the test only used %(objectmode), then the faulty output from
> "ls-files --format=3D%(objectmode)" would be
>
>     100644
>     100644
>     100755
>
> that matches the "ls-files -s | cut -d' ' -f1"
>
> If you sort, then such a breakage will become even harder to
> notice.  If the faulty output showed path3 first and then path2 and
> then path1, the raw output from "ls-files --format=3D%(objectmode)" may
> be 100755/100644/100644, but if you sort it, no matter what the
> broken order is, you will always get 100644/100644/100755.
>
> So, no, we shouldn't sort.  If ls-files were allowed to show output
> in any random order, then sorting the output before comparing is a
> good strategy, but that does not apply here.

I get what you mean. So test 'git ls-files --format imitate --stage'
can help for
checking it, because every line content is different (maybe different <path=
>,
or the same <path> with different <stage>,<objectmode>...), we can find the
--format "disorder bug" with ease.

ZheNing Hu

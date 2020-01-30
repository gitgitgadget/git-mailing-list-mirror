Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7010CC33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 12:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF2F206F0
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 12:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="L5h0AtNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgA3MgJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 07:36:09 -0500
Received: from mout.gmx.net ([212.227.17.21]:41685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbgA3MgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 07:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580387766;
        bh=/uuljFP2I1wtU0grgdvBxSrqxMMz46twsuRGErEsuwo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=L5h0AtNp2pVCXwbXBCi8CrRF8fkjsIjvvR3zhvTyvnO//d0xnA1/ny5Kp6zWNA15a
         iKDiOJh1IHy6NY4PSMOHaEXH3//qfpncpo5a7SK8CtTIOfoVc30Q5GDoEmfHYexc/L
         D4OPto3/HDum3nKEog1vEaGX8kzSYhoWDq2N9iNs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MirjY-1jSuxe1Ikm-00euX3; Thu, 30
 Jan 2020 13:36:06 +0100
Date:   Thu, 30 Jan 2020 13:36:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v2 04/11] run-command: make `exists_in_PATH()`
 non-static
In-Reply-To: <20200128144026.53128-5-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001301332450.46@tvgsbejvaqbjf.bet>
References: <20200128144026.53128-1-mirucam@gmail.com> <20200128144026.53128-5-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VnHWHtWwSqNbwEgsQawV/f0Dlq2pLsarCxRV/qpYOTK8bH4K5iI
 nIx4VlPigpeR7iPgOHTjBfKSRf4U8kNa4USIMJd0QQw9h34W4+oa6Sdg455GEtf9AnvnQN+
 o6w1kbI4YxJ6m2+d4GS1db/KnYsvYCl7IgFxQhrh1+uNZP0hIWRVauUrX3JZeE8MYrVq8td
 AMuKmn/XmFSctDHc1ioiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4YJbiSBOUgc=:x7ODEL/uQSuYomFZZmMN4+
 Clyx5sNe6HOjSY1ymXGOHVvVApXg6QOpNPSrdXgZanxL6eo/MU/ztqczx96UwUr42ughjiEIN
 TVqczIEQlF8n9ck+j9Zkf0kHRFqHP9yna+2vtXQCTaWn01xpOeoG5veHS/fQosQct7WLgH+lQ
 YAofPcDYmlRm/JxG/pyEj8FMu9S5Hu6/Y8Npjd0kUTEWUbF+sxcNYZLfJTqAdmewOxOrz4FDJ
 7qDKmVMBBtR8XmfeIDogYvWJ6e5C8xd8LY8dsCCDUR4/Gx1g8Sdrzl+vZuh2e+SFk+Bj/uRy6
 H5qlCttk6mTijDUP3nGTP81V4+1ik+E4TOkK/IRAi4RgLeOhA8nRjod650k/3jGk9XLlnU6cN
 xtsWQD1Go20ruHBUmbmNtEgUuHd/y6++Tjm33teQdUvHgVY0hhKczhQRLTi5ZKE313edrbjH7
 R+zYA5nQ8kOW1zPbRkBge9lNVnnElqeVU/5C4PgHYbBgc/9PNCJgX1LT9zIyoVSLqyXkwka9L
 jsXxOheEwjLdWb4HamV2QD/CafFwM61ELiC5Jp+26g82GUof8Gpwgl8MUgA9PJ2pa2RdimHQX
 28hvLUovv6ypI+p9hgDsJV618zW+McHEw1EqYESBj2o8cYNweNenLXn1ajoXbV1edjyVwsSHE
 Lsyr7Agw8lUop2HJdygb9WX9VL16XktxCE88WGRhJ1HOiJftzlB+65Hfnc2TmHqefItTMPoAg
 DN0iIXNpwVRFnsOHv9JKnd5jKiu18193w3S1fp8rGFIV5tOjPRBRk4tCCjINJX4WLtYgadKjr
 b1rWlJhw3ERdHYVXMvUS5gAJZWDmBOAUiDXCxRs/xFvaqPOMPfQsTikZlUqnE80EZaER3qiuW
 ILaPlqewoD9o/BoQdYhbiHFTLc3np0WFWsbW5i8iRtb/yc46GXBopyzFhWudSq2EetAkNiZKE
 X08U/UiB2mA35s9E/VKA1DwVDZ3643fBBa4apzKJB1q/1csEZ6vKMRtm+9fCSkvS0EIaRrE18
 OjqHTTUp6eMNGzjVNgHlRsi+tBT0uW4VkPAUafSDo8VkvL+SQIGTjPchlCz8Nykg6uPULvC6B
 tf+SCWFfu8wVOS/Gx6pE3//48lldDnLbNJu6uqK1RUq3JLD8XyQgFB+exMNTd/2KQVfGOj+qV
 5ICezFuxEIZOB52stUmskbvkEpQ+0C+GUEQuNnqxEeo8VZSJCDmp+G3uLK250RN5UtNOEx939
 5IPA/JZ2X+BJ1aSeQ
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Tue, 28 Jan 2020, Miriam Rubio wrote:

> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Removes the `static` keyword from `exists_in_PATH()` function
> and declares the function in `run-command.h` file.
> The function will be used in bisect_visualize() in a later
> commit.

I inspected the code in `exists_in_PATH()` and in `locate_in_PATH()` and
it looks as if neither of them depended on file-local variables (which
would otherwise need to be addressed when exporting the function).

If you contribute another iteration of this patch series, it might make
sense to mention this in the commit message explicitly.

Thanks,
Dscho

>
> Mentored by: Christian Couder <chriscool@tuxfamily.org>
> Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  run-command.c |  2 +-
>  run-command.h | 11 +++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/run-command.c b/run-command.c
> index f5e1149f9b..4df975178d 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -210,7 +210,7 @@ static char *locate_in_PATH(const char *file)
>  	return NULL;
>  }
>
> -static int exists_in_PATH(const char *file)
> +int exists_in_PATH(const char *file)
>  {
>  	char *r =3D locate_in_PATH(file);
>  	int found =3D r !=3D NULL;
> diff --git a/run-command.h b/run-command.h
> index 592d9dc035..7c8e206d97 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -172,6 +172,17 @@ void child_process_clear(struct child_process *);
>
>  int is_executable(const char *name);
>
> +/**
> + * Returns if a $PATH given by parameter is found or not (it is NULL). =
This
> + * function uses locate_in_PATH() function that emulates the path searc=
h that
> + * execvp would perform. Memory used to store the resultant path is fre=
ed by
> + * the function.
> + *
> + * The caller should ensure that $PATH contains no directory
> + * separators.
> + */
> +int exists_in_PATH(const char *);
> +
>  /**
>   * Start a sub-process. Takes a pointer to a `struct child_process`
>   * that specifies the details and returns pipe FDs (if requested).
> --
> 2.21.1 (Apple Git-122.3)
>
>

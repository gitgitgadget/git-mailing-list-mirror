Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D3211F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 21:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbfJCVIr (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 17:08:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:55727 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbfJCVIq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 17:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570136920;
        bh=hdqjRGdNWQ4jvZuj5c166NeoMzflmigAfo3d60yAMmQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OcXI5o0sXE5jiK65j2J0RH9qk0pXe25cVhFh4h5KNqYCvOy8u0QYkSGzTV3sQak37
         yyELqI6CZhmtHCmaal4lMp3fd9Wg/qD+jxcugEMp3w/qPuBbI/cLJm6QnBqaCn1IUH
         uUGc5aScaLx7ad00axjjJq3xwltjCZR0NpM3itXE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryXN-1hkdPO3yK5-00o19v; Thu, 03
 Oct 2019 23:08:40 +0200
Date:   Thu, 3 Oct 2019 23:08:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     William Baker via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] fsmonitor: don't fill bitmap with entries to be
 removed
In-Reply-To: <pull.372.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910032306380.46@tvgsbejvaqbjf.bet>
References: <pull.372.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZMKVfEfIMbzwnIzPUuv2bVM9V5iW9ZA5FzZ2++azIrgqriT6zwq
 HYRkQv1K7yFIYXP7YDanPqQHFKqLoci3PHMWjE/o29yYEZv/wJ7P8E7BdFCUswNkHvIIiNm
 N+4316KA23GgnqQ71U54DEgch9GffxfYTpqU9BsmEkkvqkJbXZ7Bce3wbC0NiWySVFLEZt0
 HSMH7ErzQkvAsbZMzWyaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pjYWYYQ2vyc=:R5WNbkWwxd59TfAlMOt3Kc
 Ny8nMV5CFqj4YJ3ti42HCtC9a67pR9iM5V+fyQSos5ypk+S+7IlB9Vf7/R1029ANtX9bDdKQs
 jR8jdYJYEdtcezlOinbdr8M0mF1dmvHPUNLbKG0LlQH45FsJ9RM7Um27B7JoaR/8z5L0KE75v
 T67ed2Mu/OiAW/+5iAFlQ0/N4DqKS9P2/ao/rtYondV62pncz7W7K2rmP82uwskPk+0DjPAqA
 Rv3lEKbBbqlCHA+OzLn7zKg435K2QJOUsNkRTsKVa19Q4tTIKXY/L7MdMq3qN1UOe/q6UI2KP
 sZgQID8UOgbnBIDt593AGbTYBybt6nMc8ZlaQFPN8FVtcpzZ/6Y0cPab55ydr+SJkGYscWmrU
 wb1rJ38GF1eFVQnLyG0E6cw67xjv1DCadNzW7RvCwoiXTlPqDAjJDn+McPivzp+7KgmAnFrFq
 bAk9yclIFe2GxawC/ryT1nBhpeG4NlXB1SPl6nfU1858dABFGKuu+TB3Dj9sZ41o8aB9xk0hq
 ZLUXnNgNxC1gByhnfNDqOFusdRgbjwQBy1B4J1WxrDSHEnULfqLigNW74VYO8v8Ff/bfXlS0T
 TeHA3j/E6kyzSsaVGno3PIkNy1PlFF6yCTWDuriTnH1ST0dZSVpizIfWaz6r5QwQhpe6D2OQg
 VOeFYgyXg0kmYXfYGtCRuGOJEzzTTM6DwrpmFtwD9qD6liZbkISONiHoLC/Zo6HXnuXUFRp6h
 K/P7PZ7kAIBK+Ue6KlWJovGAdsdcBlFSH9VJim+NPmHP9ntg0bUrUfS1NnGl+CjaLbvY133bl
 7pUE96dlVUwLXfr5CDJVFiZgqeyUzCOHoce9G1clOXM8RXVejwwJe2uZ2Q5FCSu5enqDKx9Fs
 lMvlfuMzI8Nw+HoliyNTcpHipuhpI2Jsl8KFi30XOpGI0aFP7w100WxPce+6ZWc+3lNc4zudV
 mEebxCnst08nCmlQBKOp6B5lkhEFbW0oxrTHsmSxqM6ORaBTTPI2MgoF1RGaP2QCne//QKJf+
 sW7ILQ5kN8kbMaju2scSBXLhoi+UTpyJeJKBFDm2YgNxmANeKut9MCHY074wOD5oZwr8jlhNc
 Hd4Js6FwM/hUyNBbPySw8Y/ombompnFkbUO+4h2hjksykQa8/sM5KQ7W+BZdjVrgDDfhvqWau
 vyGcZ6HMK4Ns0zaMe15FRIzplAU/QGKW5lM9WnKq5ohDf4uoLYV4tgsE1NZAYMP7TQXGp3Maq
 cg7oFf4OoKMkEsIxS5ZFZSVA89/rH+f9kKj6Veu3MSdKAJTxRT6ESQF/Ht2s=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

On Thu, 3 Oct 2019, William Baker via GitGitGadget wrote:

> This patch series fixes a segfault that I encountered while testing
> fsmonitor. Under some circumstances, the fsmonitor extension was being
> written with too many bits, and subsequent git commands would segfault w=
hen
> trying to apply the bits to the index.
>
> As part of these changes I've added some BUG checks that would have help=
ed
> catch this problem sooner. Special thanks to Dscho for pointing me in th=
e
> right direction and suggesting a test that can reproduce the issue.
>
> Thanks, William

Please note that I was involved with the development of this patch,
reviewed a couple of iterations internally and am implictly okay with
this first public iteration.

Ciao,
Dscho

>
> William Baker (1):
>   fsmonitor: don't fill bitmap with entries to be removed
>
>  fsmonitor.c                 | 29 ++++++++++++++++++++++++-----
>  t/t7519-status-fsmonitor.sh | 12 ++++++++++++
>  t/t7519/fsmonitor-env       | 24 ++++++++++++++++++++++++
>  3 files changed, 60 insertions(+), 5 deletions(-)
>  create mode 100755 t/t7519/fsmonitor-env
>
>
> base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-372%2F=
wilbaker%2Ffix_git_fsmonitor_crash-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-372/wilba=
ker/fix_git_fsmonitor_crash-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/372
> --
> gitgitgadget
>

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69461F461
	for <e@80x24.org>; Thu, 29 Aug 2019 14:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfH2OgN (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 10:36:13 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:41914 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfH2OgN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 10:36:13 -0400
Received: by mail-qk1-f181.google.com with SMTP id g17so3112955qkk.8
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4y5CAiuTmRkhs27bDLfILx69K8n7P6jaGy37WG3TIs=;
        b=OkG9SDmpYUaXDth1uemlt0XHmpzBmXD4k9O9Mo07fMK+f3udQr0ge/zT0c1gVwaPmV
         eoSPvagiiNEW7VI1KW2urRGF0XJQZpkikv78cexDvdd17Oyq+2YhJuBKieZ/tDoOfuSN
         XAn0K2jkl9xQMjHhNfR+Ix71S+OPfu4nE9TNiwKLxWW8PBGRWM4Q87l9GPeHw8QxPuRn
         1ikFgkXfolL7KMtyCGo/1I9n6qTDWjGPFdrqSqpylE3mVf5eWR891Hgf9DbApAm+gBJf
         GccOmJlvxyby5wmruPOkwMAAGa/QRHm3H0s+P55JDgIEDSdiudhXr+dw3LSA0vEOAuXB
         x0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4y5CAiuTmRkhs27bDLfILx69K8n7P6jaGy37WG3TIs=;
        b=XbeZPvTM/h4mAtkifGcO2hyHfWkyTOvlrQKKNG3GpoMWq1jflpYr7fQzJebhrZURJ2
         5sEJe42YERvD2u58k8P8IzJvo4qcQP3XHRCI9iknDzySAa4bqLb+CXA3mMOmQ6pUXn7i
         VoNRLKaoHYJrai/D+5gDKWJ8vqC5WurKJLY9s2ecUwVAhhW6WqvTH454+DzhWPXdilVO
         hYaO7xHsGHBijr0sI545T6dLtMppcTB5nkKCmwK6OsvDBkl68SbosXv8oWVGTAbWcKN0
         p4wm2SyERmj6xyCacsRINnnOllqkoFtFJSXgd9HpKW+fn15xK1EJ3YVS1HRW8RpHoQdS
         ptNQ==
X-Gm-Message-State: APjAAAWc/lGcpwCTE5EVh9Uluz7WdbwSVe+hkxzMvB1YbE5y1iytbV3u
        g2/aX8dzKSh7b/U06Qj6hLBoog+piuOC+PJwSI5DUVLPBt6f9w==
X-Google-Smtp-Source: APXvYqyneZR10Sx5SSeSDKFiC9bFxDweak/u4Orr4tpSyRwmh/Ym1paKtUdM43qBB6A5Pfk+lv5wYruVsswAJVIzjKc=
X-Received: by 2002:a37:7001:: with SMTP id l1mr9420908qkc.85.1567089372526;
 Thu, 29 Aug 2019 07:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAH53SykX12SN83=gey8KS_x3cGkXH758sfEieskXnnvos8DMcA@mail.gmail.com>
 <xmqqtva0zkvu.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtva0zkvu.fsf@gitster-ct.c.googlers.com>
From:   Dmitry Nikulin <pastafariant@gmail.com>
Date:   Thu, 29 Aug 2019 17:36:00 +0300
Message-ID: <CAH53SymNwjrh_CzXVVtU5xABuGQWMsXhRDYyRzyHEwuxLWA2NQ@mail.gmail.com>
Subject: Re: git-diff passes <rev>:<path> args to GIT_EXTERNAL_DIFF incorrectly?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the reply.

On Thu, 29 Aug 2019 at 06:54, Junio C Hamano <gitster@pobox.com> wrote:
>     $ git diff -M branch1 branch2 -- file1 file2
>
> if file1 and file2 have similar-enough contents, may have a better
> chance of what you wanted to ask Git (if I am guessing what it is,
> that is).

The context here is that I am trying to diff two Jupyter notebooks
using an external tool (git-nbdiffdriver in my case). Therefore, for
me it is crucial to use the external tool, and not Git's internal
machinery.

For the particular command that you suggested as the replacement, on
my demo repository it does not produce anything interesting, as it
does not detect renames and calls my honeypot twice:

$ env GIT_EXTERNAL_DIFF=./print_argv.py git diff -M origin/branch1
origin/branch2 -- file1.txt file2.txt
['./print_argv.py',
 'file1.txt',
 '/tmp/2IEKCw_file1.txt',
 '802b1c4ed7b06162b2ce09b7db72a576695b96e5',
 '100644',
 '/dev/null',
 '.',
 '.']
['./print_argv.py',
 'file2.txt',
 '/dev/null',
 '.',
 '.',
 '/tmp/oAMdDx_file2.txt',
 '076e8e37a712d8a66c0c3d1a103050dc509ca6ff',
 '100644']

However, for the original repository where I first faced this problem
(https://github.com/yandexdataschool/Practical_RL), Git passes a very
weird set of args to the external diff:

$ env GIT_EXTERNAL_DIFF=./print_argv.py git diff -M master coursera --
week02_value_based/seminar_vi.ipynb
week2_model_based/practice_vi.ipynb
['./print_argv.py',
 'week02_value_based/seminar_vi.ipynb',
 '/tmp/amudWz_seminar_vi.ipynb',
 '8f8016963c888b7dd8dd20f60b7d6fdb41b26c1d',
 '100644',
 '/tmp/Ub7zPz_practice_vi.ipynb',
 '21db80f53b632d975a9af0acbaf397eb717cde2c',
 '100644',
 'week2_model_based/practice_vi.ipynb',
 'similarity index 82%\n'
 'rename from week02_value_based/seminar_vi.ipynb\n'
 'rename to week2_model_based/practice_vi.ipynb\n'
 'index 8f80169..21db80f 100644\n']

I would guess that this is a bug. There can clearly be a hotfix (after
all, Git passes all of the information to the external that it should
per the spec, that is, <old|new>-path, <old|new>-hex, <old|new>-mode;
adding, however, some garbage). I do not know though to what extent
this information is correct. You say that this information is lost
when I use the <tree-ish>:<path> notation; however, Git seems to pass
paths and hexes correctly. This only leaves open the question of file
mode. Perhaps it could be preserved at least for some cases, such as
when the blob is retrieved from a path in a tree?

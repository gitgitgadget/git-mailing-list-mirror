Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 102561F424
	for <e@80x24.org>; Mon, 18 Dec 2017 16:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936212AbdLRQoN (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 11:44:13 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:37810 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936070AbdLRQoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 11:44:09 -0500
Received: by mail-it0-f42.google.com with SMTP id d137so28325518itc.2
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 08:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oFt4Wu0/Wf0N4ChARvqY+/0KaWvd2Zunm+Cjpyo60M4=;
        b=HPutPwAdpxawyQkLK5DgSx2p2cBQQfZxitHFPjVUhCkHU2FNA+vmGMXZckqbMCpTkx
         KHJUp8/pMGqg1jdFaGIEzs9k1lpa/kJFsrnnqlNfhqOgr+tj1lKHlycaDoi1kE1h1MdE
         pimUiaPhUaNs1VTrcQ+vS4aYZrR82LClOX0Z65B5VN9bGJXMFekrDIk0mia6sV9aPzfv
         NJFg987xlQh3whMfTQmVzocB7B1dCdSAN5kqCVOo08CHwOxV1EyMrtLmMlRC+YbhFOEa
         93wMtOjT9d4B3BCDhz0JRhd0iFzr/UiW77pSBEuT+G0TzyQ0/CVt9vKwYi0XwBvn9I82
         zKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oFt4Wu0/Wf0N4ChARvqY+/0KaWvd2Zunm+Cjpyo60M4=;
        b=TMZcOcrENe6cFxfhAFBwj0EfNdQ3pMBXkEPbj0DLI2UnouiRRTRNWwfc1h9oZsssCa
         7DJi0PX8rsT0DKPkTBCNXj19ivneud5UFWQbtGz4UPC/IpZ0Bnu48arC0FZVFZKdTxst
         s+Pryz6RwtaXCQ76jc4WgaI5ZPZ70qk8Jp+jnYidNGjWZz2eP/1w4HR/eDHBHnBS0uhM
         w9+4k6yKQdpQzukTOXOxEk3zYTFp0+RYrgggtlBrDIZ+3Rj3fxCV0FnlePBb32SyqaHm
         FtlM4fxGs8N89cVpAF6bO1i1c32xRX2MQu0aexUOPpucZq0jTs89UkVIhJmUX56eQ8Ez
         hZxQ==
X-Gm-Message-State: AKGB3mKk9DfTS/3EOIZfPQfEaVPze7OCPBY5SlENxCFeknVuzCEwtmw8
        caFFPtUM+iPtZiEoMM1flUM49Ek4V2oBCGn8+Tw=
X-Google-Smtp-Source: ACJfBovMOD+v7DJuZ2uGEyugdwS6F/KeNuXXy6GexXK030qqv5HkzwJK5kHCIrSIbkYK4uIomvaDArHM1jLhWp/HizE=
X-Received: by 10.36.58.11 with SMTP id m11mr321572itm.109.1513615448618; Mon,
 18 Dec 2017 08:44:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.118.74 with HTTP; Mon, 18 Dec 2017 08:43:38 -0800 (PST)
From:   Seth Raymond <seth.c.raymond@gmail.com>
Date:   Mon, 18 Dec 2017 11:43:38 -0500
Message-ID: <CAJ4+5mHMD+yW1ZDD6KJSnMtyygLUGiHzNPgPDZUi7+KUvOczkg@mail.gmail.com>
Subject: commit-msg hook possible bad behavior with -F <file>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a commit is invoked with -F <file>, indicating that the commit
message should be read from an existing file, the the
prepare-commit-msg and commit-msg hooks do not operate on <file>. The
first argument to the hook is always <git_repo>/COMMIT_EDITMSG, rather
than <file>.

Am I wrong in this line of thinking?

-Seth

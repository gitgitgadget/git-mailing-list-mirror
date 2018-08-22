Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D96B1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 18:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeHVWZ2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 18:25:28 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:39667 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbeHVWZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 18:25:28 -0400
Received: by mail-lj1-f175.google.com with SMTP id l15-v6so2237235lji.6
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j0UPlF6jhRhSRN/bboo6pw6/5TkSdkPCx08huhdpoyU=;
        b=JPmOvq3pj1jCv/LlLmRicMYqHYmkoVTll+dbPDDR+8WBpzJsxbn8fLGjOembgmwQWw
         kA3PsLmAjHqyAWumA9OtiEnTQh2OH3jGOFFy1AXe95mSAl5nBwCHcvu/deJCw8ZOp8bQ
         I7WFzc4J50kf0pidq2vgg3bxSdt8RuE7q30xosmhPTD1LAPtQmmZSGsQsGpKWf9iFOIa
         lFxVTcSr7angOG7qpqFpX8xqTy5QXoTOB6mcqLpJjDidtFTmDQ5cZOppKMO2dwMuN28u
         SNE05vA2LlCCBAEKxxvHefFIQZKYZ3Xi0qLdK6Hc/UiMruhQt1KG2poz8/e8xcY/cCdy
         HQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0UPlF6jhRhSRN/bboo6pw6/5TkSdkPCx08huhdpoyU=;
        b=QMTEj2xYZ9DX40mr1E8X7LJCzdCoQmerrOnB8M3H0mdiL0jhDhRU8v+EnobLSSotmf
         b9EOemb0bs5ZhzKqBh8+sgvKGqrfz62hP/PSLFT5qipKyfwupGocRI3wL6kXvssphGcn
         CHwLIlRoxKZ1LmSOmFl30BU9fBJ8ByKCtcBkF2RFciEgMgEiXK/pHOT26wSxJxb/Zw62
         EK8s1lfYLkvQRQBK1zuCUiv48OtY/kjKwI8XH6YYOlrBcLWEwM5hFRA6jx4Cje0V5B+N
         eituYn+DQZgRPxahr4/soqlEsjR8AMLxsJkNyH5slFnVXJTiYXgqItJW+2o/mCQoUPrw
         SpMg==
X-Gm-Message-State: APzg51Bez6ehx9XY4hB2MWKhThA2ncUsRKqDGsOy8SamnuAMtuaqfJSb
        wfa/1Er8PKE51e46psDtU2GpkSywGYrUDo1xueE=
X-Google-Smtp-Source: ANB0VdbSN0S+oKz8iXQM1hp/QGNJQ7BwFkIZ7dE7OZTuFpmoJX2PYXA6GARMAxAfSZgF3SaWlU+2cWobWKSpIr1LQNI=
X-Received: by 2002:a2e:360c:: with SMTP id d12-v6mr3574770lja.88.1534964362955;
 Wed, 22 Aug 2018 11:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180727174811.27360-1-avarab@gmail.com> <20180822174820.12909-1-szeder.dev@gmail.com>
 <CAPig+cTQrBmgXQdwQpH7DO2AbraD3B4LiRHDx4Sf9rXg0d_eDA@mail.gmail.com>
In-Reply-To: <CAPig+cTQrBmgXQdwQpH7DO2AbraD3B4LiRHDx4Sf9rXg0d_eDA@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 22 Aug 2018 20:59:11 +0200
Message-ID: <CAM0VKjkVreBKQsvMZ=pEE0NN5gG0MM+XJ0MzCbw1rxi_pR+FXQ@mail.gmail.com>
Subject: Re: [PATCH] t6018-rev-list-glob: fix 'empty stdin' test
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 7:53 PM Eric Sunshine <sunshine@sunshineco.com> wrote:

> Can you say a word or two (here in the email thread) about how you're
> finding these failures (across the various test fixes you've posted
> recently)? Are you instrumenting the code in some fashion? Or, finding
> them by visual inspection?

Errors from system commands in our tests look like these:

  grep: file3: No such file or directory
  sed: -e expression #1, char 2: extra characters after command
  diff: sub1/.git: No such file or directory
  tar: rmtlseek not stopped at a record boundary
  tar: Error is not recoverable: exiting now

while errors from the shell running the test like these:

  t0020-crlf.sh: 8: eval: cannot open two: No such file
  t6018-rev-list-glob.sh: 4: eval: cannot open expect: No such file
  t7408-submodule-reference.sh: 615: test: =: unexpected operator

i.e. lines starting with various system commands' or test scripts'
names, followed by ': '.

So I've modified t/Makefile to not remove the 'test-results' directory
after a successful 'make test':

diff --git a/t/Makefile b/t/Makefile
index ea36cf7ac7..c7b1655593 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -54,10 +54,11 @@ pre-clean:
        $(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'

 clean-except-prove-cache:
-       $(RM) -r 'trash directory'.* '$(TEST_RESULTS_DIRECTORY_SQ)'
+       $(RM) -r 'trash directory'.*
        $(RM) -r valgrind/bin

 clean: clean-except-prove-cache
+       $(RM) '$(TEST_RESULTS_DIRECTORY_SQ)'

 distclean: clean
        $(RM) .prove

And then scanned the results of a '--verbose-log -x' test run with:

  grep -E '^(awk|basename|cat|cd|chmod|cmp|cp|cut|diff|dirname|egrep|find|fgrep|grep|gunzip|gzip|ln|mkdir|mkfifo|mktemp|mv|readlink|rmdir|sed|sort|tar|touch|tr|ulimit|umask|uniq|unzip|wc|zipinfo|t[0-9][0-9][0-9][0-9]-[^:]*\.sh):
' test-results/*.out

and then, for lack of something better to do ;), I started looking at
the simpler looking errors.

I've though about how a check like this could be automated, but
haven't had any workable idea yet.  There are commands that can
legitimately print errors, e.g. when checking for a prereq which the
system doesn't have (e.g. the 'tar' errors above, I think).  And the
list of system commands in the grep pattern above is surely incomplete
and will likely change in the future...

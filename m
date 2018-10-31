Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2605C1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 22:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeKAH6x (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 03:58:53 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:42548 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbeKAH6w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 03:58:52 -0400
Received: by mail-pf1-f177.google.com with SMTP id f26-v6so8326221pfn.9
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 15:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yLdBDcVG97vUWK7ysAPUWagm3LUtOTYbEIUloNFmppQ=;
        b=lWs0MVxJ8tsQeLHDvE8peXvs19dA2yA+x6NK7QiUXfhS5lNZE/7dq/Y0kOUsD9TV6k
         EJWKcWFGAU22XnDww120aBJa8CTDLKWyvqDVdwoE5nj34pv2w/3xGBapEal2SRFiISYY
         /AHAWQzYrOC1RiV/cV+/JOUHIJZfWK43DAM6gmU0GD+urDXQK0z1CSf0Ykxr4B+q/pnH
         4645dNsjp1kCoNA+1F0ZpPhXLicA6TOR4dDUOCkE99VUsGWgVrODuWJ87k8jijpaXTC6
         0lIpdsuWaxIEa8cYx1UKziN0XxEH7/LMVK3zMARWgIgCpFBscbKPrXG8nmFlmelQoe9N
         W3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yLdBDcVG97vUWK7ysAPUWagm3LUtOTYbEIUloNFmppQ=;
        b=pG1nu5BUileFNZvYO0w9Wa/uudhTBdTP+tn7Eplv1Ohut4be7YczgM22O/GLxt4etz
         brLZqcqtjGprA3r+wwq326pxqoTy+oSyH6jL+0Ls+9OAm+r5p9PCtIG0PJ8lDslYsfae
         CUKe3wl77N9BqqjLHNZl+p+DVF7QP5EkmEORcHpWmL789bpCrH5XQ4R3trgSIjJuhwYr
         vcg2NtTthGb8lal0tpjy2y76WLpMMmYM0MtM/oYtqrggZPZ0yQpcfvlHfdAxSOLWf62M
         7Z6ZWuxmlTFI1ZFY6kDNRAxmhsB2Yg9NB5NVic8qIZ7zLYJ9G6T0ip7Q+BomV8RaUFIY
         lGHQ==
X-Gm-Message-State: AGRZ1gL+CdIpyr/3Dv2t6Ik4jbzO7I6nQgTvYsmff2rLz396+Pl90QUk
        dYGF9KGc0DcDYF1JpvWD16GL08gY
X-Google-Smtp-Source: AJdET5c87uBMo9rBcrdTmq1Ljw4ZgBGnbm+b86jCDgnesw3VuDWS0JUiWxjsLi5KGH1CCbNKeXGDYA==
X-Received: by 2002:a65:620f:: with SMTP id d15-v6mr5057374pgv.120.1541026723994;
        Wed, 31 Oct 2018 15:58:43 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id 68-v6sm34303569pfg.136.2018.10.31.15.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 15:58:43 -0700 (PDT)
Date:   Wed, 31 Oct 2018 15:58:43 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Oct 2018 22:58:40 GMT
Message-Id: <pull.59.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.59.git.gitgitgadget@gmail.com>
References: <pull.59.git.gitgitgadget@gmail.com>
From:   "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] DiffHighlight.pm: Use correct /dev/null for UNIX and Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use File::Spec->devnull() for output redirection to avoid messages when
Windows version of Perl is first in path. The message 'The system cannot
find the path specified.' is displayed each time git is run to get colors.

Chris. Webster (1):
  diff-highlight: Use correct /dev/null for UNIX and Windows

 contrib/diff-highlight/DiffHighlight.pm | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)


base-commit: c670b1f876521c9f7cd40184bf7ed05aad843433
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-59%2Fwebstech%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-59/webstech/master-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/59

Range-diff vs v1:

 1:  8159cbd1b8 ! 1:  bcbffa1411 Use correct /dev/null for UNIX and Windows
     @@ -1,6 +1,6 @@
     -Author: chris <chris@webstech.net>
     +Author: Chris. Webster <chris@webstech.net>
      
     -    Use correct /dev/null for UNIX and Windows
     +    diff-highlight: Use correct /dev/null for UNIX and Windows
      
          Use File::Spec->devnull() for output redirection to avoid messages
          when Windows version of Perl is first in path.  The message 'The

-- 
gitgitgadget

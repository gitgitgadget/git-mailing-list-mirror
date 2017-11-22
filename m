Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 853A62036D
	for <e@80x24.org>; Wed, 22 Nov 2017 00:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbdKVAmm (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 19:42:42 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:40820 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbdKVAml (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 19:42:41 -0500
Received: by mail-qt0-f182.google.com with SMTP id u42so21664982qte.7
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 16:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=byFT7sq8I9Q6Ahs0MfklaHnx6HDPFNr/VPk01jOV7no=;
        b=lPS5T4ZDTxTlunv1YB8qEAViOpGzqVICTM07gZ9Dkxzjd+5W9ZWJj9+7RO1TsKYiv9
         Mn64mnDSA9+cXAivsE22nVqWDLLH7bFRZnWR6mvJulJnbRaV9U4ncExrsx/xtWcRp919
         8ZxSWQbIwio+BdNFTU97MNJ8P81lTi6DQxCfADfvo5hpVAlzk5YWdPV9/aJErR53htB6
         EsCn6eMKf8cjkPQ+rqzMACZQOyw5zejW/0afOkR5zNct9z5p4WA8NBPNV4JexVLLAitm
         5VYTHaIAcjcMryd69oqfKaEZUfDi9GJERnj1bEHtLfgM0SfEWQaarNnPDUTKc8lLq3WO
         Ee+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=byFT7sq8I9Q6Ahs0MfklaHnx6HDPFNr/VPk01jOV7no=;
        b=OYSu+U3nK+uuJgQ4xWBpt6j0jWqCSyaGHIRQckDQUKGUiAEMQd6zt5rAZBKMG0fFz6
         N9NI3mF0QwypEkYxmFade83a8zed3g4xlmh2QzWLHI9mQ3tqoDFQsx1Yl86pqESzPgwv
         QocenyEcrnqRsggW9STU2ZD4BWrFRAiklsX81zZdiZbBithjssHknyffTcKdiy7XTBT9
         7wT507uvPJTFcDjDIB+hz4Uc6CmgW8Roxie1dNLXgvuaVdX/o7ZVIYHLiXWzx3DDQBrs
         1rZpQRW5Vf6vW1ABdaLDz02d+kcqwxes1U9bo5cIQ5I8yDLdBw+VnoqpHe2BvTBLNOLq
         7NMA==
X-Gm-Message-State: AJaThX5qiVA3UYnEGlG5LRfjvDrkwVJcxXLVLoe+hVD0u9R6E58X+WkI
        0gu/4Gb8+Y+o2CU4PV/xQXNg3JlUzZZ/ITaiqL5ffg==
X-Google-Smtp-Source: AGs4zMbRk/glnX1yKJMLMi/4oGrD9CpXd7hibshsBQPZ+vNtE2tLqRtuJe2scDX8OWRgIMmLnS8ALv8OZXpxrdqDHgU=
X-Received: by 10.200.44.251 with SMTP id 56mr30058672qtx.87.1511311360630;
 Tue, 21 Nov 2017 16:42:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 21 Nov 2017 16:42:40 -0800 (PST)
In-Reply-To: <20171121080059.32304-1-newren@gmail.com>
References: <20171121080059.32304-1-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Nov 2017 16:42:40 -0800
Message-ID: <CAGZ79kbVzDEv=rj7X6EhWZyAFd+fq+nwG8c+raqu9tXv_z9f4A@mail.gmail.com>
Subject: Re: [PATCH v3 00/33] Add directory rename detection to git
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 12:00 AM, Elijah Newren <newren@gmail.com> wrote:
> This patchset introduces directory rename detection to merge-recursive; I'm
> resubmitting just a few hours after my PATCHv2 because I didn't know about
> the DEVELOPER=1 flag previously, and my code had a number of
> warnings/errors.  I would have just submitted fixup/squash patches, but
> when I checked, there sadly they cause merge conflicts when rebasing
>
> See https://public-inbox.org/git/20171110190550.27059-1-newren@gmail.com/
> for the first series, design considerations, etc, and
> https://public-inbox.org/git/20171120220209.15111-1-newren@gmail.com/ for
> v2.

Thanks, I'll take a look!

Protip: To make it easy for reviewers add an interdiff[1] between the different
versions of the patch series, this can be done via tbdiff[2] for example,
or in case you still have the old branch around or Junio has it queued already,
you can do a diff against that branch.

I just looked through recent cover letters and it doesn't seem to be common
(any more?), or just not suitable for the series currently in flight.

[1] for example
https://public-inbox.org/git/20171116020039.17810-1-sbeller@google.com/
[2] https://github.com/trast/tbdiff

Stefan

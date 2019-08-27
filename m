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
	by dcvr.yhbt.net (Postfix) with ESMTP id D3D7E1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 04:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfH0Epi (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 00:45:38 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44027 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfH0Eph (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 00:45:37 -0400
Received: by mail-io1-f66.google.com with SMTP id 18so43123607ioe.10
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 21:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lCt+399YLlfRn3vHugnGALNUf5gGbIk4It7OU2mvFks=;
        b=jqgfT3/MI7t2+H2OghXTcCCjswesN82TRsKz29oavDFJXSGndtWR3zZx2sNIC/bsiY
         hFivWgU7puIi2uyEBfXPYYxFV1C367hMOA8TaQFtIZn9lHXTJdyZmJzzc0/bXP19e2Dc
         69K5iHa79LiBXUYUsCb8/2PHEto53pbQyBp1k8Nj4qBtivZWJV7mjdhi3hiKDmg0RWMf
         Ls+UMIl+HHLq2+ip3MtWUqD3o0OfAXsv35ZjCQt3ah6jtU0U8L5VvK8p2N9Fv+VWlEnY
         VylkckHd8B8i8AryIu0RZODOkOaeKYDOChiMORyhowNGVaj3khfVVrps9Tl0/KmaC3Bj
         fmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lCt+399YLlfRn3vHugnGALNUf5gGbIk4It7OU2mvFks=;
        b=JWMcrct5/0fvrIps+7+UAtRIA5IUbj7BWqfH3/PRbiiO3JswrBxubuz4oWQkgbVabC
         CcdaOQc+WacwrsC9LFNseR+/gHWPs1OeSvy6iwWGLFhstA5FUYhtnzoil8jDGuyUNj0J
         kE3BcTirRcIpk5jLwZNZCbLiwWYi6/UvMPmzGAwR1CCZMcn6HHlAaxXRjKiD1T40ffyn
         txXxruuscmugEea+Gx+UM5mERyTrhQfTSQDaxdO+xQMBsRHQRGfLZm0OYzNYaluyoAha
         YL44VRxXRTPktkdZwei5+dKx8SMSQYr7kMZqTEUqvciD86kyumyC8dN5X4YyZxQ9MBiQ
         TZ0w==
X-Gm-Message-State: APjAAAWZtfOs9xhLpl1a3RU8XZPzJ9P1gbWL+TJ8cRPE4UdDnwHmfhWv
        8Met47tRYd8QwBrOkneLtoDFoPso
X-Google-Smtp-Source: APXvYqykNHFuhwyyls+okCAqM1B7VILXBLIFFPSyhosZpXgVk653V/vjbOiDeD4jsbX7caDM5o7q9A==
X-Received: by 2002:a5e:c104:: with SMTP id v4mr954739iol.209.1566881136563;
        Mon, 26 Aug 2019 21:45:36 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id i10sm8299001ioq.51.2019.08.26.21.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 21:45:35 -0700 (PDT)
Date:   Tue, 27 Aug 2019 00:45:33 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] advertise --skip for cherry-pick and revert better
Message-ID: <cover.1566880835.git.liu.denton@gmail.com>
References: <cover.1566637431.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566637431.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio, thanks for the suggestion. I incorporated your suggestion.
Also, I decided to incorporate another patch (3/3) I was planning on
submitting later since both these patchsets have a common purpose:
advertising the `--skip` option better.


Before, the completion script would not complete `--skip` for
cherry-pick and revert, even though it is a valid option while that
operation is in progress. Add that missing completion.

Also, if a cherry-pick or revert is still in progress, mention the
`--skip` flag in the status message so that users are more aware of
their options.

Changes since v1:

* Instead of outright replacing the old completion variables, make them derive
  from a common variable.
* Add patch 3/3 and change the focus of this patchset so that it's focused on
  advertising the `--skip` option better.


Denton Liu (3):
  completion: merge options for cherry-pick and revert
  completion: add --skip for cherry-pick and revert
  status: mention --skip for revert and cherry-pick

 contrib/completion/git-completion.bash | 6 ++++--
 t/t7512-status-help.sh                 | 6 ++++++
 wt-status.c                            | 4 ++++
 3 files changed, 14 insertions(+), 2 deletions(-)

Range-diff against v1:
1:  cdcac97554 < -:  ---------- completion: merge options for cherry-pick and revert
2:  75adf58158 < -:  ---------- completion: add --skip for cherry-pick and revert
-:  ---------- > 1:  862802366a completion: merge options for cherry-pick and revert
-:  ---------- > 2:  c83feb3d6e completion: add --skip for cherry-pick and revert
-:  ---------- > 3:  be64ce1e92 status: mention --skip for revert and cherry-pick
-- 
2.23.0.248.g3a9dd8fb08


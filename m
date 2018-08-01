Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90EEC1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 18:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbeHAUAu (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 16:00:50 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:48729 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729653AbeHAUAt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 16:00:49 -0400
Received: by mail-qk0-f202.google.com with SMTP id 17-v6so17740670qkz.15
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 11:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HLOZL16k3Miw1tA+hMzQebis2ZYCuof+MXP8eLoObAk=;
        b=dVdPeoCvWzizsuAyDFKNAY7m/LfzKRNpdmtj6aBiLwKKScRDrGqy1fd75ZCVq9sAqc
         DaQx6D0VZADbvu6/EF5lr7Gh8lVrM1tYYJqmGtc1nDxxre5elJ8yTtAzhvDcLWjffm4d
         975peYt/yYMyttrjAHRno5xc81uVI2ai13OrPndKOnAgQSeBQVQmRqF7I34tke6H7VkW
         c8WMt+HgXpyV3dRBX7kjf4hXx++Y8GwqYqCP6vewaD3dDRiSUroBTgmNzvCJf/DUFCcA
         FkDL9ddukdKeh0UHqvzXIBnLj3l3ct4Pj2smnJhTZc784uFRl/fGmsyqrUMOhUP+F8Cl
         48JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HLOZL16k3Miw1tA+hMzQebis2ZYCuof+MXP8eLoObAk=;
        b=dcF5oDTLvfNO/lkD2sGm3ljBpOUi2PDDOsvRlzxK1FjMTpW3TbT2cqPSDjuy1UWrfR
         2DKRgz5XzshCi/9foIaJMUiPqMTZA4pDZSrkflXT9A26C+q/GAFH4QmJG2cqW7c93DvG
         gg8aZivkWru8SAJkkxjCUSo80h7lmBMD8COl6wUwNRNWhGFUOoeZRp7p1U+vTGQysRiT
         gPghu/1+VWpF9qXieXkTzartRT3BbUMXklQOnMm/7LF3Q0oBTt+/Q2aSd26lmLuaUgqT
         mR1v8if0eeGV9L0RobMVeQ8jBlQGVd/QxTHybVEW3j2eLC7HfmI/Z8fUQRUBMnbNg+dG
         yMIQ==
X-Gm-Message-State: AOUpUlFO9BgIW3OSjOyvXoGdRThTzgyRrrGwtDrfv2pFQogcyqkhFgCD
        2TR9RsBL0EH7LYp61vhIhsDMRk9Z1rGjQOtpnvmt
X-Google-Smtp-Source: AAOMgpcaOud0AQcCFHNO4E9muFuaJnPLMyulvZFuhJAQcTuwLr+J/JAn60yUCni5BkhuHX04lfVIFpZU0PgZftEDyqrV
X-Received: by 2002:a0c:9b88:: with SMTP id o8-v6mr14539294qve.43.1533147232258;
 Wed, 01 Aug 2018 11:13:52 -0700 (PDT)
Date:   Wed,  1 Aug 2018 11:13:48 -0700
In-Reply-To: <xmqq8t5q821c.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180801181348.106679-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq8t5q821c.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3.dirty
Subject: Re: [PATCH v2] remote: make refspec follow the same disambiguation
 rule as local refs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +test_expect_success 'LHS of refspec follows ref disambiguation rules' '
> +	mkdir lhs-ambiguous &&
> +	(
> +		cd lhs-ambiguous &&
> +		git init server &&
> +		test_commit -C server unwanted &&
> +		test_commit -C server wanted &&
> +
> +		git init client &&
> +
> +		# Check a name coming after "refs" alphabetically ...
> +		git -C server update-ref refs/heads/s wanted &&
> +		git -C server update-ref refs/heads/refs/heads/s unwanted &&
> +		git -C client fetch ../server +refs/heads/s:refs/heads/checkthis &&
> +		git -C server rev-parse wanted >expect &&
> +		git -C client rev-parse checkthis >actual &&
> +		test_cmp expect actual &&
> +
> +		# ... and one before.
> +		git -C server update-ref refs/heads/q wanted &&
> +		git -C server update-ref refs/heads/refs/heads/q unwanted &&
> +		git -C client fetch ../server +refs/heads/q:refs/heads/checkthis &&
> +		git -C server rev-parse wanted >expect &&
> +		git -C client rev-parse checkthis >actual &&
> +		test_cmp expect actual &&
> +
> +		# Tags are preferred over branches like refs/{heads,tags}/*
> +		git -C server update-ref refs/tags/t wanted &&
> +		git -C server update-ref refs/heads/t unwanted &&
> +		git -C client fetch ../server +t:refs/heads/checkthis &&
> +		git -C server rev-parse wanted >expect &&
> +		git -C client rev-parse checkthis >actual
> +	)
> +'

Thanks, this looks good to me. Also thanks for adding the "+" in the
fetch commands in the test.

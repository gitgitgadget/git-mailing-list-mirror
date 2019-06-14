Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BB3F1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 03:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbfFNDsF (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 23:48:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43479 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfFNDsF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 23:48:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so704688pgv.10
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 20:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9uaHBVG6gmLAOo4P4d2qrg4ODU7ebtLgeGFCAgy/KC4=;
        b=U3DqD5vebpOL7XFHM7tERO/j9kaS88GNY8mDI8EcC8zCG15wuJ+n0CJOj1Uf+/l1gj
         /Z7eLETqCw4saAu41XRqb8spHMVE9kIPNN5sPiDI3br3OyQt4+0rquLf5BszC1zbSYQd
         TyGjM10VB2LOFq/OFwR++8A1y/OjjTk4MgoQ+vjV4mki1JYP6+oQj7SX9HJVBIlB4yXg
         WsYm7kBfwG5ivz8JnLt79X4tKZ27BWrYXlsO+8iY7WPtRB6z+K61mXMDqt4Kt9Y/EIof
         2vQBEPm0Xv6gJ06iP7ncYiPPR4LcF6x+ZqXsm/3IfVwLLOXtKXljfxcjWD3lvXp1I/gk
         tgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9uaHBVG6gmLAOo4P4d2qrg4ODU7ebtLgeGFCAgy/KC4=;
        b=nMUyp/FeOoLMBpVK+ZaKPLxObAKsHuhoMWajA84o9G/NLvtwQo7S7deGSaMB42A7wr
         XLcdanBGhsEe4BPwoQ2Sw2gFjfSGNsrBGQWqJS+NBWTyNn9SYSXuhd7Xi8tr0T1KSHdU
         7+etZfB03bBj+XMgvDUIsc8TGguzCK3Ie2bd+6a//Snh9W3qcbdIC3ZB+loUf0qMzLqP
         wav1BFSN9VOyo+Caju+vH+E8jgr0vKid3sd80MN1NrKtkqxqyR6OAWeWzweMihcGfCOI
         T3BTzS3NqXMNG9UIs4+Dh4LFC0wQgT3FDhloe+CwRCYtqhNj46CnwLDsWKzGWpgmx4dt
         k7/Q==
X-Gm-Message-State: APjAAAVnM7F7Y+ku56GIunFUTktVS31W99rWkBbtPXpWJ4BqT9b6aOZK
        ZyUEKaCbqsn3HS296UBjDGQ=
X-Google-Smtp-Source: APXvYqxH5cUjDcJoQt59M3CexKI3YX6tBwp5dKq+C5yRJnPN7l0ZpKOUdDAklDH6WRImZYBwLfGZlg==
X-Received: by 2002:aa7:8e54:: with SMTP id d20mr7640245pfr.16.1560484084276;
        Thu, 13 Jun 2019 20:48:04 -0700 (PDT)
Received: from ar135.iitr.local ([117.234.2.144])
        by smtp.gmail.com with ESMTPSA id c69sm1373585pje.6.2019.06.13.20.48.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 20:48:03 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, newren@gmail.com, phillip.wood123@gmail.com,
        rohit.ashiwal265@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v3 2/3] cherry-pick/revert: add --skip option
Date:   Fri, 14 Jun 2019 09:15:54 +0530
Message-Id: <20190614034554.19364-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <xmqqa7elwer9.fsf@gitster-ct.c.googlers.com>
References: <xmqqa7elwer9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 2019-06-13 17:56 UTC Junio C Hamano <gitster@pobox.com> wrote:
> 
> > +'git cherry-pick' --continue | --skip | --abort | --quit
> 
> Is this correct, or do we need to enclose these choices inside (),
> i.e.
> 
> 	'git cherry-pick' ( --continue | --skip | --abort | --quit )
> 
> ?

Documentation of `git rebase` also lists these options without the
'('s so, I thought to make it similar to that.
 
> It is unclear *why* the function (and more importantly, its callers)
> would want to omit two sanity checks when is_skip is in effect.
> 
> Before this patch introduced such conditional behaviour, the name
> was descriptive enough for this single-purpose function that is a
> file-local helper, but it is no longer a case.  The function needs a
> bit of commentary before it.
> 
> When &&-chaining error checks that are optional, check the condition
> that makes the error checks optional first, i.e.
> 
> 	if (!is_skip &&
> 		!file_exists(...) && !file_exists(...))
> 		return error(...);
> 
> [...]
> 
> no, do not merely give answer to me in your response---write the
> answer as in-code comment to help future readers of the code).
> 
> "Because when we come here, sometimes the XXX_HEAD must exist but
> some other times XXX_HEAD may not exist, so insisting that either
> exists would make the function fail" is *NOT* a good answer, on the
> other hand.  Somebody must still check that the necessary file
> exists when it must exist.

Yes, I should have added some comments. I'll add them in next revision.

Thanks
Rohit


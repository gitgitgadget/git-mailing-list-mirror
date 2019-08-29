Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8C871F461
	for <e@80x24.org>; Thu, 29 Aug 2019 21:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfH2V6Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 17:58:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43059 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfH2V6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 17:58:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8so4906148wrn.10
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 14:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fbV9zqH8GUsWrQNjxcy0XOtXEkT1KAW4Ova6geKxGTU=;
        b=NThEHatCT+7RM8uc2tpmmi9kQvLHAJk7UJ/PBTW9jwCdHrPRiW4CfIzFC0fM882SYs
         7Dh5Ll766f164+7qWJPjTovVJ4qsJraoSrCuOjJGWh3Zn+qCZ+lNZ+pxn5HA0iDAEQgJ
         zSaII//FPQOU6WjHVC3C53Q07/l0nyUsAE1ziIGzkek7G6Z3yfUXikuiFVH3F8/gu9zW
         EPEo0ON/QZPXyV9n1x7hCYgivNGg2ZsktSusfX6AXnVk1LL4weS96JA4+T4DuO0SYZjT
         rdgRzUUrKSdiEEIUraKKvKJzMle8ZTlW3nPiAN3qNkBgF5YKNvoJDpdu6dXu4DgODJpa
         QMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fbV9zqH8GUsWrQNjxcy0XOtXEkT1KAW4Ova6geKxGTU=;
        b=YGc8iGi+qXMo/cTzaFjhruJcOMWItUtz3iYxM0S9Hcxz4kgR9ud11A7REUTdGnPZdH
         C9vmJ/NLPkzATfvD3b6qV3mqddipY6QVvGDN++LJrOF9tFegaWMgQUxU42aXsxg/2Ejl
         iKXQZ19iAGXLyQ/4ivsr5SK0I/Ds0ALAqoYUaxGLNt9Uc15sKlkVRRqGt1yXWeOG3mq6
         xvWsOto6nrhroxtvHpQUngbzIlnoOmXwykQ2EVD6ka/QTbIdvGNw80dIeUqQ03WJpOuB
         CbARNQC746vAze4JFqelB+keDwgB8DNJU3U3uRrJ+eU0Sqk/fK1HRQRrrLxZwqSc2bwB
         lTtg==
X-Gm-Message-State: APjAAAWQp+3SZpLvuG0Y9Fo0sbHd1nKcjY5sUqpV4217ot5qQBAkM/12
        EwWX5Fa9LOeMGNARMYeVw7E=
X-Google-Smtp-Source: APXvYqwpw1pa2Ads2Au9zKh9Et+9dBPadY1+IdhFS+ldzR4eawCLe8ZHL2wmYSOZ3SDRFdR1FFVjtg==
X-Received: by 2002:adf:ea08:: with SMTP id q8mr14920043wrm.188.1567115902343;
        Thu, 29 Aug 2019 14:58:22 -0700 (PDT)
Received: from szeder.dev (x4db98d3c.dyn.telefonica.de. [77.185.141.60])
        by smtp.gmail.com with ESMTPSA id r190sm5156064wmf.0.2019.08.29.14.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 14:58:21 -0700 (PDT)
Date:   Thu, 29 Aug 2019 23:58:18 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] upload-pack: fix race condition in error messages
Message-ID: <20190829215818.GG8571@szeder.dev>
References: <pull.324.git.gitgitgadget@gmail.com>
 <5c313aba7e97cb93e7d07f6d5dfaf0febe8a2f8b.1566956608.git.gitgitgadget@gmail.com>
 <20190828093408.GD8571@szeder.dev>
 <20190828145412.GB14432@sigill.intra.peff.net>
 <20190828153944.GA29715@sigill.intra.peff.net>
 <20190828161552.GE8571@szeder.dev>
 <4d5773f9-4637-d8a3-d683-82624950f319@gmail.com>
 <20190829141307.GE1797@sigill.intra.peff.net>
 <131dfa37-0f65-f0c3-6f30-5b6eca12d9c0@gmail.com>
 <20190829143805.GB1746@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190829143805.GB1746@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 29, 2019 at 10:38:05AM -0400, Jeff King wrote:
> So any fixes there have to happen on the client side. I am still
> confused about why the client is writing in this case, per the argument
> in 014ade7484 (upload-pack: send ERR packet for non-tip objects,
> 2019-04-13). It would be nice to use GIT_TRACE_PACKET to see what it's
> trying to write, but I still haven't been able to reproduce the issue.

It's the "done" line:

  + cat trace-packet
  packet:  upload-pack> 5e26403b4485d7a44fd8b65dc3f71e21c0dd6fad HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow deepen-since deepen-not deepen-relative no-progress include-tag multi_ack_detailed allow-tip-sha1-in-want allow-reachable-sha1-in-want symref=HEAD:refs/heads/master agent=git/2.23.0.40.g4d780d4382.dirty
  packet:  upload-pack> 5e26403b4485d7a44fd8b65dc3f71e21c0dd6fad refs/heads/master
  packet:  upload-pack> 0000
  packet:        fetch< 5e26403b4485d7a44fd8b65dc3f71e21c0dd6fad HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow deepen-since deepen-not deepen-relative no-progress include-tag multi_ack_detailed allow-tip-sha1-in-want allow-reachable-sha1-in-want symref=HEAD:refs/heads/master agent=git/2.23.0.40.g4d780d4382.dirty
  packet:        fetch< 5e26403b4485d7a44fd8b65dc3f71e21c0dd6fad refs/heads/master
  packet:        fetch< 0000
  packet:        fetch> want 64ea4c133d59fa98e86a771eda009872d6ab2886 multi_ack_detailed side-band-64k thin-pack no-progress ofs-delta deepen-since deepen-not agent=git/2.23.0.40.g4d780d4382.dirty
  packet:        fetch> 0000
  packet:  upload-pack< want 64ea4c133d59fa98e86a771eda009872d6ab2886 multi_ack_detailed side-band-64k thin-pack no-progress ofs-delta deepen-since deepen-not agent=git/2.23.0.40.g4d780d4382.dirty
  packet:  upload-pack< 0000
  packet:  upload-pack> ERR upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab2886
  packet:  upload-pack> 0000
  packet:        fetch> done

In the avarage successful run that "fetch> done" pkt-line is
immediately after the "fetch> 0000".

The above is on my Linux box; here is a failure on macOS, essentially
the same:

  https://travis-ci.org/szeder/git/jobs/578555606#L3453



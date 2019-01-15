Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F3901F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 01:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfAOBiM (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 20:38:12 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:33932 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfAOBiL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 20:38:11 -0500
Received: by mail-pl1-f181.google.com with SMTP id w4so498259plz.1
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 17:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jZ8TaFMB4M4nBcLTt/CfdHpeYCpoUeSgwgnbuGwVrWQ=;
        b=nd74begoEzgAHik6e7e3MBvUfUSnNfd/g+5ABqZibi4DKXaZW4Lg1ircYRunLxEKNl
         Xzqc9zqeUWEkGflZ7ErQsKxB2O42Qe0I4RJRPT55fctB8FcEbcq+LnmZceI2yZ8QkWhY
         VwhBw1MF8BViLR/FMFYgG4qb7CrZbkR8dfQRCElsDdVlWC3HMhe8bquUM/5EFPYXyMQb
         zOGDE8v2e5B7hZIEWip/qLY7Z16BRVv2Bf3yQub3ICAIWJfgxV+AQ0VKIA8UN97AsLYB
         5vXNVQTLCHQmStHyVvfsIKlAQ7RY/H6ZURDrmo2biEnV89rhSaYXUml+7qsQxtnJOxWQ
         n96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jZ8TaFMB4M4nBcLTt/CfdHpeYCpoUeSgwgnbuGwVrWQ=;
        b=c9mxVer8nqSQc6pPqpk2huR6/8Hmi6mxMgwohiWOmipiF+uB2vN+oZ7lXfWw7AwsdN
         GZTeQw3mY9iaoIdaj17Z89aIK1fkoN5rimS9uHfP7mnDjKi4fZhfRvFLtdzaOnt/qvkJ
         d/80WE58uDmGVFGCrS2BvDw5/Imd9ME6N0IIlvsw2NNFhp9G1HWbKUmnPpGuUUTAxRsG
         tWI8joDX88JO4RdDS4it/q8QKWQ6d762m4DwWaOd4DXZ0ChSvTdpVDkgkrUkuypccbEM
         0nEGWP80d1y7jsTgLV+9i1S2S+dq8CYMvw9VMCHv0bO/Ns1AeP/Jf7Edq2mt8KtsjEDN
         xO0w==
X-Gm-Message-State: AJcUukd8IyG1+TV8fUiCoBQ5GTaLfUTDFS3PBi9apq+9hiiFdCXyKUzK
        zvy365yoNQDB3DMvZcC0kl4=
X-Google-Smtp-Source: ALg8bN4OWQEr+T7oHhX5UiobpemvjYsVZ8rGM4IzgdM6Z0CR9UjiUfBrtmt8MLGmvBoGKtDdFfsgRw==
X-Received: by 2002:a17:902:8484:: with SMTP id c4mr1435404plo.59.1547516291058;
        Mon, 14 Jan 2019 17:38:11 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id y84sm4566045pfb.81.2019.01.14.17.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 17:38:10 -0800 (PST)
Date:   Mon, 14 Jan 2019 17:38:08 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/9] Resending sb/submodule-recursive-fetch-gets-the-tip
Message-ID: <20190115013808.GL162110@google.com>
References: <20181129002756.167615-1-sbeller@google.com>
 <20181207002531.GA37614@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207002531.GA37614@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon wrote:

> I am not very familiar with most of the submodule code, but for what
> it's worth, this entire series looks good to me. I'll note that most of
> the commits caused some style complaints, but I'll leave it up to your
> judgement as to whether they're valid or not.
>
> Reviewed-by: Josh Steadmon <steadmon@google.com>

For what it's worth, we've been running with this at Google (using the
sb/submodule-recursive-fetch-gets-the-tip branch from "pu") for more
than a month, with no user complaints.

Tested-by: Jonathan Nieder <jrnieder@gmail.com>

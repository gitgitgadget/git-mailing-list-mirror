Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F571FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 19:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933229AbeAHTc3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 14:32:29 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39147 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932155AbeAHTc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 14:32:28 -0500
Received: by mail-pg0-f67.google.com with SMTP id z20so3942504pgv.6
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 11:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MZQdfJCL3SYQis5hzADOkuMhnMMyhLPkBzlSvWxvUv0=;
        b=c5fFyHOtM7ovAjRpJya7ZMC3OSrH3cFRpTuryBAfcKMvk1mJXvVbFLH4hDpCyiAVhF
         IGoe1RRaEV8Jkwi1rqMiHhPQU4ou9QaVCqzf/oH5lFTPxg67466Iw24PQYbhWQIqnR9D
         uSTrMHaDKxliBudpDDEN9hd0SnndpU5jqelgvCf6LwKPdhEZmiHxtyNFFrGkFNHSvWbR
         HLHU8kqU5c5YGjle1lSxNW669FwRfCKQaB/oQf702aCXOBko8NoHyvL3GnBhzSinGi/B
         pmMHmA0RMtM57k5dJl5/it4+1yf0Z0hBHsg5DcO2vlDocFFw58G06+LQhfBhAEjf0t5e
         9foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MZQdfJCL3SYQis5hzADOkuMhnMMyhLPkBzlSvWxvUv0=;
        b=qP0SfjbKm56JUqYwK55S8u2+z05YZnxNtJXjpHTtQ31xIW0JpYcqN8DPhqeUD9Adg0
         9KiBPkuCvoCBzm2yyJVLP7Aeg3pxS2rMlYJh8OxkbojxYQ2LLJC+4XY80OMrFRVHU2cx
         GT27jk/v9cB7YpHbsRdZXdbTkJQQRGJGQRr+Oi49BIuoDYzvr9jRnbJ2KFzfCqnvw4yk
         VShVU6S4i4lCxThBIqsK5xj6XrwBDM08jip4+CaOO1ABF+uaEWtuuM1kusWm/ZvC4Pg0
         EB5F9vWzgCQXc4d3u92TEEdieuvNPahhDJwGICkuL9Yj+ozUBCXJ95aIgU12QzRwIbMN
         td7A==
X-Gm-Message-State: AKGB3mLciUbw7Zwd5j3kSULEeMZRMYjk5TRDZaCucs0z6qBHIMl1/64r
        tos3KNc/1ifjJlybhLsk7UPjfRC8KX4=
X-Google-Smtp-Source: ACJfBouoJjx1uqgdZCSGPAu1S9zfXGqpnX9D90LE2kW+YrWeox62Trf/I9mudNP7PkBJcwlY8kts9Q==
X-Received: by 10.101.80.139 with SMTP id r11mr10125619pgp.383.1515439947783;
        Mon, 08 Jan 2018 11:32:27 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:b54f:f5a7:98a3:acf1])
        by smtp.gmail.com with ESMTPSA id w21sm26680103pfl.50.2018.01.08.11.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jan 2018 11:32:26 -0800 (PST)
Date:   Mon, 8 Jan 2018 11:32:26 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: Re: [RFC PATCH 01/18] docs: Multi-Pack Index (MIDX) Design Notes
Message-Id: <20180108113226.da265814e5c1deea1f8c404d@google.com>
In-Reply-To: <20180107181459.222909-2-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
        <20180107181459.222909-2-dstolee@microsoft.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun,  7 Jan 2018 13:14:42 -0500
Derrick Stolee <stolee@gmail.com> wrote:

> +Design Details
> +--------------
> +
> +- The MIDX file refers only to packfiles in the same directory
> +  as the MIDX file.
> +
> +- A special file, 'midx-head', stores the hash of the latest
> +  MIDX file so we can load the file without performing a dirstat.
> +  This file is especially important with incremental MIDX files,
> +  pointing to the newest file.

I presume that the actual MIDX files are named by hash? (You might have
written this somewhere that I somehow missed.)

Also, I notice that in the "Future Work" section, the possibility of
multiple MIDX files is raised. Could this 'midx-head' file be allowed to
store multiple such files? That way, we avoid a bit of file format
churn (in that we won't need to define a new "chunk" in the future).

> +- If a packfile exists in the pack directory but is not referenced
> +  by the MIDX file, then the packfile is loaded into the packed_git
> +  list and Git can access the objects as usual. This behavior is
> +  necessary since other tools could add packfiles to the pack
> +  directory without notifying Git.
> +
> +- The MIDX file should be only a supplemental structure. If a
> +  user downgrades or disables the `core.midx` config setting,
> +  then the existing .idx and .pack files should be sufficient
> +  to operate correctly.

Let me try to summarize: so, at this point, there are no
backwards-incompatible changes to the repo disk format. Unupdated code
paths (and old versions of Git) can just read the .idx and .pack files,
as always. Updated code paths will look at the .midx and .idx files, and
will sort them as follows:
 - .midx files go into a data structure
 - .idx files not referenced by any .midx files go into the
   existing packed_git data structure

A writer can either merely write a new packfile (like old versions of
Git) or write a packfile and update the .midx file, and everything above
will still work. In the event that a writer deletes an existing packfile
referenced by a .midx (for example, old versions of Git during a
repack), we will lose the advantages of the .midx file - we will detect
that the .midx no longer works when attempting to read an object given
its information, but in this case, we can recover by dropping the .midx
file and loading all the .idx files it references that still exist.

As a reviewer, I think this is a very good approach, and this does make
things easier to review (as opposed to, say, an approach where a lot of
the code must be aware of .midx files).

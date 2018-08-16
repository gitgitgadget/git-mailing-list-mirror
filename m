Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9596C1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 16:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388841AbeHPTWx (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 15:22:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33789 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeHPTWx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 15:22:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id v90-v6so1509792wrc.0
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=eqZUlP3BtrbLX17HIdpxRWlwKyXS1wpvGxw2PDKxCeg=;
        b=pNhbVAcpxYyiuXyOfAeo5QgmdX+NfK4Y0Yn7jlGVpdPb9CJ9XpzjNkLUU7hvHUhFEX
         AMbCaty8PLbHJWBg+rT5Q0ehHI5skPczfbBWXJ3Spi5GCReBuzGI5n1Ay+tFnR8TGijk
         fZsXsffvVc5wOglYGEewEOta16XMq5iqa0/cBmaibmqgm+4cZGpdFMCKKT/p1Vn6dglh
         o70vbIPjrcDEUTmJWtNWhZW4/O2GE+VgCMbDFMUbHD+0/Ao6+LzboekLxS75++Wc9/5u
         SSkaTzzA+pAcm1lPyNKYVtYw3c/m4C/jBrqa9zjzAUJgh2XWo52oCfoE3rr32y0XUGAM
         uALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=eqZUlP3BtrbLX17HIdpxRWlwKyXS1wpvGxw2PDKxCeg=;
        b=N/57xfXkBuks6rvegtjVdc5/PPJpKLFbuA6RG7QJ24MiJeA+Nb9rlHr6bANEcOiOV8
         zp5p02mc5/8/x2rNiNhOGUv3fNGWi+RFZcOkX6yQX4QWEsTNyzrJ1UAUrmpH+ZDrGdQd
         BP/8duMdnOHvTQ8IfGGPODVxgMyd+O9ZrIRE359qeqm6IRhfltWu8Xday7Q6EQ+OljLr
         1T2CAdvqCGuR0sezzOW8EthnMEzhsT/h9X1v7Oh79TRUqLbo8LtV2hm+3/Xg+f++CvL3
         /24s7yBCXv3MyYy78nbuO6Dz57ax1tC2tWq7BL/Yc2koyqQKzbQyMXBTLqpBUfoS4uiQ
         UgvA==
X-Gm-Message-State: AOUpUlF3qxm65Uv6sEU53cbrt+iQPQg29mddUXfwL8u0jQs9no94/HYg
        4RBIYxyOTwHe/D6RyKnrJ+k=
X-Google-Smtp-Source: AA+uWPwgr3TY7hEetvAREs1weEK32AErLL/4eycac/RnyZAkRu/Wl+QTSWJFtSQQhfrmL9TfaKFN6g==
X-Received: by 2002:a5d:4e49:: with SMTP id r9-v6mr18897668wrt.27.1534436603282;
        Thu, 16 Aug 2018 09:23:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w18-v6sm5943187wrc.38.2018.08.16.09.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 09:23:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@jeffhostetler.com, git@vger.kernel.org, newren@gmail.com,
        pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4] clone: report duplicate entries on case-insensitive filesystems
References: <20180810153608.30051-1-pclouds@gmail.com>
        <20180812090714.19060-1-pclouds@gmail.com>
        <20180815190816.GA26521@tor.lan>
        <xmqqtvnvh12u.fsf@gitster-ct.c.googlers.com>
        <20180816140312.GA6102@tor.lan>
Date:   Thu, 16 Aug 2018 09:23:19 -0700
In-Reply-To: <20180816140312.GA6102@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6ge?=
 =?utf-8?Q?rshausen=22's?= message
        of "Thu, 16 Aug 2018 16:03:12 +0200")
Message-ID: <xmqqpnyiffgo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> check_stat is 0 on Windows, and inum is allways 0 in lstat().
> I was thinking about systems which don't have inodes and inum,
> and then generate an inum in memory, sometimes random.
> After a reboot or a re-mount of the file systems those ino values
> change.
> However, for the initial clone we are fine in any case.

Yup.

> Now back to the compiler switch:
> Windows always set inum to 0 and I can't think about a situation where
> a file in a working tree gets inum = 0, can we use the following:
>
> static void mark_colliding_entries(const struct checkout *state,
> 				   struct cache_entry *ce, struct stat *st)
> {
> 	int i;
> 	ce->ce_flags |= CE_MATCHED;
>
> 	for (i = 0; i < state->istate->cache_nr; i++) {
> 		struct cache_entry *dup = state->istate->cache[i];
> 		int folded = 0;
>
> 		if (dup == ce)
> 			break;
>
> 		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
> 			continue;
> 		/*
> 		 * Windows sets ino to 0. On other FS ino = 0 will already be
> 		 *  used, so we don't see it for a file in a Git working tree
> 		 */
> 		if (st->st_ino && (dup->ce_stat_data.sd_ino == st->st_ino))
> 			folded = 1;

Hmm, that is tempting but feels slightly too magical to my taste.
Others may easily be able to persuade me to change my mind in this
case, though.

> 		/*
> 		 * Fallback for NTFS and other case insenstive FS,
> 		 * which don't use POSIX inums
> 		 */
> 		if (!fspathcmp(dup->name, ce->name))
> 			folded = 1;
>
> 		if (folded) {
> 			dup->ce_flags |= CE_MATCHED;
> 			break;
> 		}
> 	}
> }
>
>
>> 
>> Another thing we maybe want to see is if we can update the caller of
>> this function so that we do not overwrite the earlier checkout with
>> the data for this path.  When two paths collide, we check out one of
>> the paths without reporting (because we cannot notice), then attempt
>> to check out the other path and report (because we do notice the
>> previous one with lstat()).  The current code then goes on and overwrites
>> the file with the contents from the "other" path.
>> 
>> Even if we had false negative in this loop, if we leave the contents
>> for the earlier path while reporting the "other" path, then the user
>> can get curious, inspect what contents the "other" path has on the
>> filesystem, and can notice that it belongs to the (unreported--due
>> to false negative) earlier path.
>> 
> [snip]

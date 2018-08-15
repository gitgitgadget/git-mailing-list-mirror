Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8D3C1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 19:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeHOWcX (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 18:32:23 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:39535 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbeHOWcX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 18:32:23 -0400
Received: by mail-wr1-f45.google.com with SMTP id h10-v6so2054711wre.6
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 12:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=azL3I72/Ktb7ma0DXFMrBeZ2GsXs+QHWZMfRtTJcxaw=;
        b=nEdzJu0MHswq1OfBkDurp91hQyk1aDac45dO/1pKyewNP5cBceNMezzOFIL5h3mds6
         zCNILCg5ACMIKRRULlLhDoQe8Y9P472v1VBUljnKUq/0gvvpZBOzCZ+h4Z+1A/0ijkrE
         BO5T59nHzBhiJLT+b626oGdWao/qFfZrwaZ356KP1sI56+uoOYKBFcYkT55YiG1vSLrm
         XySbdw31rIRFDk+PDUzk9+xgid1k7unTR+9M3OMGXMcfu6iek/UM8spruJN2TYfHRzZ6
         VsJeerZeNq1tDiujbBlI9a9KuSdbV4zUEtMjsKy2E+/R67OxMDASyKymSYlAHK6OhnpB
         UVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=azL3I72/Ktb7ma0DXFMrBeZ2GsXs+QHWZMfRtTJcxaw=;
        b=N0yMltSA2Or9OXzL4JQ2/rXG/Ba4dmDW7LdegY/slt4lNa4/Rddgm484QW5uE6y3yG
         efedhyQynZFSEQjww6o+ub6Shaz6+M8Gi28M+qkEhQB/8yBRK4WKOSMd32pbdwZFTDCL
         FLdKZYoALAymQTC9LtSIwiKaksdIxfnoKLO92JOCM8Km4Va+bE1ke4JDyDUVSsosnVzW
         D9o0hrfzpu/isQBvFKmdnFUpHl3ekng1Tzle8TEqE3sy5mOAcGpfPv18xlQumt5bldpz
         P5GwIqvlLViMkmAD/jZslIuFSvMPVJpoUmnrMo/IXsdsfIfmmYTSJq/zp6qTCYfFmWpa
         A0IA==
X-Gm-Message-State: AOUpUlFAK+9zIjPZaAarmOtCR8eTNn3BlUbUgA++teAhTpvvT+Tk9WIr
        Xo0RgBEfWZ49qCqybjNCALg=
X-Google-Smtp-Source: AA+uWPwLIfgk1aI7pCa3dwWytYJlocNnpEpguiadngvlDRlzL6+Ny6Jr4LTA2aZOU+aUCzZDmJs0dg==
X-Received: by 2002:adf:a789:: with SMTP id j9-v6mr16963302wrc.277.1534361930402;
        Wed, 15 Aug 2018 12:38:50 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h83-v6sm2016066wmf.46.2018.08.15.12.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 12:38:49 -0700 (PDT)
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
Date:   Wed, 15 Aug 2018 12:38:49 -0700
In-Reply-To: <20180815190816.GA26521@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Wed, 15 Aug 2018 21:08:16 +0200")
Message-ID: <xmqqtvnvh12u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

>> +
>> +#if !defined(GIT_WINDOWS_NATIVE) /* inode is always zero on Windows */
>> +	for (i = 0; i < state->istate->cache_nr; i++) {
>> +		struct cache_entry *dup = state->istate->cache[i];
>> +
>> +		if (dup == ce)
>> +			break;
>> +
>> +		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
>> +			continue;
>> +
>
> Should the following be protected by core.checkstat ? 
> 	if (check_stat) {

I do not think such a if statement is strictly necessary.

Even if check_stat tells us "when checking if a cached stat
information tells us that the path may have modified, use minimum
set of fields from the 'struct stat'", we still capture and update
the values from the same "full" set of fields when we mark a cache
entry up-to-date.  So it all depends on why you are limiting with
check_stat.  Is it because stdev is unusable?  Is it because nsec is
unusable?  Is it because ino is unusable?  Only in the last case,
paying attention to check_stat will reduce the false positive.

But then you made me wonder what value check_stat has on Windows.
If it is false, perhaps we do not even need the conditional
compilation, which is a huge plus.

>> +		if (dup->ce_stat_data.sd_ino == st->st_ino) {
>> +			dup->ce_flags |= CE_MATCHED;
>> +			break;
>> +		}
>> +	}
>> +#endif
>
> Another thing is that we switch of the ASCII case-folding-detection-logic
> off for Windows users, even if we otherwise rely on icase.
> I think we can use fspathcmp() as a fallback. when inodes fail,
> because we may be on a network file system.
>
> (I don't have a test setup at the moment, but what happens with inodes
> when a Windows machine exports a share to Linux or Mac ?)
>
> Is there a chance to get the fspathcmp() back, like this ?

If fspathcmp() never gives false positives, I do not think we would
mind using it like your update.  False negatives are fine, as that
is better than just punting the whole thing when there is no usable
inum.  And we do not care all that much if it is more expensive;
this is an error codepath after all.

And from code structure's point of view, I think it makes sense.  It
would be even better if we can lose the conditional compilation.

Another thing we maybe want to see is if we can update the caller of
this function so that we do not overwrite the earlier checkout with
the data for this path.  When two paths collide, we check out one of
the paths without reporting (because we cannot notice), then attempt
to check out the other path and report (because we do notice the
previous one with lstat()).  The current code then goes on and overwrites
the file with the contents from the "other" path.

Even if we had false negative in this loop, if we leave the contents
for the earlier path while reporting the "other" path, then the user
can get curious, inspect what contents the "other" path has on the
filesystem, and can notice that it belongs to the (unreported--due
to false negative) earlier path.

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
>
> 		if (!fspathcmp(dup->name, ce->name))
> 			folded = 1;
>
> #if !defined(GIT_WINDOWS_NATIVE) /* inode is always zero on Windows */
> 		if (check_stat && (dup->ce_stat_data.sd_ino == st->st_ino))
> 			folded = 1;
> #endif
> 		if (folded) {
> 			dup->ce_flags |= CE_MATCHED;
> 			break;
> 		}
> 	}
> }

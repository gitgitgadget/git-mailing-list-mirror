Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 692AE20A40
	for <e@80x24.org>; Wed, 29 Nov 2017 20:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752350AbdK2UEZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 15:04:25 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:46485 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbdK2UEY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 15:04:24 -0500
Received: by mail-it0-f51.google.com with SMTP id t1so5478938ite.5
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 12:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AMIboDWVzrula0JQIeOtnjx7Hk8A7OqwJKij4Fi+R5o=;
        b=poKg8Weh3FIBo/Z1KyfEosfM0wjoSZ4nM4iy/Lc6EeSiO4KJcqtC34BaVrg/P3t/F1
         GaYRm1O1t9k6JgW6Yzo6zItHEmk5hett7eEEtcLE+sRS9QMFGZYcvtFQSec/v2w9qWEg
         wJTXc6WCxdn9mKAJsDpZsHifoKDJwT7UvY+jkj2sfF2DDyIpcR68psdumAz4QjACHz3Z
         aUem5G6JV+A69RML9TSY3d0In8WAX9Qak1fFE/+/edZcQHjgetZ/zwh6DUXrCIyg/gQB
         rnHICwzoqenq0DZEx/c0cO1V53PHV0KuLBIVfDIV1J0aYtcJulvjhmR1Wxm/MnoxfTdt
         2V4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AMIboDWVzrula0JQIeOtnjx7Hk8A7OqwJKij4Fi+R5o=;
        b=nOLx9ApVUYQPigS0O1STXl2rnLaW+aaodFm7uzXVUHsaxMtlMCUXEsSR8EvWgYe4ba
         aZc/MrcebjT/j/QbOJFXoT6ilRIl0CtJKgsqnplsictwdXHItZvi18CScsLZZ962RxxO
         TpyBpXVKxk07+rsfSE6Of18aCANqiNqsbJXF6RJNnTVlcxOxI8jAtvZBd9HTEaIYTiVs
         Zg3ySlXkcNO+HAknpD3OPU8cgo2NWk/tI30dxB8tU9+6mNFz5YZGDKt9f4D2z8BEuxix
         7RUa36pdpaYBdw+FoETHON9JnpNYghovVEz9s1FV1qN/jXSXxHo0VlXl0UzlRi/grPRc
         HOHA==
X-Gm-Message-State: AJaThX4f7mwUC5/GZzZ1vKoDzYmMMq44T6OfSE934EMk6EJpoUNEslal
        5UxvxN66IMZDIBuGKR7fHR0=
X-Google-Smtp-Source: AGs4zMbcVtBtF6EVxOc7SZbKe7/0OExJ5qqYzOJUYd+NF0mIsCKFc/b0IaxeUbCB7KxXK8CdE9IU5Q==
X-Received: by 10.36.208.207 with SMTP id m198mr34823itg.131.1511985863798;
        Wed, 29 Nov 2017 12:04:23 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id r17sm1088929ioe.88.2017.11.29.12.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 12:04:23 -0800 (PST)
Date:   Wed, 29 Nov 2017 12:04:21 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH on en/rename-progress] diffcore-rename: make diff-tree
 -l0 mean -l<large>
Message-ID: <20171129200421.GB15098@aiede.mtv.corp.google.com>
References: <20171129183200.178183-1-jonathantanmy@google.com>
 <CABPp-BHEyXcjFzGvLHToz+2FRMM3g-mUTxn2uf8exQV61qff9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHEyXcjFzGvLHToz+2FRMM3g-mUTxn2uf8exQV61qff9w@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Wed, Nov 29, 2017 at 10:32 AM, Jonathan Tan <jonathantanmy@google.com> wrote:

>> In the documentation of diff-tree, it is stated that the -l option
>> "prevents rename/copy detection from running if the number of
>> rename/copy targets exceeds the specified number". The documentation
>> does not mention any special handling for the number 0, but the
>> implementation before commit b520abf ("sequencer: warn when internal
>> merge may be suboptimal due to renameLimit", 2017-11-14) treated 0 as a
>> special value indicating that the rename limit is to be a very large
>> number instead.
>>
>> The commit b520abf changed that behavior, treating 0 as 0. Revert this
>> behavior to what it was previously. This allows existing scripts and
>> tools that use "-l0" to continue working. The alternative (to allow
>> "-l0") is probably much less useful, since users can just refrain from

I think in the parenthesis you mean 'to allow "-l0" to suppress rename
detection', since this patch is all about allowing '-l0' already.

>> specifying -M and/or -C to have the same effect.
>>
>> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>> ---
>> Note that this patch is built on en/rename-progress.
>>
>> We noticed this through an automated test for an internal tool - the
>> tool uses git diff-tree with -l0, and no longer produces the same
>> results as before.
>
> Thanks for testing that version and sending along the fix.
>
> I suspect the commit referenced twice in the commit message should
> have been 9f7e4bfa3b ("diff: remove silent clamp of renameLimit",
> 2017-11-13) rather than b520abf ("sequencer: warn when internal merge
> may be suboptimal due to renameLimit", 2017-11-14).
>
> Other than that minor issue, patch and test looks good to me.

Thanks, both.  Looking at that patch, the fix is obviously correct.

With Elijah's commit message tweak,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

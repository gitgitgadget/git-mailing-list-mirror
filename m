Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A9EF2021E
	for <e@80x24.org>; Wed,  2 Nov 2016 07:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750833AbcKBHQ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 03:16:59 -0400
Received: from mout.web.de ([212.227.17.11]:65246 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750720AbcKBHQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 03:16:58 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MJTZX-1bzuuo17Wt-00351M; Wed, 02 Nov 2016 08:16:49
 +0100
Date:   Wed, 2 Nov 2016 07:16:46 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #09; Mon, 31)
Message-ID: <20161102071646.GA5094@tb-raspi>
References: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:MXA6frm0G01l3y30BTtDhcvxqJk5xL/RYK1UMwv08xKa9VJicoK
 IL6U+OjdtXIXpqhaP74HelJtOmKEGeagW+0oCh7+l8v/NdlK18lTwrRCcTOE+ojNTLsLTb3
 qZcSlzlxNuym+iyUVYxJO7t2PFcLKCTgcFToEf3jBQgzo7ATiJzVA8EEqzyNO1ZUz3WQuHM
 anqco1uoGZg3blQHHe7DA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j0iO8dB4pAY=:r4RIQu0FxesJ2SYgZ5pMlf
 rNILiQ46ohs+NVfAZhxQ7fWBaq98SJ9/VkIu0QcSxWNtq285OVkWAAGwUz2jNNikWMjOecarq
 +v+hqvzJy/i2Tqbso7Eihkxrt/GoqYIhvKAqwLzmfpakHJd3dj8g8o3Ff1pS/vMxHv2uAkmmz
 heX2FJyDeGSRIUwZtcNPlNZNhVBsMobAdpEqWck49w/1/BpOdGrRZH5j+kceJot6JOyqhuc/p
 RHaIeluyP5OsYV/+cn8/iotICszT3ut93ZLkjfQ0+A+tSu/KAl2qtqJGDhSpvnHZN1/Dsm+xa
 6oxdejFykV24PTmWFVBPkEMgMZFSlZlo9YZhFn1KItLYwhPk/vHPrpoSJibRWVMuADPenb/CI
 0Igg0XRm/lNaW1/V9ucOrHaEU+6IN8/LU/QmMwhBCU8Bf9agNYJ4kDguzpkZ1IjfcqMkk/Emh
 /rcQ9QlmC2HEOlJpDnlZh/nzSg227BytljbXDEE1IHOXIgdZFdnqkk19HesfdbAMLeuzsq7wW
 XB6S51Sp4fQ6HStZdS9O1SuuIMvLHeXHrkceiPvCG3Rk/NtWofmLu+CnbhmLrWu6WFSnlt3SH
 As7y6byE3Nat4aOsf4pYvqu+8TtDgahtpJpePpXMIej7RC3ZzscX3BY+nXE4TXm8FbN0gQTHO
 E+dm8bJDfHxOML44PmytqL/h/IlkobF2j5s/OhZ9b2bT48oZ4HMRz8Pm9+5QS0tOoFSEJEXxl
 2GrIFTc0io3EJ9DmG1gTcwkamkwWuiqV4hbXQzGSncJ0jydFU+TpuIBUOEE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> 
> * tb/convert-stream-check (2016-10-27) 2 commits
>  - convert.c: stream and fast search for binary
>  - read-cache: factor out get_sha1_from_index() helper
> 
>  End-of-line conversion sometimes needs to see if the current blob
>  in the index has NULs and CRs to base its decision.  We used to
>  always get a full statistics over the blob, but in many cases we
>  can return early when we have seen "enough" (e.g. if we see a
>  single NUL, the blob will be handled as binary).  The codepaths
>  have been optimized by using streaming interface.
> 
>  The tip seems to do too much in a single commit and may be better split.
>  cf. <20161012134724.28287-1-tboegi@web.de>
>  cf. <xmqqd1il5w4e.fsf@gitster.mtv.corp.google.com>

Reviews have been done, thanks everybody.

It looks to be a good "proof of concept".

The current series is far away from being ready, so please kick it
out of pu and feel free to discard.
 

 

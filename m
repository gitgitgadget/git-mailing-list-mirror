Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1C761F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 18:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966100AbcIVSoR (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 14:44:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35017 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030244AbcIVSoO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 14:44:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3DCB261254; Thu, 22 Sep 2016 18:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1474569853;
        bh=HD/W4SsU4Qvp8wqt70EmP3pH/MbfqospGFlCj9ESnqY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=I3xtoQB4pRrMM48xPtk/5HxAhKVJUy3oBkbrxB07R/ZYqWHFh68uLOBJ1uQsL+nzW
         lhHnX2hWt+ZIBqoak39DyAoH0CMIRp1R51aCz0aeX191BYuqzS6PCxJfWgFC66e6AE
         q2TrbpjX/0VWThqiDb5bZ/A29FEdjWkXLRnqsZDE=
Received: from [10.222.143.167] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: timur@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94B7460CF5;
        Thu, 22 Sep 2016 18:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1474569853;
        bh=HD/W4SsU4Qvp8wqt70EmP3pH/MbfqospGFlCj9ESnqY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=I3xtoQB4pRrMM48xPtk/5HxAhKVJUy3oBkbrxB07R/ZYqWHFh68uLOBJ1uQsL+nzW
         lhHnX2hWt+ZIBqoak39DyAoH0CMIRp1R51aCz0aeX191BYuqzS6PCxJfWgFC66e6AE
         q2TrbpjX/0VWThqiDb5bZ/A29FEdjWkXLRnqsZDE=
DMARC-Filter: OpenDMARC Filter v1.3.1 smtp.codeaurora.org 94B7460CF5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=pass smtp.mailfrom=timur@codeaurora.org
Subject: Re: .gitignore does not ignore Makefile
To:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>
Cc:     git <git@vger.kernel.org>
References: <CAOZdJXWpcSZ+jAoV8HttkaB7Fh=wzWDTCsHy8W-S9xOOBodVFw@mail.gmail.com>
 <20160922154421.GA6641@ikke.info>
 <xmqqy42j4wp9.fsf@gitster.mtv.corp.google.com>
From:   Timur Tabi <timur@codeaurora.org>
Message-ID: <57E4267B.1050507@codeaurora.org>
Date:   Thu, 22 Sep 2016 13:44:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:43.0) Gecko/20100101
 Firefox/43.0 SeaMonkey/2.40
MIME-Version: 1.0
In-Reply-To: <xmqqy42j4wp9.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> It actually is even worse.  As the user promised Git that the <file>
> will not be modified and will be kept the same as the version in the
> index, Git reserves the right to_overwrite_  it with the version in
> the index anytime when it is convenient to do so, removing whatever
> local change the user had despite the promise to Git.  The "abort
> saying that the file has changed" is merely various codepaths in the
> current implementation trying to be extra nice.

So .gitignore only ignores new files, not modified ones?  That seems 
odd, but I guess that's the way it's always been and I just haven't 
noticed until now.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

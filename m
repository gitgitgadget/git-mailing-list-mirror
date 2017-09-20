Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45EEB2047F
	for <e@80x24.org>; Wed, 20 Sep 2017 01:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbdITBH6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 21:07:58 -0400
Received: from p3plsmtpa09-05.prod.phx3.secureserver.net ([173.201.193.234]:33613
        "EHLO p3plsmtpa09-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751471AbdITBH5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 21:07:57 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id uTTzd2BrDY659uTU5dLt4l; Tue, 19 Sep 2017 18:07:26 -0700
Date:   Wed, 20 Sep 2017 04:07:20 +0300
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>,
        Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] describe: teach --match to handle branches and remotes
Message-ID: <20170920010719.GA12408@jessie.local>
References: <20170917142416.30685-1-max@max630.net>
 <xmqqzi9rsgxz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzi9rsgxz.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfB/OQe9OqrtZOIgWPn3U03r5ifzSxkwy5fv3f9GLbyEV0WvP/wwn6eOQWTtKCW3PQ/sNTbmRRa8Bcf9JocjOif07PpKEfrdM9owyrAYzxgHjracmf9V8
 UqY1zqYsr7+EozBRdPArLli0LSxMWp0x37kYJwWNdlc3zdcdSG2QQFhoN5LHhUYMwLkJYN35yRyMYGswQS3Q5RpEpS1K/ps6d+FMSIOsZCXx68u/o09PqTn2
 wk01f2XOnyrfoS1w2/xUjQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 19, 2017 at 08:52:24AM +0900, Junio C Hamano wrote:
> I think you can use skip_prefix() to avoid counting the length of
> the prefix yourself, i.e.

Thanks, will use it.

> The hardcoded +10 for "is_tag" case assumes that anything other than
> "refs/tags/something" would ever be used to call into this function
> when is_tag is true, and that may well be true in the current code
> and have been so ever since the original code was written, but it
> still smells like an invitation for future bugs.

is_tag is used later. I'll chance it so that it does not
rely on it to match, but it still has to produce it.

> Was there a reason why A and c are in different cases?  Are we
> worried about case insensitive filesystems or something?

The tags have been there of different case already. I don't
know why. I'll change the branch names but I'm reluctant to
touch existing tests.

-- 
Max

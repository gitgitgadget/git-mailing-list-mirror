Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SBL_CSS,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FA0F2082D
	for <e@80x24.org>; Thu,  7 Sep 2017 07:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753908AbdIGHIf (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 03:08:35 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21314 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbdIGHIe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 03:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1504768111;
        s=zoho; d=shikherverma.com; i=root@shikherverma.com;
        h=Date:From:To:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        l=2162; bh=l7OnanDG7/g37WLVrFrQBMV+rKDOM+RIbPjw1nHmKQo=;
        b=Aq2WP25F3RA1TesHlQ/4qphLNSEC0KKEQwkqrOAMB6nAOjpYluvPXK/2iG7XnfSJ
        xeU9LApNMw2YviOtHv4dwfV1fyALtBLbX1QTQtD0p2kdw6a2qrfp1JPZmbiPmADVISR
        JPHeQ1sNUulTi/YP/IzQdiKA1UsbimiL19xJMyIM=
Received: from weakknees.security.iitk.ac.in (125.17.242.34 [125.17.242.34]) by mx.zohomail.com
        with SMTPS id 1504768111738944.2313052896537; Thu, 7 Sep 2017 00:08:31 -0700 (PDT)
Date:   Thu, 7 Sep 2017 12:38:27 +0530
From:   Shikher Verma <root@shikherverma.com>
To:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Add named reference to latest push cert
Message-ID: <20170907070827.sysqmszdwduruwis@weakknees.security.iitk.ac.in>
References: <20170906093913.21485-1-root@shikherverma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170906093913.21485-1-root@shikherverma.com>
X-ZohoMailClient: External
X-ZohoMail: Z_65354923 SPT_1 Z_50090816 SPT_1 SLF_D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone,

I felt like I should introduce myself since this is my first patch on
the git mailing list (or any mailing list actually) :D

I am Shikher[1], currently in my 4th year undergrad at IIT Kanpur.
This summer I was lucky enough to intern at NYU Secure Systems Lab[2]
mentored by Santiago. We looked into how signed pushes work and how 
we can use them to increase the security of git. We encountered a
strange error in tests which resulted in a patch[3] and I wrote a
python script to verify push certificates[4]. I was pretty surprised 
to not find any push certificate on the remote repo after I did a 
signed push, hence this RFC.

Anyway this is my first time trying to contribute to a large OSS so 
forgive me if I make any noob mistakes.

Thanks
Shikher Verma

[1]http://shikherverma.com/
[2]https://ssl.engineering.nyu.edu/
[3]https://public-inbox.org/git/20170707220159.12752-1-santiago@nyu.edu/
[4]https://gist.github.com/ShikherVerma/9204060b545c00597e7ad9b694cfeb9c

On Wed, Sep 06, 2017 at 03:09:11PM +0530, Shikher Verma wrote:
> Currently, git only stores push certificates if there is a receive hook 
> present. This may violate the principle of least surprise (e.g., I 
> pushed with --signed, and I don't see anything in upstream). 
> Additionally, push certificates could be more versatile if they are not 
> tightly bound to git hooks. Finally, it would be useful to verify the 
> signed pushes at later points of time with ease.
> 
> A named ref is added for ease of access/tooling around push 
> certificates. If the last push was signed, ref/PUSH_CERT stores the 
> ref of the latest push cert otherwise it is empty.
>  
> Sending patches as RFC since the documentation would have to be 
> updated and git gc might have to be patched to not garbage collect 
> the latest push certificate.
> 
> This patch applies on master (3ec7d702a) 
> 
> Shikher Verma (2):
>   Always write push cert to disk
>   Store latest push cert ref in PUSH_CERT
> 
>  builtin/receive-pack.c | 25 ++++++++++++++++++++-----
>  path.c                 |  1 +
>  path.h                 |  1 +
>  3 files changed, 22 insertions(+), 5 deletions(-)
> 
> -- 
> 2.14.1
> 


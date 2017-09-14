Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7208520A21
	for <e@80x24.org>; Thu, 14 Sep 2017 18:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbdINSYd (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 14:24:33 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35263 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdINSYc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 14:24:32 -0400
Received: by mail-pf0-f196.google.com with SMTP id i23so74243pfi.2
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 11:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RWhMBPrdRQu5Vz3YJxGmgwrWwWqX2DjxgP32ynWO9tE=;
        b=h+xt0bAxFZsMc9ff6YEIZ0VVqRaYYMhB63wy5P0G3zCPApHT1DC/a6JOnc8z5i/bly
         BvdZZtLfJWsahrc3CuizqHbBCP/AAsOLvDs0igGZejNv9tm5GPsHL5mU7RtTdaxSkGla
         i4t38DdKUYYcqa2Tr1oP45aY7ko9fMM2KrjQyYWdROEaIVaS2o2y+s75ug2kEbJob5dN
         RXVdqSAF8n/bEt0FwdWtb8XSE+XlJKvSBaHhNRun/CPvj3xYqph2rtYlNkhWqb0iMR1p
         3gKnVz/4iD/QopydtWZ6Li/PXvqZw+J+t8RNjZfC2qJ89/jRFKRDojzVmF88hmz9c/1t
         uR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RWhMBPrdRQu5Vz3YJxGmgwrWwWqX2DjxgP32ynWO9tE=;
        b=dHUnYkEG/UK32jIqKzvbCGFzRinWYkxBBHcbE88OTmDxBujbXiwJbBZ1jlKMXYNXjb
         U6TLtuVhIPEDIJoUbt6uusNQuiBiUJ2W8KbR/NfvvM2oAgG2NXNuOMtK5gLnlkj5GSzg
         rQYVceFTeuRRLGwjs2piMtEZaK6tEub9/BG1xeeXpb1V1oTuXVFDVOdhX+lzLJgrYqo5
         baABgJ7z4KLSqrem9AimZhazDYgjugxdDsfW0jnW3O/RWdlCTOfmB8aSFgMUrLDVRo2h
         1AN4yO3xHnMeYMDKliw4on+ZY1vcljrtSVailPYdIw0YIEMhFldYgAUUJ2oYuTAt8jl2
         81ig==
X-Gm-Message-State: AHPjjUhnaLypEX5dGqvOg6xIrhFZjwUOVRDId9BbxnSQySCmZZRNLW9s
        CRvkkxOrixa/8g==
X-Google-Smtp-Source: ADKCNb5/+SNt9cn9urK8VozquCMU+C+IA/mxT94nCMAPP1o/Fkxg5TFr4BfWYu7cDOkByrEemWgjLQ==
X-Received: by 10.84.131.101 with SMTP id 92mr18289255pld.97.1505413471673;
        Thu, 14 Sep 2017 11:24:31 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:539:86cc:e014:7a2])
        by smtp.gmail.com with ESMTPSA id u12sm27141321pfg.146.2017.09.14.11.24.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 14 Sep 2017 11:24:31 -0700 (PDT)
Date:   Thu, 14 Sep 2017 11:24:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH v2] test-lib: don't use ulimit in test prerequisites on
 cygwin
Message-ID: <20170914182407.GA78683@aiede.mtv.corp.google.com>
References: <580fd1db-2506-42bc-4b6e-3636e21fb4cf@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <580fd1db-2506-42bc-4b6e-3636e21fb4cf@ramsayjones.plus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones wrote:

> On cygwin (and MinGW), the 'ulimit' built-in bash command does not have
> the desired effect of limiting the resources of new processes, at least
> for the stack and file descriptors. However, it always returns success
> and leads to several test prerequisites being erroneously set to true.
>
> Add a check for cygwin and MinGW to the prerequisite expressions, using
> a 'test_have_prereq !MINGW,!CYGWIN' clause, to guard against using ulimit.
> This affects the prerequisite expressions for the ULIMIT_STACK_SIZE,
> CMDLINE_LIMIT and ULIMIT_FILE_DESCRIPTORS prerequisites.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  t/t1400-update-ref.sh |  5 ++++-
>  t/t6120-describe.sh   |  1 -
>  t/t7004-tag.sh        |  1 -
>  t/test-lib.sh         | 10 ++++++++--
>  4 files changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thank you.

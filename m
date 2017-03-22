Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 440A020323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbdCVW36 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:29:58 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36298 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752310AbdCVW34 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:29:56 -0400
Received: by mail-pf0-f196.google.com with SMTP id r137so25023363pfr.3
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ugH1kr3LuHFr9J6sWw2uAP/Ky2sjxW/OHeN9Qwnr/fk=;
        b=mTj1tOzNCwBEy/ikvLzCExdXB5XILd6yaYscE+YdffN/srVc43cdTU+IPgTiSjiv/O
         JwRfu+ps1EM56fCK6Eo206cvj3Ijtb8vVkwKjdJGG9QFhLonSbn5lAI2RRzN7XHBJ0Yf
         BFfFYn0gkIpE+QrlqUKXGCr4G0he11mSp6+OQpiEYCNeagvt9V5jogAgd4oqkPVJaLM/
         GUHy1pqs8XBDhhbNPMmLTQATJVGFjiVw2ctHdFZd5LoxEdcCCBo/cDpCBk158f5oqZUd
         MZo5pbrMa9Z+yy20mq8pzqx7DYK9txT5j7JvfuKWzSSNidTiRiCTnIBd3vCBT79OBV0u
         FAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ugH1kr3LuHFr9J6sWw2uAP/Ky2sjxW/OHeN9Qwnr/fk=;
        b=txf4G3h/569nTLLo5IzwRaTT2hHdW2mwI/AKCoHkSYnegOvbHHF9owIHrbv5g7tvUB
         cezMgeCmmyEWG5cyP7tUQg59dq+KJbYweBpqigsTis5Q3WT5PCuyPJ44je0N1O6xRgiW
         pj177xGlyJ1rifYRazFLuKmGZ0AA8BnYhy5m0Ow5n3cP+FE6P2wsgwYAfPkToe8BFVPW
         0V9OXZr6KlxCE7YcELPJ6aj+xa0/MZHmW16DA7dhsPsqeWf8KfFm5saP1dF4SjVi2sr2
         f89HCO44rMjx/vi7MPNEou16qQoQZl6kzRnhfNQb9eelZNKAp9jL4uYZCISWPw900IFU
         DAKg==
X-Gm-Message-State: AFeK/H2nLW7/rd863FIXdAyxP43ag0mTwak7a9MgMP8F5KU/y5BjRmxavt9t3T7aOKKXLQ==
X-Received: by 10.99.67.130 with SMTP id q124mr46783506pga.221.1490221760710;
        Wed, 22 Mar 2017 15:29:20 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:55f5:992d:bc78:c749])
        by smtp.gmail.com with ESMTPSA id 80sm5486023pfh.110.2017.03.22.15.29.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 15:29:19 -0700 (PDT)
Date:   Wed, 22 Mar 2017 15:29:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com
Subject: Re: [PATCH v2 0/2] push options across http
Message-ID: <20170322222918.GF26108@aiede.mtv.corp.google.com>
References: <20170322195102.165314-1-bmwill@google.com>
 <20170322222200.103204-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170322222200.103204-1-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> v2 addresses Jonathan's comments from v1.
>   * Fix a test
>   * Add some documentation
>   * remove short option from --push-option in git send-pack
> 
> Brandon Williams (2):
>   send-pack: send push options correctly in stateless-rpc case
>   remote-curl: allow push options
> 
>  Documentation/git-send-pack.txt |  6 ++++++
>  builtin/send-pack.c             |  5 +++++
>  remote-curl.c                   |  8 ++++++++
>  send-pack.c                     | 20 ++++++++------------
>  t/t5545-push-options.sh         | 33 +++++++++++++++++++++++++++++++--
>  5 files changed, 58 insertions(+), 14 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Tested-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31BD81FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 17:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbdCMRsJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 13:48:09 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33058 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbdCMRsI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 13:48:08 -0400
Received: by mail-pf0-f194.google.com with SMTP id v190so19717355pfb.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TRqwYOt5R210MtgzTytOPzVMrf9Sd+9RmVrdgZ/JQr4=;
        b=jYXvepH6rdiLnjQ+uT03SdbS5sP7j1JtsZjpZhR9rZxWruH5sGb4juKx6hJmcnhmjr
         H3fcbVOMBmBamYoHNThB2X61EE4o89TkTmKfrjCP8/OojHrKdJNOXZ96dr2fYwdFwofS
         6TT8XhR8FO1laNhbU3bivsXnVmoNaKXiSl1rjXw3+9rhlDN4oz8IBi58feZI9J+ypXNU
         MIl4qJv1qiBpafwUTHkx3M9uNf5iwcrs9fFp7Lqg6jCx2e+BuvZHCVXiNFqS3olxX+wz
         4F0lO1nlZJvuTCtreyq1VuSg5VpCCly1z/tY/Gjs5+pQVXx3MXA8rR0bSPKvI23CziSD
         xcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TRqwYOt5R210MtgzTytOPzVMrf9Sd+9RmVrdgZ/JQr4=;
        b=okJ31fyNWo7T6agIQbX8AY6NQ/qIsUHVkK5xuoFiPfcbUQ5nHxtrGurFjsSzsMQJIU
         4JLHuYnJY2hoZo1t2v3jdv+ggNI1kw3zTOwUsUXHO+Rs8CeNjcKVAIUsqpYMh8rq7FKk
         tsSiA3q+UaZcwvyD2Bu6WqgeEStnnYkMvmuOCduq1ByY5Ky4/q3cwo0q3MiS2Twasy3G
         3pQMopmCNkcrKcdnGM3GX/q3cKu6AHoKQcSYfx7lxMf4cyjc101pdH+ksiUzie4mssnD
         Gmfk7nS2opOuM+8IouSYFVwqn++KG0dlBAvekEmnudnQbbGF7URiW+QmjByIqXfcijn2
         pdXQ==
X-Gm-Message-State: AMke39mTSMkJsCrYi5yNrC4jWQvK7RFbV/WDlcFtVUK9k3Yuwtcx7PVNd76RWzsaG41PBg==
X-Received: by 10.99.121.77 with SMTP id u74mr37972690pgc.200.1489427286713;
        Mon, 13 Mar 2017 10:48:06 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:8575:602f:b00e:ca2f])
        by smtp.gmail.com with ESMTPSA id k76sm33933340pfg.42.2017.03.13.10.48.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 10:48:06 -0700 (PDT)
Date:   Mon, 13 Mar 2017 10:48:04 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     The Keccak Team <keccak@noekeon.org>
Cc:     git@vger.kernel.org, sbeller@google.com, bmwill@google.com,
        jonathantanmy@google.com, peff@peff.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: RFC: Another proposed hash function transition plan
Message-ID: <20170313174804.GH26789@aiede.mtv.corp.google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <91a34c5b-7844-3db2-cf29-411df5bcf886@noekeon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91a34c5b-7844-3db2-cf29-411df5bcf886@noekeon.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The Keccak Team wrote:

> We have read your transition plan to move away from SHA-1 and noticed
> your intent to use SHA3-256 as the new hash function in the new Git
> repository format and protocol. Although this is a valid choice, we
> think that the new SHA-3 standard proposes alternatives that may also be
> interesting for your use cases.  As designers of the Keccak function
> family, we thought we could jump in the mail thread and present these
> alternatives.

I indeed had some reservations about SHA3-256's performance.  The main
hash function we had in mind to compare against is blake2bp-256.  This
overview of other functions to compare against should end up being
very helpful.

Thanks for this.  When I have more questions (which I most likely
will) I'll keep you posted.

Sincerely,
Jonathan

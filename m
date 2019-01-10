Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EDB11F803
	for <e@80x24.org>; Thu, 10 Jan 2019 18:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbfAJS0L (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 13:26:11 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:33127 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbfAJS0L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 13:26:11 -0500
Received: by mail-wr1-f44.google.com with SMTP id c14so12578391wrr.0
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 10:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3xMWLlqZpHZHXfDDPBeCB7NfzpHRlbzcAmW23D3UNxs=;
        b=n1ZPdzXgF+BAmqgadBqV/dGBZJfSo0bAqNETMZyjc7E+eBCOthycKdPo8ZbTSVRyHe
         CxVJWP7lhOeXm6BK2LZ8g8zSZ1soSCJS/Bl04F70UunZUjgSxdnXwIKs6Ni4oKuFQ5ek
         aLV2PjtZIhVdYwOlpd3OrM0k8j2I3xpoEiJUHuJPB8PfWMeSzAKGrase+432WXSkJ2ra
         jlDs5RIV3T35BqEV5KJQJiq0nUy1iUkdo2KKqVOunew865C5bvvzlikW0ubGWm3glQVs
         8mOIc4CNCEULSSIuXnDE4xxyznq0mQZwEiw3zUlzEHmiW/ayKkENgcMxY2ciG4kzZFg8
         CYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3xMWLlqZpHZHXfDDPBeCB7NfzpHRlbzcAmW23D3UNxs=;
        b=KMTdSDwpV7tgsBOLEEa/4Y30h94QZMI7/TsveUJDOwDjDKe9U9rocsYeGGlzY7Mx4G
         OhqzIRIBInkQwhHPmoDaWV03j9tXiH6IFBBXnIV5QZ2+yDmTjL0Cb1Jw1KTP78Q5ng31
         q4WagLx7cIycd9pdEZyRKKU/yapU9CaQLKb7SP6ND9ib2gy8xB4BpdapcoXkOxqBOtbX
         H8M6Acc5gG9aQSUgqhistkuoSvUNvtUjd0zFfmiK7kKcMiBBJUV5r94TsaVmBw+kUcsL
         D72rPHOUPaRM+AluanGkMbReRGuwefAvFvOOf4G+MMqK/b0bi0q7Bgzc1AcZqB2tMPgL
         Si5g==
X-Gm-Message-State: AJcUukeMnRA+eo4cGSjPOwr39pREjww7Yxx5XVA/DeFqQASp8EAKYGAK
        DUhQZ0pSBOopP3Ly+bTpxSDuKUFP
X-Google-Smtp-Source: ALg8bN6vgBjMrfBCJuHZHqXftuRTApDgxkvuJvhoJVHWnARirW/WY2jR+rcNLL/S3v/krkEY2K1lBw==
X-Received: by 2002:adf:8464:: with SMTP id 91mr10876768wrf.251.1547144768600;
        Thu, 10 Jan 2019 10:26:08 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t199sm5381209wmt.1.2019.01.10.10.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 10:26:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samir Benmendil <me@rmz.io>
Cc:     git@vger.kernel.org
Subject: Re: Git rebase --exec cannot run git commands affecting other repos
References: <20190110161904.23fwbrgg7blyx3nj@uh-nuc001>
Date:   Thu, 10 Jan 2019 10:26:07 -0800
In-Reply-To: <20190110161904.23fwbrgg7blyx3nj@uh-nuc001> (Samir Benmendil's
        message of "Thu, 10 Jan 2019 16:19:04 +0000")
Message-ID: <xmqqlg3s2wu8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samir Benmendil <me@rmz.io> writes:

> It is impossible to run git commands affecting a different repo from
> within a `git rebase --exec` because in that environment the `GIT_DIR`
> and `GIT_WORK_TREE` variables are set and inherited by any commands
> run as part of `git rebase --exec`.

If the user wants to work in a different repository, the
environments that tells Git about the original repository can be
unset to do so, which is a very much deliberately designed
behaviour, primarily to help those who run "git rebase" from a
subdirectory of the project.


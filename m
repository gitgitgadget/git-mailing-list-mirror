Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DAE21FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 22:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbcHJWyR (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 18:54:17 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35813 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbcHJWyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 18:54:16 -0400
Received: by mail-yw0-f194.google.com with SMTP id r9so2609061ywg.2
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 15:54:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LVsJ8roPcWH19Q1dJn9/QXzZeEoYJl35HtaMjCrT8PQ=;
        b=ROOFJmiOof3x133s4CYjqbkQi6xIh5s4nN379G4qoLNOnan8SQzTV5I68SFguPtlZ0
         3+Cn2E9Xi4eyUianbg2CjlCywNKLUXb8h06ZZGzgNFeepog1bu5/z52VKrWhgZChjUqo
         ZZpvm+yQZ3d95XMSOHx37ivC6mNaToZwxEgMs/bCaxIA+Hr91Dq0FDDF7ixtf1/fSEuu
         m+p5ZgIPSW/WoCToUSYev/vA165XA4BmljijSC5d2CXoWR86xoSHeDwChuGfEDCrlZz5
         yFj5tKDSHdEYsIVw2S95gKQaFRyosT+95uCfBEJOEsl+lRcIn64LFVSNHSiL9RpC9JOi
         H+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LVsJ8roPcWH19Q1dJn9/QXzZeEoYJl35HtaMjCrT8PQ=;
        b=ewP34+sMUWW1bh8GVvrZvFv4xcGPbjmUQRPqbYywD1uKDwfEdFKlS/Q7cVNwvOXaSx
         7fEGSQyEFqg2yZ88uZZDYToIvoYON5OMl3MiXWAE3VV8indwZfOxoUZl/svb4N+IKp+R
         KzqicxvM3RRlULD3NHtY52+lHXi8qxgbJ3K57qW4SCjZV/4Xy87aZQGHIFPSeQf59Kr4
         6jxfy9vvVQRnNZ9bQQXC27IaBgYNwk9g3YlzyYmNHjpoAjVdhHjRkRDXQTIc5zF5tDbT
         m0WaATgmUPDfKxZDNnzx41ZMhXowZffKLq4B+SDvIkVZYImUtSOtOJWF5tOLUu7Urrn9
         Zgtg==
X-Gm-Message-State: AEkoous8SB7XdCWvL30+StalLyKGy+YLiCV5MUw+5DfpwivJbi8Fnk3GCfsXf0gexuyHJvJFl+riyKkCf+Hvug==
X-Received: by 10.13.197.195 with SMTP id h186mr4414071ywd.54.1470869655994;
 Wed, 10 Aug 2016 15:54:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Wed, 10 Aug 2016 15:53:54 -0700 (PDT)
In-Reply-To: <xmqq4m6s476t.fsf@gitster.mtv.corp.google.com>
References: <20160810211710.23173-1-jacob.e.keller@intel.com> <xmqq4m6s476t.fsf@gitster.mtv.corp.google.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Wed, 10 Aug 2016 15:53:54 -0700
Message-ID: <CA+P7+xpmWu6eeoPkenn=-2s=pW8GdCtBpRGcqDWkmASPmMsetA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] diff: add --line-prefix option for passing in a prefix
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 2:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> You might be envisioning a future enhancement where the recursive
> one uses not "-Submodule commit A"/"-Submodule commit B", and not
> "diff A B", but "log -p A...B" in the submodule, and in such a case,
> it might make sense to run "log -p --graph A...B" instead when the
> command the end user run in the superproject asked for "--graph".
> You would use the same "--line-prefix='| | | '" when running the
> "log -p --graph A...B" command in the submodule, so that the output
> for the submodule will go _after_ the graph of the superproject, but
> in that case, the output for the submodule would also include its
> own graph to show the relationship between A and B.  The line-prefix
> must come before that graph part (and also if it is "git log" run in
> the submodule, the same line-prefix must come before each line of
> the log message output).
>

Oops, you are correct. In this case, the line-prefix should come
first, and I will reverse this.

Thanks,
Jake

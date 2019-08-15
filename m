Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E11A1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 22:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733152AbfHOWwh (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 18:52:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44073 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730491AbfHOWwh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 18:52:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id c81so2047356pfc.11
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 15:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fDs1hmRqTPElC58gbC23ypuFaoD1+Du6MyHho8VQcsI=;
        b=dsw/j5/ugBJFCYqKAuXB7F+WoFhZvorpaBqP3n9a8coYQLdnAxZMSDkYwCisTtqPFp
         ffj51/ERfiXlhIr/fVBydw2q5qa+MM19eKJGFbESD8uxOXM2JiHrkwOennO5RV3dEUl8
         10HB2We0xs5bx3TcfLvk5BJvdAaNeYjJfXrcC73k+3AkifHLAaxHC8rJLdNhPO2jhPMP
         2qPQ+kJ4JzV0+ykFkkX4sp2Nd2XM7ZBDAunlSg0Irycw5b85OsOzFT4oGGIAM4C1BII9
         acWnGWrWhs5RczdBEJu34p/qbvF7g5ZzsBIW++32TKYyn8lCHtic4v+o4UCJIe8Q8kkT
         Sq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fDs1hmRqTPElC58gbC23ypuFaoD1+Du6MyHho8VQcsI=;
        b=SB/dRd2f2knMnu2ekruBC/esmweTq7V4/pJdfSHPHZrNfocj9298uMekck6FByEKSh
         c/0yDToHvyBM9ixtnWH3ywYA1wfbOigWe78jyQztq2YtRkbM1lMqxIhwCE5w/irHIY7e
         uNqCld2NUuEzXM4wxTQH9zP5vf1+WORUEevGpGYxdw9vWfrxqJAyDM5HQ6l7cOKY76oQ
         YZ6qFW0aZa/MlMpNBuSr0njFcYz+6IWlTae7tYy/Q44GDbzlLMVYs7q/g2rmV/RM4tLa
         VAeOJ+d3Vm5qfVoq5duldn4yRu1BaLfwTTMhcFfnlKJlvScSDkfUHMXTEJWBsRJ4hwwe
         FAPw==
X-Gm-Message-State: APjAAAXDSxvKQ0vxa4+Umu2DdrSHiPa+NNZskN+NVmRv6Ns6JAPix5E4
        FSyyNhbHoR9JVj1s/hZjTQnS3g==
X-Google-Smtp-Source: APXvYqyzPKa7mQNlo6YTeyjTlust/JppXzJv/bdNA8W0MACttm34CcQ63d1MS9H/X2pLFg2mw8Jg6g==
X-Received: by 2002:a17:90a:7304:: with SMTP id m4mr4341355pjk.73.1565909555851;
        Thu, 15 Aug 2019 15:52:35 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id h11sm3961033pfn.120.2019.08.15.15.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 15:52:35 -0700 (PDT)
Date:   Thu, 15 Aug 2019 15:52:31 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add tool to generate debugging info
Message-ID: <20190815225231.GD208753@google.com>
References: <20190815023418.33407-1-emilyshaffer@google.com>
 <e6d56d97-99c9-064a-71b5-2b7eb9b71e01@gmail.com>
 <xmqqy2zu4hrq.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy2zu4hrq.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 15, 2019 at 07:36:57AM -0700, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
> > Config options to consider stripping out:
> >
> > 	*url*
> > 	*pass* (anything "password" but also "sendmail.smtppass")
> 
> Blacklisting?  I wonder if users feel safer if these are limited to
> known-benign ones.

I think a whitelist of config options to print would grow stale
immediately, and the options we're missing would be very likely to be
configs to turn on new experimental features - which is probably what we
most want the bugreport for.

> 
> >> +	echo "[Configured Hooks]"
> >> +	find "$GIT_DIR/hooks/" -type f | grep -v "\.sample$" | print_filenames_and_content
> >> +	echo
> >
> > Remove the sample hooks, but focus on the others. Will this look like garbage if a hook
> > is a binary file?
> 
> This makes me feel very nervous.  $GIT_DIR/hooks/ are private and
> people can hardcode credentials in them; $GIT_DIR/hooks/pre-foo may
> be written toread from $GIT_DIR/hooks/mypassword with the knowledge
> that there won't be any "mypassword" hook.

Hmm. I think the list of valid hooks isn't one that changes often, but
it's also not enumerated in some machine-parseable way - it exists in
Documentation/githooks.txt but that's all. I'd still be a little worried
about bitrot... I think it's probably better to list the filenames in
$GIT_DIR/hooks but not print their contents. I'll modify it.

 - Emily

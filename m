Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099E21F731
	for <e@80x24.org>; Mon,  5 Aug 2019 18:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfHESSD (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 14:18:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40670 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfHESSC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 14:18:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so40046790pfp.7
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UvZpN2VLpMoArJD+/W6APcEGsLJY3lmNstKt//WOzVI=;
        b=LhqSIzoFifgbNtphgAONPLNtlreiD7lpiuJp1ekoGW+QyC52oXwOp+TirtL7WZwmka
         qUFWgLH2xcYVSIBTmsJFF/spOSB7NOGS0BIPk1qzHSxR6hkuLBdXyg+Tjvi5dSCKjD4H
         jZC1oJgh+iwqWA5kpr6yAqnxJ5Kjk11nQd4LZ1kkffg0oroWLuIbRQQj5UWA/7HSPBn5
         E87Z2dti/mz5OjhRRYaMseHcPFlBZ5uHHAxKlL8eAO1Jh+BHvY9MyC52o2/2nroSgXlM
         j6zI0hybX6nizI96hZHqpZX6rpeb5hQHbg7gQjf/CwwtKA2Nd36wU3HbidUCPiulqcUk
         76hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=UvZpN2VLpMoArJD+/W6APcEGsLJY3lmNstKt//WOzVI=;
        b=CKHtlrnvTcLyEoPjElaCaQg+gnGakzcpt9EiLjEO97EZTSt1lrZqPV3Rxvhkm+8W6z
         LxNRIj9XSBWEUfvq5JMuUXH1/qkU244PnAxY2gAjj8NKCLMwIYQwEslV2Z+K1N0f275U
         YP70EJFngtQ0wkckNi1P7b9q3huogS6+VcrM6wpcz9y33vHBNJwYwgzGJ802k6swbSJe
         OV63SuwZP30fn/L2nEMedMEFjwdUjFGKlPh2r/xrs09vXMOIiB2dRwWf+gV31pfYN7PG
         FK8L6H7ZUsCGTd/n9vEQk5yyhtLounWz2t8O83lL5W41aDPM07Q4Kc1z4kKQKGu5Ycy3
         Worw==
X-Gm-Message-State: APjAAAU9/Ndgf9ABsTOKCh2kyCSkynT4u9xoP7JE9ZxQIdEDvGy6dNk4
        jmvwhyoWWSRwR5l+0zw4Ct/XQ7nNitHLnA==
X-Google-Smtp-Source: APXvYqxM2MWqR8Dr9tg/l84aPGg1buI9Qx/8N3gQGBwI7FHfqEEdYxa0LUqChy7c2la0NUCn3vX8eA==
X-Received: by 2002:a63:7358:: with SMTP id d24mr137264864pgn.224.1565029081076;
        Mon, 05 Aug 2019 11:18:01 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id k70sm17070685pje.14.2019.08.05.11.18.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 11:18:00 -0700 (PDT)
Date:   Mon, 5 Aug 2019 11:17:55 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [RFC PATCH v2 2/2] trace2: don't overload target directories
Message-ID: <20190805181755.GU43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        stolee@gmail.com
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1564771000.git.steadmon@google.com>
 <a779e272df958702c0df06ab58f1f6d6f8086a30.1564771000.git.steadmon@google.com>
 <b1009a3e-92c6-248c-8d15-f4bb5cc71a11@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1009a3e-92c6-248c-8d15-f4bb5cc71a11@jeffhostetler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.08.05 11:34, Jeff Hostetler wrote:
> 
> 
> On 8/2/2019 6:02 PM, Josh Steadmon wrote:
> > trace2 can write files into a target directory. With heavy usage, this
> > directory can fill up with files, causing difficulty for
> > trace-processing systems.
> > 
> > This patch adds a config option (trace2.maxFiles) to set a maximum
> > number of files that trace2 will write to a target directory. The
> > following behavior is enabled when the maxFiles is set to a positive
> > integer:
> >    When trace2 would write a file to a target directory, first check
> >    whether or not the directory is overloaded. A directory is overloaded
> >    if there is a sentinel file declaring an overload, or if the number of
> >    files exceeds trace2.maxFiles. If the latter, create a sentinel file
> >    to speed up later overload checks.
> > 
> > The assumption is that a separate trace-processing system is dealing
> > with the generated traces; once it processes and removes the sentinel
> > file, it should be safe to generate new trace files again.
> > 
> > The default value for trace2.maxFiles is zero, which disables the
> > overload check.
> > 
> > The config can also be overridden with a new environment variable:
> > GIT_TRACE2_MAX_FILES.
> > 
> > Potential future work:
> > * Write a message into the sentinel file (should match the requested
> >    trace2 output format).
> > * Add a performance test to make sure that contention between multiple
> >    processes all writing to the same target directory does not become an
> >    issue.
> 
> 
> This looks much nicer than the V1 version.  Having it be a
> real feature rather than a test feature helps.
> 
> I don't see anything wrong with this.  I do worry about the
> overhead a bit.  If you really have that many files in the
> target directory, having every command count them at startup
> might be an issue.
> 
> As an alternative, you might consider doing something like
> this:
> 
> [] have an option to make the target directory path expand to
>    something like "<path>/yyyymmdd/" and create the per-process
>    files as "<path>/yyyymmdd/<sid>".
> 
> If there are 0, 1 or 2 directories, logging is enabled.
> We assume that the post-processor is keeping up and all is well.
> We need to allow 2 so that we continue to log around midnight.
> 
> If there are 3 or more directories, logging is disabled.
> The post-processor is more than 24 hours behind for whatever
> reason.  We assume here that the post-processor will process
> and delete the oldest-named directory, so it is a valid measure
> of the backlog.
> 
> I suggest "yyyymmdd" here for simplicity in this discussion
> as daily log rotation is common.  If that's still overloading,
> you could make it a longer prefix of the <sid>.  And include
> the hour, for example.
> 
> I suggest 3 as the cutoff lower bound, because we need to allow
> 2 for midnight rotation.  But you may want to increase it to
> allow for someone to be offline for a long weekend, for example.
> 
> Anyway, this is just a suggestion.  It would give you the
> throttling, but without the need for every command to count
> the contents of the target directory.
> 
> And it would still allow your post-processor to operate in
> near real-time on the contents of the current day's target
> directory or to hang back if that causes too much contention.
> 
> Feel free to ignore this :-)
> 
> Jeff

This does sound reasonable. I'll talk with our collection team and see
if this would work without requiring any changes on their side. If not,
I'll probably take a stab at this when I'm back from vacation.

Thanks!

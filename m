Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6630A1F404
	for <e@80x24.org>; Thu, 11 Jan 2018 00:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbeAKAX7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 19:23:59 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:42884 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752763AbeAKAX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 19:23:58 -0500
Received: by mail-pg0-f47.google.com with SMTP id q67so1221696pga.9
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 16:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H/qRUvrgzg5niyPu8/7eBoxhL+Q0SFk+iu2vwiglatQ=;
        b=YBP8CGKOwIhaFEuWZNGLE+NerbUSK1xAtNGcFX1nVyvEyXl2Dlg626c4DygkN9zfNA
         G2u3s8SJZPBHprN+g4eONY53E1PV+pM7Dwkc7CkJnAnk2DmBg/429RQMDMpWts0Lx9I1
         KWgXF2yZ5QgAC/su8QbMFJc6O5LYaOlVHQBWwrbHDNqWoM5ZHGQysWELdk8KAq/ddm4v
         l7cmURcG996P6KP3ZpjnyJQ/x9oTQAg6GhFLlxjjISTYy6zsixl2es+dOZzbyOMWk8vv
         nl6sQOtWr49RTnuyTciDf+rTMVwpVbI3W+qb22/499ePYbfnZ7qW7VBxLyA4yn8JG96I
         ZvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H/qRUvrgzg5niyPu8/7eBoxhL+Q0SFk+iu2vwiglatQ=;
        b=FY6AiGfubMDzKrj5Oj0p71Px3oOLiIMqvM+G7t9Ir2WoQ49O73SyHGADJN9NvytLjs
         zM3OAx/6vafw0YHyF+Lk5VyPzdsckh3oVaIbaqq4jImLQOPZa0quKyWM9PeqOKZy0mQ4
         oRqb5SDB/jVSf111eXRvPgYHqdWt++WUhvhgGqah7qYX/LYUWuwvMkCI62TsZnApwcRs
         JZsdSbMeOf1ozx++cxNZOQW2pl7xfNWqCgb+dzfWrozFk2YbuXm/rDUgC1c1nex21bsO
         N8/zTk+Q1bbFh/28wwrJMnsvsD8GbvqDIukYM4i/svrG1dkLi4RCG6zyZEqkhLf6qR8s
         AAtA==
X-Gm-Message-State: AKGB3mKzTM4NCietCXSXnQ+ZTaopZdBLYqRBTeVhP6Yi+gh7UuWKj9oy
        vgJAEIvNt0rs0gGgouWJZLIHEAXB/98=
X-Google-Smtp-Source: ACJfBov3A1HQyoXs9lM92TdpCL3IFojvuaHUHpBPRbxSQ9zJW8VvW1/6/q4My2aQI8dm+NjrQ/a/XA==
X-Received: by 10.99.157.13 with SMTP id i13mr16674573pgd.309.1515630237919;
        Wed, 10 Jan 2018 16:23:57 -0800 (PST)
Received: from google.com ([2620:0:100e:422:d157:f909:10c:5e57])
        by smtp.gmail.com with ESMTPSA id e12sm33380616pgu.81.2018.01.10.16.23.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 Jan 2018 16:23:57 -0800 (PST)
Date:   Wed, 10 Jan 2018 16:23:55 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 00/26] protocol version 2
Message-ID: <20180111002355.GA91567@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180109095534.c0c9b9ad3933d406c993c3ab@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180109095534.c0c9b9ad3933d406c993c3ab@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/09, Jonathan Tan wrote:
> On Tue,  2 Jan 2018 16:18:02 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> >  * Introduce a new remote-helper command 'connect-half-duplex' which is
> >    implemented by remote-curl (the http remote-helper).  This allows for a
> >    client to establish a half-duplex connection and use remote-curl as a proxy
> >    to wrap requests in http before sending them to the remote end and
> >    unwrapping the responses and sending them back to the client's stdin.
> 
> I'm not sure about the "half-duplex" name - it is half-duplex in that
> each side must terminate their communications with a flush, but not
> half-duplex in that request-response pairs can overlap each other (e.g.
> during negotation during fetch - there is an optimization in which the
> client tries to keep two requests pending at a time). I think that the
> idea we want to communicate is that requests and responses are always
> packetized, stateless, and always happen as a pair.
> 
> I wonder if "stateless-connect" is a better keyword - it makes sense to
> me (once described) that "stateless" implies that the client sends
> everything the server needs at once (thus, in a packet), the server
> sends everything the client needs back at once (thus, in a packet), and
> then the client must not assume any state-storing on the part of the
> server or transport.

I like that name much better, I think I'll change it to use
'stateless-connect'.  Thanks :)


-- 
Brandon Williams
